ifndef _INC_LTEX_LS
_INC_LTEX_LS=yes

include manifest.mk

LTEX_LS_VERSION?=16.0.0
LTEX_LS_PKGNAME=ltex-ls-$(LTEX_LS_VERSION)
LTEX_LS_PKGTYPE=tar.gz
LTEX_LS_DIR=$(SRCDIR)/$(LTEX_LS_PKGNAME)
LTEX_LS_PKG=$(LTEX_LS_PKGNAME).$(LTEX_LS_PKGTYPE)
LTEX_LS_URL=https://github.com/valentjn/ltex-ls/releases/download/$(LTEX_LS_VERSION)/$(LTEX_LS_PKGNAME)-linux-x64.$(LTEX_LS_PKGTYPE)

$(LTEX_LS_PKG): | $(PKGDIR)
	wget $(LTEX_LS_URL) -O $(PKGDIR)/$(LTEX_LS_PKG)

$(LTEX_LS_PKGNAME)/bin/ltex-ls: | $(LTEX_LS_PKG) $(SRCDIR)
	tar xf $(PKGDIR)/$(LTEX_LS_PKG) -C $(SRCDIR)

ltex-ls: $(LTEX_LS_PKGNAME)/bin/ltex-ls | $(BINDIR)
	ln -sf $(LTEX_LS_DIR)/bin/ltex-ls $(BINDIR) 

endif


