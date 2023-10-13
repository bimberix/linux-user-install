ifndef _INC_MANIFEST
_INC_MANIFEST=yes

PREFIX?=$(HOME)/.local
PKGDIR?=$(PREFIX)/share/pkg
SRCDIR?=$(PREFIX)/src

ARCH?=$(shell uname -m)
XCLIP_VERSION?=0.13
XSEL_VERSION?=1.2.0

VPATH=$(PREFIX)/bin:$(PREFIX)/lib:$(SRCDIR):$(PKGDIR)

include packages/*.mk

$(PKGDIR):
	mkdir -p $(PKGDIR)

$(SRCDIR):
	mkdir -p $(SRCDIR)

endif

