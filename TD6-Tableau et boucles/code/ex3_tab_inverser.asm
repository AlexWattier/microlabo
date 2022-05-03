; ex3_tab_inverser.asm


global main
section .bss
    tab     RESQ    100
    
section .text
main:

    mov rax , 0
    mov rbx , 99
pour: 
    cmp rax, 100 ; r8b non alter
    jz fin
  
    mov qword [tab + rax * 8] , rbx  ; multiplier par 8 car 
    inc rax
    dec rbx
    jmp pour
    
fin:
    mov     rax , 60
    mov     rdi , 0
    syscall
