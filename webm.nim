import clurp, os

proc vpxFiles(): seq[string] {.compileTime.} =
    const lib = "libvpx-1.6.0"
    result = @[
        lib / "vpx_config.h",
        lib / "vpx/src/vpx_decoder.c",
        lib / "vpx/src/vpx_codec.c",

        lib / "vpx_version.h",
        lib / "webmdec.cc",
        lib / "webmdec.h",
        lib / "tools_common.h",
        lib / "tools_common.c",
        lib / "vpx_ports/msvc.h",

        lib / "vpx/internal/vpx_codec_internal.h",

        lib / "vpx/vpx_decoder.h",
        lib / "vpx/vpx_codec.h",
        lib / "vpx/vpx_integer.h",
        lib / "vpx/vpx_image.h",
        lib / "vpx/vpx_frame_buffer.h",
        lib / "vpx/vpx_encoder.h",

        lib / "vpx/vp8dx.h",
        lib / "vpx/vp8.h",

        lib / "vp9/vp9_dx_iface.h",
        lib / "vp9/vp9_dx_iface.c",
        lib / "vp9/decoder/vp9_decoder.h",
        lib / "vp9/common/vp9_alloccommon.h",
        lib / "vp9/common/vp9_frame_buffers.h",
        lib / "vp9/decoder/vp9_decodeframe.h",
        lib / "vp9/decoder/vp9_decodeframe.c",
        lib / "vp9/common/vp9_enums.h",
        lib / "vp9/common/vp9_thread_common.h",
        lib / "vp9/common/vp9_thread_common.c",
        lib / "vp9/common/vp9_loopfilter.h",
        lib / "vp9/common/vp9_loopfilter.c",
        lib / "vp9/common/vp9_blockd.h",
        lib / "vp9/common/vp9_blockd.c",
        lib / "vp9/common/vp9_common_data.h",
        lib / "vp9/common/vp9_entropy.h",
        lib / "vp9/common/vp9_entropy.c",
        lib / "vp9/common/vp9_common.h",
        lib / "vp9/common/vp9_entropymode.h",
        lib / "vp9/common/vp9_entropymode.c",
        lib / "vp9/common/vp9_entropymv.h",
        lib / "vp9/common/vp9_entropymv.c",
        lib / "vp9/common/vp9_mv.h",
        lib / "vp9/common/vp9_filter.h",
        lib / "vp9/common/vp9_filter.c",
        lib / "vp9/common/vp9_scale.h",
        lib / "vp9/common/vp9_scale.c",
        lib / "vp9/common/vp9_seg_common.h",
        lib / "vp9/common/vp9_seg_common.c",
        lib / "vp9/common/vp9_tile_common.h",
        lib / "vp9/common/vp9_tile_common.c",
        lib / "vp9/common/vp9_onyxc_int.h",
        lib / "vp9/common/vp9_quant_common.h",
        lib / "vp9/common/vp9_quant_common.c",
        lib / "vp9/common/vp9_ppflags.h",
        lib / "vp9/common/vp9_alloccommon.c",
        lib / "vp9/common/vp9_frame_buffers.c",
        lib / "vp9/common/vp9_reconintra.h",
        lib / "vp9/common/vp9_scan.h",
        lib / "vp9/common/vp9_scan.c",
        lib / "vp9/common/vp9_idct.h",
        lib / "vp9/common/vp9_idct.c",
        lib / "vp9/common/vp9_pred_common.h",
        lib / "vp9/common/vp9_pred_common.c",
        lib / "vp9/common/vp9_reconinter.h",
        lib / "vp9/common/vp9_reconinter.c",
        lib / "vp9/common/vp9_reconintra.c",
        lib / "vp9/common/vp9_common_data.c",
        lib / "vp9/common/vp9_quant_common.c",
        lib / "vp9/common/vp9_mvref_common.h",
        lib / "vp9/common/vp9_rtcd.c",

        lib / "vp9/decoder/vp9_decoder.c",
        lib / "vp9/decoder/vp9_detokenize.h",
        lib / "vp9/decoder/vp9_detokenize.c",
        lib / "vp9/decoder/vp9_decodeframe.c",
        lib / "vp9/decoder/vp9_decodemv.h",
        lib / "vp9/decoder/vp9_decodemv.c",
        lib / "vp9/decoder/vp9_dsubexp.h",
        lib / "vp9/decoder/vp9_dsubexp.c",

        lib / "vp9/decoder/vp9_dthread.h",
        lib / "vp9/decoder/vp9_dthread.c",
        lib / "vp9/vp9_iface_common.h",

        lib / "vp9_rtcd.h",
        lib / "vpx_dsp_rtcd.h",
        lib / "vpx_scale_rtcd.h",
        lib / "vpx_scale/yv12config.h",
        lib / "vpx_scale/generic/yv12config.c",
        lib / "vpx_scale/vpx_scale.h",
        lib / "vpx_scale/vpx_scale_rtcd.c",
        lib / "vpx_scale/generic/yv12extend.c",

        lib / "vpx_mem/vpx_mem.h",
        lib / "vpx_mem/vpx_mem.c",
        lib / "vpx_mem/include/vpx_mem_intrnl.h",

        lib / "vpx_util/endian_inl.h",
        lib / "vpx_util/vpx_thread.c",

        lib / "vpx_ports/mem.h",
        lib / "vpx_ports/mem_ops.h",
        lib / "vpx_ports/mem_ops_aligned.h",
        lib / "vpx_ports/bitops.h",
        lib / "vpx_ports/system_state.h",
        lib / "vpx_ports/vpx_once.h",
        lib / "vpx_ports/vpx_timer.h",
        lib / "vpx_util/vpx_thread.h",
        lib / "vpx_dsp/vpx_dsp_common.h",
        lib / "vpx_dsp/bitreader_buffer.h",
        lib / "vpx_dsp/bitreader_buffer.c",
        lib / "vpx_dsp/vpx_filter.h",
        lib / "vpx_dsp/vpx_convolve.h",
        lib / "vpx_dsp/vpx_convolve.c",
        lib / "vpx_dsp/inv_txfm.h",
        lib / "vpx_dsp/inv_txfm.c",
        lib / "vpx_dsp/txfm_common.h",
        lib / "vpx_dsp/loopfilter.c",
        lib / "vpx_dsp/bitreader.h",
        lib / "vpx_dsp/bitreader.c",
        lib / "vpx_dsp/prob.h",
        lib / "vpx_dsp/prob.c",
        lib / "vpx_dsp/vpx_dsp_rtcd.c",
        lib / "vpx_dsp/intrapred.c",

        lib / "third_party/libwebm/mkvparser/mkvparser.h",
        lib / "third_party/libwebm/mkvparser/mkvparser.cc",
        lib / "third_party/libwebm/mkvparser/mkvreader.h",
        lib / "third_party/libwebm/mkvparser/mkvreader.cc",
        lib / "third_party/libwebm/common/webmids.h"
    ]

