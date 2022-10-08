# Create uefi.img
cd ..
cd edk2

cat ./Nexus5XPkg/BootShim/BootShim.bin ./Build/Nexus5X-AARCH64/DEBUG_GCC5/FV/MSM8992_EFI.fd > ./Build/Nexus5X-AARCH64/DEBUG_GCC5/FV/BootShimMSM8992_EFI.fd

gzip -c < Build/Nexus5X-AARCH64/DEBUG_GCC5/FV/BootShimMSM8992_EFI.fd >Build/Nexus5X-AARCH64/DEBUG_GCC5/FV/BootShimMSM8992_EFI.fd.gz

# Rev 1.0
cat ./Build/Nexus5X-AARCH64/DEBUG_GCC5/FV/BootShimMSM8992_EFI.fd.gz ./Nexus5XPkg/device-specific/sm6225-redmi-note-11-spesn.dtb >> Build/Nexus5X-AARCH64/DEBUG_GCC5/FV/Image.gz-dtb

mkbootimg --kernel ./Build/Nexus5X-AARCH64/DEBUG_GCC5/FV/Image.gz-dtb --ramdisk ./Nexus5XPkg/device-specific/ramdisk-null --base 0x40000000 --pagesize 4096 -o ./Build/Nexus5X-AARCH64/DEBUG_GCC5/FV/uefi.img 
