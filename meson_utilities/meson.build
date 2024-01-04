compiler = meson.get_compiler('c')

# Compiler info
use_clang = false
use_msvc = false
use_icc = false
use_gcc = false
use_cl = false

if compiler.get_id() == 'clang' or compiler.get_id() == 'clang-cl'
	use_clang = true
	if compiler.get_id() == 'clang-cl'
		use_cl = true
	else
		use_gcc = true
	endif
elif compiler.get_id() == 'gcc'
	use_gcc = true
elif compiler.get_id() == 'msvc'
	use_msvc = true
	use_cl = true
elif compiler.get_id() == 'intel'
	use_icc = true
elif compiler.get_id() == 'intel-cl'
	use_icc = true
	use_cl = true
elif compiler.get_id() == 'intel-llvm'
	use_icc = true
	use_clang = true
elif compiler.get_id() == 'intel-llvm-cl'
	use_icc = true
	use_clang = true
	use_cl = true
endif

#platform
is_64_bits = false
is_32_bits = false

if target_machine.cpu_family() == 'aarch64' or target_machine.cpu_family() == 'x86_64' or target_machine.cpu_family() == 'ia64' or target_machine.cpu_family() == 'loongarch64' or target_machine.cpu_family() == 'mips64' or target_machine.cpu_family() == 'ppc64' or target_machine.cpu_family() == 'riscv64' or target_machine.cpu_family() == 'sparc64' or target_machine.cpu_family() == 'sw_64' or target_machine.cpu_family() == 'wasm64'
	is_64_bits = true
elif target_machine.cpu_family() == 'x86' or target_machine.cpu_family() == 'arc' or target_machine.cpu_family() == 'arm' or target_machine.cpu_family() == 'c2000' or target_machine.cpu_family() == 'csky' or target_machine.cpu_family() == 'ft32' or target_machine.cpu_family() == 'mips' or target_machine.cpu_family() == 'ppc' or target_machine.cpu_family() == 'riscv32' or target_machine.cpu_family() == 'sparc' or target_machine.cpu_family() == 'wasm32'
	is_32_bits = true
endif




#intrinsics
has_mmx = false
has_sse = false
has_sse2 = false
has_sse3 = false
has_sse4_1 = false
has_sse4_2 = false
has_avx = false
has_avx2 = false
has_avx512f = false
has_altivec = false
has_armsimd = false
has_armneon = false

if test_intrinsics

