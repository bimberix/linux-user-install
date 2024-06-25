# sudo apt install libreadline-dev

#https://stackoverflow.com/questions/8495655/how-come-when-i-press-the-up-or-down-arrow-keys-in-the-python-interpreter-i-get
#It looks as if you're using a build from source. It looks like you'll need to rebuild Python after installing the libreadline-dev or equivalent package on your distribution.

#Update: There should be no special build steps needed, just running make should do. There are some messages printed at the end about optional modules which couldn't be built because of missing dependencies (in addition to readline, there are also Tcl/Tk, zlib, gdbm and openssl dependencies, for example).

#If for some reason just running make doesn't work, try running configure again first (if make doesn't already run it for you).

ifndef _INC_PYTHON
_INC_PYTHON=yes

include manifest.mk

PYTHON_VERSION?=3.12.1
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
		--enable-optimizations

$(PYTHON_PKGNAME)/python: $(PYTHON_PKGNAME)/Makefile
	cd $(PYTHON_DIR) && \
	$(MAKE) $(MKFLAGS)

python: $(PYTHON_PKGNAME)/python
	cd $(PYTHON_DIR) && \
	$(MAKE) $(MKFLAGS) install

endif

