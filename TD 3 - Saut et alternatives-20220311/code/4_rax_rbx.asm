; 4_rax_rbx.asm

global main

section .text
main:
    nop         ; ne fait rien

    mov rax , 15 ; met 15 a rax 
    mov rax , 3 
    
    bt rax, 0
    jc _sinon
        mov r8, 0      ; si rax est paire 
        jmp fin
        
_sinon:
    mov r8, 1     ; si rax est impaire
    
fin:            ; fin
    mov rax, 60
    mov rdi, 0
    syscall