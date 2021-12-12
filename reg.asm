
[bits 16]
[org 0]

push ax
mov ax,cs
mov ds,ax
mov es,ax
pop ax
push axx
push ax
call parahexa

push bxx
push bx
call parahexa

push cxx
push cx
call parahexa

push dxx
push dx
call parahexa

push css
push cs
call parahexa

push dss
push ds
call parahexa

push sss
push ss
call parahexa

push ess
push es
call parahexa

push spp
push sp
call parahexa

push sii
push si
call parahexa

push dii
push di
call parahexa

push gss
push gs
call parahexa


push fss
push fs
call parahexa

mov ax, 0
int 12h

jmp 0x1000:0


escrever:	
	pusha
	mov bp,sp
	mov si,[bp+18] 
	cont:
		lodsb
		or al,al
		jz pronto
		mov ah,0x0e
		mov bx,0
		mov bl,7
		int 10h
		jmp cont
	pronto:
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
css db "Registrador CS: ",0
dss db "Registrador DS: ",0
sss db "Registrador SS: ",0
ess db "Registrador ES: ",0
gss db "Registrador GS: ",0
fss db "Registrador FS: ",0
axx db "Registrador AX: ",0
bxx db "Registrador BX: ",0
cxx db "Registrador CX: ",0
dxx db "Registrador DX: ",0
spp db "Registrador SP: ",0
bpp db "Registrador BP: ",0
sii db "Registrador SI: ",0
dii db "Registrador DI: ",0

