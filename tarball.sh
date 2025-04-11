#!/bin/sh

. "$HOME/.cargo/env"
CWD=`pwd`
TARGET=`rustc -vV | sed -n 's|host: ||p' | sed 's/_/-/'`

TAG=`git -C rust-workspace name-rev --tags --name-only HEAD | grep '^20'`
if [ -z "$TAG" ];then
	exit 0
fi

rm -rf rust-toolchain-*
cp -r rust-staged rust-toolchain-${TARGET}-${TAG}
MacOS=`echo ${TARGET} | grep apple`
if [ -n "$MacOS" ];then
	tar cjvf rust-toolchain-${TARGET}-${TAG}.tar.bz2
else
	tar cJvf rust-toolchain-${TARGET}-${TAG}.tar.xz
fi
