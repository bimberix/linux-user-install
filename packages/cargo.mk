ifndef _INC_RUSTUP
_INC_RUSTUP=yes

include manifest.mk

CARGO_HOME=$(PREFIX)/lib/cargo
RUSTUP_HOME=$(PREFIX)/lib/rustup

$(CARGO_HOME)/bin/cargo:
	curl https://sh.rustup.rs -sSf | bash -s -- -y

cargo: $(CARGO_HOME)/bin/cargo

endif
