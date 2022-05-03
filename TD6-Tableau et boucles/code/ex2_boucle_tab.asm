; ex2_boucle_tab.asm


global main
section .bss
    tab     RESQ    100
    
section .text
main:

    mov rax, 0
pour: 
    cmp rax, 100 ; r8b non alter
    jz fin
  
    mov qword [tab + rax * 8] , rax  ; multiplier par 8 car 
    inc rax
    jmp pour
    
fin:
    mov     rax , 60
    mov     rdi , 0
    syscall
