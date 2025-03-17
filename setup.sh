#!/bin/sh

origin_dir=`pwd`
mkdir -p ~/.zkm-toolchain/bin
cd ~/.zkm-toolchain
wget -q https://raw.githubusercontent.com/zkMIPS/toolchain/refs/heads/main/zkmup -O bin/zkmup
chmod +x ~/.zkm-toolchain/bin/zkmup 
cd $origin_dir
~/.zkm-toolchain/bin/zkmup install
~/.zkm-toolchain/bin/zkmup setup
