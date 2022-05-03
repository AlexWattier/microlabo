global main

section .data

    var     dq      5312561
    var1    dq      544


section .text

main:

    push qword[var]
    push qword[var1]
    pop qword[var]
    pop qword[var1]
    
fin:
    mov     rax , 60
    mov     rdi , 0
    syscall