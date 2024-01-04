project('SDL 3', ['c', 'objc', 'nasm'],
	default_options : [
		'c_std=c11',
		'b_vscrt=static_from_buildtype'
	],
	version: '3.0.0'
)

compiler = meson.get_compiler('c')
objc_compiler = meson.get_compiler('objc')

has_headers = []

link_deps = [
	dependency('threads'),
]

objc_flags = []
c_flags = [ '-D_GNU_SOURCE=1', '-DUSING_GENERATED_CONFIG_H' ]
incdirs = [ '.', 'include' ]
build_incdirs = ['src', 'src/hidapi/hidapi']

sources = [
	'src/SDL.c',
	'src/SDL_assert.c',
	'src/SDL_dataqueue.c',
	'src/SDL_error.c',
	'src/SDL_guid.c',
	'src/SDL_hints.c',
	'src/SDL_list.c',
	'src/SDL_log.c',
	'src/SDL_utils.c',
	'src/atomic/SDL_atomic.c',
	'src/atomic/SDL_spinlock.c',
	'src/audio/SDL_audio.c',
	'src/audio/SDL_audiocvt.c',
	'src/audio/SDL_audiodev.c',
	'src/audio/SDL_audiotypecvt.c',
	'src/audio/SDL_mixer.c',
	'src/audio/SDL_wave.c',
	'src/core/SDL_runapp.c',
	'src/cpuinfo/SDL_cpuinfo.c',
	'src/dynapi/SDL_dynapi.c',
	'src/events/imKStoUCS.c',
	'src/events/SDL_clipboardevents.c',
	'src/events/SDL_displayevents.c',
	'src/events/SDL_dropevents.c',
	'src/events/SDL_events.c',
	'src/events/SDL_keyboard.c',
	'src/events/SDL_keysym_to_scancode.c',
	'src/events/SDL_mouse.c',
	'src/events/SDL_quit.c',
	'src/events/SDL_scancode_tables.c',
	'src/events/SDL_touch.c',
	'src/events/SDL_windowevents.c',
	'src/file/SDL_rwops.c',
	'src/joystick/controller_type.c',
	'src/joystick/SDL_gamepad.c',
	'src/joystick/SDL_joystick.c',
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
	'src/misc/SDL_url.c',
	'src/power/SDL_power.c',
	'src/render/SDL_d3dmath.c',
	'src/render/SDL_render.c',
	'src/render/SDL_yuv_sw.c',
	'src/render/software/SDL_blendfillrect.c',
	'src/render/software/SDL_blendline.c',
	'src/render/software/SDL_blendpoint.c',
	'src/render/software/SDL_drawline.c',
	'src/render/software/SDL_drawpoint.c',
	'src/render/software/SDL_render_sw.c',
	'src/render/software/SDL_rotate.c',
	'src/render/software/SDL_triangle.c',
	'src/sensor/SDL_sensor.c',
	'src/stdlib/SDL_crc16.c',
	'src/stdlib/SDL_crc32.c',
	'src/stdlib/SDL_getenv.c',
	'src/stdlib/SDL_iconv.c',
	'src/stdlib/SDL_malloc.c',
	'src/stdlib/SDL_mslibc.c',
	'src/stdlib/SDL_qsort.c',
	'src/stdlib/SDL_stdlib.c',
	'src/stdlib/SDL_string.c',
	'src/stdlib/SDL_strtokr.c',
	'src/thread/SDL_thread.c',
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
	'src/video/SDL_shape.c',
	'src/video/SDL_stretch.c',
	'src/video/SDL_surface.c',
	'src/video/SDL_video.c',
	'src/video/SDL_vulkan_utils.c',
	'src/video/SDL_yuv.c',
	'src/video/yuv2rgb/yuv_rgb.c',
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
	c_flags += [ '-W', '-Wno-sign-compare' ]
endif

configuration = configuration_data()
configuration.set('HAVE_LIBC', true)

configuration.set('SDL_DISABLE_MMX', not has_mmx)
configuration.set('SDL_DISABLE_SSE', not has_sse)
configuration.set('SDL_DISABLE_SSE2', not has_sse2)
configuration.set('SDL_DISABLE_SSE3', not has_sse3)
configuration.set('SDL_DISABLE_SSE4_1', not has_sse4_1)
configuration.set('SDL_DISABLE_SSE4_2', not has_sse4_2)
configuration.set('SDL_DISABLE_AVX', not has_avx)
configuration.set('SDL_DISABLE_AVX2', not has_avx2)
configuration.set('SDL_DISABLE_AVX512F', not has_avx512f)
configuration.set('SDL_DISABLE_NEON', not has_armneon)
configuration.set('SDL_DISABLE_LSX', true)
configuration.set('SDL_DISABLE_LASX', true)

configuration.set('SDL_DEFAULT_ASSERT_LEVEL_CONFIGURED', true)
configuration.set('SDL_DEFAULT_ASSERT_LEVEL', 1) # release

if has_altivec
	c_flags += '-maltivec'
	configuration.set('SDL_ALTIVEC_BLITTERS', true)
endif

if has_armsimd
	sources += 'pixman-arm-simd-asm.S'
	configuration.set('SDL_ARM_SIMD_BLITTERS', true)
endif

if has_armneon
	sources += 'pixman-arm-neon-asm.S'
	configuration.set('SDL_ARM_NEON_BLITTERS', true)
endif

has_inotify = false
has_libusb = false

if get_option('dummyAudio').enabled()
	sources += 'src/audio/dummy/SDL_dummyaudio.c'
	configuration.set('SDL_AUDIO_DRIVER_DUMMY', true)
endif

if get_option('diskAudio').enabled()
	sources += 'src/audio/disk/SDL_diskaudio.c'
	configuration.set('SDL_AUDIO_DRIVER_DISK', true)
endif

if get_option('virtualJoystick').enabled()
	sources += 'src/joystick/virtual/SDL_virtualjoystick.c'
	configuration.set('SDL_JOYSTICK_VIRTUAL', true)
endif

if get_option('dummyVideo').enabled()
	sources += [
		'src/video/dummy/SDL_nullevents.c',
		'src/video/dummy/SDL_nullframebuffer.c',
		'src/video/dummy/SDL_nullvideo.c',
	]
	configuration.set('SDL_VIDEO_DRIVER_DUMMY', true)
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

	configuration.set('DYNAPI_NEEDS_DLOPEN', true)
	configuration.set('SDL_THREAD_PTHREAD', true)
	configuration.set('SDL_TIMER_UNIX', true)
	configuration.set('HAVE_CLOCK_GETTIME', compiler.has_function('clock_gettime'))
	configuration.set('HAVE_DLOPEN', compiler.has_function('dlopen', prefix : '#include<dlfcn.h>'))

	libm = compiler.find_library('m')
	if libm 
		link_deps += libm
		configuration.set('HAVE_LIBM', true)
	endif

	libiconv = compiler.find_library('iconv')
	if not libiconv
		libiconv = compiler.find_library('c')
	endif

	if libiconv
		link_deps += libiconv
		configuration.set('HAVE_LIBICONV', true)
	endif

	if compiler.has_header('semaphore.h')
		result = compiler.has_function('sem_timedwait', prefix : '#include<semaphore.h>')
		configuration.set('HAVE_SEM_TIMEDWAIT', result)

		sources += 'src/thread/pthread/SDL_syssem.c'
	else
		sources += 'src/thread/generic/SDL_syssem.c'
	endif
	
	
	code = '''#include <pthread.h>
		int main(int argc, char **argv) {
			pthread_mutexattr_t attr;
			pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
			return 0;
		}'''

	result = compiler.compiles(code, name : 'pthread recursive mutex test')
	configuration.set('SDL_THREAD_PTHREAD_RECURSIVE_MUTEX', result)
	
	code = ''' #include <pthread.h>
		int main(int argc, char **argv) {
			pthread_mutexattr_t attr;
			pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE_NP);
			return 0;
		}'''

	result = compiler.compiles(code, name : 'pthread recursive mutex np test')
	configuration.set('SDL_THREAD_PTHREAD_RECURSIVE_MUTEX_NP', result)


	result = compiler.has_function('pthread_setname_np', prefix : '#include<pthread.h>')
	configuration.set('HAVE_PTHREAD_SETNAME_NP', result)
	
	if compiler.has_header('pthread_np.h')
		configuration.set('HAVE_PTHREAD_NP_H', true)
		
		result = compiler.has_function('pthread_set_name_np', prefix : '#include <pthread.h>; #include <pthread_np.h>')
		configuration.set('HAVE_PTHREAD_SET_NAME_NP', result)
	endif
	
	has_libudev = compiler.has_header('libudev.h')
	if has_libudev
		configuration.set('HAVE_LIBUDEV_H', true)
		has_headers += '#include <libudev.h>'
		
		sources += 'src/core/linux/SDL_udev.c'
	endif
	
	has_libusb = dependency('libusb-1.0')	
	if has_libusb.found() and compiler.has_header('libudev.h')
		link_deps += has_libusb
		configuration.set('HAVE_LIBUSB', true)
		
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

	if compiler.has_header('linux/input.h')
		has_headers += '#include <linux/input.h>'
		configuration.set('HAVE_LINUX_INPUT_H', true)
		
		code = '''#include <linux/input.h>
			#ifndef EVIOCGNAME
			#error EVIOCGNAME() ioctl not available
			#endif
			int main(int argc, char** argv) { return 0; }'''
			
		result = compiler.compiles(code, name : 'input linux event test')
		configuration.set('SDL_INPUT_LINUXEV', result)
		
		sources += [
			'src/haptic/linux/SDL_syshaptic.c',
			'src/core/linux/SDL_evdev.c',
			'src/core/linux/SDL_evdev_kbd.c',
			'src/joystick/linux/SDL_sysjoystick.c',
			'src/joystick/steam/SDL_steamcontroller.c'
		]
		
	endif
	
	code = '''#include <linux/kd.h>
		#include <linux/keyboard.h>
		#include <sys/ioctl.h>
		int main(int argc, char **argv) {
			struct kbentry kbe;
			kbe.kb_table = KG_CTRL;
			ioctl(0, KDGKBENT, &kbe);
			return 0;
		}'''
		
	configuration.set('SDL_INPUT_LINUXKD', compiler.has_header('linux/kd.h'))

	use_ime = false

	dbus_dep = dependency('dbus-1')
	if dbus_dep
		link_deps += dbus_dep
		configuration.set('HAVE_DBUS_DBUS_H', true)
		configuration.set('HAVE_FCITX', true)
		
		sources += [
			'src/core/linux/SDL_dbus.c',
			'src/core/linux/SDL_system_theme.c',
			'src/core/linux/SDL_fcitx.c'
		]
		use_ime = true
	endif
	
		
	if compiler.has_header('sys/inotify.h')
		configuration.set('HAVE_SYS_INOTIFY_H', true)
		
		result = compiler.has_function('inotify_init', prefix : 'sys/inotify.h')
		configuration.set('HAVE_INOTIFY_INIT', result)
		configuration.set('HAVE_INOTIFY_INIT1', compiler.has_function('inotify_init1', prefix : 'sys/inotify.h'))
		configuration.set('HAVE_INOTIFY', result)

		ibus_dep = dependency('ibus-1.0')
		if ibus_dep
			link_deps += ibus_dep
			configuration.set('HAVE_IBUS_IBUS_H', true)
			
			sources += 'src/core/linux/SDL_ibus.c'
			
			use_ime = true
		endif
	endif
	
	if use_ime
		configuration.set('SDL_USE_IME', true)
		sources += 'src/core/linux/SDL_ime.c'
	endif

	audio_libs = {
		'ossaudio' : [ 'SDL_AUDIO_DRIVER_OSS', 'src/audio/dsp/SDL_dspaudio.c' ],
		'asound' : [ 'SDL_AUDIO_DRIVER_ALSA', 'src/audio/alsa/SDL_alsa_audio.c' ],
		'pipewire-0.3' : [ 'SDL_AUDIO_DRIVER_PIPEWIRE', 'src/audio/pipewire/SDL_pipewire.c' ],
		'pulse-simple' : [ 'SDL_AUDIO_DRIVER_PULSEAUDIO', 'src/audio/pulseaudio/SDL_pulseaudio.c' ],
		'jack' : [ 'SDL_AUDIO_DRIVER_JACK', 'src/audio/jack/SDL_jackaudio.c' ],
		'sndio' : [ 'SDL_AUDIO_DRIVER_SNDIO', 'src/audio/sndio/SDL_sndioaudio.c' ]
	}

	foreach name, ref : audio_libs
	  dep = dependency(name, required : false, static : true)
	  if dep.found()
		link_deps += dep
		configuration.set(ref[0], true)
		sources += ref[1]
	  endif
	endforeach

	x11_dep = compiler.find_library('X11', required : false)
	if x11_dep.found()
		link_deps += x11_dep
		configuration.set('SDL_VIDEO_DRIVER_X11', true)
		
		headers = {
			'X11/Xcursor/Xcursor.h': 'HAVE_XCURSOR_H',
			'X11/extensions/XInput2.h': 'HAVE_XINPUT2_H',
			'X11/extensions/Xrandr.h': 'HAVE_XRANDR_H',
			'X11/extensions/Xfixes.h': 'HAVE_XFIXES_H_',
			'X11/extensions/Xrender.h': 'HAVE_XRENDER_H',
			'X11/extensions/scrnsaver.h': 'HAVE_XSS_H',
			'X11/extensions/shape.h': 'HAVE_XSHAPE_H',
			'X11/extensions/Xdbe.h': 'HAVE_XDBE_H',
			'X11/extensions/Xext.h': 'HAVE_XEXT_H'
		}
		
	
		foreach header, define : headers
			configuration.set(define, compiler.has_header(header))
		endforeach
	
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
		
		code = '''#include <X11/Xlib.h>
			int main(int argc, char **argv) {
				Display *display;
				XEvent event;
				XGenericEventCookie *cookie = &event.xcookie;
				XNextEvent(display, &event);
				XGetEventData(display, cookie);
				XFreeEventData(display, cookie);
				return 0;
			}'''

		result = compiler.compiles(code, name : 'x11 supports generic events test')
		configuration.set('SDL_VIDEO_DRIVER_X11_SUPPORTS_GENERIC_EVENTS', result)
	
		if compiler.has_function('XkbKeycodeToKeysym', prefix : '#include <X11/Xlib.h>; #include <X11/XKBlib.h>')
			configuration.set('SDL_VIDEO_DRIVER_X11_HAS_XKBKEYCODETOKEYSYM', true)
		endif
		
		code = '''#include <X11/Xlib.h>
			#include <X11/Xproto.h>
			#include <X11/extensions/XInput2.h>
			int event_type = XI_TouchBegin;
			XITouchClassInfo *t;
			Status XIAllowTouchEvents(Display *a,int b,unsigned int c,Window d,int f) {
			  return (Status)0;
			}
			int main(int argc, char **argv) { return 0; }'''

		result = compiler.compiles(code, name : 'xinput2 multitouch test')
		configuration.set('SDL_VIDEO_DRIVER_X11_XINPUT2_SUPPORTS_MULTITOUCH', result)
	
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
			wl_protos_src += custom_target(
				xml.underscorify() + '_server_c',
				input: xml,
				output: '@BASENAME@-protocol.c',
				command: [wayland_scanner, 'private-code', '@INPUT@', '@OUTPUT@'],
			)
			wl_protos_headers += custom_target(
				xml.underscorify() + '_server_h',
				input: xml,
				output: '@BASENAME@-protocol.h',
				command: [wayland_scanner, 'server-header', '@INPUT@', '@OUTPUT@'],
			)
		endforeach

		foreach xml : protocols
			wl_protos_headers += custom_target(
				xml.underscorify() + '_client_h',
				input: xml,
				output: '@BASENAME@-client-protocol.h',
				command: [wayland_scanner, 'client-header', '@INPUT@', '@OUTPUT@'],
			)
		endforeach

		lib_client_protos = static_library(
			'sdl_client_protos',
			wl_protos_src + wl_protos_headers,
			dependencies: wayland_client.partial_dependency(compile_args: true),
		)

		client_protos = declare_dependency(
			link_with: lib_client_protos,
			sources: wl_protos_headers,
		)
		link_deps += [
			client_protos,
		]
		
		configuration.set('SDL_VIDEO_DRIVER_WAYLAND', true)
		
		link_deps += dependency('wayland-cursor')
		
		if has_egl
			link_deps += dependency('wayland-egl')
		endif
		
		link_deps += dependency('xkbcommon')
		
		libdecor_dep = dependency('wayland-libdecor')
		if libdecor_dep.found()
			link_deps += libdecor_dep
			result_max = compiler.has_function('libdecor_frame_get_max_content_size', prefix : '#include <libdecor.h>')
			result_min = compiler.has_function('libdecor_frame_get_min_content_size', prefix : '#include <libdecor.h>')
			
			configuration.set('SDL_HAVE_LIBDECOR_GET_MIN_MAX', result_max and result_min)
		endif
		
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
		code = '''#include <gc_vdk.h>
			int main(int argc, char** argv) { return 0; }'''

		result = compiler.compiles(code, name : 'vivante vdk test')
		
		code = '''#define LINUX
			#define EGL_API_FB
			#include <EGL/eglvivante.h>
			int main(int argc, char** argv) { return 0; }'''

		result2 = compiler.compiles(code, name : 'vivante egl fb test')
		
		if result or result2
			configuration.set('SDL_VIDEO_DRIVER_VIVANTE_VDK', true)
			sources += [
				'src/video/vivante/SDL_vivanteopengles.c',
				'src/video/vivante/SDL_vivanteplatform.c',
				'src/video/vivante/SDL_vivantevideo.c',
				'src/video/vivante/SDL_vivantevulkan.c',
			]
		endif
		
		if result
			link_deps += dependency('vdk')
		else
			link_deps += dependency('EGL')
			c_flags += '-DEGL_API_FB'
		endif
	endif
elif target_machine.system() == 'darwin'
	
	c_flags += '-D_THREAD_SAFE'
	
	if has_libusb
		sources += 'src/hidapi/ios/hid.m'
	endif
	
	configuration.set('SDL_FRAMEWORK_COCOA', true)
	configuration.set('SDL_FRAMEWORK_CARBON', true)
	configuration.set('SDL_FRAMEWORK_FOUNDATION', true)
	configuration.set('SDL_FRAMEWORK_COREVIDEO', true)
	
	configuration.set('SDL_AUDIO_DRIVER_COREAUDIO', true)
	configuration.set('SDL_FRAMEWORK_COREAUDIO', true)
	configuration.set('SDL_FRAMEWORK_AUDIOTOOLBOX', true)
	configuration.set('SDL_FRAMEWORK_AVFOUNDATION', true)
	
	code = '''#include <AvailabilityMacros.h>
		#include <TargetConditionals.h>
		#import <Foundation/Foundation.h>
		#import <GameController/GameController.h>
		#if MAC_OS_X_VERSION_MIN_REQUIRED < 1080
		#error GameController framework doesn't work on this configuration
		#endif
		#if TARGET_CPU_X86
		#error GameController framework doesn't work on this configuration
		#endif
		int main() { return 0; }'''

	has_gamecontroller = objc_compiler.compiles(code, name : 'have framework game controller test')
	
	has_corehaptic = objc_compiler.has_header('CoreHaptics/CoreHaptics.h')
	
	if has_gamecontroller and has_corehaptic
		configuration.set('SDL_JOYSTICK_MFI', true)
		configuration.set('SDL_FRAMEWORK_GAMECONTROLLER', true)
		configuration.set('SDL_FRAMEWORK_COREHAPTICS', true)
	endif
	
	configuration.set('SDL_JOYSTICK_IOKIT', true)
	configuration.set('SDL_FRAMEWORK_IOKIT', true)
	configuration.set('SDL_FRAMEWORK_FF', true)
	
	configuration.set('SDL_HAPTIC_IOKIT', true)
	
	configuration.set('SDL_POWER_MACOSX', true)
	configuration.set('SDL_FRAMEWORK_IOKIT', true)
	
	configuration.set('SDL_FILESYSTEM_COCOA', true)
	configuration.set('SDL_VIDEO_DRIVER_COCOA', true)
	
	if has_ogl
		configuration.set(SDL_VIDEO_OPENGL_CGL, true)
	endif
	
	code = '''#include <AvailabilityMacros.h>
        #import <Metal/Metal.h>
        #import <QuartzCore/CAMetalLayer.h>

        #if (!TARGET_CPU_X86_64 && !TARGET_CPU_ARM64)
        #error Metal doesn't work on this configuration
        #endif
        int main(int argc, char **argv) { return 0; }'''

	has_metal = objc_compiler.compiles(code, name : 'have framework metal test')
	
	if has_metal
		configuration.set(SDL_FRAMEWORK_METAL, true)
		configuration.set(SDL_FRAMEWORK_QUARTZCORE, true)
		configuration.set(SDL_VIDEO_VULKAN, true)
		configuration.set(SDL_VIDEO_METAL, true)
		configuration.set(SDL_VIDEO_RENDER_METAL, true)
	endif

elif target_machine.system() == 'windows'
	c_flags += '-DHAVE__FSEEKI64'

	if use_msvc and is_32_bits
		c_flags += '/arch:SSE'
	endif

	configuration.set('SDL_LOADSO_WINDOWS', true)
	configuration.set('SDL_VIDEO_DRIVER_WINDOWS', true)
	configuration.set('SDL_THREAD_GENERIC_COND_SUFFIX', true)
	configuration.set('SDL_THREAD_WINDOWS', true)
	configuration.set('SDL_TIMER_WINDOWS', true)
	configuration.set('SDL_POWER_WINDOWS', true)
	configuration.set('SDL_FILESYSTEM_WINDOWS', true)
	configuration.set('SDL_VIDEO_VULKAN', true)
	configuration.set('SDL_JOYSTICK_RAWINPUT', true)
	configuration.set('SDL_JOYSTICK_HIDAPI', true)

	configuration.set('HAVE_DDRAW_H', compiler.has_header('ddraw.h'))
	configuration.set('HAVE_DXGI_H', compiler.has_header('dxgi.h'))
	

	has_xinput = compiler.has_header('xinput.h')
	if has_xinput
		configuration.set('HAVE_XINPUT_H', has_xinput)
		configuration.set('SDL_JOYSTICK_XINPUT', true)
	endif

	code = '''#include <windows.h>
		#include <xinput.h>
		XINPUT_GAMEPAD_EX x1;
		int main(int argc, char **argv) { return 0; }'''

	result = compiler.compiles(code, name : 'have xinput gamepad ex test')
	configuration.set('HAVE_XINPUT_GAMEPAD_EX', result)
	
	code = '''#include <windows.h>
		#include <xinput.h>
		XINPUT_STATE_EX s1;
		int main(int argc, char **argv) { return 0; }'''

	result = compiler.compiles(code, name : 'have xinput state ex test')
	configuration.set('HAVE_XINPUT_STATE_EX', result)

	code = '''#define COBJMACROS
		#include <windows.gaming.input.h>
		__x_ABI_CWindows_CGaming_CInput_CIGamepadStatics2 *s2;
		int main(int argc, char **argv) { return 0; }'''

	has_windowsgaminginput = compiler.compiles(code, name : 'have xinput gaming input test')
	configuration.set('HAVE_WINDOWS_GAMING_INPUT_H', has_windowsgaminginput)
	configuration.set('SDL_JOYSTICK_WGI', has_windowsgaminginput and has_xinput)

	has_dinput = false
	if build_machine.cpu() != 'aarch64'
		has_dinput = compiler.has_header('dinput.h')
	endif

	if has_dinput
		configuration.set('HAVE_DINPUT_H', has_dinput)
		configuration.set('SDL_JOYSTICK_DINPUT', true)
		link_deps += compiler.find_library('dinput8')
	endif
	
	if has_xinput or has_dinput
		configuration.set('SDL_HAPTIC_DINPUT', has_dinput)
		configuration.set('SDL_HAPTIC_XINPUT', has_xinput)
	
		sources += [
			'src/haptic/windows/SDL_dinputhaptic.c',
			'src/haptic/windows/SDL_windowshaptic.c',
			'src/haptic/windows/SDL_xinputhaptic.c',
		]
	else
		configuration.set('SDL_HAPTIC_DUMMY', has_dummy)
	
		sources += 'src/haptic/dummy/SDL_syshaptic.c'
	endif

	configuration.set('HAVE_TPCSHRD_H', compiler.has_header('tpcshrd.h'))
	configuration.set('HAVE_ROAPI_H', compiler.has_header('roapi.h'))
	
	has_mmdeviceapi = compiler.has_header('mmdeviceapi.h')
	configuration.set('HAVE_MMDEVICEAPI_H', has_mmdeviceapi)
	
	has_audioclient = compiler.has_header('audioclient.h')
	configuration.set('HAVE_AUDIOCLIENT_H', has_audioclient)

	if has_mmdeviceapi and has_audioclient
		configuration.set('SDL_AUDIO_DRIVER_WASAPI', true)
		
		sources += [
			'src/audio/wasapi/SDL_wasapi.c',
			'src/audio/wasapi/SDL_wasapi_win32.c',
		]
	endif

	
	if compiler.has_header('sensorsapi.h')
		configuration.set('HAVE_SENSORSAPI_H', true)
		configuration.set('SDL_SENSOR_WINDOWS', true)
		
		sources += 'src/sensor/windows/SDL_windowssensor.c'
	endif
	
	configuration.set('HAVE_SHELLSCALINGAPI_H', compiler.has_header('shellscalingapi.h'))

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

	if compiler.has_header('dsound.h')
		configuration.set('HAVE_DSOUND_H', true)
		configuration.set('SDL_AUDIO_DRIVER_DSOUND', true)
		
		sources += 'src/audio/directsound/SDL_directsound.c'
	endif

	if has_ogl
		configuration.set('SDL_VIDEO_OPENGL_WGL', true)
	endif
endif

if has_d3d
	configuration.set('HAVE_D3D_H', true)
	configuration.set('SDL_VIDEO_RENDER_D3D', true)
	sources += [ 'src/render/direct3d/SDL_render_d3d.c', 'src/render/direct3d/SDL_shaders_d3d.c']
endif

if has_d3d11
	configuration.set('HAVE_D3D11_H', true)
	configuration.set('SDL_VIDEO_RENDER_D3D11', true)
	sources += [ 'src/render/direct3d11/SDL_render_d3d11.c', 'src/render/direct3d11/SDL_shaders_d3d11.c']
endif

if has_d3d12
	configuration.set('HAVE_D3D12_H', true)
	configuration.set('SDL_VIDEO_RENDER_D3D12', true)
	sources += [ 'src/render/direct3d12/SDL_render_d3d12.c', 'src/render/direct3d12/SDL_shaders_d3d12.c']
endif

if has_ogl
	configuration.set('SDL_VIDEO_OPENGL', true)
	configuration.set('SDL_VIDEO_RENDER_OGL', true)
	sources += [ 'src/render/opengl/SDL_render_gl.c', 'src/render/opengl/SDL_shaders_gl.c']
endif

if has_egl
	configuration.set('SDL_VIDEO_OPENGL_EGL', true)
endif

if has_gles2
	configuration.set('SDL_VIDEO_OPENGL_ES2', true)
	configuration.set('SDL_VIDEO_RENDER_OGL_ES2', true)
	sources += [ 'src/render/opengles2/SDL_render_gles2.c', 'src/render/opengles2/SDL_shaders_gles2.c']
endif

headers = ['alloca.h', 'ctype.h', 'float.h', 'iconv.h', 'inttypes.h', 'limits.h',
			'malloc.h', 'math.h', 'memory.h', 'signal.h', 'stdarg.h', 'stddef.h',
			'stdint.h', 'stdio.h', 'stdlib.h', 'strings.h', 'string.h', 'sys/types.h',
			'wchar.h', 'libunwind.h']


foreach header : headers
	refName = header.replace('.', '_').replace('/', '_')
	header_availability = compiler.has_header(header)
	if header_availability
		has_headers += '#include <' +  header + '>'
	endif
	configuration.set('HAVE_' + refName.to_upper(), header_availability)
endforeach

functions = ['alloca', 'malloc', 'calloc', 'realloc', 'free', 'bsearch', 'qsort', 'abs', 'bcopy', 'memset', 'memcpy', 'memmove', 'memcmp', 'wcslen', '_wcsdup', 'wcsdup', 'wcslcat', 'wcslcpy', 'wcsstr', 'wcscmp', 'wcsncmp', 'wcscasecmp', '_wcsicmp', 'wcsncasecmp', '_wcsnicmp', 'strlen', 'strlcpy', 'strlcat', '_strrev', '_strupr', '_strlwr', 'index', 'rindex', 'strchr', 'strrchr', 'strstr', 'strtok_r', 'itoa', '_ltoa', '_uitoa', '_ultoa', '_i64toa', '_ui64toa', 'strtol', 'strtoul', 'strtoll', 'strtoull', 'strtod', 'atoi', 'atof', 'strcmp', 'strncmp', '_stricmp', 'strcasecmp', '_strnicmp', 'strncasecmp', 'strcasestr', 'sscanf', 'vsscanf', 'vsnprintf', 'fopen64', 'fseeko', 'fseeko64', '_Exit', 'acos', 'acosf', 'asin', 'asinf', 'atan', 'atanf', 'atan2', 'atan2f', 'ceil', 'ceilf', 'copysign', 'copysignf', 'cos', 'cosf', 'exp', 'expf', 'fabs', 'fabsf', 'floor', 'floorf', 'fmod', 'fmodf', 'log', 'logf', 'log10', 'log10f', 'lround', 'lroundf', 'modf', 'modff', 'pow', 'powf', 'round', 'roundf', 'scalbn', 'scalbnf', 'sin', 'sinf', 'sqrt', 'sqrtf', 'tan', 'tanf', 'trunc', 'truncf', 'getenv', 'setenv', 'putenv', 'unsetenv', '_Exit']

foreach function : functions
	configuration.set('HAVE_' + function.to_upper(),  compiler.has_function(function, prefix : has_headers))
endforeach

configuration.set('HAVE_SA_SIGACTION', compiler.has_member('struct sigaction', 'sa_sigaction', prefix : '#include <signal.h>'))

configuration.set('HAVE_SIGACTION', compiler.has_function('sigaction', prefix : '#include <signal.h>'))
configuration.set('HAVE_SETJMP', compiler.has_function('setjmp', prefix : '#include <setjmp.h>'))
configuration.set('HAVE_NANOSLEEP', compiler.has_function('nanosleep', prefix : '#include <time.h>'))
configuration.set('HAVE_SYSCONF', compiler.has_function('sysconf', prefix : '#include <unistd.h>'))
configuration.set('HAVE_SYSCTLBYNAME', compiler.has_function('sysctlbyname', prefix : [ '#include <sys/types.h>', '#include <sys/sysctl.h>' ]))
configuration.set('HAVE_GETAUXVAL', compiler.has_function('getauxval', prefix : '#include <sys/auxv.h>'))
configuration.set('HAVE_ELF_AUX_INFO', compiler.has_function('elf_aux_info', prefix : '#include <sys/auxv.h>'))
configuration.set('HAVE_POLL', compiler.has_function('poll', prefix : '#include <poll.h>'))

if use_gcc or use_clang or use_icc
	code = '''int main(int argc, char **argv) {
		int a;
		void *x, *y, *z;
		__sync_lock_test_and_set(&a, 4);
		__sync_lock_test_and_set(&x, y);
		__sync_fetch_and_add(&a, 1);
		__sync_bool_compare_and_swap(&a, 5, 10);
		__sync_bool_compare_and_swap(&x, y, z);
		return 0;
	}'''

	result = compiler.compiles(code, name : 'gcc atomics test')
	configuration.set('HAVE_GCC_ATOMICS', result)
	if not result
		code = '''int main(int argc, char **argv) {
			int a;
			__sync_lock_test_and_set(&a, 1);
			__sync_lock_release(&a);
			return 0;
		}'''

		result = compiler.compiles(code, name : 'gcc sync lock test and set')
		configuration.set('HAVE_GCC_SYNC_LOCK_TEST_AND_SET', result)
	endif
	
	configuration.set('HAVE_GCC_FVISIBILITY',
		compiler.has_function_attribute('visibility:default') and
		compiler.has_function_attribute('visibility:hidden'))
endif

configure_file(input : 'include/build_config/SDL_build_config.h.cmake',
  output : 'SDL_build_config.h',
  format : 'cmake@',
  configuration : configuration)


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
		'src/filesystem/windows/SDL_sysfilesystem.c',
		'src/hidapi/windows/hid.c',
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
		'src/thread/generic/SDL_syscond.c',
		'src/thread/windows/SDL_syscond_cv.c',
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
		'src/core/linux/SDL_evdev_capabilities.c',
		'src/core/linux/SDL_sandbox.c',
		'src/core/linux/SDL_threadprio.c',
		'src/events/imKStoUCS.c',
		'src/events/SDL_keysym_to_scancode.c',
		'src/power/linux/SDL_syspower.c',
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
		'src/file/cocoa/SDL_rwopsbundlesupport.m',
		'src/filesystem/cocoa/SDL_sysfilesystem.m',
		'src/misc/macos/SDL_sysurl.m',
		'src/haptic/darwin/SDL_syshaptic.c',
		'src/locale/macos/SDL_syslocale.m',
		'src/joystick/apple/SDL_iokitjoystick.c',
		'src/render/metal/SDL_render_metal.m',
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

incdirs = include_directories(incdirs)
build_incdirs = include_directories(build_incdirs)

sdl_lib = library(
	'sdl3',
	sources,
	include_directories: [incdirs, build_incdirs],
	c_args: c_flags,
	dependencies: link_deps,
	objc_args: objc_flags,
)

sdl_dep = declare_dependency(
	compile_args: [ c_flags, objc_flags ],
	include_directories: incdirs,
	dependencies: link_deps,
	link_with: sdl_lib,
	version: meson.project_version()
)

meson.override_dependency('sdl3', sdl_dep)

# vim: set ts=4 sts=4 sw=4 et:
