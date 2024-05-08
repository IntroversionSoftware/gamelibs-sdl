project('SDL 3', ['c', 'objc'],
    default_options : [ 'c_std=c11' ],
    version: '3.0.0'
)

compiler = meson.get_compiler('c')
objc_compiler = meson.get_compiler('objc')

has_headers = []

link_deps = [ dependency('threads') ]

objc_flags = []
c_flags = [ '-D_GNU_SOURCE=1', '-DUSING_GENERATED_CONFIG_H' ]
incdirs = [ '.', 'include' ]
build_incdirs = ['src', 'src/hidapi/hidapi']

sources = [
    'src/SDL.c',
    'src/SDL_assert.c',
    'src/SDL_error.c',
    'src/SDL_guid.c',
    'src/SDL_hashtable.c',
    'src/SDL_hints.c',
    'src/SDL_list.c',
    'src/SDL_log.c',
    'src/SDL_properties.c',
    'src/SDL_utils.c',
    'src/atomic/SDL_atomic.c',
    'src/atomic/SDL_spinlock.c',
    'src/audio/SDL_audio.c',
    'src/audio/SDL_audiocvt.c',
    'src/audio/SDL_audiodev.c',
    'src/audio/SDL_audioqueue.c',
    'src/audio/SDL_audioresample.c',
    'src/audio/SDL_audiotypecvt.c',
    'src/audio/SDL_mixer.c',
    'src/audio/SDL_wave.c',
    'src/camera/SDL_camera.c',
    'src/core/SDL_core_unsupported.c',
    'src/core/SDL_runapp.c',
    'src/cpuinfo/SDL_cpuinfo.c',
    'src/dialog/SDL_dialog_utils.c',
    'src/dynapi/SDL_dynapi.c',
    'src/events/imKStoUCS.c',
    'src/events/SDL_clipboardevents.c',
    'src/events/SDL_displayevents.c',
    'src/events/SDL_dropevents.c',
    'src/events/SDL_events.c',
    'src/events/SDL_keyboard.c',
    'src/events/SDL_keysym_to_scancode.c',
    'src/events/SDL_mouse.c',
    'src/events/SDL_pen.c',
    'src/events/SDL_quit.c',
    'src/events/SDL_scancode_tables.c',
    'src/events/SDL_touch.c',
    'src/events/SDL_windowevents.c',
    'src/file/SDL_iostream.c',
    'src/filesystem/SDL_filesystem.c',
    'src/joystick/controller_type.c',
    'src/joystick/SDL_gamepad.c',
    'src/joystick/SDL_joystick.c',
    'src/joystick/SDL_steam_virtual_gamepad.c',
    'src/haptic/SDL_haptic.c',
    'src/hidapi/SDL_hidapi.c',
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
    'src/libm/s_modf.c',
    'src/libm/s_scalbn.c',
    'src/libm/s_sin.c',
    'src/libm/s_tan.c',
    'src/locale/SDL_locale.c',
    'src/main/SDL_main_callbacks.c',
    'src/misc/SDL_url.c',
    'src/power/SDL_power.c',
    'src/render/SDL_d3dmath.c',
    'src/render/SDL_render.c',
    'src/render/SDL_render_unsupported.c',
    'src/render/SDL_yuv_sw.c',
    'src/render/direct3d/SDL_render_d3d.c',
    'src/render/direct3d/SDL_shaders_d3d.c',
    'src/render/direct3d11/SDL_render_d3d11.c',
    'src/render/direct3d11/SDL_shaders_d3d11.c',
    'src/render/direct3d12/SDL_render_d3d12.c',
    'src/render/direct3d12/SDL_shaders_d3d12.c',
    'src/render/opengl/SDL_render_gl.c',
    'src/render/opengl/SDL_shaders_gl.c',
    'src/render/opengles2/SDL_render_gles2.c',
    'src/render/opengles2/SDL_shaders_gles2.c',
    'src/render/ps2/SDL_render_ps2.c',
    'src/render/psp/SDL_render_psp.c',
    'src/render/software/SDL_blendfillrect.c',
    'src/render/software/SDL_blendline.c',
    'src/render/software/SDL_blendpoint.c',
    'src/render/software/SDL_drawline.c',
    'src/render/software/SDL_drawpoint.c',
    'src/render/software/SDL_render_sw.c',
    'src/render/software/SDL_rotate.c',
    'src/render/software/SDL_triangle.c',
    'src/render/vitagxm/SDL_render_vita_gxm.c',
    'src/render/vitagxm/SDL_render_vita_gxm_memory.c',
    'src/render/vitagxm/SDL_render_vita_gxm_tools.c',
    'src/render/vulkan/SDL_render_vulkan.c',
    'src/render/vulkan/SDL_shaders_vulkan.c',
    'src/sensor/SDL_sensor.c',
    'src/stdlib/SDL_crc16.c',
    'src/stdlib/SDL_crc32.c',
    'src/stdlib/SDL_getenv.c',
    'src/stdlib/SDL_iconv.c',
    'src/stdlib/SDL_malloc.c',
    'src/stdlib/SDL_memcpy.c',
    'src/stdlib/SDL_memmove.c',
    'src/stdlib/SDL_memset.c',
    'src/stdlib/SDL_mslibc.c',
    'src/stdlib/SDL_qsort.c',
    'src/stdlib/SDL_stdlib.c',
    'src/stdlib/SDL_string.c',
    'src/stdlib/SDL_strtokr.c',
    'src/storage/SDL_storage.c',
    'src/thread/SDL_thread.c',
    'src/time/SDL_time.c',
    'src/timer/SDL_timer.c',
    'src/video/SDL_blit.c',
    'src/video/SDL_blit_0.c',
    'src/video/SDL_blit_1.c',
    'src/video/SDL_blit_A.c',
    'src/video/SDL_blit_auto.c',
    'src/video/SDL_blit_copy.c',
    'src/video/SDL_blit_N.c',
    'src/video/SDL_blit_slow.c',
    'src/video/SDL_bmp.c',
    'src/video/SDL_clipboard.c',
    'src/video/SDL_egl.c',
    'src/video/SDL_fillrect.c',
    'src/video/SDL_pixels.c',
    'src/video/SDL_rect.c',
    'src/video/SDL_RLEaccel.c',
    'src/video/SDL_stretch.c',
    'src/video/SDL_surface.c',
    'src/video/SDL_video.c',
    'src/video/SDL_video_unsupported.c',
    'src/video/SDL_vulkan_utils.c',
    'src/video/SDL_yuv.c',
    'src/video/yuv2rgb/yuv_rgb_lsx.c',
    'src/video/yuv2rgb/yuv_rgb_sse.c',
    'src/video/yuv2rgb/yuv_rgb_std.c',

    'src/joystick/hidapi/SDL_hidapi_combined.c',
    'src/joystick/hidapi/SDL_hidapi_gamecube.c',
    'src/joystick/hidapi/SDL_hidapi_luna.c',
    'src/joystick/hidapi/SDL_hidapi_ps3.c',
    'src/joystick/hidapi/SDL_hidapi_ps4.c',
    'src/joystick/hidapi/SDL_hidapi_ps5.c',
    'src/joystick/hidapi/SDL_hidapi_rumble.c',
    'src/joystick/hidapi/SDL_hidapi_shield.c',
    'src/joystick/hidapi/SDL_hidapi_stadia.c',
    'src/joystick/hidapi/SDL_hidapi_steam.c',
    'src/joystick/hidapi/SDL_hidapi_steamdeck.c',
    'src/joystick/hidapi/SDL_hidapi_switch.c',
    'src/joystick/hidapi/SDL_hidapi_wii.c',
    'src/joystick/hidapi/SDL_hidapi_xbox360.c',
    'src/joystick/hidapi/SDL_hidapi_xbox360w.c',
    'src/joystick/hidapi/SDL_hidapi_xboxone.c',
    'src/joystick/hidapi/SDL_hidapijoystick.c',

    'src/main/generic/SDL_sysmain_callbacks.c',

    'src/thread/generic/SDL_syscond.c',
    #'src/thread/generic/SDL_sysmutex.c',
    'src/thread/generic/SDL_sysrwlock.c',
    #'src/thread/generic/SDL_syssem.c',
    #'src/thread/generic/SDL_systhread.c',
    #'src/thread/generic/SDL_systls.c',
	
	# TODO steam storage
    'src/storage/generic/SDL_genericstorage.c',
]

