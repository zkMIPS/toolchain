#!/bin/sh

. "$HOME/.cargo/env"
CWD=`pwd`

rm -rf $CWD/rust-staged

cd $CWD/rust-workspace
./x build library
./x build --stage 2 compiler/rustc
BOOTSTRAP_SKIP_TARGET_SANITY=1 ./x build --target x86_64-unknown-linux-gnu,mips-zkm-zkvm-elf
BOOTSTRAP_SKIP_TARGET_SANITY=1 ./x install --target x86_64-unknown-linux-gnu,mips-zkm-zkvm-elf


cd $CWD/cargo
cargo build --release
cargo install --path . --root=$CWD/rust-staged
