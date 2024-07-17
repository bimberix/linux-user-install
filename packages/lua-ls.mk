ifndef _INC_LUA_LS
_INC_LUA_LS=yes

include manifest.mk

LUA_LS_VERSION?=3.9.3
LUA_LS_PKGNAME=lua-language-server-$(LUA_LS_VERSION)-linux-x64
LUA_LS_PKGTYPE=tar.gz
LUA_LS_DIR=$(SRCDIR)/$(LUA_LS_PKGNAME)
LUA_LS_PKG=$(LUA_LS_PKGNAME).$(LUA_LS_PKGTYPE)
LUA_LS_URL=https://github.com/LuaLS/lua-language-server/releases/download/$(LUA_LS_VERSION)/$(LUA_LS_PKGNAME).$(LUA_LS_PKGTYPE)

$(LUA_LS_PKG): | $(PKGDIR)
	wget $(LUA_LS_URL) -O $(PKGDIR)/$(LUA_LS_PKG)

$(LUA_LS_PKGNAME)/bin/lua-language-server: | $(LUA_LS_PKG) $(SRCDIR)
	mkdir -p $(LUA_LS_DIR)
	tar xf $(PKGDIR)/$(LUA_LS_PKG) -C $(LUA_LS_DIR)

lua-language-server: $(LUA_LS_PKGNAME)/bin/lua-language-server | $(BINDIR)
	ln -sf $(LUA_LS_DIR)/bin/lua-language-server $(BINDIR) 

endif


