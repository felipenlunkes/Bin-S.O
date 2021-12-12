;;*******************************************************************
;;
;;
;;   Aplicativo para realizar teste do monitor gravando diretamente
;;
;;                     na memória de vídeo
;;
;;
;;                   Sistema Operacional Bin S.O 
;;
;;         Copyright (C) 2013 Felipe Miguel Nery Lunkes
;;
;;*******************************************************************


[bits 16]
[org 0]


inicio:



	mov ax, cs
	mov ds, ax
	mov es, ax

	mov ax, 0xb800
	mov gs, ax
	mov bx, 0

	mov si, msg
	mov ch, 1
	
	
	contar:
		lodsb 
		or al,al
		jz pronto
	
		mov byte [gs:bx], al
		mov byte [gs:bx+1], ch
		inc ch
		add bx,2
	jmp contar	
	
	
	pronto:

		jmp 0x1000:0
	
	
msg db "Sistema Operacional Bin S.O Apollo",0
