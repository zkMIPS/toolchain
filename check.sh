#!/bin/sh

CWD=`pwd`
export PATH=${CWD}/rust-staged/bin:$PATH

## FAIL due to ring 0.16.20 too old
#cd $CWD
#cd zkm/prover/examples/keccak
#RUST_LOG=info SEG_FILE_DIR=/tmp/output cargo run --release

## FAIL due to ring 0.16.20 too old
#cd $CWD
#cd zkm/prover/examples/prove-large-seg
#RUST_LOG=info SEG_FILE_DIR=/tmp/output cargo run --release

cd $CWD
cd zkm/prover/examples/prove-seg
RUST_LOG=info SEG_FILE_DIR=/tmp/output cargo run --release

cd $CWD
cd zkm/prover/examples/revme/host
RUST_LOG=info SEG_OUTPUT=/tmp/output cargo run --release

cd $CWD
cd zkm/prover/examples/sha2-rust/host
ARGS="711e9609339e92b03ddc0a211827dba421f38f9ed8b9d806e1ffdd8c15ffa03d world!" RUST_LOG=info SEG_OUTPUT=/tmp/output cargo run --release

cd $CWD
cd zkm/prover/examples/sha2-composition/host
RUST_LOG=info PRECOMPILE_PATH=../../sha2-rust/guest/elf/mips-zkm-zkvm-elf SEG_OUTPUT=/tmp/output cargo run --release

cd $CWD
cd zkm/prover/examples/split-seg
BASEDIR=../../../emulator/test-vectors RUST_LOG=info ELF_PATH=../../../emulator/test-vectors/minigeth BLOCK_NO=13284491 SEG_OUTPUT=/tmp/output SEG_SIZE=65536 ARGS="" cargo run --release
BASEDIR=../../../emulator/test-vectors RUST_LOG=info ELF_PATH=../../../emulator/test-vectors/minigeth BLOCK_NO=13284491 SEG_OUTPUT=/tmp/output SEG_START_ID=0 SEG_NUM=1 SEG_SIZE=65536 cargo run --release
BASEDIR=../../../emulator/test-vectors RUST_LOG=info ELF_PATH=../../../emulator/test-vectors/minigeth BLOCK_NO=13284491 SEG_OUTPUT=/tmp/output SEG_START_ID=0 SEG_NUM=299 SEG_SIZE=65536 cargo run --release
