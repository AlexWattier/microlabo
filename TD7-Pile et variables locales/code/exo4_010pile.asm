global main

section .text

main:

    push rbp
    mov rbp, rsp        ; création du nouveau contexte de pile
    
    sub rsp, 10          ; variable local
    
    mov al , 0
    mov r10 , -10
    
for:
    cmp r10 , 0
    jz affiche
    
    
    mov byte[rbp+r10] , al
    or byte[rbp+r10], 00110000b
    inc r10
    inc al
    jmp for
        
affiche:
    mov     rax, 1          ; write
    mov     rdi, 1          ; stdout, sortie standard
    mov     rsi, rbp        ; adresse du 1er caractère
    sub rsi , 10             ; contenu de rsi : adresse de la varibale locale
    mov     rdx, 10          ; nombre de caractères
    syscall
    
    
fin:                    ; fin normal du programme
    mov     rax , 60
    mov     rdi , 0
    syscall