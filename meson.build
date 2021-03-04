project('sdl', 'c', version: '2.0.14')

compiler = meson.get_compiler('c')

incdirs = ['include']
build_incdirs = ['src/hidapi/hidapi']

objc_flags = []

link_deps = [
    dependency('threads'),
    dependency('gl'),
]

if target_machine.system() == 'windows'
    link_deps += [
        compiler.find_library('version'),
        compiler.find_library('winmm'),
    ]
endif

sdlmain_sources = []

sources = [
    'src/SDL.c',
    'src/SDL_assert.c',
    'src/SDL_dataqueue.c',
    'src/SDL_error.c',
    'src/SDL_hints.c',
    'src/SDL_log.c',
    'src/atomic/SDL_atomic.c',
    'src/atomic/SDL_spinlock.c',
    'src/audio/SDL_audio.c',
    'src/audio/SDL_audiocvt.c',
    'src/audio/SDL_audiodev.c',
    'src/audio/SDL_audiotypecvt.c',
    'src/audio/SDL_mixer.c',
    'src/audio/SDL_wave.c',
    'src/audio/disk/SDL_diskaudio.c',
    'src/audio/dummy/SDL_dummyaudio.c',
    'src/cpuinfo/SDL_cpuinfo.c',
    'src/dynapi/SDL_dynapi.c',
    'src/events/SDL_clipboardevents.c',
    'src/events/SDL_displayevents.c',
    'src/events/SDL_dropevents.c',
    'src/events/SDL_events.c',
    'src/events/SDL_gesture.c',
    'src/events/SDL_keyboard.c',
    'src/events/SDL_mouse.c',
    'src/events/SDL_quit.c',
    'src/events/SDL_touch.c',
    'src/events/SDL_windowevents.c',
    'src/file/SDL_rwops.c',
    'src/filesystem/dummy/SDL_sysfilesystem.c',
    'src/haptic/SDL_haptic.c',
    'src/haptic/dummy/SDL_syshaptic.c',
    'src/hidapi/SDL_hidapi.c',
    'src/joystick/SDL_gamecontroller.c',
    'src/joystick/SDL_joystick.c',
    'src/joystick/dummy/SDL_sysjoystick.c',
    'src/joystick/hidapi/SDL_hidapi_gamecube.c',
    'src/joystick/hidapi/SDL_hidapi_ps4.c',
    'src/joystick/hidapi/SDL_hidapi_ps5.c',
    'src/joystick/hidapi/SDL_hidapi_rumble.c',
    'src/joystick/hidapi/SDL_hidapi_stadia.c',
    'src/joystick/hidapi/SDL_hidapi_steam.c',
    'src/joystick/hidapi/SDL_hidapi_switch.c',
    'src/joystick/hidapi/SDL_hidapi_xbox360.c',
    'src/joystick/hidapi/SDL_hidapi_xbox360w.c',
    'src/joystick/hidapi/SDL_hidapi_xboxone.c',
    'src/joystick/hidapi/SDL_hidapijoystick.c',
    'src/joystick/virtual/SDL_virtualjoystick.c',
    'src/libm/e_atan2.c',
    'src/libm/e_exp.c',
    'src/libm/e_fmod.c',
    'src/libm/e_log.c',
    'src/libm/e_log10.c',
    'src/libm/e_pow.c',
    'src/libm/e_rem_pio2.c',
    'src/libm/e_sqrt.c',
    'src/libm/k_cos.c',
    'src/libm/k_rem_pio2.c',
    'src/libm/k_sin.c',
    'src/libm/k_tan.c',
    'src/libm/s_atan.c',
    'src/libm/s_copysign.c',
    'src/libm/s_cos.c',
    'src/libm/s_fabs.c',
    'src/libm/s_floor.c',
    'src/libm/s_scalbn.c',
    'src/libm/s_sin.c',
    'src/libm/s_tan.c',
    'src/loadso/dummy/SDL_sysloadso.c',
    'src/locale/SDL_locale.c',
    'src/misc/SDL_url.c',
    'src/power/SDL_power.c',
    'src/render/SDL_d3dmath.c',
    'src/render/SDL_render.c',
    'src/render/SDL_yuv_sw.c',
    'src/render/opengl/SDL_render_gl.c',
    'src/render/opengl/SDL_shaders_gl.c',
    'src/render/opengles2/SDL_render_gles2.c',
    'src/render/opengles2/SDL_shaders_gles2.c',
    'src/render/software/SDL_blendfillrect.c',
    'src/render/software/SDL_blendline.c',
    'src/render/software/SDL_blendpoint.c',
    'src/render/software/SDL_drawline.c',
    'src/render/software/SDL_drawpoint.c',
    'src/render/software/SDL_render_sw.c',
    'src/render/software/SDL_rotate.c',
    'src/sensor/SDL_sensor.c',
    'src/sensor/dummy/SDL_dummysensor.c',
    'src/stdlib/SDL_crc32.c',
    'src/stdlib/SDL_getenv.c',
    'src/stdlib/SDL_iconv.c',
    'src/stdlib/SDL_malloc.c',
    'src/stdlib/SDL_qsort.c',
    'src/stdlib/SDL_stdlib.c',
    'src/stdlib/SDL_string.c',
    'src/stdlib/SDL_strtokr.c',
    'src/thread/SDL_thread.c',
    'src/timer/SDL_timer.c',
    'src/timer/dummy/SDL_systimer.c',
    'src/video/SDL_RLEaccel.c',
    'src/video/SDL_blit.c',
    'src/video/SDL_blit_0.c',
    'src/video/SDL_blit_1.c',
    'src/video/SDL_blit_A.c',
    'src/video/SDL_blit_N.c',
    'src/video/SDL_blit_auto.c',
    'src/video/SDL_blit_copy.c',
    'src/video/SDL_blit_slow.c',
    'src/video/SDL_bmp.c',
    'src/video/SDL_clipboard.c',
    'src/video/SDL_egl.c',
    'src/video/SDL_fillrect.c',
    'src/video/SDL_pixels.c',
    'src/video/SDL_rect.c',
    'src/video/SDL_shape.c',
    'src/video/SDL_stretch.c',
    'src/video/SDL_surface.c',
    'src/video/SDL_video.c',
    'src/video/SDL_vulkan_utils.c',
    'src/video/SDL_yuv.c',
    'src/video/dummy/SDL_nullevents.c',
    'src/video/dummy/SDL_nullframebuffer.c',
    'src/video/dummy/SDL_nullvideo.c',
    'src/video/yuv2rgb/yuv_rgb.c',
]

if target_machine.system() != 'windows'
    link_deps += [
        compiler.find_library('m'),
    ]
    sources += [
        'src/core/unix/SDL_poll.c',
        'src/filesystem/unix/SDL_sysfilesystem.c',
        'src/loadso/dlopen/SDL_sysloadso.c',
        'src/locale/unix/SDL_syslocale.c',
        'src/misc/unix/SDL_sysurl.c',
        'src/thread/pthread/SDL_syscond.c',
        'src/thread/pthread/SDL_sysmutex.c',
        'src/thread/pthread/SDL_syssem.c',
        'src/thread/pthread/SDL_systhread.c',
        'src/thread/pthread/SDL_systls.c',
        'src/timer/unix/SDL_systimer.c'
    ]
endif


if target_machine.system() == 'windows'
    link_deps += [
        compiler.find_library('imm32'),
        compiler.find_library('setupapi'),
    ]
    sdlmain_sources += [
        'src/main/windows/SDL_windows_main.c',
    ]
    sources += [
        'src/audio/directsound/SDL_directsound.c',
        'src/audio/wasapi/SDL_wasapi.c',
        'src/audio/wasapi/SDL_wasapi_win32.c',
        'src/audio/winmm/SDL_winmm.c',
        'src/core/windows/SDL_hid.c',
        'src/core/windows/SDL_windows.c',
        'src/core/windows/SDL_xinput.c',
        'src/filesystem/windows/SDL_sysfilesystem.c',
        'src/haptic/windows/SDL_dinputhaptic.c',
        'src/haptic/windows/SDL_windowshaptic.c',
        'src/haptic/windows/SDL_xinputhaptic.c',
        'src/hidapi/windows/hid.c',
        'src/joystick/windows/SDL_dinputjoystick.c',
        'src/joystick/windows/SDL_mmjoystick.c',
        'src/joystick/windows/SDL_rawinputjoystick.c',
        'src/joystick/windows/SDL_windows_gaming_input.c',
        'src/joystick/windows/SDL_windowsjoystick.c',
        'src/joystick/windows/SDL_xinputjoystick.c',
        'src/loadso/windows/SDL_sysloadso.c',
        'src/locale/windows/SDL_syslocale.c',
        'src/main/windows/SDL_windows_main.c',
        'src/misc/windows/SDL_sysurl.c',
        'src/power/windows/SDL_syspower.c',
        'src/render/direct3d/SDL_render_d3d.c',
        'src/render/direct3d/SDL_shaders_d3d.c',
        'src/render/direct3d11/SDL_render_d3d11.c',
        'src/render/direct3d11/SDL_shaders_d3d11.c',
        'src/sensor/windows/SDL_windowssensor.c',
        'src/thread/generic/SDL_syscond.c',
        'src/thread/windows/SDL_syscond_srw.c',
        'src/thread/windows/SDL_sysmutex.c',
        'src/thread/windows/SDL_syssem.c',
        'src/thread/windows/SDL_systhread.c',
        'src/thread/windows/SDL_systls.c',
        'src/timer/windows/SDL_systimer.c',
        'src/video/windows/SDL_windowsclipboard.c',
        'src/video/windows/SDL_windowsevents.c',
        'src/video/windows/SDL_windowsframebuffer.c',
        'src/video/windows/SDL_windowskeyboard.c',
        'src/video/windows/SDL_windowsmessagebox.c',
        'src/video/windows/SDL_windowsmodes.c',
        'src/video/windows/SDL_windowsmouse.c',
        'src/video/windows/SDL_windowsopengl.c',
        'src/video/windows/SDL_windowsopengles.c',
        'src/video/windows/SDL_windowsshape.c',
        'src/video/windows/SDL_windowsvideo.c',
        'src/video/windows/SDL_windowsvulkan.c',
        'src/video/windows/SDL_windowswindow.c',
    ]
endif

if target_machine.system() == 'linux'
    link_deps += [
        dependency('libusb-1.0'),
        compiler.find_library('dl'),
    ]
    sources += [
        'src/audio/alsa/SDL_alsa_audio.c',
        'src/audio/dsp/SDL_dspaudio.c',
        'src/audio/jack/SDL_jackaudio.c',
        'src/audio/pulseaudio/SDL_pulseaudio.c',
        'src/core/linux/SDL_dbus.c',
        'src/core/linux/SDL_evdev.c',
        'src/core/linux/SDL_evdev_capabilities.c',
        'src/core/linux/SDL_evdev_kbd.c',
        'src/core/linux/SDL_fcitx.c',
        'src/core/linux/SDL_ibus.c',
        'src/core/linux/SDL_ime.c',
        'src/core/linux/SDL_threadprio.c',
        'src/core/linux/SDL_udev.c',
        'src/haptic/linux/SDL_syshaptic.c',
        'src/joystick/linux/SDL_sysjoystick.c',
        'src/joystick/steam/SDL_steamcontroller.c',
        'src/power/linux/SDL_syspower.c',
        'src/video/wayland/SDL_waylandclipboard.c',
        'src/video/wayland/SDL_waylanddatamanager.c',
        'src/video/wayland/SDL_waylanddyn.c',
        'src/video/wayland/SDL_waylandevents.c',
        'src/video/wayland/SDL_waylandmouse.c',
        'src/video/wayland/SDL_waylandopengles.c',
        'src/video/wayland/SDL_waylandtouch.c',
        'src/video/wayland/SDL_waylandvideo.c',
        'src/video/wayland/SDL_waylandvulkan.c',
        'src/video/wayland/SDL_waylandwindow.c',
        'src/video/x11/SDL_x11clipboard.c',
        'src/video/x11/SDL_x11dyn.c',
        'src/video/x11/SDL_x11events.c',
        'src/video/x11/SDL_x11framebuffer.c',
        'src/video/x11/SDL_x11keyboard.c',
        'src/video/x11/SDL_x11messagebox.c',
        'src/video/x11/SDL_x11modes.c',
        'src/video/x11/SDL_x11mouse.c',
        'src/video/x11/SDL_x11opengl.c',
        'src/video/x11/SDL_x11opengles.c',
        'src/video/x11/SDL_x11shape.c',
        'src/video/x11/SDL_x11touch.c',
        'src/video/x11/SDL_x11video.c',
        'src/video/x11/SDL_x11vulkan.c',
        'src/video/x11/SDL_x11window.c',
        'src/video/x11/SDL_x11xinput2.c',
        'src/video/x11/edid-parse.c',
        'src/video/x11/imKStoUCS.c',
    ]
endif


if target_machine.system() == 'darwin'
    add_languages('objc', required: true)
    objc_flags += [ '-fobjc-weak' ]
    build_incdirs += [ 'src/video/khronos' ]
    link_deps += [
        dependency('Carbon'),
        dependency('Cocoa'),
        dependency('CoreGraphics'),
        dependency('CoreHaptics'),
        dependency('CoreVideo'),
        dependency('ForceFeedback'),
        dependency('GameController'),
        dependency('IOKit'),
        dependency('Metal'),
        dependency('OpenGL'),
    ]
    sources += [
        'src/audio/coreaudio/SDL_coreaudio.m',
        'src/file/cocoa/SDL_rwopsbundlesupport.m',
        'src/haptic/darwin/SDL_syshaptic.c',
        'src/joystick/darwin/SDL_iokitjoystick.c',
        'src/joystick/iphoneos/SDL_mfijoystick.m',
        'src/render/metal/SDL_render_metal.m',
        'src/timer/unix/SDL_systimer.c',
        'src/video/cocoa/SDL_cocoaclipboard.m',
        'src/video/cocoa/SDL_cocoaevents.m',
        'src/video/cocoa/SDL_cocoakeyboard.m',
        'src/video/cocoa/SDL_cocoamessagebox.m',
        'src/video/cocoa/SDL_cocoametalview.m',
        'src/video/cocoa/SDL_cocoamodes.m',
        'src/video/cocoa/SDL_cocoamouse.m',
        'src/video/cocoa/SDL_cocoamousetap.m',
        'src/video/cocoa/SDL_cocoaopengles.m',
        'src/video/cocoa/SDL_cocoaopengl.m',
        'src/video/cocoa/SDL_cocoashape.m',
        'src/video/cocoa/SDL_cocoavideo.m',
        'src/video/cocoa/SDL_cocoavulkan.m',
        'src/video/cocoa/SDL_cocoawindow.m',
    ]
endif

incdirs = include_directories(incdirs)
build_incdirs = include_directories(build_incdirs)

sdl = static_library(
    'sdl2',
    sources,
    include_directories: [incdirs, build_incdirs],
    dependencies: link_deps,
    objc_args: objc_flags,
)

sdlmain = []
if target_machine.system() == 'windows'
    sdlmain += [static_library(
        'sdlmain',
        sdlmain_sources,
        include_directories: [incdirs, build_incdirs],
        dependencies: link_deps,
        objc_args: objc_flags,
    )]
endif

sdl_dep = declare_dependency(
    include_directories: incdirs,
    dependencies: link_deps,
    link_with: [sdl] + sdlmain,
    version: meson.project_version()
)

meson.override_dependency('sdl2', sdl_dep)

# vim: set ts=4 sts=4 sw=4 et:
