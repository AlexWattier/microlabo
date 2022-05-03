global main

section .rodata

	fichier  	DB	`fichier`, 0
	
	msgError 	DB 	`échec lors de l’ouverture du fichier\n`
	lgmsg 		DQ 	$ - msgError
	
	msgError2	DB	`fichier ouvert avec succès\n`
	lgmsg2		DQ 	$ - msgError2

section .text

	

main:

; tente ouverture fichier lecture seul si reussi envoie erreur

	mov rax ,2             ; ouvre
	mov rdi ,fichier       ; adresse du premier caractere du fichier
	mov rsi ,0q            ; read only avec 0q / 1q | 2000q pour write only
	syscall                ; appel systeme
	mov r9,rax             ; stock rax dans r9
	cmp rax ,0             ; verifie si le fichier est bien ouvert
	js fileNotOpen         ; saut si le fichier n existe pas
	jns fileOpen           ; saut si le fichier existe

fileOpen :

	mov rax ,1             ; met rax a 1 pour ecrire
	mov rdi ,1             ; sortie numero 1 (sortie standard)
	mov rsi , msgError2    ; adresse du premier caractere a afficher
	mov rdx ,[lgmsg]       ; nombre de caractere a afficher
	syscall                ; appel systeme
	jmp fin                ; saut a la fin

fileNotOpen:
	mov rax ,1             ; met rax a 1 pour ecrire
	mov rdi ,1             ; sortie numero 1 (sortie standard)
	mov rsi , msgError     ; adresse du premier caractere a afficher
	mov rdx , [lgmsg]      ; nombre de caractere a afficher
	syscall                ; appel systeme

	mov rax ,60            ;fin du programme avec erreur
	mov rdi ,1
	syscall
fin:                           ;fin du programme sans erreur
	mov rax ,60
	mov rdi ,0
	syscall