if get_option('opengl') != 'angle'
    link_deps += dependency('gl')
endif

has_d3d = false
has_d3d11 = false
has_d3d12 = false
has_ogl = true
has_egl = compiler.has_header('EGL/egl.h')
has_gles2 = compiler.has_header('GLES2/gl2platform.h')

test_intrinsics = true
subdir('meson_utilities')

if not use_msvc
    c_flags += [ '-W', '-Wno-sign-compare', '-Wno-unused-parameter' ]
endif

if has_altivec
    c_flags += '-maltivec'
endif

if has_armsimd
    sources += 'pixman-arm-simd-asm.S'
endif

if has_armneon
    sources += 'pixman-arm-neon-asm.S'
endif

has_libibus = false
has_libdbus = false
has_libudev = false
has_libusb = false
has_libm = false
has_libiconv = false

has_inotify = false
has_semaphore = false
has_linux_input = false

has_ossaudio = false
has_asound = false
has_pipewire = false
has_pulse = false
has_jack = false
has_sndio = false

has_x11 = false
has_vivante = false
has_vivante_vdk = false

has_xinput = false
has_dinput = false
has_mmdeviceapi = false
has_audioclient = false
has_sensorapi = false
has_dsound = false

if get_option('dummyAudio').enabled()
    sources += 'src/audio/dummy/SDL_dummyaudio.c'
