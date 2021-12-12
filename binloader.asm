;;*******************************************************************
;;
;;
;;                  BootLoader do Bin S.O
;;
;;  Carrega o Kernel do Bin S.O e a tabela de alocação de arquivos 
;;                         do BinFS
;;
;;*******************************************************************



%define loc 0x1000           ;; Copiar Kernel 
%define tabelabinfs 0x2000   ;; Copiar Tabela de alocação de arquivos do BinFS 
%define drive 0x80           ;; Drive do Sistema
%define binkernel 3          ;; Setor onde se localiza o início do Kernel
%define setordatabela 2      ;; Setor onde se localiza a tabela


[bits 16]
[org 0]

jmp 0x7c0:inicio

inicio:

	mov ax, cs
	mov ds, ax
	mov es, ax

	mov al, 03h
	mov ah, 0
	int 10h	

    mov si, msg
    call escrever
    
    mov ax,0
    int 16h
    
     
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
	
	mov ax, 3000
	mov bx, 0

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
	
	pusha

	in al, 61h
	and al, 0FCh
	out 61h, al

	popa
	
	pop dx
	pop cx
	pop bx
	pop ax
    
	mov ax, loc
	mov es, ax
	mov cl, binkernel 
	mov al, 3

	call carregarsetor

	mov ax, tabelabinfs
	mov es, ax
	mov cl, setordatabela
	mov al, 1 
	call carregarsetor
	

	jmp loc:0000 


pronto:
	jmp $

carregarsetor:
	mov bx, 0
	mov dl, drive 
	mov dh, 0 
	mov ch, 0 
	mov ah, 2
	int 0x13
	jc err
	ret
	
err:
	mov si, erro
	call escrever
	ret
	
escrever:
	mov bp, sp
	
	cont:
	lodsb
	or al, al
	jz pnt
	
	mov ah, 0x0e
	mov bx, 0
	int 10h
	jmp cont
	
pnt:
	mov sp, bp
	ret

	
msg db "[ BinLoader - Gerenciador de Inicializacao do Bin S.O ]",10,13
    db "*******************************************************",10,13
    db "",10,13
    db "Sistema Operacional Bin S.O carregado com sucesso.",10,13
    db "",10,13
    db "Pressione ENTER para continuar...",10,13
    db "",10,13,0
	
	
erro db "Erro carregando. ",10,13,0

kerver db "0.1.1 Apollo",0

times 510 - ($-$$) db 0
dw 0xaa55
