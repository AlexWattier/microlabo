global main

section .rodadata
var	DB	1
msgpr	DB	`pair \n`
prlg 	DQ  	 $ - msgpr

msimp	DB	`impair \n`
implg 	DQ  	 $ - msimp


section .text

	

main:

	mov rcx ,[var]     ; met la valeur de var dans rcx
	bt rcx ,0          ; verifie si rcx est paire
	
	jnc Paire          ;saut si le nombre est paire
	jmp impair         ;saut si le nombre est impaire
	
	
Paire:
	mov rax ,1         ; met rax a 1 pour ecrire
	mov rdi ,1         ; sortie numero 1 (sortie standard)
	mov rsi ,msgpr     ; adresse du premier caractere
	mov rdx ,[implg]   ; nombre de caractere a afficher
	syscall            ; appel systeme
	jmp fin            ; saut a la fin

	
impair: 

	mov rax ,1         ; met rax a 1 pour ecrire
	mov rdi ,1         ; sortie numero 1 (sortie standard)
	mov rsi ,msimp     ; adresse du premier caractere
	mov rdx ,[prlg]    ; nombre de caractere a afficher
	syscall            ; appel systeme
	jmp fin	           ; saut a la fin

fin:                       ; fini le programme
	mov rax ,60
	mov rdi ,0
	syscall
