# -*- Makefile -*- for sdl

.SECONDEXPANSION:
.SUFFIXES:

ifneq ($(findstring $(MAKEFLAGS),s),s)
ifndef V
        QUIET          = @
        QUIET_CC       = @echo '   ' CC $<;
        QUIET_AR       = @echo '   ' AR $@;
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
SDLMAIN_LIB = libSDLmain.a
AR    ?= ar
ARFLAGS ?= rc
CC    ?= gcc
CXX   ?= g++
RANLIB?= ranlib
RM    ?= rm -f

BUILD_DIR := build
BUILD_ID  ?= default-build-id
OBJ_DIR   := $(BUILD_DIR)/$(BUILD_ID)

ifeq (,$(BUILD_ID))
$(error BUILD_ID cannot be an empty string)
endif

prefix ?= /usr/local
libdir := $(prefix)/lib
includedir := $(prefix)/include/SDL

CFLAGS += -Isrc/hidapi/hidapi

HEADERS = include/*.h

SDL_SOURCES = \
    src/*.c \
    src/atomic/*.c \
    src/audio/*.c \
    src/audio/disk/*.c \
    src/audio/dummy/*.c \
    src/cpuinfo/*.c \
    src/dynapi/*.c \
    src/events/*.c \
    src/file/*.c \
    src/haptic/*.c \
    src/haptic/dummy/*.c \
    src/hidapi/*.c \
    src/joystick/*.c \
    src/joystick/dummy/*.c \
    src/joystick/hidapi/*.c \
    src/joystick/virtual/*.c \
    src/libm/*.c \
    src/loadso/dummy/*.c \
    src/locale/*.c \
    src/misc/*.c \
    src/power/*.c \
    src/filesystem/dummy/*.c \
    src/render/*.c \
    src/render/software/*.c \
    src/render/opengl/*.c \
    src/render/opengles2/*.c \
    src/sensor/*.c \
    src/sensor/dummy/*.c \
    src/stdlib/*.c \
    src/thread/*.c \
    src/timer/*.c \
    src/timer/dummy/*.c \
    src/video/*.c \
    src/video/dummy/*.c \
    src/video/yuv2rgb/*.c \

SDLMAIN_SOURCES =    

ifndef TARGET_OS_WINDOWS
# Common to non-Windows platforms
SDL_SOURCES += \
    src/core/unix/*.c \
    src/filesystem/unix/*.c \
    src/loadso/dlopen/*.c \
    src/locale/unix/*.c \
    src/misc/unix/*.c \
    src/thread/pthread/*.c \
    src/timer/unix/*.c \

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
    src/power/linux/*.c \
    src/video/wayland/*.c \
    src/video/x11/*.c \

endif

ifdef TARGET_OS_MACOSX
CFLAGS += -Isrc/video/khronos
OBJCFLAGS += -fobjc-weak
SDL_SOURCES += \
    src/audio/coreaudio/*.m \
    src/file/cocoa/*.m \
    src/haptic/darwin/*c \
    src/joystick/darwin/*.c \
    src/joystick/iphoneos/*.m \
    src/render/metal/*.m \
    src/timer/unix/*.c \
    src/video/cocoa/*.m
endif

ifdef TARGET_OS_WINDOWS
SDL_SOURCES += \
    src/core/windows/*.c \
    src/filesystem/windows/*.c \
    src/haptic/windows/*.c \
    src/hidapi/windows/*.c \
    src/joystick/windows/*.c \
    src/loadso/windows/*.c \
    src/locale/windows/*.c \
    src/main/windows/*.c \
    src/misc/windows/*.c \
    src/power/windows/*.c \
    src/sensor/windows/*.c \
    src/thread/generic/SDL_syscond.c \
    src/thread/windows/*.c \
    src/timer/windows/*.c \
    src/video/windows/*.c \
    src/audio/directsound/*.c \
    src/audio/wasapi/*.c \
    src/audio/winmm/*.c \
    src/render/direct3d/*.c \
    src/render/direct3d11/*.c \

SDLMAIN_SOURCES += \
    src/main/windows/*.c
endif

SDL_SOURCES := $(wildcard $(SDL_SOURCES))
SDLMAIN_SOURCES := $(wildcard $(SDLMAIN_SOURCES))
HEADERS := $(wildcard $(HEADERS))

HEADERS_INST := $(patsubst include/%,$(includedir)/%,$(HEADERS))
SDL_OBJECTS := $(filter %.o,$(patsubst %.c,$(OBJ_DIR)/%.o,$(SDL_SOURCES)))
SDL_OBJECTS += $(filter %.o,$(patsubst %.m,$(OBJ_DIR)/%.o,$(SDL_SOURCES)))
SDL_OBJECTS += $(filter %.o,$(patsubst %.cpp,$(OBJ_DIR)/%.o,$(SDL_SOURCES)))
SDLMAIN_OBJECTS := $(patsubst %.c,$(OBJ_DIR)/%.o,$(SDLMAIN_SOURCES))

CFLAGS ?= -O2
CFLAGS += -I. -Iinclude -DNO_STDIO_REDIRECT

.PHONY: install

INSTALL_TARGETS := $(HEADERS_INST) $(libdir)/$(SDL_LIB)
ifneq ($(SDLMAIN_OBJECTS),)
INSTALL_TARGETS += $(libdir)/$(SDLMAIN_LIB)
endif

ALL_TARGETS := $(OBJ_DIR)/$(SDL_LIB)
ifneq ($(SDLMAIN_OBJECTS),)
ALL_TARGETS += $(OBJ_DIR)/$(SDLMAIN_LIB)
endif

all: $(ALL_TARGETS)

.disable-dynapi: src/dynapi/SDL_dynapi.h
	sed 's/SDL_DYNAMIC_API 1/SDL_DYNAMIC_API 0/g' $< > $<.tmp
	mv $<.tmp $<
	touch .disable-dynapi

$(includedir)/%.h: include/%.h
	-@if [ ! -d $(includedir)  ]; then mkdir -p $(includedir); fi
	$(QUIET_INSTALL)cp $< $@
	@chmod 0644 $@

$(libdir)/%.a: $(OBJ_DIR)/%.a
	-@if [ ! -d $(libdir)  ]; then mkdir -p $(libdir); fi
	$(QUIET_INSTALL)cp $< $@
	@chmod 0644 $@

install: $(INSTALL_TARGETS)

clean:
	$(RM) -r $(OBJ_DIR)

distclean: clean
	$(RM) -r $(BUILD_DIR)

$(OBJ_DIR)/$(SDL_LIB): $(SDL_OBJECTS) | $$(@D)/.
	$(QUIET_AR)$(AR) $(ARFLAGS) $@ $^
	$(QUIET_RANLIB)$(RANLIB) $@

ifneq ($(SDLMAIN_OBJECTS),)
$(OBJ_DIR)/$(SDLMAIN_LIB): $(SDLMAIN_OBJECTS) | $$(@D)/.
	$(QUIET_AR)$(AR) $(ARFLAGS) $@ $^
	$(QUIET_RANLIB)$(RANLIB) $@
endif

$(OBJ_DIR)/%.o: %.c $(OBJ_DIR)/.cflags .disable-dynapi | $$(@D)/.
	$(QUIET_CC)$(CC) $(CFLAGS) -o $@ -c $<

$(OBJ_DIR)/%.o: %.cpp $(OBJ_DIR)/.cflags .disable-dynapi | $$(@D)/.
	$(QUIET_CXX)$(CXX) $(CFLAGS) -o $@ -c $<

$(OBJ_DIR)/%.o: %.m $(OBJ_DIR)/.cflags .disable-dynapi | $$(@D)/.
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
