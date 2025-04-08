# -*- Makefile -*- for sdl

.SECONDEXPANSION:
.SUFFIXES:

ifneq ($(findstring $(MAKEFLAGS),s),s)
ifndef V
        QUIET          = @
        QUIET_CC       = @echo '   ' CC $<;
        QUIET_AR       = @echo '   ' AR $@;
        QUIET_GEN      = @echo '   ' GEN $@;
        QUIET_RANLIB   = @echo '   ' RANLIB $@;
        QUIET_INSTALL  = @echo '   ' INSTALL $<;
        export V
endif
endif

uname_S ?= $(shell uname -s)

# Since Windows builds could be done with MinGW or Cygwin,
# set a TARGET_OS_WINDOWS flag when either shows up.
ifneq (,$(findstring MINGW,$(uname_S)))
TARGET_OS_WINDOWS := YesPlease
endif
ifneq (,$(findstring CYGWIN,$(uname_S)))
TARGET_OS_WINDOWS := YesPlease
endif
ifneq (,$(findstring Linux,$(uname_S)))
TARGET_OS_LINUX   := YesPlease
endif
ifneq (,$(findstring Darwin,$(uname_S)))
TARGET_OS_MACOSX  := YesPlease
endif

SDL_LIB = libSDL.a

AR       ?= ar
ARFLAGS  ?= rc
CC       ?= gcc
CXX      ?= g++
RANLIB   ?= ranlib
RM       ?= rm -f
PYTHON   ?= python

BUILD_DIR := build
BUILD_ID  ?= default-build-id
OBJ_DIR   := $(BUILD_DIR)/$(BUILD_ID)

ifeq (,$(BUILD_ID))
$(error BUILD_ID cannot be an empty string)
endif

prefix ?= /usr/local
libdir := $(prefix)/lib
includedir := $(prefix)/include

CFLAGS ?= -O2
CFLAGS += -I$(OBJ_DIR)/include -Isrc -Isrc/video/khronos -Iinclude/build_config -Iinclude -D_LARGEFILE64_SOURCE

