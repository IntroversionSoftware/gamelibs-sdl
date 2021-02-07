# -*- Makefile -*- for sdl

ifneq ($(findstring $(MAKEFLAGS),s),s)
ifndef V
        QUIET_CC       = @echo '   ' CC $@;
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
ARFLAGS ?= rcu
CC    ?= gcc
RANLIB?= ranlib
RM    ?= rm -f

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
    src/thread/pthread/*.c \
    src/timer/unix/*.c \
    src/video/cocoa/*.m
endif

ifdef TARGET_OS_WINDOWS
SDL_SOURCES += \
    src/audio/windib/*.c \
    src/joystick/win32/*.c \
    src/loadso/win32/*.c \
    src/thread/win32/SDL*.c \
    src/timer/win32/*.c \
    src/video/wincommon/*.c \
    src/video/windib/*.c

SDLMAIN_SOURCES += \
    src/main/win32/*.c
endif

SDL_SOURCES := $(wildcard $(SDL_SOURCES))
SDLMAIN_SOURCES := $(wildcard $(SDLMAIN_SOURCES))
HEADERS := $(wildcard $(HEADERS))

HEADERS_INST := $(patsubst include/%,$(includedir)/%,$(HEADERS))
SDL_OBJECTS := $(filter %.o,$(patsubst %.c,%.o,$(SDL_SOURCES)))
SDL_OBJECTS += $(filter %.o,$(patsubst %.m,%.o,$(SDL_SOURCES)))
SDLMAIN_OBJECTS := $(patsubst %.c,%.o,$(SDLMAIN_SOURCES))

CFLAGS ?= -O2
CFLAGS += -I. -Iinclude -DNO_STDIO_REDIRECT

.PHONY: install

INSTALL_TARGETS := $(HEADERS_INST) $(libdir)/$(SDL_LIB)
ifneq ($(SDLMAIN_OBJECTS),)
INSTALL_TARGETS += $(libdir)/$(SDLMAIN_LIB)
endif

ALL_TARGETS := $(SDL_LIB)
ifneq ($(SDLMAIN_OBJECTS),)
ALL_TARGETS += $(SDLMAIN_LIB)
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

$(libdir)/%.a: %.a
	-@if [ ! -d $(libdir)  ]; then mkdir -p $(libdir); fi
	$(QUIET_INSTALL)cp $< $@
	@chmod 0644 $@

install: $(INSTALL_TARGETS)

clean:
	$(RM) $(SDL_OBJECTS) $(SDLMAIN_OBJECTS) *.a

distclean: clean

$(SDL_LIB): $(SDL_OBJECTS)
	$(QUIET_AR)$(AR) $(ARFLAGS) $@ $^
	$(QUIET_RANLIB)$(RANLIB) $@

ifneq ($(SDLMAIN_OBJECTS),)
$(SDLMAIN_LIB): $(SDLMAIN_OBJECTS)
	$(QUIET_AR)$(AR) $(ARFLAGS) $@ $^
	$(QUIET_RANLIB)$(RANLIB) $@
endif

%.o: %.c .disable-dynapi
	$(QUIET_CC)$(CC) $(CFLAGS) -o $@ -c $<

%.o: %.m .disable-dynapi
	$(QUIET_CC)$(CC) $(CFLAGS) $(OBJCFLAGS) -o $@ -c $<
