import webm
export vpx_image_t

type WebmReader* = ref object
    webmctx: WebmInputContext
    vpxctx: VpxInputContext
    decoder: vpx_codec_ctx_t
    alpha_decoder: vpx_codec_ctx_t
    cfg: vpx_codec_dec_cfg_t
    buffer: ptr uint8
    bufferCap: csize
    iter: vpx_codec_iter_t

proc chapters*(r: WebmReader): seq[tuple[name: string, a, b: uint64]] =
    let count = webm_get_chapters(addr r.webmctx, nil, nil, nil).int
    result = @[]
    if count == 0: return
    var names = newSeq[cstring](count)
    var startTimes = newSeq[uint64](count)
    var endTimes = newSeq[uint64](count)
    discard webm_get_chapters(addr r.webmctx, addr names[0], addr startTimes[0], addr endTimes[0])
    for i in 0 ..< count:
        result.add(($names[i], startTimes[i], endTimes[i]))

proc free(r: WebmReader) =
    webm_free(addr r.webmctx)
    discard vpx_codec_destroy(addr r.decoder)
    discard vpx_codec_destroy(addr r.alpha_decoder)

proc init(r: WebmReader) =
    r.vpxctx.file_type = FILE_TYPE_WEBM
    if file_is_webm(addr r.webmctx, addr r.vpxctx) == 0:
        raise newException(Exception, "Invalid file format")
    discard webm_guess_framerate(addr r.webmctx, addr r.vpxctx)

    var res = vpx_codec_dec_init_ver(addr r.decoder, vpx_codec_vp9_dx(), addr r.cfg, 0)
    if res != 0:
        echo "Error initializing codec: ", vpx_codec_error(addr r.decoder)

    res = vpx_codec_dec_init_ver(addr r.alpha_decoder, vpx_codec_vp9_dx(), addr r.cfg, 0)
    if res != 0:
        echo "Error initializing alpha codec: ", vpx_codec_error(addr r.alpha_decoder)

proc newReader*(path: string): WebmReader =
    result.new(free)
    result.vpxctx.file = open(path)
    if result.vpxctx.file.isNil:
        echo "FILE IS NIL!"
    result.init()

proc rewind*(r: WebmReader) =
    let f = r.vpxctx.file
    r.webmctx.buffer = nil
    free(r)
    zeroMem(addr r.webmctx, sizeof(r.webmctx))
    zeroMem(addr r.vpxctx, sizeof(r.vpxctx))
    zeroMem(addr r.cfg, sizeof(r.cfg))
    zeroMem(addr r.decoder, sizeof(r.decoder))
    zeroMem(addr r.alpha_decoder, sizeof(r.alpha_decoder))
    rewind(f)
    r.vpxctx.file = f
    r.webmctx.buffer = r.buffer
    r.init()

proc close*(r: WebmReader) =
    close(r.vpxctx.file)
    free(r)
    zeroMem(addr r.webmctx, sizeof(r.webmctx))
    zeroMem(addr r.vpxctx, sizeof(r.vpxctx))
    zeroMem(addr r.cfg, sizeof(r.cfg))
    zeroMem(addr r.decoder, sizeof(r.decoder))
    zeroMem(addr r.alpha_decoder, sizeof(r.alpha_decoder))

proc decodeNextFrame*(r: WebmReader): bool =
    var flushDecoder = false
    var sz = r.bufferCap

    var readStatus = webm_read_frame(addr r.webmctx, addr r.buffer, addr sz)
    if sz > r.bufferCap: r.bufferCap = sz

    if readStatus == 0:
        let res = vpx_codec_decode(addr r.decoder, r.buffer, sz.cuint, nil, 0)
        if res != 0:
            echo "decode error: ", res, ": ", vpx_codec_error_detail(addr r.decoder)
            return
    else:
        flushDecoder = true

    if flushDecoder:
        if vpx_codec_decode(addr r.decoder, nil, 0, nil, 0) != 0:
            echo "Failed to flush decoder"
            return

    sz = r.bufferCap
    readStatus = webm_read_frame_alpha(addr r.webmctx, addr r.buffer, addr sz)
    if sz > r.bufferCap: r.bufferCap = sz

    if readStatus == 0:
        let res = vpx_codec_decode(addr r.alpha_decoder, r.buffer, sz.cuint, nil, 0)
        if res != 0:
            echo "alpha decode error: ", res, ": ", vpx_codec_error_detail(addr r.alpha_decoder)

    result = true

