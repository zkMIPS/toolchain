#!/bin/sh

. "$HOME/.cargo/env"
CWD=`pwd`
TARGET=`rustc -vV | sed -n 's|host: ||p'`

rm -rf $CWD/rust-staged

cd $CWD/rust
./x build library
./x build --stage 2 compiler/rustc
BOOTSTRAP_SKIP_TARGET_SANITY=1 ./x build --target ${TARGET},mips-mti-none-elf,mipsel-mti-none-elf
BOOTSTRAP_SKIP_TARGET_SANITY=1 ./x install --target ${TARGET},mips-mti-none-elf,mipsel-mti-none-elf


cd $CWD/cargo
cargo build --release
cargo install --path . --root=$CWD/rust-staged
