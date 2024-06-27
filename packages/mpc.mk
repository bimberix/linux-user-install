ifndef _INC_MPC
_INC_MPC=yes

include manifest.mk

MPC_VERSION?=1.2.1
MPC_PKGNAME=mpc-$(MPC_VERSION)
MPC_PKGTYPE=tar.gz
MPC_DIR=$(SRC_DIR)/$(MPC_PKGNAME)
MPC_PKG=$(MPC_PKGNAME).$(MPC_PKGTYPE)
MPC_URL=https://gcc.gnu.org/pub/gcc/infrastructure/$(MPC_PKG)

$(MPC_PKG): | $(PKGDIR)
	cd $(PKGDIR) && wget -nc $(MPC_URL)

$(MPC_PKGNAME)/configure: | $(MPC_PKG) $(SRCDIR)
	tar xf $(PKGDIR)/$(MPC_PKG) -C $(SRCDIR)

$(MPC_PKGNAME)/Makefile: libgmp.so libmpfr.so | $(MPC_PKGNAME)/configure
	cd $(MPC_DIR) && \
	./configure \
		--prefix=$(PREFIX) \
		--with-gmp-include=$(PREFIX)/include \
		--with-gmp-lib=$(PREFIX)/lib

$(MPC_PKGNAME)/src/.libs/libmpc.so: $(MPC_PKGNAME)/Makefile
	cd $(MPC_DIR) && \
	$(MAKE) $(MKFLAGS)

libmpc.so: $(MPC_PKGNAME)/src/.libs/libmpc.so
	cd $(MPC_DIR) && \
	$(MAKE) $(MKFLAGS) install

endif
