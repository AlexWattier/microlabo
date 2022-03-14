    mov rax, 0x80   ; rax : 0x00_00_00_00_00_00_00_80
    cmp rax, 0x80   ; ZF : 1, SF : 0 car extension de signe donne
    ; cmp 0x00_00_00_00_00_00_00_80, 0x00_00_00_00_00_00_00_80
    
    mov rax, 0x80808080 ; rax : 0x00_00_00_00_80_80_80_80
    cmp rax, 0x80808080 ; ZF : 0, SF : 0 car extension de signe donne
    ; cmp 0x00_00_00_00_80_80_80_80, 0xFF_FF_FF_FF_80_80_80_80
    
    ; à comparer à
    mov rax, 0x80808080 ; rax : 0x00_00_00_00_80_80_80_80
    mov ebx, 0x80808080 ; rbx : 0x00_00_00_00_80_80_80_80
                        ; mov rbx, 0x80808080 donne idem car pas
                        ;  d'extension de signe avec mov !
    cmp rax, rbx        ; ZF : 1, SF : 0 car 
    ; cmp 0x00_00_00_00_80_80_80_80, 0x00_00_00_00_80_80_80_80

