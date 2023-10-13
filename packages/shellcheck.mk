ifndef _INC_SHELLCHECK
_INC_SHELLCHECK=yes

include .manifest.mk

SHELLCHECK_VERSION?=0.9.0
SHELLCHECK_PKGNAME=shellcheck-$(SHELLCHECK_VERSION)
SHELLCHECK_PKGTYPE=tar.xz
SHELLCHECK_DIR=$(SRCDIR)/$(SHELLCHECK_PKGNAME)
SHELLCHECK_PKG=$(SHELLCHECK_PKGNAME).$(SHELLCHECK_PKGTYPE)
SHELLCHECK_URL=https://github.com/koalaman/shellcheck/releases/download/v$(SHELLCHECK_VERSION)/shellcheck-v$(SHELLCHECK_VERSION).linux.$(ARCH).tar.xz

$(SHELLCHECK_PKG): | $(PKGDIR)
	wget $(SHELLCHECK_URL) -O $(PKGDIR)/$(SHELLCHECK_PKG)

shellcheck-v$(SHELLCHECK_VERSION)/shellcheck: | $(SHELLCHECK_PKG) $(LIBDIR)
	tar xf $(PKGDIR)/$(SHELLCHECK_PKG) -C $(PREFIX)/lib/ shellcheck-v$(SHELLCHECK_VERSION)/shellcheck

shellcheck: shellcheck-v$(SHELLCHECK_VERSION)/shellcheck | $(BINDIR)
	ln -sf $(LIBDIR)/shellcheck-v$(SHELLCHECK_VERSION)/shellcheck $(BINDIR)/shellcheck

endif
