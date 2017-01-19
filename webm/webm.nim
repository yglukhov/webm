import clurp, os

const enableEncoder = true

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

    when enableEncoder:
        result.add([
            lib / "vp9/vp9_cx_iface.h",
            lib / "vp9/vp9_cx_iface.c",
            lib / "vp9/encoder/vp9_encoder.h",
            lib / "vp9/encoder/vp9_encoder.c",
            lib / "vpx_dsp/variance.h",
            lib / "vpx_dsp/variance.c",
            lib / "vp9/encoder/vp9_aq_cyclicrefresh.h",
            lib / "vp9/encoder/vp9_aq_cyclicrefresh.c",
            lib / "vp9/encoder/vp9_block.h",
            lib / "vp9/encoder/vp9_skin_detection.h",
            lib / "vp9/encoder/vp9_skin_detection.c",
            lib / "vp9/encoder/vp9_context_tree.h",
            lib / "vp9/encoder/vp9_context_tree.c",
            lib / "vp9/encoder/vp9_encodemb.h",
            lib / "vp9/encoder/vp9_encodemb.c",
            lib / "vp9/encoder/vp9_firstpass.h",
            lib / "vp9/encoder/vp9_firstpass.c",
            lib / "vp9/encoder/vp9_lookahead.h",
            lib / "vp9/encoder/vp9_lookahead.c",
            lib / "vp9/encoder/vp9_ratectrl.h",
            lib / "vp9/encoder/vp9_ratectrl.c",
            lib / "vp9/encoder/vp9_mbgraph.h",
            lib / "vp9/encoder/vp9_mbgraph.c",
            lib / "vp9/encoder/vp9_mcomp.h",
            lib / "vp9/encoder/vp9_mcomp.c",
            lib / "vp9/encoder/vp9_noise_estimate.h",
            lib / "vp9/encoder/vp9_noise_estimate.c",
            lib / "vp9/encoder/vp9_quantize.h",
            lib / "vp9/encoder/vp9_quantize.c",
            lib / "vp9/encoder/vp9_rd.h",
            lib / "vp9/encoder/vp9_rd.c",
            lib / "vp9/encoder/vp9_cost.h",
            lib / "vp9/encoder/vp9_cost.c",
            lib / "vp9/encoder/vp9_speed_features.h",
            lib / "vp9/encoder/vp9_speed_features.c",
            lib / "vp9/encoder/vp9_svc_layercontext.h",
            lib / "vp9/encoder/vp9_svc_layercontext.c",
            lib / "vp9/encoder/vp9_tokenize.h",
            lib / "vp9/encoder/vp9_tokenize.c",
            lib / "vp9/encoder/vp9_treewriter.h",
            lib / "vp9/encoder/vp9_treewriter.c",
            lib / "vpx_dsp/bitwriter.h",
            lib / "vpx_dsp/bitwriter.c",
            lib / "vpx/internal/vpx_psnr.h",
            lib / "vp9/encoder/vp9_aq_360.h",
            lib / "vp9/encoder/vp9_aq_360.c",
            lib / "vp9/encoder/vp9_aq_complexity.h",
            lib / "vp9/encoder/vp9_aq_complexity.c",
            lib / "vp9/encoder/vp9_aq_variance.h",
            lib / "vp9/encoder/vp9_aq_variance.c",
            lib / "vp9/encoder/vp9_bitstream.h",
            lib / "vp9/encoder/vp9_bitstream.c",
            lib / "vp9/encoder/vp9_encodeframe.h",
            lib / "vp9/encoder/vp9_encodeframe.c",
            lib / "vp9/encoder/vp9_encodemv.h",
            lib / "vp9/encoder/vp9_encodemv.c",
            lib / "vp9/encoder/vp9_ethread.h",
            lib / "vp9/encoder/vp9_ethread.c",
            lib / "vp9/encoder/vp9_picklpf.h",
            lib / "vp9/encoder/vp9_picklpf.c",
            lib / "vp9/encoder/vp9_resize.h",
            lib / "vp9/encoder/vp9_resize.c",
            lib / "vp9/encoder/vp9_segmentation.h",
            lib / "vp9/encoder/vp9_segmentation.c",
            lib / "y4minput.h",
            lib / "vp9/encoder/vp9_temporal_filter.h",
            lib / "vp9/encoder/vp9_temporal_filter.c",
            lib / "vp9/encoder/vp9_extend.h",
            lib / "vp9/encoder/vp9_extend.c",
            lib / "vp9/encoder/vp9_pickmode.h",
            lib / "vp9/encoder/vp9_pickmode.c",
            lib / "vpx_dsp/bitwriter_buffer.h",
            lib / "vpx_dsp/bitwriter_buffer.c",
            lib / "vp9/encoder/vp9_subexp.h",
            lib / "vp9/encoder/vp9_subexp.c",
            lib / "vp9/encoder/vp9_rdopt.h",
            lib / "vp9/encoder/vp9_rdopt.c",
            lib / "vp9/common/vp9_mvref_common.c",
            lib / "vpx_dsp/quantize.h",
            lib / "vpx_dsp/quantize.c",
            lib / "vp9/encoder/vp9_dct.c",
            lib / "vpx_dsp/fwd_txfm.h",
            lib / "vpx/src/vpx_encoder.c",
            lib / "vpx/src/vpx_psnr.c",
            lib / "vpx/src/vpx_image.c",
            lib / "vpx_dsp/avg.c",
            lib / "vpx_dsp/sad.c",
            lib / "vpx_dsp/fwd_txfm.c",
            lib / "vpx_dsp/subtract.c",
            lib / "video_writer.c",
            lib / "video_writer.h",
            lib / "video_common.h",
            lib / "ivfenc.h",
            lib / "ivfenc.c",
            lib / "vpx/vp8cx.h",
            lib / "webmenc.cc",
            lib / "webmenc.h",
            lib / "third_party/libwebm/mkvmuxer/mkvmuxer.h",
            lib / "third_party/libwebm/mkvmuxer/mkvmuxer.cc",
            lib / "third_party/libwebm/mkvmuxer/mkvmuxertypes.h",
            lib / "third_party/libwebm/mkvmuxer/mkvmuxerutil.h",
            lib / "third_party/libwebm/mkvmuxer/mkvmuxerutil.cc",
            lib / "third_party/libwebm/mkvmuxer/mkvwriter.h",
            lib / "third_party/libwebm/mkvmuxer/mkvwriter.cc",
            lib / "rate_hist.c",
            lib / "rate_hist.h",
        ])