endif

if get_option('diskAudio').enabled()
    sources += 'src/audio/disk/SDL_diskaudio.c'
endif

if get_option('virtualJoystick').enabled()
    sources += 'src/joystick/virtual/SDL_virtualjoystick.c'
endif

if get_option('dummyVideo').enabled()
    sources += [
        'src/video/dummy/SDL_nullevents.c',
        'src/video/dummy/SDL_nullframebuffer.c',
        'src/video/dummy/SDL_nullvideo.c',
    ]
endif

if target_machine.system() != 'windows'
    sources += [
        'src/thread/pthread/SDL_syscond.c',
        'src/thread/pthread/SDL_sysmutex.c',
        'src/thread/pthread/SDL_systhread.c',
        'src/thread/pthread/SDL_systls.c',

        'src/core/unix/SDL_poll.c',
        'src/filesystem/unix/SDL_sysfilesystem.c',
        'src/loadso/dlopen/SDL_sysloadso.c',
        'src/locale/unix/SDL_syslocale.c',
        'src/misc/unix/SDL_sysurl.c',
        'src/timer/unix/SDL_systimer.c'
    ]

    has_libm = compiler.find_library('m')
    if libm 
        link_deps += libm
        libm = true
    endif

    has_libiconv = compiler.find_library('iconv')
    if not has_libiconv
        has_libiconv = compiler.find_library('c')
    endif

    if has_libiconv
        link_deps += has_libiconv
        has_libiconv = true
    endif

    has_semaphore = compiler.has_header('semaphore.h')
    if has_semaphore
        sources += 'src/thread/pthread/SDL_syssem.c'
    else
        sources += 'src/thread/generic/SDL_syssem.c'
    endif
    
    has_libudev = compiler.has_header('libudev.h')
    if has_libudev
        has_libudev = true
        
        sources += 'src/core/linux/SDL_udev.c'
    endif
    
    has_libusb = dependency('libusb-1.0')   
    if has_libusb.found() and compiler.has_header('libudev.h')
        link_deps += has_libusb
        
        has_libusb = true
        sources += [
            'src/joystick/hidapi/SDL_hidapijoystick.c',
            'src/joystick/hidapi/SDL_hidapi_combined.c',
            'src/joystick/hidapi/SDL_hidapi_gamecube.c',
            'src/joystick/hidapi/SDL_hidapi_luna.c',
            'src/joystick/hidapi/SDL_hidapi_ps3.c',
            'src/joystick/hidapi/SDL_hidapi_ps4.c',
            'src/joystick/hidapi/SDL_hidapi_ps5.c',
            'src/joystick/hidapi/SDL_hidapi_rumble.c',
            'src/joystick/hidapi/SDL_hidapi_shield.c',
            'src/joystick/hidapi/SDL_hidapi_stadia.c',
            'src/joystick/hidapi/SDL_hidapi_steam.c',
            'src/joystick/hidapi/SDL_hidapi_switch.c',
            'src/joystick/hidapi/SDL_hidapi_wii.c',
            'src/joystick/hidapi/SDL_hidapi_xbox360.c',
            'src/joystick/hidapi/SDL_hidapi_xbox360w.c',
            'src/joystick/hidapi/SDL_hidapi_xboxone.c',
        ]
    endif
