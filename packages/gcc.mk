ifndef _INC_GCC
_INC_GCC=yes

include manifest.mk

GCC_VERSION?=13.2.0
GCC_PKGNAME=gcc-$(GCC_VERSION)
GCC_PKGTYPE=tar.xz
GCC_DIR=$(SRC_DIR)/$(GCC_PKGNAME)
GCC_PKG=$(GCC_PKGNAME).$(GCC_PKGTYPE)
GCC_URL=https://ftp.fu-berlin.de/unix/languages/gcc/releases/$(GCC_PKGNAME)/$(GCC_PKG)

$(GCC_PKG): | $(PKGDIR)
	cd $(PKGDIR) && wget -nc $(GCC_URL)

$(GCC_PKGNAME)/configure: | $(GCC_PKG) $(SRCDIR)
	tar xf $(PKGDIR)/$(GCC_PKG) -C $(SRCDIR)

$(GCC_PKGNAME)/Makefile: libgmp.so libmpfr.so libmpc.so | $(GCC_PKGNAME)/configure
	cd $(GCC_DIR) && \
	./configure \
		--prefix=$(PREFIX) \
		--with-gmp-include=$(PREFIX)/include \
		--with-gmp-lib=$(PREFIX)/lib \
		--disable-multilib

$(GCC_PKGNAME)/host-$(ARCH)-pc-linux-gnu/gcc/xgcc: $(GCC_PKGNAME)/Makefile
	cd $(GCC_DIR) && \
	$(MAKE) $(MKFLAGS)

gcc: $(GCC_PKGNAME)/host-$(ARCH)-pc-linux-gnu/gcc/xgcc
	cd $(GCC_DIR) && \
	$(MAKE) $(MKFLAGS) install

endif
