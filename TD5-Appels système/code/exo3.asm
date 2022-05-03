global main

section .bss
    file    RESB    1

section .text
main:
	
    mov rsi , 5             ; met la valeur a tester
    or rsi , 00110000b      ; applique le masque pour convertir en ascii
    mov [file] , rsi        ; met le resultat dans la variable file

    mov rax , 1             ; met rax a 1 pour ecrire 
    mov rdi , 1             ; sortie numero 1 (sortie standard)
    mov rsi , file          ; adresse du premier caractere
    mov rdx , 1             ; adresse du dernier caractere
    syscall                 ; appel systeme
	
		

fin:                        ; fini le programme
    mov rax, 60
    mov rdi, 0
    syscall