const sources = vpxFiles()
clurp(sources)

const VPX_IMG_FMT_UV_FLIP* =   0x200  #/**< V plane precedes U in memory. */
const VPX_IMG_FMT_HAS_ALPHA* =  0x400  #/**< Image has an alpha channel. */
const VPX_IMG_FMT_HIGHBITDEPTH* = 0x800  #/**< Image uses 16bit framebuffer. */

const VPX_SS_MAX_LAYERS* = 5
const VPX_MAX_LAYERS* = 12
const VPX_TS_MAX_PERIODICITY* = 16


const VPX_DL_GOOD_QUALITY* = 1000000

const VPX_CODEC_CX_FRAME_PKT* = 0
const VPX_FRAME_IS_KEY* = 0x1


type
    WebmInputContext* = object
        reader: pointer
        segment: pointer
        buffer*: ptr uint8
        cluster: pointer
        block_entry: pointer
        blck: pointer
        block_frame_index: cint
        video_track_index: cint
        timestamp_ns*: uint64
        is_key_frame*: cint
        reached_eos: cint

    FileTypeDetectionBuffer = object
        buf: array[4, char]
        buf_read: csize
        position: csize

    VideoFileType* = enum
        FILE_TYPE_RAW
        FILE_TYPE_IVF
        FILE_TYPE_Y4M
        FILE_TYPE_WEBM

    VpxRational* = object
        numerator*: cint
        denominator*: cint

    VpxInputContext* = object
        filename: cstring
        file*: File
        length: int64
        detect: FileTypeDetectionBuffer
        file_type*: VideoFileType
        width*: uint32
        height*: uint32
        pixel_aspect_ratio: VpxRational
        fmt: cint

        bit_depth: cint
        only_i420: cint
        fourcc: uint32
        framerate*: VpxRational

    VpxDecInputContext* = object
        vpx_input_ctx*: ptr VpxInputContext
        webm_ctx*: ptr WebmInputContext

    vpx_codec_flags_t* = clong

    vpx_codec_err_t* = cint

    vpx_codec_ctx_t* = object
        name: cstring ## Printable interface name
        iface: pointer ## Interface pointers
        err: vpx_codec_err_t ## Last returned error
        err_detail: cstring ## Detailed info, if available
        init_flags: vpx_codec_flags_t ## Flags passed at init time
        config: pointer ## Configuration pointer aliasing union
        priv: pointer ## Algorithm private storage

    vpx_codec_iface_ptr* = pointer

    # VpxInterface = object
    #     name: cstring
    #     fourcc: uint32
    #     codec_interface: proc(): vpx_codec_iface_ptr {.cdecl.}

    vpx_codec_dec_cfg_t* = object
        threads: cuint
        w: cuint
        h: cuint

    vpx_codec_iter_t* = distinct pointer

    vpx_img_fmt_t* = cint
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

    VpxVideoInfo* = object
        codec_fourcc: uint32
        frame_width: cint
        frame_height: cint
        time_base: VpxRational

    VpxVideoWriter* = object
        info: VpxVideoInfo
        file*: File
        frame_count: cint

    vpx_bit_depth_t* = cint # enum
    vpx_codec_er_flags_t* = uint32
    vpx_enc_pass* = cint # enum
    vpx_rc_mode* = cint # enum
    vpx_kf_mode* = cint # enum

    vpx_fixed_buf_t* = object
        buf: pointer
        sz: csize

    vpx_codec_enc_cfg_t* = object
        g_usage: cuint
        g_threads: cuint
        g_profile: cuint
        g_w*: cuint
        g_h*: cuint
        g_bit_depth: vpx_bit_depth_t
        g_input_bit_depth: cuint
        g_timebase*: VpxRational
        g_error_resilient*: vpx_codec_er_flags_t
        g_pass: vpx_enc_pass
        g_lag_in_frames: cuint
        rc_dropframe_thresh: cuint
        rc_resize_allowed: cuint
        rc_scaled_width: cuint
        rc_scaled_height: cuint
        rc_resize_up_thresh: cuint
        rc_resize_down_thresh: cuint
        rc_end_usage: vpx_rc_mode
        rc_twopass_stats_in: vpx_fixed_buf_t
        rc_firstpass_mb_stats_in: vpx_fixed_buf_t
        rc_target_bitrate*: cuint
        rc_min_quantizer: cuint
        rc_max_quantizer: cuint
        rc_undershoot_pct: cuint
        rc_overshoot_pct: cuint
        rc_buf_sz: cuint
        rc_buf_initial_sz: cuint
        rc_buf_optimal_sz: cuint
        rc_2pass_vbr_bias_pct: cuint
        rc_2pass_vbr_minsection_pct: cuint
        rc_2pass_vbr_maxsection_pct: cuint
        kf_mode: vpx_kf_mode
        kf_min_dist: cuint
        kf_max_dist: cuint
        ss_number_layers: cuint
        ss_enable_auto_alt_ref: array[VPX_SS_MAX_LAYERS, cint]
        ss_target_bitrate: array[VPX_SS_MAX_LAYERS, cuint]
        ts_number_layers: cuint
        ts_target_bitrate: array[VPX_SS_MAX_LAYERS, cuint]
        ts_rate_decimator: array[VPX_SS_MAX_LAYERS, cuint]
        ts_periodicity: cuint
        ts_layer_id: array[VPX_TS_MAX_PERIODICITY, cuint]
        layer_target_bitrate: array[VPX_MAX_LAYERS, cuint]
        temporal_layering_mode: cint

    vpx_codec_cx_pkt_kind* = cint # enum

    vpx_codec_pts_t* = int64
    vpx_codec_frame_flags_t* = uint32
    vpx_enc_frame_flags_t* = clong

    vpx_codec_cx_pkt_payload_frame* = object
        buf: pointer
        sz: csize
        pts: vpx_codec_pts_t
        duration: culong
        flags*: vpx_codec_frame_flags_t
        partition_id: cint

    vpx_psnr_pkt* = object
        samples: array[4, cuint]
        sse: array[4, uint64]
        psnr: array[4, cdouble]

    vpx_codec_cx_pkt_payload* = object {.union.}
        frame*: vpx_codec_cx_pkt_payload_frame
        twopass_stats: vpx_fixed_buf_t
        firstpass_mb_stats: vpx_fixed_buf_t
        psnr: vpx_psnr_pkt
        raw: vpx_fixed_buf_t
        layer_sizes: array[VPX_SS_MAX_LAYERS, csize]
        layer_psnr: array[VPX_SS_MAX_LAYERS, vpx_psnr_pkt]
        pad: array[128 - sizeof(vpx_codec_cx_pkt_kind), char]

    vpx_codec_cx_pkt_t* = object
        kind*: vpx_codec_cx_pkt_kind
        data*: vpx_codec_cx_pkt_payload

    stereo_format_t* = cint # enum

    WebmOutputContext* = object
        debug: cint
        stream*: File
        last_pts_ns*: int64
        writer: pointer
        segment: pointer

    rate_hist_t* = distinct pointer