endif

if target_machine.system() == 'linux'
    link_deps += compiler.find_library('dl')

    c_flags += ['-D_REENTRANT', '-D_LARGEFILE64_SOURCE']

    has_linux_input = compiler.has_header('linux/input.h')
    if has_linux_input
        sources += [
            'src/haptic/linux/SDL_syshaptic.c',
            'src/core/linux/SDL_evdev.c',
            'src/core/linux/SDL_evdev_capabilities.c',
            'src/core/linux/SDL_evdev_kbd.c',
            'src/joystick/linux/SDL_sysjoystick.c',
            'src/joystick/steam/SDL_steamcontroller.c'
        ]
    endif

    dbus_dep = dependency('dbus-1')
    if dbus_dep
        link_deps += dbus_dep
        has_libdbus = true

        sources += [
            'src/core/linux/SDL_dbus.c',
            'src/core/linux/SDL_system_theme.c',
            'src/core/linux/SDL_fcitx.c'
        ]
    endif
    
    has_inotify = compiler.has_header('sys/inotify.h')
    if has_inotify
        ibus_dep = dependency('ibus-1.0')
        if ibus_dep
            link_deps += ibus_dep
            has_libibus = true
            
            sources += 'src/core/linux/SDL_ibus.c'
        endif
    endif
    
    if has_libibus or has_libdbus
        sources += 'src/core/linux/SDL_ime.c'
    endif

    has_ossaudio = dependency('ossaudio', required : false, static : true)
    if has_ossaudio.found()
        link_deps += has_ossaudio
        sources += 'src/audio/dsp/SDL_dspaudio.c'

        has_ossaudio = true
    endif

    has_asound = dependency('asound', required : false, static : true)
    if has_asound.found()
        link_deps += has_asound
        sources += 'src/audio/alsa/SDL_alsa_audio.c'

        has_asound = true
    endif

    has_pipewire = dependency('pipewire-0.3', required : false, static : true)
    if has_pipewire.found()
        link_deps += has_pipewire
        sources += 'src/audio/pipewire/SDL_pipewire.c'

        has_pipewire = true
    endif

    has_pulse = dependency('pulse-simple', required : false, static : true)
    if has_pulse.found()
        link_deps += has_pulse
        sources += 'src/audio/pulseaudio/SDL_pulseaudio.c'

        has_pulse = true
    endif

    has_jack = dependency('jack', required : false, static : true)
    if has_jack.found()
        link_deps += has_jack
        sources += 'src/audio/jack/SDL_jackaudio.c'

        has_jack = true
    endif

    has_sndio = dependency('sndio', required : false, static : true)
    if has_sndio.found()
        link_deps += has_sndio
        sources += 'src/audio/sndio/SDL_sndioaudio.c'

        has_sndio = true
    endif

    x11_dep = compiler.find_library('X11', required : false)
    if x11_dep.found()
        link_deps += x11_dep
        has_x11 = true
    
        sources += [
            'src/video/x11/edid-parse.c',
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
            'src/video/x11/SDL_x11xfixes.c',
        ]
    endif

    if get_option('wayland').enabled()
        dep_wl_scanner = dependency('wayland-scanner', native: true)
        wayland_client = dependency('wayland-client')
        wayland_scanner = find_program(dep_wl_scanner.get_pkgconfig_variable('wayland_scanner'))

        protocols = [
            'wayland-protocols/fractional-scale-v1.xml',
            'wayland-protocols/idle-inhibit-unstable-v1.xml',
            'wayland-protocols/input-timestamps-unstable-v1.xml',
            'wayland-protocols/keyboard-shortcuts-inhibit-unstable-v1.xml',
            'wayland-protocols/pointer-constraints-unstable-v1.xml',
            'wayland-protocols/primary-selection-unstable-v1.xml',
            'wayland-protocols/relative-pointer-unstable-v1.xml',
            'wayland-protocols/tablet-unstable-v2.xml',
            'wayland-protocols/text-input-unstable-v3.xml',
            'wayland-protocols/viewporter.xml',
            'wayland-protocols/wayland.xml',
            'wayland-protocols/xdg-activation-v1.xml',
            'wayland-protocols/xdg-decoration-unstable-v1.xml',
            'wayland-protocols/xdg-output-unstable-v1.xml',
            'wayland-protocols/xdg-shell.xml',
        ]

        wl_protos_src = []
        wl_protos_headers = []

        foreach xml : protocols
            wl_protos_src += custom_target (
                xml.underscorify() + '_server_c',
                input: xml,
                output: '@BASENAME@-protocol.c',
                command: [wayland_scanner, 'private-code', '@INPUT@', '@OUTPUT@'],
            )
            wl_protos_headers += custom_target (
                xml.underscorify() + '_server_h',
                input: xml,
                output: '@BASENAME@-protocol.h',
                command: [wayland_scanner, 'server-header', '@INPUT@', '@OUTPUT@'],
            )
        endforeach

        foreach xml : protocols
            wl_protos_headers += custom_target (
                xml.underscorify() + '_client_h',
                input: xml,
                output: '@BASENAME@-client-protocol.h',
                command: [wayland_scanner, 'client-header', '@INPUT@', '@OUTPUT@'],
            )
        endforeach

        lib_client_protos = library (
            'sdl_client_protos',
            wl_protos_src + wl_protos_headers,
            dependencies: wayland_client.partial_dependency(compile_args: true),
        )

        link_deps += declare_dependency (
            link_with: lib_client_protos,
            sources: wl_protos_headers,
        )
        
        link_deps += dependency('wayland-cursor')
        
        if has_egl
            link_deps += dependency('wayland-egl')
        endif
        
        link_deps += dependency('xkbcommon')
        link_deps += dependency('wayland-libdecor')
        
        sources += [
            'src/video/wayland/SDL_waylandclipboard.c',
            'src/video/wayland/SDL_waylanddatamanager.c',
            'src/video/wayland/SDL_waylanddyn.c',
            'src/video/wayland/SDL_waylandevents.c',
            'src/video/wayland/SDL_waylandkeyboard.c',
            'src/video/wayland/SDL_waylandmessagebox.c',
            'src/video/wayland/SDL_waylandmouse.c',
            'src/video/wayland/SDL_waylandopengles.c',
            'src/video/wayland/SDL_waylandtouch.c',
            'src/video/wayland/SDL_waylandvideo.c',
            'src/video/wayland/SDL_waylandvulkan.c',
            'src/video/wayland/SDL_waylandwindow.c',
        ]
        
    endif

    if get_option('vivante').enabled()

        has_vivante_vdk = compiler.has_header('gc_vdk.h')
        result2 = compiler.has_header('EGL/eglvivante.h', args: ['-DLINUX', '-DEGL_API_FB'])
        
        if has_vivante_vdk or result2
            has_vivante = true
            sources += [
                'src/video/vivante/SDL_vivanteopengles.c',
                'src/video/vivante/SDL_vivanteplatform.c',
                'src/video/vivante/SDL_vivantevideo.c',
                'src/video/vivante/SDL_vivantevulkan.c',
            ]
        endif
        
        if has_vivante_vdk
            link_deps += dependency('vdk')
        else
            link_deps += dependency('EGL')
            c_flags += '-DEGL_API_FB'
        endif
    endif
