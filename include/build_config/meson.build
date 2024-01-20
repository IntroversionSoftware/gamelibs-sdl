configuration = configuration_data()
configuration.set('HAVE_LIBC', true)

# headers
has_headers = []

if has_libudev
	has_headers += '#include <libudev.h>'
endif

if has_linux_input
	has_headers += '#include <linux/input.h>'
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

if compiler.has_header('pthread_np.h')
	configuration.set('HAVE_PTHREAD_NP_H', true)
		
	result = compiler.has_function('pthread_set_name_np', prefix : '#include <pthread.h>; #include <pthread_np.h>')
	configuration.set('HAVE_PTHREAD_SET_NAME_NP', result)
endif


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

configuration.set('SDL_ALTIVEC_BLITTERS', has_altivec)
configuration.set('SDL_ARM_SIMD_BLITTERS', has_armsimd)
configuration.set('SDL_ARM_NEON_BLITTERS', has_armneon)

configuration.set('SDL_DEFAULT_ASSERT_LEVEL_CONFIGURED', true)
configuration.set('SDL_DEFAULT_ASSERT_LEVEL', 1) # release

configuration.set('SDL_AUDIO_DRIVER_DUMMY', get_option('dummyAudio').enabled())
configuration.set('SDL_AUDIO_DRIVER_DISK', get_option('diskAudio').enabled())

configuration.set('SDL_JOYSTICK_VIRTUAL', get_option('virtualJoystick').enabled())

configuration.set('SDL_VIDEO_DRIVER_DUMMY', get_option('dummyVideo').enabled())

configuration.set('HAVE_LIBM', has_libm)
configuration.set('HAVE_LIBICONV', has_libiconv)
configuration.set('HAVE_LIBUDEV_H', has_libudev)
configuration.set('HAVE_LIBUSB', has_libusb)

configuration.set('HAVE_LINUX_INPUT_H', has_linux_input)
configuration.set('HAVE_DBUS_DBUS_H', has_libdbus)
configuration.set('HAVE_FCITX', has_libdbus)

configuration.set('HAVE_IBUS_IBUS_H', has_libibus)

configuration.set('SDL_USE_IME', has_libdbus or has_libibus)

configuration.set('SDL_VIDEO_DRIVER_X11', has_x11)
configuration.set('SDL_VIDEO_DRIVER_VIVANTE', has_vivante)
configuration.set('SDL_VIDEO_DRIVER_VIVANTE_VDK', has_vivante_vdk)

if target_machine.system() != 'windows'
	configuration.set('DYNAPI_NEEDS_DLOPEN', true)
	configuration.set('SDL_THREAD_PTHREAD', true)
	configuration.set('SDL_TIMER_UNIX', true)
	configuration.set('HAVE_CLOCK_GETTIME', compiler.has_function('clock_gettime'))
	configuration.set('HAVE_DLOPEN', compiler.has_function('dlopen', prefix : '#include<dlfcn.h>'))


	if has_semaphore
		configuration.set('HAVE_SEM_TIMEDWAIT', compiler.has_function('sem_timedwait', prefix : '#include<semaphore.h>'))
	endif
	
	result = compiler.has_define(PTHREAD_MUTEX_RECURSIVE, prefix: '#include <pthread.h>')
	configuration.set('SDL_THREAD_PTHREAD_RECURSIVE_MUTEX', result)
	
	result = compiler.has_define(PTHREAD_MUTEX_RECURSIVE_NP, prefix: '#include <pthread.h>')
	configuration.set('SDL_THREAD_PTHREAD_RECURSIVE_MUTEX_NP', result)

	result = compiler.has_function('pthread_setname_np', prefix : '#include<pthread.h>')
	configuration.set('HAVE_PTHREAD_SETNAME_NP', result)
	

endif

