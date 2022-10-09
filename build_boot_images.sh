# Create uefi.img
cat ./BootShim/BootShim.bin ../edk2/Build/Nexus5X-AARCH64/DEBUG_GCC5/FV/MSM8992_EFI.fd ./device-specific/dummykernel > ./device-specific/bootpayload.bin

mkbootimg \
  --kernel ./device-specific/bootpayload.bin \
  --ramdisk ./device-specific/ramdisk-null \
  -o ./uefi.img \
  --pagesize 4096 \
  --header_version 2 \
  --cmdline "console=ttyMSM0,115200n8 earlycon=msm_geni_serial,0xa90000 androidboot.hardware=surfaceduo androidboot.hardware.platform=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 swiotlb=2048 loop.max_part=7 androidboot.usbcontroller=a600000.dwc3 kpti=off buildvariant=user" \
  --dtb ./device-specific/sm6225-redmi-note-11-spesn.dtb \
  --base 0x0 \
  --os_version 12.0.0 \
  --os_patch_level 2022-08-01 \
  --second_offset 0xf00000