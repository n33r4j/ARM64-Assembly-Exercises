#!/bin/bash

FULL_FILENAME=$(basename -- "$1")
FILENAME="${FULL_FILENAME%.*}"

echo "Building '${FULL_FILENAME}'.."

aarch64-linux-gnu-as $FULL_FILENAME -o "${FILENAME}.o"

aarch64-linux-gnu-gcc-11 "${FILENAME}.o" -o "${FILENAME}.elf" -nostdlib -static
# (the 2 flags at the end are to get it running with qemu I think?)

rm "${FILENAME}.o"

echo "Deleted '${FILENAME}.o'.."

echo "Running '${FILENAME}.elf'.."

qemu-aarch64 ${FILENAME}.elf

echo "return value: $?"

