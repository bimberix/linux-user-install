ifndef _INC_FD_FIND
_INC_FD_FIND=yes

include manifest.mk

FD_FIND_VERSION?=10.1.0

fd: cargo
	cargo install fd-find@$(FD_FIND_VERSION) --force

endif
