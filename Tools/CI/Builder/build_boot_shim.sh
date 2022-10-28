#!/bin/bash

cd BootShim
make UEFI_BASE=0xD0000000 UEFI_SIZE=0x00300000
cd ..