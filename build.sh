#!/bin/sh

. "$HOME/.cargo/env"
CWD=`pwd`
TARGET=`rustc -vV | sed -n 's|host: ||p'`

rm -rf $CWD/rust-staged

cd $CWD/rust-workspace
./x build library
./x build --stage 2 compiler/rustc
BOOTSTRAP_SKIP_TARGET_SANITY=1 ./x build --target ${TARGET},mips-zkm-zkvm-elf,mipsel-zkm-zkvm-elf
BOOTSTRAP_SKIP_TARGET_SANITY=1 ./x install --target ${TARGET},mips-zkm-zkvm-elf,mipsel-zkm-zkvm-elf


cd $CWD/cargo
cargo build --release
cargo install --path . --root=$CWD/rust-staged

patchelf --set-rpath '$ORIGIN/../lib' $CWD/rust-staged/bin/cargo
cp -f /usr/lib64/libcrypto.so.3* /usr/lib64/libssl.so.3* $CWD/rust-staged/lib
