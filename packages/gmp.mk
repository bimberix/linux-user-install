ifndef _INC_GMP
_INC_GMP=yes

include manifest.mk

GMP_VERSION?=6.2.1
GMP_PKGNAME=gmp-$(GMP_VERSION)
GMP_PKGTYPE=tar.bz2
GMP_DIR=$(SRCDIR)/$(GMP_PKGNAME)
GMP_PKG=$(GMP_PKGNAME).$(GMP_PKGTYPE)
GMP_URL=https://gcc.gnu.org/pub/gcc/infrastructure/$(GMP_PKG)

$(GMP_PKG): | $(PKGDIR)
	cd $(PKGDIR) && wget -nc $(GMP_URL)

$(GMP_PKGNAME)/configure: | $(GMP_PKG) $(SRCDIR)
	tar xf $(PKGDIR)/$(GMP_PKG) -C $(SRCDIR)

$(GMP_PKGNAME)/Makefile: $(GMP_PKGNAME)/configure
	cd $(GMP_DIR) && \
	./configure \
		--prefix=$(PREFIX)

$(GMP_PKGNAME)/.libs/libgmp.so: $(GMP_PKGNAME)/Makefile
	cd $(GMP_DIR) && \
	$(MAKE) $(MKFLAGS)

libgmp.so: $(GMP_PKGNAME)/.libs/libgmp.so
	cd $(GMP_DIR) && \
	$(MAKE) $(MKFLAGS) install

endif
