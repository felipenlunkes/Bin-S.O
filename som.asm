[bits 16]
[org 0]

push ax
mov ax,cs
mov ds,ax
mov es,ax
pop ax

inicio:


;; clrscr:

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
	
	pop dx
	pop cx
	pop bx
	pop ax
	
mov si, msg
call escrever

 

jmp emitirsomagr

emitirsomagr:

mov ax, 4000
mov bx, 8
call emitirsom

mov ax, 3000
mov bx, 8
call emitirsom

mov ax, 3200
mov bx, 8
call emitirsom

mov ax, 2700
mov bx, 8
call emitirsom

mov cx, 100

rep

call desligarsom 


jmp 0x1000:0	


;;*******************************************************************

escrever:            ;; Driver para imprimir caracteres na tela 
  
   lodsb        
 
   or al, al  
   jz .pronto   
 
   mov ah, 0x0E
   int 0x10      
 
   jmp escrever

 
 .pronto:
   ret  
   
;;*******************************************************************  

emitirsom:

    pusha

	mov cx, ax			

	mov al, 182
	out 43h, al
	mov ax, cx			
	out 42h, al
	mov al, ah
	out 42h, al

	in al, 61h			
	or al, 03h
	out 61h, al

	popa
	
	ret
	
desligarsom:

	
	pusha

	in al, 61h
	and al, 0FCh
	out 61h, al

	popa
	
	ret
	
	
msg db "",10,13
    db "Iniciando teste de som do Bin S.O...",10,13
    db "",10,13
    db "",10,13,0
    
inicios db "Pressione ENTER para iniciar o teste...",10,13
       db "",10,13,0    	
	


