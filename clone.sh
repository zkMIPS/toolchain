#!/bin/sh

if [ -d rust-workspace ];then
	git -C rust-workspace checkout .
	git -C rust-workspace pull --rebase
else
	git clone https://github.com/zkMIPS/rust-workspace.git
fi
git -C rust-workspace checkout Triple_mips-zkm-zkvm-elf
sed -i 's@^cc =.*@cc = { git = "https://github.com/zkMIPS/cc-rs.git", branch = "Triple_mips-zkm-zkvm-elf" }@' rust-workspace/src/bootstrap/Cargo.toml
cp -f rust-workspace/config.example.toml rust-workspace/config.toml
sed -i 's@#prefix = .*@prefix = "/var/jenkins_home/workspace/rust-toolchain/rust-staged"@' rust-workspace/config.toml
sed -i 's@#sysconfdir = .*@sysconfdir = "etc"@' rust-workspace/config.toml
sed -i 's@#docs = .*@docs = false@' rust-workspace/config.toml
sed -i 's@#lld = .*@lld = true@' rust-workspace/config.toml
sed -i 's@#download-ci-llvm = .*@download-ci-llvm = false@' rust-workspace/config.toml


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
