; 02_chaine_complet.asm

global _start

section .rodata

    s1          DB      "abc"           ; 3 bytes
    s1_long     DB      "a", "b", "c"
    s1_alt      DB      0x61, 0x62, 0x63

    s2          DB      'def', 0        ; 4 bytes, zéro-terminée
    s2_long     DB      'd', 'e', 'f', 0
    s2_alt      DB      0x64, 0x65, 0x66, 0x00

    s3          DB      `ghi\n`         ; 4 bytes, \n échappé
    s3_long     DB      `g`, `h`, `i`, `\n`
    s3_alt      DB      0x67, 0x68, 0x69, 0x0a  ; \n GNU / Linux

    s4          DB      'jkl\n'         ; 5 bytes
    s4_long     DB      'j', 'k', 'l', '\', 'n'
    s4_alt      DB      0x6a, 0x6b, 0x6c, 0x5c,0x6e

    s5          DB      `mnô`   ; 4 bytes si utf-8 comme sur linux1
    s5_long     DB      `m`, `n`, `ô`
    s5_alt      DB      0x6d, 0x6e, 0xc3, 0xb4

    s6          DW      "pqr"           ; noter le DW
    s6_long     DB      "p", "q", "r", 0
    s6_alt      DB      0x70, 0x71, 0x72, 0x00

    s7          DQ      `stu`           ; noter le DQ
    s7_long     DB      `s`, `t`, `u`, 0, 0, 0, 0, 0
    s7_alt      DB      0x73, 0x74, 0x75, 0x00, 0x00, 0x00, 0x00, 0x00

    end         DB      -1

section .data

    s10     times   20  DB '.'          ; 20 bytes à '.'

section .bss

    s20         RESB    20              ; 20 bytes

section .text
_start:

    mov     rax, 60
    mov     rdi, 0
    syscall
