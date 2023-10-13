ifndef _INC_MANIFEST
_INC_MANIFEST=yes

PREFIX?=$(HOME)/.local
PKGDIR?=$(PREFIX)/share/pkg
SRCDIR?=$(PREFIX)/src
LIBDIR?=$(PREFIX)/lib
BINDIR?=$(PREFIX)/bin

ARCH?=$(shell uname -m)
XCLIP_VERSION?=0.13
XSEL_VERSION?=1.2.0
SHELLCHECK_VERSION?=0.9.0

VPATH=$(BINDIR):$(LIBDIR):$(SRCDIR):$(PKGDIR)

include packages/*.mk

$(PKGDIR):
	mkdir -p $(PKGDIR)

$(SRCDIR):
	mkdir -p $(SRCDIR)

$(LIBDIR):
	mkdir -p $(LIBDIR)

$(BINDIR):
	mkdir -p $(BINDIR)

endif

