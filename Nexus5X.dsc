#
#  Copyright (c) 2011-2015, ARM Limited. All rights reserved.
#  Copyright (c) 2014, Linaro Limited. All rights reserved.
#  Copyright (c) 2015 - 2016, Intel Corporation. All rights reserved.
#  Copyright (c) 2018, Bingxing Wang. All rights reserved.
#
#  This program and the accompanying materials
#  are licensed and made available under the terms and conditions of the BSD License
#  which accompanies this distribution.  The full text of the license may be found at
#  http://opensource.org/licenses/bsd-license.php
#
#  THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
#  WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
#
#

################################################################################
#
# Defines Section - statements that will be processed to create a Makefile.
#
################################################################################
[Defines]
  PLATFORM_NAME                  = Nexus5X
  PLATFORM_GUID                  = b6325ac2-9f3f-4b1d-b129-ac7b35ddde60
  PLATFORM_VERSION               = 0.1
  DSC_SPECIFICATION              = 0x00010005
  OUTPUT_DIRECTORY               = Build/Nexus5X-$(ARCH)
  SUPPORTED_ARCHITECTURES        = AARCH64
  BUILD_TARGETS                  = DEBUG|RELEASE
  SKUID_IDENTIFIER               = DEFAULT
  FLASH_DEFINITION               = Nexus5XPkg/Nexus5X.fdf

  DEFINE SECURE_BOOT_ENABLE           = TRUE
  DEFINE USE_MEMORY_FOR_SERIAL_OUTPUT = 0
  DEFINE USE_SCREEN_FOR_SERIAL_OUTPUT = 1
  DEFINE MEMORY_4GB                   = 1

[BuildOptions.common]
!if $(USE_MEMORY_FOR_SERIAL_OUTPUT) == 1
  GCC:*_*_AARCH64_CC_FLAGS = -DSILICON_PLATFORM=6225 -DUSE_MEMORY_FOR_SERIAL_OUTPUT=1
!else
  GCC:*_*_AARCH64_CC_FLAGS = -DSILICON_PLATFORM=6225
!endif

[PcdsFixedAtBuild.common]
  # Platform-specific
  gArmTokenSpaceGuid.PcdSystemMemoryBase|0x40000000         # 2GB Base
  gArmTokenSpaceGuid.PcdSystemMemorySize|0x100000000         # 4GB Size
  gArmPlatformTokenSpaceGuid.PcdCoreCount|8
  gArmPlatformTokenSpaceGuid.PcdClusterCount|2
  gNexus5XPkgTokenSpaceGuid.PcdSmbiosSystemModel|"Redmi Note 11"
  gNexus5XPkgTokenSpaceGuid.PcdSmbiosProcessorModel|"Qualcomm Snapdragon 680 Processor (6225)"
  gNexus5XPkgTokenSpaceGuid.PcdSmbiosSystemRetailModel|" "
  gNexus5XPkgTokenSpaceGuid.PcdUefiMemPoolSize|0x02800000      
  gNexus5XPkgTokenSpaceGuid.PcdUefiMemPoolBase|0xD0300000   # Start here
  
!include Nexus5XPkg/Shared.dsc.inc
