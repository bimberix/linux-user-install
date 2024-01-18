# dependencies
# sudo apt-get install libasound2-dev libcups2-dev libfontconfig1-dev libx11-dev libxext-dev libxrender-dev libxrandr-dev libxtst-dev libxt-dev

ifndef _INC_JDK
_INC_JDK=yes

include manifest.mk

JDK_VERSION?=21-ga
JDK_PKGNAME=jdk-jdk-21-ga
JDK_PKGTYPE=zip
JDK_DIR=$(SRCDIR)/jdk-jdk-21-ga
JDK_PKG=$(JDK_PKGNAME).$(JDK_PKGTYPE)
JDK_URL=https://github.com/openjdk/jdk/archive/refs/tags/jdk-$(JDK_VERSION).zip

JDK_BOOT_PKG=openjdk-21.0.1_linux-x64_bin.tar.gz
JDK_BOOT_DIR=$(SRCDIR)/jdk-21.0.1
JDK_BOOT_URL=https://download.java.net/java/GA/jdk21.0.1/415e3f918a1f4062a0074a2794853d0d/12/GPL/openjdk-21.0.1_linux-x64_bin.tar.gz

$(JDK_PKG): | $(PKGDIR)
	wget $(JDK_URL) -O $(PKGDIR)/$(JDK_PKG)

$(JDK_BOOT_PKG): | $(PKGDIR)
	wget $(JDK_BOOT_URL) -O $(PKGDIR)/$(JDK_BOOT_PKG)

$(JDK_BOOT_DIR)/bin/javac: | $(JDK_BOOT_PKG)
	tar xf $(PKGDIR)/$(JDK_BOOT_PKG) -C $(SRCDIR)

$(JDK_PKGNAME)/configure: | $(JDK_PKG) $(SRCDIR)
	unzip $(PKGDIR)/$(JDK_PKG) -d $(SRCDIR)

$(JDK_PKGNAME)/Makefile: $(JDK_PKGNAME)/configure $(JDK_BOOT_DIR)/bin/javac
	cd $(JDK_DIR) && \
	bash configure \
		--prefix=$(PREFIX) \
		--with-boot-jdk=$(JDK_BOOT_DIR)

$(JDK_PKGNAME)/build/linux-x86_64-server-release/java: $(JDK_PKGNAME)/Makefile
	cd $(JDK_DIR) && \
	$(MAKE) $(MKFLAGS)

java: $(JDK_PKGNAME)/build/linux-x86_64-server-release/java
	cd $(JDK_DIR) && \
	$(MAKE) $(MKFLAGS) install

endif