# proc usage_exit() {.exportc.} =
#     raise newException(Exception, "die")

const VP9_FOURCC* = 0x30395056'u32

const VPX_EFLAG_FORCE_KF* = 1 shl 0

proc file_is_webm*(webm_ctx: ptr WebmInputContext,
                            vpx_ctx: ptr VpxInputContext): cint {.importc.}

proc webm_guess_framerate*(webm_ctx: ptr WebmInputContext,
                            vpx_ctx: ptr VpxInputContext): cint {.importc.}

const VPX_IMAGE_ABI_VERSION = 4
const VPX_CODEC_ABI_VERSION = (3 + VPX_IMAGE_ABI_VERSION)
const VPX_DECODER_ABI_VERSION = (3 + VPX_CODEC_ABI_VERSION)


const VPX_ENCODER_ABI_VERSION = (5 + VPX_CODEC_ABI_VERSION)


proc vpx_codec_dec_init_ver*(ctx: ptr vpx_codec_ctx_t, iface: vpx_codec_iface_ptr,
        cfg: ptr vpx_codec_dec_cfg_t, flags: vpx_codec_flags_t, ver: cint = VPX_DECODER_ABI_VERSION): vpx_codec_err_t {.importc.}


proc vpx_codec_enc_init_ver*(ctx: ptr vpx_codec_ctx_t, iface: vpx_codec_iface_ptr, cfg: ptr vpx_codec_enc_cfg_t,
    flags: vpx_codec_flags_t, ver: cint = VPX_ENCODER_ABI_VERSION): vpx_codec_err_t {.importc.}


