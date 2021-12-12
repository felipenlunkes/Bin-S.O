[bits 16]
[org 0]


inicio:

	mov ax,cs
	mov ds,ax
	mov es,ax
	
mov ax, 0
int 33h

cmp ax, 0

jne mousefunciona

mov si, semmouse
call escrever

jmp parar

mousefunciona:

mov si, mouseon
call escrever

mov ax, 1
int 33h

jmp 0x1000:0


parar:

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
   
   
semmouse  db "",10,13
          db "Sistema Operacional Bin S.O",10,13
          db "",10,13
          db "Sistema de Gerenciamento de Hardware do Bin S.O",10,13
          db "",10,13
          db "Copyright (C) 2013 Felipe Miguel Nery Lunkes",10,13
          db "",10,13
          db "",10,13
          db "Desculpe, mas sem mouse nao foi reconhecido, esta indisponivel ou",10,13
          db "danificado e nao pode ser inicializado com seguranca.",10,13
          db "",10,13,0
        
mouseon   db "",10,13
          db "Sistema Operacional Bin S.O",10,13
          db "",10,13
          db "Sistema de Gerenciamento de Hardware do Bin S.O",10,13
          db "",10,13
          db "Copyright (C) 2013 Felipe Miguel Nery Lunkes",10,13
          db "",10,13
          db "",10,13
          db "Mouse inicializado com sucesso.",10,13
          db "",10,13,0        
