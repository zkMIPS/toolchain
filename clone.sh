#!/bin/sh

CWD=`pwd`

if [ -d rust-workspace ];then
	git -C rust-workspace checkout .
	git -C rust-workspace pull --rebase
else
	git clone https://github.com/zkMIPS/rust-workspace.git
fi

#sed -i 's@rust-lang/llvm-project.git@zkMIPS/llvm-project.git@' rust-workspace/.gitmodules
#sed -i 's@= rustc/20.1-2025-02-13@= zkm-rustc/20.1-2025-02-13@' rust-workspace/.gitmodules
git -C rust-workspace checkout Triple_mips-zkm-zkvm-elf
git -C rust-workspace submodule update --init --recursive

#sed -i 's/mips2/mips32r2/g' rust-workspace/compiler/rustc_target/src/spec/targets/mips*_zkm_zkvm_elf.rs
#sed -i 's/+mips32r2,/+mips32r2,+inst-same-cost,/g' rust-workspace/compiler/rustc_target/src/spec/targets/mips*_zkm_zkvm_elf.rs

#sed -i 's@^cc =.*@cc = { git = "https://github.com/zkMIPS/cc-rs.git", branch = "Triple_mips-zkm-zkvm-elf" }@' rust-workspace/src/bootstrap/Cargo.toml
cp -f rust-workspace/bootstrap.example.toml rust-workspace/bootstrap.toml
sed -i "s@#prefix = .*@prefix = \"$CWD/rust-staged\"@" rust-workspace/bootstrap.toml
sed -i 's@#sysconfdir = .*@sysconfdir = "etc"@' rust-workspace/bootstrap.toml
sed -i 's@#docs = .*@docs = false@' rust-workspace/bootstrap.toml
sed -i 's@#lld = .*@lld = true@' rust-workspace/bootstrap.toml
sed -i 's@#download-ci-llvm = .*@download-ci-llvm = false@' rust-workspace/bootstrap.toml


if [ -d cargo ];then
	git -C cargo checkout .
	git -C cargo pull --rebase
else
	git clone https://github.com/rust-lang/cargo.git
fi

if [ -d zkm ];then
	git -C zkm checkout .
	git -C zkm clean -fd
	git -C zkm pull --rebase
else
	git clone https://github.com/zkMIPS/zkm.git
fi
