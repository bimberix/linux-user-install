ifndef _INC_LLVM
_INC_LLVM=yes

include manifest.mk

LLVM_VERSION?=17.0.6
LLVM_PKGNAME=llvm-project-llvmorg-$(LLVM_VERSION)
LLVM_PKGTYPE=tar.gz
LLVM_DIR=$(SRCDIR)/$(LLVM_PKGNAME)
LLVM_PKG=llvmorg-$(LLVM_VERSION).$(LLVM_PKGTYPE)
LLVM_URL=https://github.com/llvm/llvm-project/archive/refs/tags/$(LLVM_PKG)

#https://github.com/llvm/llvm-project/archive/refs/tags/llvmorg-17.0.6.tar.gz

$(LLVM_PKG): | $(PKGDIR)
	wget $(LLVM_URL) -O $(PKGDIR)/$(LLVM_PKG)

$(LLVM_PKGNAME)/llvm/CMakeLists.txt: | $(LLVM_PKG) $(SRCDIR)
	tar xf $(PKGDIR)/$(LLVM_PKG) -C $(SRCDIR)

$(LLVM_PKGNAME)/build/Makefile: cmake $(LLVM_PKGNAME)/llvm/CMakeLists.txt
	cd $(LLVM_DIR) && \
	cmake \
		-S llvm \
		-B build \
		-G "Unix Makefiles" \
		-DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" \
		-DCMAKE_INSTALL_PREFIX=$(PREFIX) \
		-DCMAKE_BUILD_TYPE=Release

$(LLVM_PKGNAME)/build/bin/clang: $(LLVM_PKGNAME)/build/Makefile
	cd $(LLVM_DIR)/build && \
	$(MAKE) $(MKFLAGS)

clang: $(LLVM_PKGNAME)/build/bin/clang
	cd $(LLVM_DIR)/build && \
	$(MAKE) install

endif
