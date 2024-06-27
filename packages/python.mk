# install readline-devel / lireadline-dev # shell navigation
# install sqlite-devel                    # sqlite3 support
# install openssl11-devel                 # internet access
# install bzip2-devel                     # bz2 compression
# install xz-devel                        # lzma compression

ifndef _INC_PYTHON
_INC_PYTHON=yes

include manifest.mk

PYTHON_VERSION?=3.12.4
PYTHON_PKGNAME=Python-$(PYTHON_VERSION)
PYTHON_PKGTYPE=tar.xz
PYTHON_DIR=$(SRCDIR)/$(PYTHON_PKGNAME)
PYTHON_PKG=$(PYTHON_PKGNAME).$(PYTHON_PKGTYPE)
PYTHON_URL=https://www.python.org/ftp/python/$(PYTHON_VERSION)/Python-$(PYTHON_VERSION).$(PYTHON_PKGTYPE)

$(PYTHON_PKG): | $(PKGDIR)
	wget $(PYTHON_URL) -O $(PKGDIR)/$(PYTHON_PKG)

$(PYTHON_PKGNAME)/configure: | $(PYTHON_PKG) $(SRCDIR)
	tar xf $(PKGDIR)/$(PYTHON_PKG) -C $(SRCDIR)

$(PYTHON_PKGNAME)/Makefile: $(PYTHON_PKGNAME)/configure
	cd $(PYTHON_DIR) && \
	./configure \
		--prefix=$(PREFIX) \
		--enable-loadable-sqlite-extensions \
		--enable-optimizations

$(PYTHON_PKGNAME)/python: $(PYTHON_PKGNAME)/Makefile
	cd $(PYTHON_DIR) && \
	$(MAKE) $(MKFLAGS)

python: $(PYTHON_PKGNAME)/python
	cd $(PYTHON_DIR) && \
	$(MAKE) $(MKFLAGS) install

endif

