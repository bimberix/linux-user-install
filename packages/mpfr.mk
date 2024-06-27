ifndef _INC_MPFR
_INC_MPFR=yes

include manifest.mk

MPFR_VERSION?=4.1.0
MPFR_PKGNAME=mpfr-$(MPFR_VERSION)
MPFR_PKGTYPE=tar.bz2
MPFR_DIR=$(SRCDIR)/$(MPFR_PKGNAME)
MPFR_PKG=$(MPFR_PKGNAME).$(MPFR_PKGTYPE)
MPFR_URL=https://gcc.gnu.org/pub/gcc/infrastructure/$(MPFR_PKG)

$(MPFR_PKG): | $(PKGDIR)
	cd $(PKGDIR) && wget -nc $(MPFR_URL)

$(MPFR_PKGNAME)/configure: | $(MPFR_PKG) $(SRCDIR)
	tar xf $(PKGDIR)/$(MPFR_PKG) -C $(SRCDIR)

$(MPFR_PKGNAME)/Makefile: libgmp.so | $(MPFR_PKGNAME)/configure
	cd $(MPFR_DIR) && \
	./configure \
		--prefix=$(PREFIX) \
		--with-gmp-include=$(PREFIX)/include \
		--with-gmp-lib=$(PREFIX)/lib

$(MPFR_PKGNAME)/src/.libs/libmpfr.so: $(MPFR_PKGNAME)/Makefile
	cd $(MPFR_DIR) && \
	$(MAKE) $(MKFLAGS)

libmpfr.so: $(MPFR_PKGNAME)/src/.libs/libmpfr.so
	cd $(MPFR_DIR) && \
	$(MAKE) $(MKFLAGS) install

endif
