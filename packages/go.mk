ifndef _INC_GO
_INC_GO=yes

include manifest.mk

GO_VERSION?=1.21.3
GO_PKGNAME=go-$(GO_VERSION)
GO_PKGTYPE=tar.gz
GO_DIR=$(SRCDIR)/$(GO_PKGNAME)
GO_PKG=$(GO_PKGNAME).$(GO_PKGTYPE)
GO_URL=https://go.dev/dl/go$(GO_VERSION).src.$(GO_PKGTYPE)
$(GO_PKG): | $(PKGDIR)
	wget $(GO_URL) -O $(PKGDIR)/$(GO_PKG)

go/src/all.bash: | $(GO_PKG) $(SRCDIR)
	tar xf $(PKGDIR)/$(GO_PKG) -C $(SRCDIR)

$(GO_PKGNAME)/src/all.bash: | go/src/all.bash
	mv -f $(SRCDIR)/go $(SRCDIR)/$(GO_PKGNAME)

$(GO_PKGNAME)/bin/go: $(GO_PKGNAME)/src/all.bash
	cd $(GO_DIR)/src && \
	./all.bash

go: $(GO_PKGNAME)/bin/go
	ln -sf $(GO_DIR)/bin/go $(PREFIX)/bin/ 
	ln -sf $(GO_DIR)/bin/gofmt $(PREFIX)/bin/ 

endif

