
[bits 16]
[org 0]

push ax
mov ax,cs
mov ds,ax
mov es,ax
pop ax


mov ax, 0
int 12h

push copyright
call escrever

push memoria
push ax
call parahexa

push espaco
call escrever
jmp 0x1000:0


escrever:	

	pusha
	mov bp,sp
	mov si,[bp+18] 
	cont:
		lodsb
		or al,al
		jz dne
		mov ah,0x0e
		mov bx,0
		mov bl,7
		int 10h
		jmp cont
	dne:
		mov sp,bp
		popa
		ret




parahexa:

	pusha
	mov bp,sp
	mov dx, [bp+20]
	push dx	
	call escrever
	mov dx,[bp+18]

	mov cx,4
	mov si,hexc
	mov di,hex+2
	
	guardar:
	
	rol dx,4
	mov bx,15
	and bx,dx
	mov al, [si+bx]
	stosb
	loop guardar
	push hex
	call escrever
	mov sp,bp
	popa
	ret
	
	
hex db "0x0000",10,13,0
hexc db "0123456789ABCDEF"
testt db "Ola!",10,13,0
memoria db "Memoria RAM disponivel para o Bin S.O: ",0
espaco db "",10,13
       db "",10,13,0
copyright db "",10,13
          db "Sistema Operacional Bin S.O",10,13
          db "",10,13
          db "Sistema de Gerenciamento de Hardware do Bin S.O",10,13
          db "",10,13
          db "Copyright (C) 2013 Felipe Miguel Nery Lunkes",10,13
          db "",10,13,0       
       
