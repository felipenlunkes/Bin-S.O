[bits 16]
[org 0]


;;*******************************************************************
;;
;;          Aplicativo para limpar a tela do Bin S.O
;;
;;
;;                 Sistema Operacional Bin S.O
;;
;;
;;
;;
;;
;;*******************************************************************

inicio:

	mov ax,cs
	mov ds,ax
	mov es,ax
    
    push ax
    push bx
    push cx
    push dx
    
    
    mov dx, 0
	mov bh, 0
	mov ah, 2
	int 10h  
	
	mov ah, 6			
	mov al, 0			
	mov bh, 7			
	mov cx, 0			
	mov dh, 24			
	mov dl, 79
	int 10h
	
	jmp 0x1000:0


	pop dx
	pop cx
	pop bx
	pop ax

	ret    
