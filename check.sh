#!/bin/sh

CWD=`pwd`
export PATH=${CWD}/rust-staged/bin:$PATH

cd zkm/prover/examples/sha2-rust/host
ARGS="711e9609339e92b03ddc0a211827dba421f38f9ed8b9d806e1ffdd8c15ffa03d world!" RUST_LOG=info SEG_OUTPUT=/tmp/output cargo run --release

cd $CWD
cd zkm/prover/examples/revme/host
RUST_LOG=info SEG_OUTPUT=/tmp/output cargo run --release
