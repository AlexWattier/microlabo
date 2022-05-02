; 03_adressage_immediat_complet.asm

global _start

section .rodata
    i       DQ      -234
    s       DB      `hello`, 0

; contenu de la section .rodata (byte par byte, hexadécimal) :
; ---> petites adresses --->
;       i                                       s
;  ... | 16 | FF | FF | FF | FF | FF | FF | FF | 68 | 65 | 6C | .
;
;     . 6C | 6F | 00 | ...
;                                       ---> grande adresses --->

section .text
_start:

    mov     rbx, 112        ; 112 est évidemment un immédiat

    mov     rcx, 1q | 100q | 2000q
    ; l'expression « 1q | 100q | 2000q » est calculée par nasm
    ; à l'exécution, on a la valeur immédiate 2101q (0x441, 1089)

    mov     r8, i
    ; i est un immédiat « calculé » par nasm, c'est l'adresse
    ; du 1er byte de la « variable » nommée i (détails voir TD04)
    ; sur ma machine, j'ai la valeur 0x402000

    mov     r9, s
    ; s est un immédiat « calculé » par nasm, c'est l'adresse
    ; du 1er byte de la chaîne de caractères étiquetée s
    ; sur ma machine, j'ai la valeur 0x402008 (ok : i + 8)

    mov     rax, 60
    mov     rdi, 0
    syscall