const sources = vpxFiles()
clurp(sources)

const VPX_IMG_FMT_UV_FLIP =   0x200  #/**< V plane precedes U in memory. */
const VPX_IMG_FMT_HAS_ALPHA =  0x400  #/**< Image has an alpha channel. */
const VPX_IMG_FMT_HIGHBITDEPTH = 0x800  #/**< Image uses 16bit framebuffer. */

type
    WebmInputContext* = object
        reader: pointer
        segment: pointer
        buffer: ptr uint8
        cluster: pointer
        block_entry: pointer
        blck: pointer
        block_frame_index: cint
        video_track_index: cint
        timestamp_ns: uint64
        is_key_frame: cint
        reached_eos: cint

    FileTypeDetectionBuffer = object
        buf: array[4, char]
        buf_read: csize
        position: csize

    VideoFileType = enum
        FILE_TYPE_RAW
        FILE_TYPE_IVF
        FILE_TYPE_Y4M
        FILE_TYPE_WEBM

    VpxRational = object
        numerator: cint
        denominator: cint

    VpxInputContext* = object
        filename: cstring
        file: File
        length: int64
        detect: FileTypeDetectionBuffer
        file_type: VideoFileType
        width: uint32
        height: uint32
        pixel_aspect_ratio: VpxRational
        fmt: cint

        bit_depth: cint
        only_i420: cint
        fourcc: uint32
        framerate: VpxRational

    VpxDecInputContext = object
        vpx_input_ctx: ptr VpxInputContext
        webm_ctx: ptr WebmInputContext

    vpx_codec_flags_t = clong

    vpx_codec_err_t = cint

    vpx_codec_ctx_t = object
        name: cstring ## Printable interface name
        iface: pointer ## Interface pointers
        err: vpx_codec_err_t ## Last returned error
        err_detail: cstring ## Detailed info, if available
        init_flags: vpx_codec_flags_t ## Flags passed at init time
        config: pointer ## Configuration pointer aliasing union
        priv: pointer ## Algorithm private storage

    vpx_codec_iface_ptr = pointer

    VpxInterface = object
        name: cstring
        fourcc: uint32
        codec_interface: proc(): vpx_codec_iface_ptr {.cdecl.}

    vpx_codec_dec_cfg_t = object
        threads: cuint
        w: cuint
        h: cuint

    vpx_codec_iter_t = distinct pointer

    # List of supported image formats */
    # vpx_img_fmt_t = enum
    #     VPX_IMG_FMT_NONE,
    #     VPX_IMG_FMT_RGB24,   #/**< 24 bit per pixel packed RGB */
    #     VPX_IMG_FMT_RGB32,   #/**< 32 bit per pixel packed 0RGB */
    #     VPX_IMG_FMT_RGB565,  #/**< 16 bit per pixel, 565 */
    #     VPX_IMG_FMT_RGB555,  #/**< 16 bit per pixel, 555 */
    #     VPX_IMG_FMT_UYVY,    #/**< UYVY packed YUV */
    #     VPX_IMG_FMT_YUY2,    #/**< YUYV packed YUV */
    #     VPX_IMG_FMT_YVYU,    #/**< YVYU packed YUV */
    #     VPX_IMG_FMT_BGR24,   #/**< 24 bit per pixel packed BGR */
    #     VPX_IMG_FMT_RGB32_LE, #/**< 32 bit packed BGR0 */
    #     VPX_IMG_FMT_ARGB,     #/**< 32 bit packed ARGB, alpha=255 */
    #     VPX_IMG_FMT_ARGB_LE,  #/**< 32 bit packed BGRA, alpha=255 */
    #     VPX_IMG_FMT_RGB565_LE,  #/**< 16 bit per pixel, gggbbbbb rrrrrggg */
    #     VPX_IMG_FMT_RGB555_LE,  #/**< 16 bit per pixel, gggbbbbb 0rrrrrgg */
    #     VPX_IMG_FMT_YV12    = VPX_IMG_FMT_PLANAR or VPX_IMG_FMT_UV_FLIP or 1, #/**< planar YVU */
    #     VPX_IMG_FMT_I420    = VPX_IMG_FMT_PLANAR or 2,
    #     VPX_IMG_FMT_VPXYV12 = VPX_IMG_FMT_PLANAR or VPX_IMG_FMT_UV_FLIP or 3, #/** < planar 4:2:0 format with vpx color space */
    #     VPX_IMG_FMT_VPXI420 = VPX_IMG_FMT_PLANAR or 4,
    #     VPX_IMG_FMT_I422    = VPX_IMG_FMT_PLANAR or 5,
    #     VPX_IMG_FMT_I444    = VPX_IMG_FMT_PLANAR or 6,
    #     VPX_IMG_FMT_I440    = VPX_IMG_FMT_PLANAR or 7,
    #     VPX_IMG_FMT_444A    = VPX_IMG_FMT_PLANAR or VPX_IMG_FMT_HAS_ALPHA or 6,
    #     VPX_IMG_FMT_I42016    = VPX_IMG_FMT_I420 or VPX_IMG_FMT_HIGHBITDEPTH,
    #     VPX_IMG_FMT_I42216    = VPX_IMG_FMT_I422 or VPX_IMG_FMT_HIGHBITDEPTH,
    #     VPX_IMG_FMT_I44416    = VPX_IMG_FMT_I444 or VPX_IMG_FMT_HIGHBITDEPTH,
    #     VPX_IMG_FMT_I44016    = VPX_IMG_FMT_I440 or VPX_IMG_FMT_HIGHBITDEPTH

