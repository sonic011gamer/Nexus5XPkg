#!/bin/bash
# Travis CI builder
#
# Copyright 2018, Bingxing Wang. <uefi-oss-projects@imbushuo.net>
# All rights reserved.
#

# Export AArch64 Tools prefix on CI
export GCC5_AARCH64_PREFIX=aarch64-linux-gnu-
# Export BUILDALL flags
export BUILDALL=1

# Go to EDK2 workspace
cd ..
cd edk2

# Start build
echo "Start build..."
. Nexus5XPkg/Tools/rundbbuild.sh --nexus5x --development

# Check if we have both FD ready
if [ ! -f Build/Nexus5X-AARCH64/DEBUG_GCC5/FV/MSM8992_EFI.fd ]; then
    echo "Unable to find build artifacts."
    exit 1
fi