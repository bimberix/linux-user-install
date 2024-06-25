ifndef _INC_NODEJS
_INC_NODEJS=yes

include manifest.mk

NODEJS_VERSION?=20.11.0
NODEJS_PKGNAME=node-v$(NODEJS_VERSION)
NODEJS_PKGTYPE=tar.gz
NODEJS_DIR=$(SRCDIR)/$(NODEJS_PKGNAME)
NODEJS_PKG=$(NODEJS_PKGNAME).$(NODEJS_PKGTYPE)
NODEJS_URL=https://nodejs.org/dist/v$(NODEJS_VERSION)/node-v$(NODEJS_VERSION).$(NODEJS_PKGTYPE)

$(NODEJS_PKG): | $(PKGDIR)
	wget $(NODEJS_URL) -O $(PKGDIR)/$(NODEJS_PKG)

$(NODEJS_PKGNAME)/configure: | $(NODEJS_PKG) $(SRCDIR)
	tar xf $(PKGDIR)/$(NODEJS_PKG) -C $(SRCDIR)

$(NODEJS_PKGNAME)/Makefile: $(NODEJS_PKGNAME)/configure
	cd $(NODEJS_DIR) && \
	./configure \
		--prefix=$(PREFIX)

$(NODEJS_PKGNAME)/node: $(NODEJS_PKGNAME)/Makefile
	cd $(NODEJS_DIR) && \
	$(MAKE) $(MKFLAGS)

node: $(NODEJS_PKGNAME)/node
	cd $(NODEJS_DIR) && \
	$(MAKE) $(MKFLAGS) install

endif

