ifndef _INC_MANIFEST
_INC_MANIFEST=yes

PREFIX?=$(HOME)/.local
PKGDIR?=$(PREFIX)/share/pkg
SRCDIR?=$(PREFIX)/src

ARCH?=$(shell uname -m)
XCLIP_VERSION?=0.13


VPATH=$(PREFIX)/bin:$(PREFIX)/lib:$(SRCDIR):$(PKGDIR)

$(PKGDIR):
	mkdir -p $(PKGDIR)

$(SRCDIR):
	mkdir -p $(SRCDIR)

endif

