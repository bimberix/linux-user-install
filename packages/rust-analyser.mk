ifndef _INC_RUST_ANALYSER
_INC_RUST_ANALYSER=yes

include manifest.mk

RUST_ANALYSER_VERSION?=2024-06-24
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

rust-analyzer: $(RUST_ANALYSER_PKGNAME)/rust-analyzer

endif
