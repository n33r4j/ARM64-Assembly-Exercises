// AARCH64 Assembly Tutorial 002

.global _start
.section .text

_start:
    // Write System call
    mov x8, #64       // write syscall
    mov x0, #1        // file descriptor, STDIN = 0, STDOUT = 1, STDERR = 2
    ldr x1, =message  // buffer, memory operation i.e load into x1, '=' means address
    mov x2, #14       // size
    svc 0             // invoke the kernel

    // Exit System call
    mov x8, #93     // exit syscall
    mov x0, #32     // return value in arg0, 0x41 is just a val we return to test that our program works. It could be any number I think?
    svc 0           // invoke the kernel

.section .data
    message:
	.ascii "Hello, World!\n"
