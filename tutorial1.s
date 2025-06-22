# AARCH64 Assembly Tutorial 001

.global _start
.section .text

_start:
    mov x8, #0x5d // exit syscall
    mov x0, #0x41 // return value in arg0, 0x41 is just a val we return to test that our program works.
    svc 0         // invoke the kernel

.section .data
