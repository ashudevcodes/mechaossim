#!/bin/bash
set -euo pipefail

for cand in "${OVMF_CODE:-}" /usr/share/OVMF/OVMF_CODE_4M.fd /usr/share/edk2/x64/OVMF_CODE.4m.fd; do
  [[ -n "$cand" && -f "$cand" ]] && { OVMF_CODE_FILE=$cand; break; }
done

for cand in "${OVMF_VARS_TEMPLATE:-}" /usr/share/OVMF/OVMF_VARS_4M.fd /usr/share/edk2/x64/OVMF_VARS.4m.fd; do
    [[ -n "$cand" && -f "$cand" ]] && { OVMF_VARS_FILE=$cand; break; }
done

cp $OVMF_VARS_FILE ovmf/
cp $OVMF_CODE_FILE ovmf/

OVMF_CODE=ovmf/OVMF_CODE.4m.fd
OVMF_VARS=ovmf/OVMF_VARS.4m.fd

IMAGE=image/mechanix-os-qemu.raw

qemu-system-x86_64 \
  -enable-kvm \
  -machine q35 \
  -cpu host \
  -smp 4 \
  -m 4096 \
  -drive if=pflash,format=raw,readonly=on,file="$OVMF_CODE" \
  -drive if=pflash,format=raw,file="$OVMF_VARS" \
  -drive file="$IMAGE",if=none,id=bootdisk,format=raw \
  -device virtio-blk-pci,drive=bootdisk,bootindex=1 \
  -display sdl,gl=on \
  -device qemu-xhci,id=xhci \
  -device usb-tablet,bus=xhci.0 \
  -device usb-kbd,bus=xhci.0 \
  -virtfs local,path=$(pwd)/shared,mount_tag=share,security_model=none,id=hostshare
