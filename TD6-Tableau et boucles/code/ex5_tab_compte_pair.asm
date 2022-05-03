
global main

section .rodata

    tab     dq  1, 2, 3, 4, 5, 6, 7, 8, 10, 12 ; 10 éléments arbitraires
    tab_len dq  $ - tab ; longueur du tableau : 10 * 8 bytes
    nb_elem dq  (tab_len - tab) / 8 ; nbr éléments : (lg tab - tab) / taille case

section .bss
    tab2     RESQ    10
section .text
main:

    mov rax , 0
    mov r15 , 0
pour: 
    cmp rax , [nb_elem] ; r8b non alter
    jz fin
  
    bt qword [tab + rax * 8] , 0  ; multiplier par 8 car 
    jnc paire          ;saut si le nombre est paire
    inc rax
    jmp pour
paire:
    
    inc r15
     inc rax
     jmp pour
   
fin:
    mov     rax , 60
    mov     rdi , 0
    syscall
