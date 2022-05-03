global main

section .rodata

    tab     dq  20, 2, 3, 50, 5, 1, 7, 8, 10, 12 ; 10 éléments arbitraires
    tab_len dq  $ - tab ; longueur du tableau : 10 * 8 bytes
    nb_elem dq  (tab_len - tab) / 8 ; nbr éléments : (lg tab - tab) / taille case

section .bss
    tab2     RESQ    10
    
section .text

main:
    mov rax , 0
    mov r8  , qword [tab]
    mov r10 , qword [tab]
pour: 
    cmp rax , [nb_elem] ; comp rax au nbr d element dans le tableau
    jz fin
  
    cmp qword [tab + rax * 8] , r8
    jns grand          ;saut si le nombre est paire
    
        mov r8 , qword [tab + rax * 8]
        jmp repete
grand:
    cmp qword [tab + rax * 8] , r10
    js repete
        mov r10 , qword [tab + rax * 8]
        
repete:
    inc rax
    jmp pour
   
fin:
    mov     rax , 60
    mov     rdi , 0
    syscall