elif target_machine.system() == 'darwin'

    if compiler.has_argument('-Wno-error=deprecated-declarations')
        c_flags += '-Wno-error=deprecated-declarations'
    endif
    
    c_flags += '-D_THREAD_SAFE'
    
    if has_libusb
        sources += 'src/hidapi/ios/hid.m'
    endif

elif target_machine.system() == 'windows'
    c_flags += '-DHAVE__FSEEKI64'

    if use_msvc and is_32_bits
        c_flags += '/arch:SSE'
    endif

    has_xinput = compiler.has_header('xinput.h')

    has_dinput = compiler.has_header('dinput.h')
    link_deps += compiler.find_library('dinput8')
    
    if has_xinput or has_dinput
        sources += [
            'src/haptic/windows/SDL_dinputhaptic.c',
            'src/haptic/windows/SDL_windowshaptic.c',
        ]
    else
        sources += 'src/haptic/dummy/SDL_syshaptic.c'
    endif

    has_mmdeviceapi = compiler.has_header('mmdeviceapi.h')
    has_audioclient = compiler.has_header('audioclient.h')

    if has_mmdeviceapi and has_audioclient
        sources += [
            'src/audio/wasapi/SDL_wasapi.c',
            'src/audio/wasapi/SDL_wasapi_win32.c',
        ]
    endif

    has_sensorapi = compiler.has_header('sensorsapi.h')
    if has_sensorapi
        sources += 'src/sensor/windows/SDL_windowssensor.c'
    endif

    has_d3d = compiler.has_header('d3d9.h')
    has_d3d11 = compiler.has_header('d3d11_1.h')

    code = '''#include <winsdkver.h>
      #include <sdkddkver.h>
      #include <d3d12.h>
      ID3D12Device1 *device;
      #if WDK_NTDDI_VERSION > 0x0A000008
      int main(int argc, char **argv) { return 0; }
      #endif'''

    has_d3d12 = compiler.compiles(code, name : 'have d3d12 test')
    
    has_dsound = compiler.has_header('dsound.h')
    if has_dsound
        sources += 'src/audio/directsound/SDL_directsound.c'
    endif