proc vpx_codec_error*(ctx: ptr vpx_codec_ctx_t): cstring {.importc.}

proc vpx_codec_destroy*(ctx: ptr vpx_codec_ctx_t): vpx_codec_err_t {.importc.}

proc webm_read_frame*(webm_ctx: ptr WebmInputContext, buffer: ptr ptr uint8, buffer_size: ptr csize): cint {.importc.}

proc webm_read_frame_alpha*(webm_ctx: ptr WebmInputContext, buffer: ptr ptr uint8, buffer_size: ptr csize): cint {.importc.}

proc webm_get_cluster_by_time*(webm_ctx: ptr WebmInputContext, time_ns: uint64) {.importc.}

proc webm_get_chapters*(webm_ctx: ptr WebmInputContext, names: ptr cstring, startTimes, endTimes: ptr uint64): cint {.importc.}

proc vpx_codec_decode*(ctx: ptr vpx_codec_ctx_t, data: ptr uint8, data_sz: cuint, user_priv: pointer, deadline: clong): vpx_codec_err_t {.importc.}

proc vpx_codec_get_frame*(ctx: ptr vpx_codec_ctx_t, iter: ptr vpx_codec_iter_t): ptr vpx_image_t {.importc.}

proc vpx_codec_error_detail*(ctx: ptr vpx_codec_ctx_t): cstring {.importc.}

proc rewind*(file: File) {.importc.}

proc webm_free*(webm_ctx: ptr WebmInputContext) {.importc.}

proc vpx_img_alloc*(img: ptr vpx_image_t, fmt: vpx_img_fmt_t, d_w, d_h, align: cuint): ptr vpx_image_t {.importc.}
proc vpx_img_free*(img: ptr vpx_image_t) {.importc.}

proc vpx_codec_vp9_cx*(): vpx_codec_iface_ptr {.importc.}
proc vpx_codec_vp9_dx*(): vpx_codec_iface_ptr {.importc.}


proc vpx_codec_enc_config_default*(iface: vpx_codec_iface_ptr, cfg: ptr vpx_codec_enc_cfg_t, usage: cuint): vpx_codec_err_t {.importc.}

proc vpx_codec_encode*(ctx: ptr vpx_codec_ctx_t, img: ptr vpx_image_t, pts: vpx_codec_pts_t,
        duration: culong, flags: vpx_enc_frame_flags_t, deadline: culong): vpx_codec_err_t {.importc.}

proc vpx_codec_get_cx_data*(ctx: ptr vpx_codec_ctx_t, iter: ptr vpx_codec_iter_t): ptr vpx_codec_cx_pkt_t {.importc.}


proc write_webm_file_header*(webm_ctx: ptr WebmOutputContext,
                            cfg: ptr vpx_codec_enc_cfg_t,
                            fps: ptr VpxRational,
                            stereo_fmt: stereo_format_t,
                            fourcc: cuint,
                            par: ptr VpxRational) {.importc.}

proc write_webm_chapter*(webm_ctx: ptr WebmOutputContext, name: cstring, a, b: uint64) {.importc.}

proc write_webm_block*(webm_ctx: ptr WebmOutputContext, cfg: ptr vpx_codec_enc_cfg_t, pkt: ptr vpx_codec_cx_pkt_t) {.importc.}
proc write_webm_file_footer*(webm_ctx: ptr WebmOutputContext) {.importc.}

proc init_rate_histogram*(cfg: ptr vpx_codec_enc_cfg_t, fps: ptr VpxRational): rate_hist_t {.importc.}
proc destroy_rate_histogram*(hist: rate_hist_t) {.importc.}

proc update_rate_histogram*(hist: rate_hist_t,
                           cfg: ptr vpx_codec_enc_cfg_t,
                           pkt: ptr vpx_codec_cx_pkt_t) {.importc.}

const VPX_IMG_FMT_PLANAR* = 0x100
const VPX_IMG_FMT_I420* = VPX_IMG_FMT_PLANAR or 2