if target_machine.system() == 'linux'
	link_deps += compiler.find_library('dl')

	c_flags += ['-D_REENTRANT', '-D_LARGEFILE64_SOURCE']

	if has_linux_input
		result = compiler.has_define('EVIOCGNAME', prefix: '#include <linux/input.h>')
		configuration.set('SDL_INPUT_LINUXEV', result)
	endif
	
	configuration.set('SDL_INPUT_LINUXKD', compiler.has_header('linux/kd.h'))

	configuration.set('HAVE_SYS_INOTIFY_H', has_inotify)
	if has_inotify
		result = compiler.has_function('inotify_init', prefix : 'sys/inotify.h')
		result2 = compiler.has_function('inotify_init1', prefix : 'sys/inotify.h')

		configuration.set('HAVE_INOTIFY_INIT', result)
		configuration.set('HAVE_INOTIFY_INIT1', result2)
		configuration.set('HAVE_INOTIFY', result or result2)
	endif
	
	configuration.set('SDL_AUDIO_DRIVER_OSS', has_ossaudio)
	configuration.set('SDL_AUDIO_DRIVER_ALSA', has_asound)
	configuration.set('SDL_AUDIO_DRIVER_PIPEWIRE', has_pipewire)
	configuration.set('SDL_AUDIO_DRIVER_PULSEAUDIO', has_pulse)
	configuration.set('SDL_AUDIO_DRIVER_JACK', has_jack)
	configuration.set('SDL_AUDIO_DRIVER_SNDIO', has_sndio)

	if has_x11
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
		configuration.set('SDL_VIDEO_DRIVER_WAYLAND', true)
		
		result_max = compiler.has_function('libdecor_frame_get_max_content_size', prefix : '#include <libdecor.h>')
		result_min = compiler.has_function('libdecor_frame_get_min_content_size', prefix : '#include <libdecor.h>')
		configuration.set('SDL_HAVE_LIBDECOR_GET_MIN_MAX', result_max and result_min)
	endif

elif target_machine.system() == 'darwin'
	

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
	
	configuration.set(SDL_VIDEO_OPENGL_CGL, has_ogl)
	
	code = '''#include <AvailabilityMacros.h>
        #import <Metal/Metal.h>
        #import <QuartzCore/CAMetalLayer.h>

        #if (!TARGET_CPU_X86_64 && !TARGET_CPU_ARM64)
        #error Metal doesn't work on this configuration
        #endif
        int main(int argc, char **argv) { return 0; }'''

	has_metal = objc_compiler.compiles(code, name : 'have framework metal test')
	
	configuration.set(SDL_FRAMEWORK_METAL, has_metal)
	configuration.set(SDL_FRAMEWORK_QUARTZCORE, has_metal)
	configuration.set(SDL_VIDEO_VULKAN, has_metal)
	configuration.set(SDL_VIDEO_METAL, has_metal)
	configuration.set(SDL_VIDEO_RENDER_METAL, has_metal)

elif target_machine.system() == 'windows'

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
	
	configuration.set('HAVE_XINPUT_H', has_xinput)
	configuration.set('SDL_JOYSTICK_XINPUT', has_xinput)

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


	configuration.set('HAVE_DINPUT_H', has_dinput)
	configuration.set('SDL_JOYSTICK_DINPUT', has_dinput)
	
	configuration.set('SDL_HAPTIC_DINPUT', has_dinput)
	configuration.set('SDL_HAPTIC_XINPUT', has_xinput)
	configuration.set('SDL_HAPTIC_DUMMY', not has_xinput and not has_dinput)

	configuration.set('HAVE_TPCSHRD_H', compiler.has_header('tpcshrd.h'))
	configuration.set('HAVE_ROAPI_H', compiler.has_header('roapi.h'))
	
	configuration.set('HAVE_MMDEVICEAPI_H', has_mmdeviceapi)
	configuration.set('HAVE_AUDIOCLIENT_H', has_audioclient)

	configuration.set('SDL_AUDIO_DRIVER_WASAPI', has_mmdeviceapi and has_audioclient)

	
	configuration.set('HAVE_SENSORSAPI_H', has_sensorapi)
	configuration.set('SDL_SENSOR_WINDOWS', has_sensorapi)
	
	configuration.set('HAVE_SHELLSCALINGAPI_H', compiler.has_header('shellscalingapi.h'))

	configuration.set('HAVE_DSOUND_H', has_dsound)
	configuration.set('SDL_AUDIO_DRIVER_DSOUND', has_dsound)

	configuration.set('SDL_VIDEO_OPENGL_WGL', has_ogl)