endif

if target_machine.system() == 'netbsd'
    sources += 'src/audio/netbsd/SDL_netbsdaudio.c'
endif

if target_machine.system() == 'windows'
    
    link_deps += [
        compiler.find_library('user32'),
        compiler.find_library('gdi32'),
        compiler.find_library('winmm'),
        compiler.find_library('imm32'),
        compiler.find_library('ole32'),
        compiler.find_library('version'),
        compiler.find_library('uuid'),
        compiler.find_library('advapi32'),
        compiler.find_library('setupapi'),
        compiler.find_library('shell32'),
    ]
    
    sources += [
        'src/core/windows/pch.c',
        'src/core/windows/SDL_hid.c',
        'src/core/windows/SDL_immdevice.c',
        'src/core/windows/SDL_windows.c',
        'src/core/windows/SDL_xinput.c',
        'src/dialog/windows/SDL_windowsdialog.c',
        'src/filesystem/windows/SDL_sysfilesystem.c',
        'src/filesystem/windows/SDL_sysfsops.c',
        'src/joystick/windows/SDL_dinputjoystick.c',
        'src/joystick/windows/SDL_rawinputjoystick.c',
        'src/joystick/windows/SDL_windows_gaming_input.c',
        'src/joystick/windows/SDL_windowsjoystick.c',
        'src/joystick/windows/SDL_xinputjoystick.c',
        'src/loadso/windows/SDL_sysloadso.c',
        'src/locale/windows/SDL_syslocale.c',
        'src/misc/windows/SDL_sysurl.c',
        'src/power/windows/SDL_syspower.c',
        'src/sensor/windows/SDL_windowssensor.c',
        'src/thread/windows/SDL_syscond_cv.c',
        'src/thread/windows/SDL_sysmutex.c',
        'src/thread/windows/SDL_sysrwlock_srw.c',
        'src/thread/windows/SDL_syssem.c',
        'src/thread/windows/SDL_systhread.c',
        'src/thread/windows/SDL_systls.c',
        'src/time/windows/SDL_systime.c',
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
        'src/video/windows/SDL_windowsrawinput.c',
        'src/video/windows/SDL_windowsshape.c',
        'src/video/windows/SDL_windowsvideo.c',
        'src/video/windows/SDL_windowsvulkan.c',
        'src/video/windows/SDL_windowswindow.c',

        'src/joystick/hidapi/SDL_hidapijoystick.c',
        'src/joystick/hidapi/SDL_hidapi_combined.c',
        'src/joystick/hidapi/SDL_hidapi_gamecube.c',
        'src/joystick/hidapi/SDL_hidapi_luna.c',
        'src/joystick/hidapi/SDL_hidapi_ps3.c',
        'src/joystick/hidapi/SDL_hidapi_ps4.c',
        'src/joystick/hidapi/SDL_hidapi_ps5.c',
        'src/joystick/hidapi/SDL_hidapi_rumble.c',
        'src/joystick/hidapi/SDL_hidapi_shield.c',
        'src/joystick/hidapi/SDL_hidapi_stadia.c',
        'src/joystick/hidapi/SDL_hidapi_steam.c',
        'src/joystick/hidapi/SDL_hidapi_switch.c',
        'src/joystick/hidapi/SDL_hidapi_wii.c',
        'src/joystick/hidapi/SDL_hidapi_xbox360.c',
        'src/joystick/hidapi/SDL_hidapi_xbox360w.c',
        'src/joystick/hidapi/SDL_hidapi_xboxone.c',
    ]
