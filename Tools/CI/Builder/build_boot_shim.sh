#!/bin/bash

cd BootShim
make UEFI_BASE=0x5FC00000 UEFI_SIZE=0x00300000
cd ..