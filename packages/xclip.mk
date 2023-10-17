ifndef _INC_XCLIP
_INC_XCLIP=yes

include manifest.mk

XCLIP_VERSION?=0.13
XCLIP_PKGNAME=xclip-$(XCLIP_VERSION)
XCLIP_PKGTYPE=tar.gz
XCLIP_DIR=$(SRCDIR)/$(XCLIP_PKGNAME)
XCLIP_PKG=$(XCLIP_PKGNAME).$(XCLIP_PKGTYPE)
XCLIP_URL=https://github.com/astrand/xclip/archive/refs/tags/$(XCLIP_VERSION).$(XCLIP_PKGTYPE)

$(XCLIP_PKG): | $(PKGDIR)
	wget $(XCLIP_URL) -O $(PKGDIR)/$(XCLIP_PKG)

$(XCLIP_PKGNAME)/configure.ac: | $(XCLIP_PKG) $(SRCDIR)
	tar xf $(PKGDIR)/$(XCLIP_PKG) -C $(SRCDIR)

$(XCLIP_PKGNAME)/configure: $(XCLIP_PKGNAME)/configure.ac
	cd $(XCLIP_DIR) && \
		autoupdate && \
		autoreconf

$(XCLIP_PKGNAME)/Makefile: $(XCLIP_PKGNAME)/configure
	cd $(XCLIP_DIR) && \
	./configure \
		--prefix=$(PREFIX)

$(XCLIP_PKGNAME)/xclip: $(XCLIP_PKGNAME)/Makefile
	cd $(XCLIP_DIR) && \
	$(MAKE) $(MKFLAGS)

xclip: $(XCLIP_PKGNAME)/xclip
	cd $(XCLIP_DIR) && \
	$(MAKE) $(MKFLAGS) install

endif