elif target_machine.system() == 'linux'
    
    link_deps += [
        dependency('libdrm'),
    ]

    sources += [
        'src/core/linux/SDL_sandbox.c',
        'src/core/linux/SDL_threadprio.c',
        'src/dialog/unix/SDL_portaldialog.c',
        'src/dialog/unix/SDL_unixdialog.c',
        'src/dialog/unix/SDL_zenitydialog.c',
        'src/filesystem/posix/SDL_sysfsops.c',
        'src/power/linux/SDL_syspower.c',
        'src/time/unix/SDL_systime.c',
    ]
elif target_machine.system() == 'darwin'
    add_languages('objc', required: true)
    objc_flags += [ '-fobjc-weak', '-fobjc-arc' ]
    build_incdirs += [ 'src/video/khronos' ]
    link_deps += [
        dependency('Carbon'),
        dependency('Cocoa'),
        dependency('CoreAudio'),
        dependency('AudioToolbox'),
        dependency('AVFoundation'),
        dependency('CoreGraphics'),
        dependency('CoreMotion'),
        dependency('CoreHaptics'),
        dependency('CoreVideo'),
        dependency('ForceFeedback'),
        dependency('GameController'),
        dependency('IOKit'),
        dependency('UIKit'),
        dependency('Metal'),
        dependency('OpenGL'),
        dependency('OpenGLES'),
        dependency('QuartzCore'),
        dependency('Foundation'),
    ]
    sources += [
        'src/audio/coreaudio/SDL_coreaudio.m',
        'src/dialog/cocoa/SDL_cocoadialog.m',
        'src/file/cocoa/SDL_rwopsbundlesupport.m',
        'src/filesystem/cocoa/SDL_sysfilesystem.m',
        'src/filesystem/posix/SDL_sysfsops.c',
        'src/misc/macos/SDL_sysurl.m',
        'src/haptic/darwin/SDL_syshaptic.c',
        'src/locale/macos/SDL_syslocale.m',
        'src/joystick/apple/SDL_iokitjoystick.c',
        'src/render/metal/SDL_render_metal.m',
        'src/time/unix/SDL_systime.c',
        'src/timer/unix/SDL_systimer.c',
        'src/power/macos/SDL_syspower.c',
        'src/video/cocoa/SDL_cocoaclipboard.m',
        'src/video/cocoa/SDL_cocoaevents.m',
        'src/video/cocoa/SDL_cocoakeyboard.m',
        'src/video/cocoa/SDL_cocoamessagebox.m',
        'src/video/cocoa/SDL_cocoametalview.m',
        'src/video/cocoa/SDL_cocoamodes.m',
        'src/video/cocoa/SDL_cocoamouse.m',
        'src/video/cocoa/SDL_cocoaopengl.m',
        'src/video/cocoa/SDL_cocoaopengles.m',
        'src/video/cocoa/SDL_cocoashape.m',
        'src/video/cocoa/SDL_cocoavideo.m',
        'src/video/cocoa/SDL_cocoavulkan.m',
        'src/video/cocoa/SDL_cocoawindow.m',
    ]
endif

#generate headers

subdir('include/build_config')

incdirs = include_directories(incdirs)
build_incdirs = include_directories(build_incdirs)

sdl_lib = library(
    'sdl3',
    sources,
    include_directories: [incdirs, build_incdirs],
    c_args: c_flags + objc_flags,
    dependencies: link_deps,
    objc_args: objc_flags,
)

sdl_dep = declare_dependency(
    include_directories: incdirs,
    dependencies: link_deps,
    link_with: sdl_lib,
    version: meson.project_version()
)

meson.override_dependency('sdl3', sdl_dep)

# vim: set ts=4 sts=4 sw=4 et:
