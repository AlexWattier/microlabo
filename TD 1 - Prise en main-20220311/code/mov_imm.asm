; mov_imm.asm 

global main       

section .text
main: 

    nop             ; ne fait rien

    ; rax, rbx, rcx et rdx : idem
    mov rax, 0x1122334455667788
    mov eax, -1
    mov rax, 0x1122334455667788
    mov ax, 1
    mov al, -1         
    mov ah, 0xA2
    
    ; rax alias r0
    ; ce qui suit n'est pas reconnu par nasm
    ; r0 -> r7 : pas reconnus par nasm
;    mov r0, 0x1122334455667788 
                    ; mov_imm.asm:21: error: symbol `r0' undefined
;    mov r0d, -1
                    ; mov_imm.asm:23: error: symbol `r0d' undefined
;    mov r0w, 1
                    ; mov_imm.asm:25: error: symbol `r0w' undefined   
;    mov r0b, -1
                    ; mov_imm.asm:27: error: symbol `r0b' undefined

    ; rsi et rdi : idem
    mov rsi, -1
    mov esi, 12345670q
    mov si, 1010101010101010b
    mov sil, 'a'    ; sil reçoit le code ASCII du caractère 'a'
    
    ; rsp et rbp : comme rsi et rdi, mais utilisation comme registres
    ;              généraux déconseillée (+ tard)
 
    ; r8 -> r15 : idem
    mov r8, 0xFFEEDDCCBBAA9988
    mov r8d, -1
    mov r8w, 1
    mov r8b, -1
    
    mov r9, 0x11_22_33_44_55_66_77_88
    mov r10, 0x1122334455667788 
    mov r11, 0x1122334455667788 
    mov r12, 0x1122334455667788 
    mov r13, 0x1122334455667788 
    mov r14, 0x1122334455667788 
    mov r15, 0x1122334455667788 

;    mov r16, 0x1122334455667788    ; r16 n'existe pas 
                    ; mov_imm.asm:53: error: symbol `r16' undefined
    
;    mov rip, 0      ; erreur de compilation : rip inaccessible
                    ; mov_imm.asm:56: error: symbol `rip' undefined
                    
;    mov rflags, 0   ; erreur de compilation : rflags inaccessible
                    ; mov_imm.asm:59: error: symbol `rflags' undefined
    
    ; fin
    mov rax, 60
    mov rdi, 0
    syscall

