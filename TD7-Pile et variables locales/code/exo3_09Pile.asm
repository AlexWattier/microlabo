global main

section .text

main:

    push rbp
    mov rbp, rsp        ; création du nouveau contexte de pile
    
    sub rsp, 1          ; variable local
    mov byte[rbp-1] , 8
        
    or byte[rbp-1], 00110000b
        
; affichage
    mov     rax, 1          ; write
    mov     rdi, 1          ; stdout, sortie standard
    mov     rsi, rbp        ; adresse du 1er caractère
    sub rsi , 1             ; contenu de rsi : adresse de la varibale locale
    mov     rdx, 1          ; nombre de caractères
    syscall
    
    mov rsp , rbp   ; destruction variable local
    pop rbp
    
fin:                    ; fin normal du programme
    mov     rax , 60
    mov     rdi , 0
    syscall