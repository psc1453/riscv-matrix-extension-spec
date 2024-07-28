#!/bin/bash

#######set parameter

compiler_file="./toolchain/Xuantie-900-gcc-linux-6.6.0-glibc-x86_64-V2.10.1-20240712.tar.gz"
compiler_md5="5a8f94bd2bc93814ce99b414df9fcee9"
compiler_address="https://mirror.ghproxy.com/https://github.com/psc1453/riscv-matrix-extension-spec/releases/download/v0.4.0/Xuantie-900-gcc-linux-6.6.0-glibc-x86_64-V2.10.1-20240712.tar.gz"

######make qemu
echo "--- Make qemu ---"
mkdir qemu
tar -zxvf ./toolchain/xuantie-qemu-x86_64-Ubuntu-18.04.tar.gz -C qemu


######make gcc
if [ -f "$compiler_file" ]; then
    if [ "$(md5sum $compiler_file | awk '{ print $1 }')" == "$compiler_md5" ]; then
        echo "--- Already have compiler tar ---"
    else
        echo "--- Wrong compiler tar ---"
        rm $compiler_file
    fi
fi

if [ ! -f "$compiler_file" ]; then
    echo "--- Download compipler ---"
    wget -O $compiler_file $compiler_address
    if [ $? != 0 ]; then
        echo "Download fail. Take a rest and retry it"
        echo "Or download compiler from github and put it in toolchain dir"
        echo "--- Fatal Error ---"
        exit 1
    fi
fi


echo "--- Make compiler ---"
mkdir gcc
tar -zxvf ./toolchain/Xuantie-900-gcc-linux-6.6.0-glibc-x86_64-V2.10.1-20240712.tar.gz -C gcc

make
echo "--- The environment is ready ---"
