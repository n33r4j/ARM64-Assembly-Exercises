// AARCH64 Assembly Tutorial 003
// Note that this is still not bare-metal assembly since we use syscalls here.
// I guess this is more for A series chips which have OSs?

.global _start
.section .text

_start:
    // Read System call
    mov x8, #63           // read syscall
    mov x0, #0            // fd
    ldr x1, =read_buffer  // pointer to buffer
    mov x2, 32            // no. of bytes to read
    svc #0

    // Write System call
    mov x8, #64           // write syscall
    mov x0, #1            // file descriptor, STDIN = 0, STDOUT = 1, STDERR = 2
    ldr x1, =read_buffer  // pointer to buffer, memory operation i.e load into x1, '=' means address
    mov x2, #32           // no. of bytes to write
    svc #0                // invoke the kernel

    // Exit System call
    mov x8, #93           // exit syscall
    mov x0, #32           // return value in arg0, 0x41 is just a val we return to test that our program works. It could be any number I think?
    svc #0                // invoke the kernel

.section .data
    read_buffer:
        .skip 32 // Reserve 32 bytes
