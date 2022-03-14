; mov_reg.asm

global main       

section .text
main: 

    nop             ; ne fait rien

    mov rax, 0x1122334455667788
    
    mov rbx, rax
    mov r12, rbx
    
    mov eax, ebx    ; effet sur rax
    mov r12d, ebx   ; effet sur r12
    
    mov r8, -1
    
    mov bx, r8w
    mov r12b, r8b
    
    ; la source et la destination doivent avoir même taille
;    mov rax, esi  ; error: invalid combination of opcode and operands
;    mov r8, ax    ; error: invalid combination of opcode and operands
;    mov eax, r8b  ; error: invalid combination of opcode and operands
 
    mov ah, al
    mov al, r8b
    mov sil, al
    mov r15b, al
    mov sil, spl
    
    ; interdit d'utiliser ah, bh, ch ou dh avec :
    ;   + sil, dil, spl, bpl ;
    ;   + r8b -> r15b.
;    mov sil, ah  ; error: cannot use high register in rex instruction
;    mov r8b, ah  ; error: cannot use high register in rex instruction
    
    ; fin
    mov rax, 60
    mov rdi, 0
    syscall