#   /*!\brief List of supported color spaces */
#   typedef enum vpx_color_space {
#     VPX_CS_UNKNOWN    = 0,  /**< Unknown */
#     VPX_CS_BT_601     = 1,  /**< BT.601 */
#     VPX_CS_BT_709     = 2,  /**< BT.709 */
#     VPX_CS_SMPTE_170  = 3,  /**< SMPTE.170 */
#     VPX_CS_SMPTE_240  = 4,  /**< SMPTE.240 */
#     VPX_CS_BT_2020    = 5,  /**< BT.2020 */
#     VPX_CS_RESERVED   = 6,  /**< Reserved */
#     VPX_CS_SRGB       = 7   /**< sRGB */
#   } vpx_color_space_t; /**< alias for enum vpx_color_space */

#   /*!\brief List of supported color range */
#   typedef enum vpx_color_range {
#     VPX_CR_STUDIO_RANGE = 0,    /**< Y [16..235], UV [16..240] */
#     VPX_CR_FULL_RANGE   = 1     /**< YUV/RGB [0..255] */
#   } vpx_color_range_t; /**< alias for enum vpx_color_range */

#   /**\brief Image Descriptor */
    vpx_image_t* = object
        fmt*: cint # Image Format
        cs*: cint # Color Space
        rng*: cint # Color Range

        # Image storage dimensions
        w*: cuint # Stored image width
        h*: cuint # Stored image height
        bit_depth*: cuint # Stored image bit-depth */

        # Image display dimensions */
        d_w*: cuint # Displayed image width */
        d_h*: cuint # Displayed image height */

        # Image intended rendering dimensions */
        r_w*: cuint # Intended rendering image width */
        r_h*: cuint # Intended rendering image height */

        # Chroma subsampling info
        x_chroma_shift*: cuint # subsampling order, X
        y_chroma_shift*: cuint # subsampling order, Y

        # Image data pointers.
    #define VPX_PLANE_PACKED 0   /**< To be used for all packed formats */
    #define VPX_PLANE_Y      0   /**< Y (Luminance) plane */
    #define VPX_PLANE_U      1   /**< U (Chroma) plane */
    #define VPX_PLANE_V      2   /**< V (Chroma) plane */
    #define VPX_PLANE_ALPHA  3   /**< A (Transparency) plane */
        planes*: array[4, ptr uint8] # pointer to the top left pixel for each plane
        stride*: array[4, cint] # stride between rows for each plane */

        bps*: cint # bits per sample (for packed formats) */

        user_priv*: pointer # may be set by the application to associate data with this image.

        # The following members should be treated as private. */
        img_data: ptr uint8 # private
        img_data_owner: cint # private */
        self_allocd: cint # private */

        fb_priv: pointer # Frame buffer data associated with the image.


