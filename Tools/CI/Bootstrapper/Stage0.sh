#!/bin/bash
# Travis CI environment bootstrapper (run this as root user)
# Stage 0
#
# Copyright 2018, Bingxing Wang. <uefi-oss-projects@imbushuo.net>
# All rights reserved.
#

# Permission check
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root." 
   exit 1
fi

echo "Installing build components..."

# Host utilities
apt-get install git-core git
apt-get install build-essential
apt-get install python3
apt-get install mkbootimg

# PowerShell
# Import the public repository GPG keys
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Register the Microsoft Ubuntu repository
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | tee /etc/apt/sources.list.d/microsoft.list

# Update the list of products
apt-get update

# Install PowerShell
apt-get install -y powershell

# Linaro Toolchains
cd /opt
wget https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-elf.tar.xz
tar xf arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-elf.tar.xz

# Skip ACPI toolchain (prebuilt tables)

echo "Build components are ready. If you would like to build ACPI tables, please install recent acpica tools."