# MMX test
	code = '''#include <mmintrin.h>
		void ints_add(int *dest, int *a, int *b, unsigned size) {
			for (; size >= 2; size -= 2, dest += 2, a += 2, b += 2) {
				*(__m64*)dest = _mm_add_pi32(*(__m64*)a, *(__m64*)b);
			}
		}
		int main(int argc, char *argv[]) {
			ints_add((int*)0, (int*)0, (int*)0, 0);
			return 0;
		}'''
		
	testFlags = []
	if use_gcc or use_clang or use_icc
		testFlags += '-mmmx'
	endif

	has_mmx = compiler.compiles(code, name : 'check MMX', args : testFlags)

	# SSE test
	code = '''#include <xmmintrin.h>
		void floats_add(float *dest, float *a, float *b, unsigned size) {
			for (; size >= 4; size -= 4, dest += 4, a += 4, b += 4) {
				_mm_storeu_ps(dest, _mm_add_ps(_mm_loadu_ps(a), _mm_loadu_ps (b)));
			}
		}
		int main(int argc, char **argv) {
			floats_add((float*)0, (float*)0, (float*)0, 0);
			return 0;
		}'''
		
	testFlags = []
	if use_gcc or use_clang or use_icc
		testFlags += '-msse'
	endif

	has_sse = compiler.compiles(code, name : 'check SSE', args : testFlags)

	# SSE2 test
	code = '''#include <emmintrin.h>
		void doubles_add(double *dest, double *a, double *b, unsigned size) {
			for (; size >= 4; size -= 4, dest += 4, a += 4, b += 4) {
				_mm_store_pd(dest, _mm_add_pd(_mm_loadu_pd(a), _mm_loadu_pd(b)));
			}
		}
		int main(int argc, char **argv) {
			doubles_add((double*)0, (double*)0, (double*)0, 0);
			return 0;
		}'''

	testFlags = []
	if use_gcc or use_clang or use_icc
		testFlags += '-msse2'
	endif

	has_sse2 = compiler.compiles(code, name : 'check SSE2', args : testFlags)

	# SSE3 test
	code = '''#include <pmmintrin.h>
		void ints_add(int *dest, int *a, int *b, unsigned size) {
			for (; size >= 4; size -= 4, dest += 4, a += 4, b += 4) {
				_mm_storeu_si128((__m128i*)dest, _mm_add_epi32(_mm_lddqu_si128((__m128i*)a), _mm_lddqu_si128((__m128i*)b)));
			}
		}
		int main(int argc, char **argv) {
			ints_add((int*)0, (int*)0, (int*)0, 0);
			return 0;
		}'''

	testFlags = []
	if use_gcc or use_clang or use_icc
		testFlags += '-msse3'
	endif

	has_sse3 = compiler.compiles(code, name : 'check SSE3', args : testFlags)

	# SSE4_1 test
	code = '''#include <smmintrin.h>
		void ints_mul(int *dest, int *a, int *b, unsigned size) {
			for (; size >= 4; size -= 4, dest += 4, a += 4, b += 4) {
			_mm_storeu_si128((__m128i*)dest, _mm_mullo_epi32(_mm_lddqu_si128((__m128i*)a), _mm_lddqu_si128((__m128i*)b)));
			}
		}
		int main(int argc, char **argv) {
			ints_mul((int*)0, (int*)0, (int*)0, 0);
			return 0;
		}'''

	testFlags = []
	if use_gcc or use_clang or use_icc
		testFlags += '-msse4.1'
	endif

	has_sse4_1 = compiler.compiles(code, name : 'check SSE4_1', args : testFlags)

	# SSE4_2 test
	code = '''#include <nmmintrin.h>
		unsigned calc_crc32c(const char *text, unsigned len) {
			unsigned crc32c = ~0;
			for (; len >= 4; len -= 4, text += 4) {
				crc32c = (unsigned)_mm_crc32_u32(crc32c, *(unsigned*)text);
			}
			return crc32c;
		}
		int main(int argc, char **argv) {
			calc_crc32c("CON_SSE4",8);
			return 0;
		}'''
		
	testFlags = []
	if use_gcc or use_clang or use_icc
		testFlags += '-msse4.2'
	endif

	has_sse4_2 = compiler.compiles(code, name : 'check SSE4_2', args : testFlags)

	# AVX test
	code = '''#include <immintrin.h>
		void floats_add(float *dest, float *a, float *b, unsigned size) {
			for (; size >= 8; size -= 8, dest += 8, a += 8, b += 8) {
				_mm256_storeu_ps(dest, _mm256_add_ps(_mm256_loadu_ps(a), _mm256_loadu_ps(b)));
			}
		}
		int main(int argc, char **argv) {
			floats_add((float*)0, (float*)0, (float*)0, 0);
			return 0;
		}'''
		
	testFlags = []
	if use_gcc or use_clang or use_icc
		testFlags += '-mavx'
	endif

	has_avx = compiler.compiles(code, name : 'check AVX', args : testFlags)

	# AVX2 test
	code = '''#include <immintrin.h>
		void ints_add(int *dest, int *a, int *b, unsigned size) {
			for (; size >= 8; size -= 8, dest += 8, a += 8, b += 8) {
				_mm256_storeu_si256((__m256i*)dest, _mm256_add_epi32(_mm256_loadu_si256((__m256i*)a), _mm256_loadu_si256((__m256i*)b)));
			}
		}
		int main(int argc, char **argv) {
			ints_add((int*)0, (int*)0, (int*)0, 0);
			return 0;
		}'''
		
	testFlags = []
	if use_gcc or use_clang or use_icc
		testFlags += '-mavx2'
	endif

	has_avx2 = compiler.compiles(code, name : 'check AVX2', args : testFlags)

	# AVX512f test
	code = '''#include <immintrin.h>
		void floats_add(float *dest, float *a, float *b, unsigned size) {
			for (; size >= 16; size -= 16, dest += 16, a += 16, b += 16) {
				_mm512_storeu_ps(dest, _mm512_add_ps(_mm512_loadu_ps(a), _mm512_loadu_ps(b)));
			}
		}
		int main(int argc, char **argv) {
			floats_add((float*)0, (float*)0, (float*)0, 0);
			return 0;
		}'''
		
	testFlags = []
	if use_gcc or use_clang or use_icc
		testFlags += '-mavx512f'
	endif

	has_avx512f = compiler.compiles(code, name : 'check AVX512f', args : testFlags)


	# ALTIVEC test
	code = '''#include <altivec.h>
		vector unsigned int vzero() {
			return vec_splat_u32(0);
		}
		int main(int argc, char **argv) { return 0; }'''
		
	testFlags = []
	if use_gcc or use_clang or use_icc
		testFlags += '-maltivec'
	endif

	has_altivec = compiler.compiles(code, name : 'check ALTIVEC', args : testFlags)


	# ARMSIMD test
	code = '''.text
		.arch armv6
		.object_arch armv4
		.arm
		.altmacro
		#ifndef __ARM_EABI__
		#error EABI is required (to be sure that calling conventions are compatible)
		#endif
		main:
		.global main
		pld [r0]
		uqadd8 r0, r0, r0
		'''
		
	testFlags = [ '-x assembler-with-cpp' ]

	has_armsimd = compiler.compiles(code, name : 'check ARMSIMD', args : testFlags)

	# ARMNeon test
	code = '''.text
		.fpu neon
		.arch armv7a
		.object_arch armv4
		.eabi_attribute 10, 0
		.arm
		.altmacro
		#ifndef __ARM_EABI__
		#error EABI is required (to be sure that calling conventions are compatible)
		#endif
		main:
		.global main
		pld [r0]
		vmovn.u16 d0, q0'''
		
	testFlags = [ '-x assembler-with-cpp' ]

	has_armneon = compiler.compiles(code, name : 'check ARMNeon', args : testFlags)

endif