proc usage_exit() {.exportc.} =
    raise newException(Exception, "die")

const VP9_FOURCC = 0x30395056'u32

# clurp([
#     "libwebm/mkvmuxertypes.hpp",
#     "libwebm/webmids.hpp",
#     "libwebm/mkvmuxerutil.hpp",
#     "libwebm/mkvmuxerutil.cpp",
#     "libwebm/mkvparser.hpp",
#     "libwebm/mkvparser.cpp",
#     "libwebm/mkvwriter.hpp",
#     "libwebm/mkvwriter.cpp",
#     "libwebm/mkvreader.hpp",
#     "libwebm/mkvreader.cpp",
#     "libwebm/mkvmuxer.hpp",
#     "libwebm/mkvmuxer.cpp"
# ])

proc file_is_webm(webm_ctx: ptr WebmInputContext,
                            vpx_ctx: ptr VpxInputContext): cint {.importc.}

proc webm_guess_framerate(webm_ctx: ptr WebmInputContext,
                            vpx_ctx: ptr VpxInputContext): cint {.importc.}

proc get_vpx_decoder_by_fourcc(fourcc: uint32): ptr VpxInterface {.importc.}

const VPX_IMAGE_ABI_VERSION = 4
const VPX_CODEC_ABI_VERSION = (3 + VPX_IMAGE_ABI_VERSION)
const VPX_DECODER_ABI_VERSION = (3 + VPX_CODEC_ABI_VERSION)

proc vpx_codec_dec_init_ver(ctx: ptr vpx_codec_ctx_t, iface: vpx_codec_iface_ptr,
        cfg: ptr vpx_codec_dec_cfg_t, flags: vpx_codec_flags_t, ver: cint = VPX_DECODER_ABI_VERSION): vpx_codec_err_t {.importc.}