endif

configuration.set('HAVE_D3D_H', has_d3d)
configuration.set('SDL_VIDEO_RENDER_D3D', has_d3d)

configuration.set('HAVE_D3D11_H', has_d3d11)
configuration.set('SDL_VIDEO_RENDER_D3D11', has_d3d11)

configuration.set('HAVE_D3D12_H', has_d3d12)
configuration.set('SDL_VIDEO_RENDER_D3D12', has_d3d12)

configuration.set('SDL_VIDEO_OPENGL', has_ogl)
configuration.set('SDL_VIDEO_RENDER_OGL', has_ogl)

configuration.set('SDL_VIDEO_OPENGL_EGL', has_egl)

configuration.set('SDL_VIDEO_OPENGL_ES2', has_gles2)
configuration.set('SDL_VIDEO_RENDER_OGL_ES2', has_gles2)






functions = ['alloca', 'malloc', 'calloc', 'realloc', 'free', 'bsearch',
			 'qsort', 'abs', 'bcopy', 'memset', 'memcpy', 'memmove', 'memcmp',
			 'wcslen', '_wcsdup', 'wcsdup', 'wcslcat', 'wcslcpy', 'wcsstr',
			 'wcscmp', 'wcsncmp', 'wcscasecmp', '_wcsicmp', 'wcsncasecmp',
			 '_wcsnicmp', 'strlen', 'strlcpy', 'strlcat', '_strrev', '_strupr',
			 '_strlwr', 'index', 'rindex', 'strchr', 'strrchr', 'strstr', 'strtok_r',
			 'itoa', '_ltoa', '_uitoa', '_ultoa', '_i64toa', '_ui64toa', 'strtol',
			 'strtoul', 'strtoll', 'strtoull', 'strtod', 'atoi', 'atof', 'strcmp',
			 'strncmp', '_stricmp', 'strcasecmp', '_strnicmp', 'strncasecmp',
			 'strcasestr', 'sscanf', 'vsscanf', 'vsnprintf', 'fopen64', 'fseeko',
			 'fseeko64', '_Exit', 'acos', 'acosf', 'asin', 'asinf', 'atan', 'atanf',
			 'atan2', 'atan2f', 'ceil', 'ceilf', 'copysign', 'copysignf', 'cos', 'cosf',
			 'exp', 'expf', 'fabs', 'fabsf', 'floor', 'floorf', 'fmod', 'fmodf', 'log', 'logf',
			 'log10', 'log10f', 'lround', 'lroundf', 'modf', 'modff', 'pow', 'powf', 'round',
			 'roundf', 'scalbn', 'scalbnf', 'sin', 'sinf', 'sqrt', 'sqrtf', 'tan', 'tanf',
			 'trunc', 'truncf', 'getenv', 'setenv', 'putenv', 'unsetenv', '_Exit'
]

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
	result = compiler.has_function('__sync_lock_test_and_set')
	configuration.set('HAVE_GCC_SYNC_LOCK_TEST_AND_SET', result)

	if result
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
	endif
	
	configuration.set('HAVE_GCC_FVISIBILITY',
		compiler.has_function_attribute('visibility:default') and
		compiler.has_function_attribute('visibility:hidden'))
endif

configure_file(input : 'SDL_build_config.h.cmake',
  output : 'SDL_build_config.h',
  format : 'cmake@',
  configuration : configuration)
