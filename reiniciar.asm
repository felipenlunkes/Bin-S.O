[bits 16]
[org 0]


push ax
mov ax,cs
mov ds,ax
mov es,ax
pop ax

call clrscr

mov si, reiniciar
call escrever

mov ax, 0
int 16h

int 19h


escrever:            ;; Driver para imprimir caracteres na tela 
  
    lodsb        
 
   or al, al  
   jz .pronto   
 
   mov ah, 0x0E
   int 0x10      
 
   jmp escrever

 
 .pronto:
   ret
   
clrscr:                      ;; Processo para limpar a tela
    
    
    
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

	ret       
   
reiniciar db "",10,13
          db "Sistema Operacional Bin S.O",10,13
          db "---*---*---*---*---*---*---*",10,13
          db "",10,13
          db "",10,13
          db "Preparando para desligar seu computador e o Bin S.O...",10,13
          db "",10,13
          db "Finalizando o Bin S.O...",10,13
          db "",10,13
          db "",10,13
          db "Pressione ENTER para reiniciar seu computador.",10,13
          db "",10,13
          db "",10,13,0 