proc frameImage*(r: WebmReader): ptr vpx_image_t =
    var iter: vpx_codec_iter_t
    result = vpx_codec_get_frame(addr r.decoder, addr iter)

proc alphaImage*(r: WebmReader): ptr vpx_image_t =
    var iter: vpx_codec_iter_t
    result = vpx_codec_get_frame(addr r.alpha_decoder, addr iter)

proc frameTimestamp*(r: WebmReader): uint64 = r.webmctx.timestamp_ns

proc rewindToNearestKeyframeAtTime*(r: WebmReader, t: float) =
    let t = uint64(t * 1000000000)
    webm_get_cluster_by_time(addr r.webmctx, t)

proc rewindToTime*(r: WebmReader, t: float) =
    let t = uint64(t * 1000000000)
    webm_get_cluster_by_time(addr r.webmctx, t)
    while r.webmctx.timestamp_ns < t:
        if not r.decodeNextFrame():
            break

proc nextFrame*(r: WebmReader, alpha: var ptr vpx_image_t): ptr vpx_image_t =
    if r.decodeNextFrame():
        result = r.frameImage()
        alpha = r.alphaImage()

proc width*(r: WebmReader): int = r.vpxctx.width.int
proc height*(r: WebmReader): int = r.vpxctx.height.int

proc fps*(r: WebmReader): float =
    r.vpxctx.framerate.numerator / r.vpxctx.framerate.denominator

when isMainModule:
    proc testDecode() =
        var webmctx: WebmInputContext
        var vpxctx: VpxInputContext
        var input: VpxDecInputContext
        input.vpx_input_ctx = addr vpxctx
        input.webm_ctx = addr webmctx
        vpxctx.file = open("output.webm")
        vpxctx.file_type = FILE_TYPE_WEBM
        echo file_is_webm(input.webm_ctx, input.vpx_input_ctx)
        echo webm_guess_framerate(input.webm_ctx, input.vpx_input_ctx)
        var decoder: vpx_codec_ctx_t

        var cfg: vpx_codec_dec_cfg_t

        let i = vpx_codec_dec_init_ver(addr decoder, vpx_codec_vp9_dx(), addr cfg, 0)
        if i != 0:
            echo vpx_codec_error(addr decoder)


        var buf: ptr uint8
        var bytes_in_buffer: csize

        var flush_decoder = false
        if webm_read_frame(input.webm_ctx, addr buf, addr bytes_in_buffer) == 0:
            let res = vpx_codec_decode(addr decoder, buf, cuint(bytes_in_buffer), nil, 0)
            if res != 0:
                echo "decode error: ", res, ": ", vpx_codec_error_detail(addr decoder)
        else:
            flush_decoder = true

        if flush_decoder:
            if vpx_codec_decode(addr decoder, nil, 0, nil, 0) != 0:
                echo "Failed to flush decoder"

        var got_data = false
        var iter: vpx_codec_iter_t
        let img = vpx_codec_get_frame(addr decoder, addr iter)
        if not img.isNil:
            echo "Got DATA!"
            if (img.fmt and VPX_IMG_FMT_PLANAR) != 0:
                echo "PLANAR"
            if img.fmt == VPX_IMG_FMT_I420:
                echo "VPX_IMG_FMT_I420"
            echo img.fmt
            echo img.cs
            echo img.rng

    testDecode()
