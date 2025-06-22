// AARCH64 Assembly Tutorial 004
// Note that this is still not bare-metal assembly since we use syscalls here.
// I guess this is more for A series chips which have OSs?

.global _start
.section .text

_start:
    ldr x29, =stack_top // set up a stack, since linux might be looking for this?
    mov sp, x29
    
    ldr x4, =my_str // Load the address of my_string into x1
    ldr x5, =buffer
    
loop:
    ldrb w2, [x4] // Load byte at address x1 into w2
    cbz w2, done  // If null terminator, exit

    // Print character
    // Step 1 - Move the char and newline into buffer
    // ldr  x3, =buffer // This is bad for some reason?
    strb w2, [x5]     // Store char into buffer[0], post increment by 1
    mov  w3, #'\n'
    strb w3, [x5, #1] // Store newline into buffer[1]
    
    // Step 2 - Write what's in buffer to STDOUT
    mov x0, #1        // fd, STDOUT=1
    mov x1, x5   // x1 now has the address of buffer
    mov x2, #2        // size i.e. 2 bytes
    mov x8, #64       // Write syscall
    svc #0            // invoke kernel
    
    add x4, x4, #1    // increment address i.e. move to next char
    b loop
    
done:
    // Exit System call
    mov x8, #93           // exit syscall
    mov x0, #0            // return value
    svc #0                // invoke the kernel

.section .data
    my_str:
        .asciz "Hello World!"
// '.asciz' assembler directive null terminates the string.
// '.ascii' does not null terminate.

.section .bss
    .lcomm buffer, 2 // 2-byte buffer

    // Stack (8KB)
    .lcomm stack, 8192
    .equ stack_top, stack + 8192
