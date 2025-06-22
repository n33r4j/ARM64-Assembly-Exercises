// AARCH64 Assembly Tutorial 005
// Note that this is still not bare-metal assembly since we use syscalls here.
// I guess this is more for A series chips which have OSs?
// Try in-place reversing next

.global _start
.section .text

_start:
    // Read System call
    mov x8, #63           // read syscall
    mov x0, #0            // fd
    ldr x1, =read_buffer  // pointer to buffer
    mov x2, 32            // no. of bytes to read
    svc #0
    
    mov x9, x0 // actual no. of bytes read
    
    // read_buffer has our "input string"
    
    mov x5, x1            // move the read_buffer address to x5
    sub x6, x9, #2       // store offset in x6, -2 since zero indexing and we're skipping '\n'
    ldr x7, =write_buffer
//    ldr x10, =buffer
    
loop:
    ldrb w2, [x5, x6] // Load byte at address x5 into w2
    strb w2, [x7], #1 // Store char into write_buffer, post increment
    
  //  strb w2, [x10]
  //  mov x8, #64           // write syscall
  //  mov x0, #1            // file descriptor, STDIN = 0, STDOUT = 1, STDERR = 2
  //  mov x1, x10  // pointer to buffer, memory operation i.e load into x1, '=' means address
  //  mov x2, #1           // no. of bytes to write
  //  svc #0                // invoke the kernel
    
    cbz x6, done  // If zero, exit

    sub x6, x6, #1    // decrement address i.e. move to prev char
    b loop
    
done:
    ldr x7, =write_buffer // reset x7 to start of buffer
    
    // Add a newline to the end of the write_buffer
    mov w3, #'\n'
    mov x4, x9
    sub x4, x4, #1
    strb w3, [x7, x4]
    
    // Print out write buffer
    mov x8, #64            // write syscall
    mov x0, #1             // file descriptor, STDIN = 0, STDOUT = 1, STDERR = 2
    mov x1, x7             // pointer to buffer, memory operation i.e load into x1, '=' means address
    mov x2, x9             // no. of bytes to write
    svc #0                 // invoke the kernel
    
    // Exit System call
    mov x8, #93           // exit syscall
    mov x0, #0            // return value
    svc #0                // invoke the kernel

.section .data
    read_buffer:
        .skip 32 // Reserve 32 bytes
    
    write_buffer:
        .skip 32

