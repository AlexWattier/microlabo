; 1_cmp_rax.asm

global main

section .text
main:
    nop         ; ne fait rien

    mov rax, 15 ; met 15 a rax 

   cmp rax, 0
jnz _notnull

    mov rbx , 0
    jmp fin

_notnull:
    mov rbx , 1
    jmp fin
    
fin:            ; fin
    mov rax, 60
    mov rdi, 0
    syscall