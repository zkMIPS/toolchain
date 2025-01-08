#!/bin/sh

CWD=`pwd`

if [ -d rust ];then
	git -C rust checkout .
	git -C rust pull --rebase
else
	git clone https://github.com/rust-lang/rust.git
fi

git -C rust checkout master
sed -i 's@^cc =.*@cc = { git = "https://github.com/zkMIPS/cc-rs.git", branch = "mips-mti" }@' rust/src/bootstrap/Cargo.toml
cp -f rust/config.example.toml rust/config.toml
sed -i "s@#prefix = .*@prefix = \"${CWD}/rust-staged\"@" rust/config.toml
sed -i 's@#sysconfdir = .*@sysconfdir = "etc"@' rust/config.toml
sed -i 's@#docs = .*@docs = false@' rust/config.toml
sed -i 's@#lld = .*@lld = true@' rust/config.toml
sed -i 's@#download-ci-llvm = .*@download-ci-llvm = false@' rust/config.toml


if [ -d cargo ];then
	git -C cargo checkout .
	git -C cargo pull --rebase
else
	git clone https://github.com/rust-lang/cargo.git
fi

if [ -d zkm ];then
	git -C zkm checkout .
	git -C zkm pull --rebase
else
	git clone https://github.com/zkMIPS/zkm.git
fi
for i in `grep -r mips-zkm zkm/prover zkm/build | awk -F':' '{print $1}' | sort | uniq`;do
	sed -i 's/mips-zkm-zkvm-elf/mips-mti-none-elf/g' $i
done
for i in `grep -r 'target_os = "zkvm"' zkm/runtime | awk -F':' '{print $1}' | sort | uniq`;do
	sed -i 's/target_os = "zkvm"/target_os = "none"/g' $i
done