proc vpx_codec_error(ctx: ptr vpx_codec_ctx_t): cstring {.importc.}

proc webm_read_frame(webm_ctx: ptr WebmInputContext, buffer: ptr ptr uint8, buffer_size: ptr csize): cint {.importc.}

proc vpx_codec_decode(ctx: ptr vpx_codec_ctx_t, data: ptr uint8, data_sz: cuint, user_priv: pointer, deadline: clong): vpx_codec_err_t {.importc.}

proc vpx_codec_get_frame(ctx: ptr vpx_codec_ctx_t, iter: ptr vpx_codec_iter_t): ptr vpx_image_t {.importc.}

proc vpx_codec_error_detail(ctx: ptr vpx_codec_ctx_t): cstring {.importc.}

proc rewind(file: File) {.importc.}

proc webm_free(webm_ctx: ptr WebmInputContext) {.importc.}

const VPX_IMG_FMT_PLANAR    = 0x100
const VPX_IMG_FMT_I420 = VPX_IMG_FMT_PLANAR or 2

type WebmReader* = ref object
    webmctx: WebmInputContext
    vpxctx: VpxInputContext
    iface: ptr VpxInterface
    decoder: vpx_codec_ctx_t
    cfg: vpx_codec_dec_cfg_t
    buf: ptr uint8
    bytes_in_buffer: csize
    iter: vpx_codec_iter_t

proc init(r: WebmReader) =
    r.vpxctx.file_type = FILE_TYPE_WEBM
    discard file_is_webm(addr r.webmctx, addr r.vpxctx)
    discard webm_guess_framerate(addr r.webmctx, addr r.vpxctx)
    r.iface = get_vpx_decoder_by_fourcc(VP9_FOURCC)
    assert(not r.iface.isNil)

    let i = vpx_codec_dec_init_ver(addr r.decoder, r.iface.codec_interface(), addr r.cfg, 0)
    if i != 0:
        echo vpx_codec_error(addr r.decoder)

proc newReader*(path: string): WebmReader =
    result.new()
    result.vpxctx.file = open(path)
    result.init()

proc rewind*(r: WebmReader) =
    webm_free(addr r.webmctx)
    let f = r.vpxctx.file
    rewind(f)
    zeroMem(addr r.webmctx, sizeof(r.webmctx))
    zeroMem(addr r.vpxctx, sizeof(r.vpxctx))
    zeroMem(addr r.cfg, sizeof(r.cfg))
    r.vpxctx.file = f
    r.buf = nil
    r.bytes_in_buffer = 0
    r.init()

proc nextFrame*(r: WebmReader): ptr vpx_image_t =
    var flush_decoder = false
    if webm_read_frame(addr r.webmctx, addr r.buf, addr r.bytes_in_buffer) == 0:
        let res = vpx_codec_decode(addr r.decoder, r.buf, cuint(r.bytes_in_buffer), nil, 0)
        if res != 0:
            echo "decode error: ", res, ": ", vpx_codec_error_detail(addr r.decoder)
    else:
        flush_decoder = true

    if flush_decoder:
        if vpx_codec_decode(addr r.decoder, nil, 0, nil, 0) != 0:
            echo "Failed to flush decoder"

    var got_data = false
    var iter: vpx_codec_iter_t
    let img = vpx_codec_get_frame(addr r.decoder, addr iter)
    return img

when isMainModule:
    var webmctx: WebmInputContext
    var vpxctx: VpxInputContext
    var input: VpxDecInputContext
    input.vpx_input_ctx = addr vpxctx
    input.webm_ctx = addr webmctx
    vpxctx.file = open("/Users/yglukhov/Downloads/out9.webm")
    vpxctx.file_type = FILE_TYPE_WEBM
    echo file_is_webm(input.webm_ctx, input.vpx_input_ctx)
    echo webm_guess_framerate(input.webm_ctx, input.vpx_input_ctx)
    var decoder: vpx_codec_ctx_t
    let iface = get_vpx_decoder_by_fourcc(VP9_FOURCC)
    assert(not iface.isNil)

    var cfg: vpx_codec_dec_cfg_t

    let i = vpx_codec_dec_init_ver(addr decoder, iface.codec_interface(), addr cfg, 0, VPX_DECODER_ABI_VERSION)
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
