# How to build the toolchain

### Install rustc/cargo with rustup

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"
rustup toolchain install nightly
rustup default nightly
```

### Build/Install rustc

```
git clone https://github.com/ProjectZKM/rust-workspace.git
cd rust-workspace
git checkout Triple_mips-zkm-zkvm-elf
cp config.example.toml config.toml
    Edit config.toml in 
    [install]
      prefix = "/home/USERNAME/rust-staged"
      sysconfdir = "etc"
    [build]
      docs = false
    [rust]
      lld = true
    [llvm]
      download-ci-llvm = false
./x build library
./x build --stage 2 compiler/rustc
BOOTSTRAP_SKIP_TARGET_SANITY=1 ./x build --target x86_64-unknown-linux-gnu,mips-zkm-zkvm-elf
BOOTSTRAP_SKIP_TARGET_SANITY=1 ./x install --target x86_64-unknown-linux-gnu,mips-zkm-zkvm-elf
```

### Build/Install cargo
```
git clone https://github.com/rust-lang/cargo.git
cd cargo
cargo build --release
cargo install --path . --root=/home/USERNAME/rust-staged/
```


# Then now you have /home/USERNAME/rust-staged/


# Howto install binary
```
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/ProjectZKM/toolchain/refs/heads/main/setup.sh | sh
```
