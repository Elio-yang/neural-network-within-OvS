#!/bin/bash

libnmu_version=1.0.5
date=2022/04
my_dir=$(readlink -f $PWD)
ovs_dir=$my_dir/ovs
dpdk_dir=$my_dir/dpdk
nmu_dir=$my_dir/nuevomatchup

rm -rf  $dpdk_dir/build


if [[ ! -e $dpdk_dir ]]; then
    echo "Cloning DPDK 19.11 into $dpdk_dir..."
    git clone https://github.com/DPDK/dpdk.git $dpdk_dir
    git -C $dpdk_dir checkout tags/v19.11
    git -C $ovs_dir apply $my_dir/dpdk.patch
fi


echo "Building DPDK..."
make -C $dpdk_dir config T=x86_64-native-linux-gcc O=build
make -C $dpdk_dir -j4 O=build


