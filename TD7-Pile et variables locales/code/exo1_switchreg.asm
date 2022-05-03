global main

section .text

main:

    mov rax, 27
    mov rbx, -9

    push rax        ; push rax  ; { int i = rax;
    mov rax, rbx    ; push rbx   ; { int j = rbx;
    pop rbx         ; pop rax    ; rax = j; }
                    ; pop rbx    ; rbx = i; }
    
    




fin:
    mov     rax , 60
    mov     rdi , 0
    syscall