#!/bin/sh

origin_dir=`pwd`
mkdir -p ~/.zkm-toolchain
cd ~/.zkm-toolchain

cleanup() {
  cd ${origin_dir}
}
trap cleanup EXIT

setpath() {
	local newpath=`readlink -f ~/.zkm-toolchain/$1/bin`
	echo "export PATH=$newpath:\$PATH" > ~/.zkm-toolchain/env
	local q=`readlink -f ~/.zkm-toolchain/`
	split_path=`echo $PATH | sed 's/:/ /g'`
	for e in ${split_path};do
		xxx=`echo $e | grep "^$q"`
		if [ -n "$xxx" ];then
			continue
		fi
		newpath="$newpath:$e"
	done
	export PATH=$newpath
}

os=`uname`
cpu=`uname -m`

reinstall=no
update=no
pkg="rust-toolchain"
rel=20241217
for i in $@;do
	if [ "$i" = "--reinstall" ];then
		reinstall=yes
		continue
	fi
	if [ "$i" = "--update" ];then
		update=yes
		continue
	fi
done

if [ "${os}-${cpu}" = "Linux-aarch64" ];then
	pkg="${pkg}-aarch64-unknown-linux-gnu-${rel}.tar.xz"
elif [ "${os}-${cpu}" = "Linux-x86_64" ];then
	pkg="${pkg}-x86-64-unknown-linux-gnu-${rel}.tar.xz"
elif [ "${os}-${cpu}" = "Darwin-arm64" ];then
	pkg="${pkg}-aarch64-apple-darwin-${rel}.tar.bz2"
elif [ "${os}-${cpu}" = "Darwin-x86_64" ];then
	pkg="${pkg}-x86-64-apple-darwin-${rel}.tar.bz2"
else
	echo -n "Unsupported Platform: "
	uname -a
	exit 1
fi

if [ "update" = "yes" ];then
	rel=`curl -s https://api.github.com/repos/zkMIPS/toolchain/releases | grep "tag_name:" | sed 's/[^0-9]*//g' | sort -r | head -1`
	if [ -z "$rel" ];then
		echo "Failed to get release list from github"
		exit 1
	fi
fi

dir=`echo $pkg | sed 's/.tar.*//'`
if [ ! -d "$dir" ] || [ "$reinstall" = "yes" ] ;then
	if [ -e "$dir" ] && [ ! -d "$dir" ];then
		echo "Error: $dir exists, while is not a diretory"
		exit 1
	fi
	echo "Downloading... $pkg ..."
	wget -c https://github.com/zkMIPS/toolchain/releases/download/$rel/$pkg -O ~/.zkm-toolchain/$pkg
	tar xf $pkg

fi

if [ -d "$dir" ]; then
	setpath $dir
	echo "'\033[0;31m~/.zkm-toolcain/env\033[0m' created. Now you can add"
	echo "\033[0;32m     . ~/.zkm-toolchain/env\033[0m"
	echo "to your .bashrc/.zshrc/.profile to use zkMIPS toolchain"
	echo "Starting a new shell session..."
	cd ${origin_dir}
	$SHELL
fi
