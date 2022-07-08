#!/bin/bash
# Travis CI builder
#
# Copyright 2018, Bingxing Wang. <uefi-oss-projects@imbushuo.net>
# All rights reserved.
#

# Export AArch64 Tools prefix on CI
export GCC5_AARCH64_PREFIX=/opt/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-elf/bin/aarch64-elf-
# Export BUILDALL flags
export BUILDALL=1

# Go to EDK2 workspace
cd ..
cd edk2

# Start build
echo "Start build..."
. rundbbuild.sh --950xl --development

# Check if we have both FD ready
if [ ! -f Build/Lumia950-AARCH64/DEBUG_GCC5/FV/MSM8992_EFI.fd ]; then
    echo "Unable to find build artifacts."
    exit 1
fi

# Create uefi.img
gzip -c < Build/Lumia950-AARCH64/DEBUG_GCC5/FV/MSM8992_EFI.fd >Build/Lumia950-AARCH64/DEBUG_GCC5/FV/MSM8992_EFI.fd.gz
cat Build/Lumia950-AARCH64/DEBUG_GCC5/FV/MSM8992_EFI.fd.gz Lumia950XLPkg/device-specific/fdt.img > Build/Lumia950-AARCH64/DEBUG_GCC5/FV/Image.gz-dtb

mkbootimg --kernel Build/Lumia950-AARCH64/DEBUG_GCC5/FV/Image.gz-dtb --ramdisk Lumia950XLPkg/device-specific/ramdisk-null --base 0x00000000 --pagesize 4096 --ramdisk_offset 0x02000000 --tags_offset 0x01e00000 -o Build/Lumia950-AARCH64/DEBUG_GCC5/FV/uefi.img 

