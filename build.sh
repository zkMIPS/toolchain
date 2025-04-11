#!/bin/sh

. "$HOME/.cargo/env"
CWD=`pwd`
TARGET=`rustc -vV | sed -n 's|host: ||p'`

rm -rf $CWD/rust-staged

cd $CWD/rust-workspace
for i in `ls -d build/* | grep -v '^build/cache'`;do
        rm -rf $i
done
./x build library
./x build --stage 2 compiler/rustc
BOOTSTRAP_SKIP_TARGET_SANITY=1 ./x build --target ${TARGET},mips-zkm-zkvm-elf,mipsel-zkm-zkvm-elf
BOOTSTRAP_SKIP_TARGET_SANITY=1 ./x install --target ${TARGET},mips-zkm-zkvm-elf,mipsel-zkm-zkvm-elf


cd $CWD/cargo
cargo build --release
cargo install --path . --root=$CWD/rust-staged

patchelf --set-rpath '$ORIGIN/../lib' $CWD/rust-staged/bin/cargo
cp -f /usr/lib64/libcrypto.so.3* /usr/lib64/libssl.so.3* $CWD/rust-staged/lib

cd $CWD
rm -f $CWD/rust-staged/buildinfo
echo "Rustc:" >> $CWD/rust-staged/buildinfo
git -C rust-workspace log -1 >> $CWD/rust-staged/buildinfo
echo >> $CWD/rust-staged/buildinfo

echo "LLVM:" >> $CWD/rust-staged/buildinfo
git -C rust-workspace/src/llvm-project log -1 >> $CWD/rust-staged/buildinfo
echo >> $CWD/rust-staged/buildinfo

echo "Cargo:" >> $CWD/rust-staged/buildinfo
git -C cargo log -1 >> $CWD/rust-staged/buildinfo
echo >> $CWD/rust-staged/buildinfo
