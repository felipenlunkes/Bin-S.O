[bits 16]
[org 0]




inicio:

	mov ax,cs
	mov ds,ax
	mov es,ax


	
	mov ah,03
	mov bh,0
	int 10h
	
	mov si, msg
	call escrever
	
	jmp 0x1000:0
	
	
escrever:            ;; Driver para imprimir caracteres na tela 
   lodsb        
 
   or al, al  
   jz .pronto   
 
   mov ah, 0x0E
   int 0x10      
 
   jmp escrever

 
 .pronto:
   ret  
   
   


msg db "",10,13
    db "Sistema Operacional Bin S.O Versao 0.1.1 Apollo",10,13
    db "",10,13
    db "Copyright (C) 2013 Felipe Miguel Nery Lunkes",10,13
    db "",10,13
    db "Todos os direitos reservados.",10,13,0
