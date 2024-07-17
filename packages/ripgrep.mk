ifndef _INC_RIPGREP
_INC_RIPGREP=yes

include manifest.mk

RIPGREP_VERSION?=14.1.0

rg: cargo
	cargo install ripgrep@$(RIPGREP_VERSION) --force

endif
