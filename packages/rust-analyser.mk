ifndef _INC_RUST_ANALYSER
_INC_RUST_ANALYSER=yes

include manifest.mk

RUST_ANALYSER_VERSION?=2024-01-22
RUST_ANALYSER_PKGNAME=rust-analyzer-$(RUST_ANALYSER_VERSION)
RUST_ANALYSER_PKGTYPE=tar.gz
RUST_ANALYSER_DIR=$(SRCDIR)/$(RUST_ANALYSER_PKGNAME)
RUST_ANALYSER_PKG=$(RUST_ANALYSER_PKGNAME).$(RUST_ANALYSER_PKGTYPE)
RUST_ANALYSER_URL=https://github.com/rust-lang/rust-analyzer/archive/refs/tags/$(RUST_ANALYSER_VERSION).$(RUST_ANALYSER_PKGTYPE)

$(RUST_ANALYSER_PKG): | $(PKGDIR)
	wget $(RUST_ANALYSER_URL) -O $(PKGDIR)/$(RUST_ANALYSER_PKG)

$(RUST_ANALYSER_PKGNAME)/Cargo.toml: | $(RUST_ANALYSER_PKG) $(SRCDIR)
	tar xf $(PKGDIR)/$(RUST_ANALYSER_PKG) -C $(SRCDIR)

$(RUST_ANALYSER_PKGNAME)/rust-analyzer: $(RUST_ANALYSER_PKGNAME)/Cargo.toml
	cd $(RUST_ANALYSER_DIR) && \
		cargo xtask install --server



#$(RUST_ANALYSER_PKGNAME)/build/Makefile: cmake $(RUST_ANALYSER_PKGNAME)/llvm/CMakeLists.txt
	#cd $(RUST_ANALYSER_DIR) && \
	#cmake \
		#-S llvm \
		#-B build \
		#-G "Unix Makefiles" \
		#-DRUST_ANALYSER_ENABLE_PROJECTS="clang;clang-tools-extra" \
		#-DCMAKE_INSTALL_PREFIX=$(PREFIX) \
		#-DCMAKE_BUILD_TYPE=Release

#$(RUST_ANALYSER_PKGNAME)/build/bin/clang: $(RUST_ANALYSER_PKGNAME)/build/Makefile
	#cd $(RUST_ANALYSER_DIR)/build && \
	#$(MAKE) $(MKFLAGS)

#clang: $(RUST_ANALYSER_PKGNAME)/build/bin/clang
	#cd $(RUST_ANALYSER_DIR)/build && \
	#$(MAKE) install

endif
