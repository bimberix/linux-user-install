ifndef _INC_XSEL
_INC_XSEL=yes

include .manifest.mk

XSEL_VERSION?=1.2.0
XSEL_PKGNAME=xsel-$(XSEL_VERSION)
XSEL_PKGTYPE=tar.gz
XSEL_DIR=$(SRCDIR)/$(XSEL_PKGNAME)
XSEL_PKG=$(XSEL_PKGNAME).$(XSEL_PKGTYPE)
XSEL_URL=http://www.vergenet.net/~conrad/software/xsel/download/$(XSEL_PKG)

$(XSEL_PKG): | $(PKGDIR)
	wget $(XSEL_URL) -O $(PKGDIR)/$(XSEL_PKG)

$(XSEL_PKGNAME)/configure: | $(XSEL_PKG) $(SRCDIR)
	tar xf $(PKGDIR)/$(XSEL_PKG) -C $(SRCDIR)

$(XSEL_PKGNAME)/Makefile: $(XSEL_PKGNAME)/configure
	cd $(XSEL_DIR) && \
	CFLAGS=-Wno-error ./configure \
		--prefix=$(PREFIX)

$(XSEL_PKGNAME)/xsel: $(XSEL_PKGNAME)/Makefile
	cd $(XSEL_DIR) && \
	$(MAKE) $(MKFLAGS)

xsel: $(XSEL_PKGNAME)/xsel
	cd $(XSEL_DIR) && \
	$(MAKE) $(MKFLAGS) install

endif