HEADERS = include/SDL3/*.h

SDL_SOURCES = \
    src/*.c \
    src/atomic/*.c \
    src/audio/*.c \
    src/audio/disk/*.c \
    src/audio/dummy/*.c \
    src/camera/*.c \
    src/camera/dummy/*.c \
    src/core/*.c \
    src/cpuinfo/*.c \
    src/dialog/*.c \
    src/dialog/dummy/*.c \
    src/dynapi/*.c \
    src/events/*.c \
    src/file/*.c \
    src/filesystem/*.c \
    src/filesystem/dummy/*.c \
    src/gpu/*.c \
    src/gpu/vulkan/*.c \
    src/haptic/*.c \
    src/haptic/dummy/*.c \
    src/haptic/hidapi/*.c \
    src/hidapi/*.c \
    src/io/*.c \
    src/io/generic/*.c \
    src/joystick/*.c \
    src/joystick/dummy/*.c \
    src/joystick/hidapi/*.c \
    src/joystick/virtual/*.c \
    src/libm/*.c \
    src/loadso/dummy/*.c \
    src/locale/*.c \
    src/locale/dummy/*.c \
    src/main/*.c \
    src/misc/*.c \
    src/power/*.c \
    src/process/*.c \
    src/process/dummy/*.c \
    src/render/*.c \
    src/render/gpu/*.c \
    src/render/opengl/*.c \
    src/render/opengles2/*.c \
    src/render/software/*.c \
    src/render/vulkan/*.c \
    src/sensor/*.c \
    src/sensor/dummy/*.c \
    src/stdlib/*.c \
    src/storage/*.c \
    src/storage/generic/*.c \
    src/storage/steam/*.c \
    src/thread/*.c \
    src/time/*.c \
    src/timer/*.c \
    src/timer/dummy/*.c \
    src/tray/*.c \
    src/tray/dummy/*.c \
    src/video/*.c \
    src/video/offscreen/*.c \
    src/video/yuv2rgb/*.c \

ifndef TARGET_OS_WINDOWS
# Common to non-Windows platforms
SDL_SOURCES += \
    src/core/unix/*.c \
    src/dialog/unix/*.c \
    src/filesystem/posix/*.c \
    src/filesystem/unix/*.c \
    src/loadso/dlopen/*.c \
    src/locale/unix/*.c \
    src/misc/unix/*.c \
    src/process/posix/*.c \
    src/thread/pthread/*.c \
    src/time/unix/*.c \
    src/timer/unix/*.c \
    src/tray/unix/*.c \

endif

ifdef TARGET_OS_LINUX
CFLAGS += $(shell pkg-config --cflags libusb-1.0)
SDL_SOURCES += \
    src/audio/alsa/*.c \
    src/audio/dsp/*.c \
    src/audio/jack/*.c \
    src/audio/pulseaudio/*.c \
    src/core/linux/*.c \
    src/haptic/linux/*.c \
    src/joystick/linux/*.c \
    src/joystick/steam/*.c \
    src/misc/unix/*.c \
    src/power/linux/*.c \
    src/video/wayland/*.c \
    src/video/x11/*.c \

endif

ifdef TARGET_OS_MACOSX
CFLAGS += -Isrc/video/khronos
OBJCFLAGS += -fobjc-weak -fobjc-arc
SDL_SOURCES += \
    src/audio/coreaudio/*.m \
    src/camera/coremedia/*.m \
    src/dialog/cocoa/*.m \
    src/filesystem/cocoa/*.m \
    src/gpu/metal/*.m \
    src/haptic/darwin/*c \
    src/joystick/darwin/*.c \
    src/joystick/apple/*.m \
    src/locale/macos/*.m \
    src/misc/macosx/*.m \
    src/power/macosx/*.c \
    src/render/metal/*.m \
    src/sensor/coremotion/*.c \
    src/tray/cocoa/*.c \
    src/video/cocoa/*.m \
    src/video/uikit/*.m \

endif

ifdef TARGET_OS_WINDOWS
SDL_SOURCES += \
    src/audio/directsound/*.c \
    src/audio/wasapi/*.c \
    src/camera/mediafoundation/*.c \
    src/core/windows/*.c \
    src/dialog/windows/*.c \
    src/filesystem/windows/*.c \
    src/gpu/d3d12/*.c \
    src/haptic/windows/*.c \
    src/hidapi/windows/*.c \
    src/io/windows/*.c \
    src/joystick/gdk/*.c \
    src/joystick/windows/*.c \
    src/loadso/windows/*.c \
    src/locale/windows/*.c \
    src/main/windows/*.c \
    src/misc/windows/*.c \
    src/power/windows/*.c \
    src/process/windows/*.c \
    src/render/direct3d/*.c \
    src/render/direct3d11/*.c \
    src/render/direct3d12/*.c \
    src/sensor/windows/*.c \
    src/thread/generic/SDL_syscond.c \
    src/thread/windows/*.c \
    src/time/windows/*.c \
    src/timer/windows/*.c \
    src/video/windows/*.c \

endif

SDL_SOURCES := $(wildcard $(SDL_SOURCES))
HEADERS := $(wildcard $(HEADERS))

HEADERS_INST := $(patsubst include/%,$(includedir)/%,$(HEADERS))
SDL_OBJECTS := $(filter %.o,$(patsubst %.c,$(OBJ_DIR)/%.o,$(SDL_SOURCES)))
SDL_OBJECTS += $(filter %.o,$(patsubst %.m,$(OBJ_DIR)/%.o,$(SDL_SOURCES)))
SDL_OBJECTS += $(filter %.o,$(patsubst %.cpp,$(OBJ_DIR)/%.o,$(SDL_SOURCES)))

.PHONY: install

INSTALL_TARGETS := $(HEADERS_INST) $(libdir)/$(SDL_LIB)
ALL_TARGETS := $(OBJ_DIR)/$(SDL_LIB)

all: $(ALL_TARGETS)

$(OBJ_DIR)/include/SDL3/SDL_revision.h:
	$(QUIET_GEN)$(PYTHON) msvc/gen_revision.py $@

$(includedir)/%.h: include/%.h
	$(QUIET_INSTALL)install -Dm0644 $< $@

$(libdir)/%.a: $(OBJ_DIR)/%.a $(OBJ_DIR)/include/SDL3/SDL_revision.h
	$(QUIET_INSTALL)install -Dm0644 $< $@

install: $(INSTALL_TARGETS)

clean:
	$(RM) -r $(OBJ_DIR)

distclean:
	$(RM) -r $(BUILD_DIR)

$(OBJ_DIR)/$(SDL_LIB): $(SDL_OBJECTS) | $$(@D)/.
	$(QUIET_AR)$(AR) $(ARFLAGS) $@ $^
	$(QUIET_RANLIB)$(RANLIB) $@

$(OBJ_DIR)/%.o: %.c $(OBJ_DIR)/include/SDL3/SDL_revision.h $(OBJ_DIR)/.cflags | $$(@D)/.
	$(QUIET_CC)$(CC) $(CFLAGS) -o $@ -c $<

$(OBJ_DIR)/%.o: %.cpp $(OBJ_DIR)/include/SDL3/SDL_revision.h $(OBJ_DIR)/.cflags | $$(@D)/.
	$(QUIET_CXX)$(CXX) $(CFLAGS) -o $@ -c $<

$(OBJ_DIR)/%.o: %.m $(OBJ_DIR)/include/SDL3/SDL_revision.h $(OBJ_DIR)/.cflags | $$(@D)/.
	$(QUIET_CC)$(CC) $(CFLAGS) $(OBJCFLAGS) -o $@ -c $<

.PRECIOUS: $(OBJ_DIR)/. $(OBJ_DIR)%/.

$(OBJ_DIR)/.:
	$(QUIET)mkdir -p $@

$(OBJ_DIR)%/.:
	$(QUIET)mkdir -p $@

TRACK_CFLAGS = $(subst ','\'',$(CC) $(CFLAGS) $(OBJCFLAGS))

$(OBJ_DIR)/.cflags: .force-cflags | $$(@D)/.
	@FLAGS='$(TRACK_CFLAGS)'; \
    if test x"$$FLAGS" != x"`cat $(OBJ_DIR)/.cflags 2>/dev/null`" ; then \
        echo "    * rebuilding sdl: new build flags or prefix"; \
        echo "$$FLAGS" > $(OBJ_DIR)/.cflags; \
    fi

.PHONY: .force-cflags
