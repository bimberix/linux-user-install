# Linux Local Package Manager

The aim of this project is to implement basic Makefile rules that
would allow installtion of packages in home directory and without
root privileges.

## Example .bashrc appendix

```bash
export PATH=$HOME/.local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$HOME/.local/lib64:$LD_LIBRARY_PATH

export CARGO_HOME=$HOME/.local/lib/cargo
export RUSTUP_HOME=$HOME/.local/lib/rustup
```
