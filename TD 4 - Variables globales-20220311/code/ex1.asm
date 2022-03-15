global _start

section .data
    var1   DB   1 
    var2   DB   2
    var3   DW   0x0304
    var4   DQ   0x000000008000FFFF
    ; la section des données occupe ...... bytes
    ; son contenu est ...........................................
    
section .text
main:
_start:
    mov rax, var1     ; rax contient l addresse de var1
    mov al,  [var1]   ; al  contient la valeur de var1
    mov ax,  [var1]   ; ax  contient la valeur de var1
    mov al,  [var3]   ; al  contient la valeur de var3    
    mov ax,  [var3]   ; ax  contient la valeur de var3      
    mov rax, -1       ; rax contient -1
    mov eax, [var4]   ; rax contient ............................

    mov rax, 60
    mov rdi, 0    
    syscall

