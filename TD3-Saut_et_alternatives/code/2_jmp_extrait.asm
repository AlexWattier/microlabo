    mov rax, 123    ; rax <-- 123
    mov rbx, 150    ; rbx <-- 150

    jmp fin         ; saut inconditionnel vers le label fin

    mov rax, 0      ; ces instructions
    mov rbx, 0      ; ne sont pas exécutées

fin:                ; label fin 
    mov rax, 60 	
    mov rdi, 0
    syscall
