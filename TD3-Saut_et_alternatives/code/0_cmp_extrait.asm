    mov rax, 4
    
    cmp rax, 4      ; ZF : 1, SF : 0 (4 - 4 >= 0) 
    cmp rax, 5      ; ZF : 0, SF : 1 (4 - 5 < 0)
    cmp rax, 2      ; ZF : 0, SF : 0 (4 - 2 >= 0)
    cmp rax, -3     ; ZF : 0, SF : 0 (4 - -3 >= 0)
    cmp rax, -10    ; ZF : 0, SF : 0 (4 - -10 >= 0)

    mov rax, -3
    
    cmp rax, 4      ; ZF : 0, SF : 1 (-3 - 4 < 0) 
    cmp rax, 5      ; ZF : 0, SF : 1 (-3 - 5 < 0)
    cmp rax, 2      ; ZF : 0, SF : 1 (-3 - 2 < 0)
    cmp rax, -3     ; ZF : 1, SF : 0 (-3 - -3 >= 0)
    cmp rax, -10    ; ZF : 0, SF : 0 (-3 - -10 >= 0)
    
    mov ebx, 42
    ; cmp rax, ebx    ; compile pas : tailles différentes

