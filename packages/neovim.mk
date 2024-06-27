https://github.com/neovim/neovim/archive/refs/tags/v0.9.4.tar.gz

ifndef _INC_NEOVIM
_INC_NEOVIM=yes

include manifest.mk

NEOVIM_VERSION?=0.10.0
NEOVIM_PKGNAME=neovim-$(NEOVIM_VERSION)
NEOVIM_PKGTYPE=tar.gz
NEOVIM_DIR=$(SRCDIR)/$(NEOVIM_PKGNAME)
NEOVIM_PKG=$(NEOVIM_PKGNAME).$(NEOVIM_PKGTYPE)
NEOVIM_URL=https://github.com/neovim/neovim/archive/refs/tags/v$(NEOVIM_VERSION).tar.gz

$(NEOVIM_PKG): | $(PKGDIR)
	wget $(NEOVIM_URL) -O $(PKGDIR)/$(NEOVIM_PKG)

$(NEOVIM_PKGNAME)/Makefile: | $(NEOVIM_PKG) $(SRCDIR)
	tar xf $(PKGDIR)/$(NEOVIM_PKG) -C $(SRCDIR)

$(NEOVIM_PKGNAME)/build/bin/nvim: $(NEOVIM_PKGNAME)/Makefile cmake
	cd $(NEOVIM_DIR) && \
	$(MAKE) $(MKFLAGS) CMAKE_BUILD_TYPE="Release" CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$(PREFIX)"

nvim: $(NEOVIM_PKGNAME)/build/bin/nvim
	cd $(NEOVIM_DIR) && \
	$(MAKE) $(MKFLAGS) install

endif

