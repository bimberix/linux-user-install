ifndef _INC_CMAKE
_INC_CMAKE=yes

include .manifest.mk

CMAKE_VERSION?=3.27.7
CMAKE_PKGNAME=cmake-$(CMAKE_VERSION)
CMAKE_PKGTYPE=tar.gz
CMAKE_DIR=$(SRCDIR)/$(CMAKE_PKGNAME)
CMAKE_PKG=$(CMAKE_PKGNAME).$(CMAKE_PKGTYPE)
CMAKE_URL=https://github.com/Kitware/CMake/releases/download/v$(CMAKE_VERSION)/cmake-$(CMAKE_VERSION).$(CMAKE_PKGTYPE)

$(CMAKE_PKG): | $(PKGDIR)
	wget $(CMAKE_URL) -O $(PKGDIR)/$(CMAKE_PKG)

$(CMAKE_PKGNAME)/bootstrap: | $(CMAKE_PKG) $(SRCDIR)
	tar xf $(PKGDIR)/$(CMAKE_PKG) -C $(SRCDIR)

$(CMAKE_PKGNAME)/Makefile: $(CMAKE_PKGNAME)/bootstrap
	cd $(CMAKE_DIR) && \
	./bootstrap --generator="Unix Makefiles" -- -DCMAKE_INSTALL_PREFIX=$(PREFIX)

$(CMAKE_PKGNAME)/bin/cmake: $(CMAKE_PKGNAME)/Makefile
	cd $(CMAKE_DIR) && \
	$(MAKE) $(MKFLAGS)

cmake: $(CMAKE_PKGNAME)/bin/cmake
	cd $(CMAKE_DIR) && \
	$(MAKE) $(MKFLAGS) install

endif

