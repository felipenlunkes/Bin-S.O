;;*******************************************************************
;;
;;                 Sistema Operacional Bin S.O
;;
;;
;;                  Felipe Miguel Nery Lunkes
;;
;;
;;
;;
;;
;;
;;*******************************************************************


%define drive 0x80    ;; Deixe o drive em que procurar executáveis

%define ploc 0x9000

[bits 16]

[org 0]

;;*******************************************************************
;;
;;
;;                       Inicio do Bin Kernel
;;
;;
;;
;;*******************************************************************


iniciar:         ;; Ponto inicial do Kernel do Bin S.O


	mov ax, cs
	mov ds, ax
	mov es, ax
	mov ax, 0x7000	
	mov ss, ax	
	mov sp, ss

	cmp byte [primeiro], 0
	jnz pular

	push bemvindo	
	call escrever

	mov byte [primeiro], 1 
	
	

;;*******************************************************************

	
pular:

	mov ax, 0x2000 	
	mov gs, ax
	mov bx, 0
              
              
              
;;*******************************************************************

         
mostrar_prompt:     ;; Exibe o Prompt

    push prompt 	
	call escrever
		
	push buffer
	call ler
		
	call procurar
		
	jmp mostrar_prompt  
		


;;*******************************************************************


ler:	            ;; Obtem informacoes digitadas no teclado


	pusha
	mov bp, sp
	cld
	mov byte  [contletras], 0
	mov di, [bp+18]
	
	continueaprocurar:
		
		
		mov ah, 0
		int 16h
		
		cmp al, 0dh
		jz ir
		
		mov ah, 0x0e
		mov bx, 0
		int 10h
		
		stosb
		inc byte [contletras]
		jmp continueaprocurar
		
			
	ir:
		
		
		push nl
		call escrever
		
		mov sp, bp
		popa
		ret


;;*******************************************************************


procurar:		
	
	
	pusha
	mov bp, sp 

	cmp ax, ax 
	mov di, buffer

	mov bx, 0
	
	cld
	 
	 
checar_cont:
	
	mov al, [gs:bx]
	cmp al, '}'
		
	je completo	

	cmp al, [di]
	je chr
	
	inc bx
	
	jmp checar_cont
		

chr:
	
	push bx
	mov cx, [contletras] 
		
		
checar:
	
	
	mov al, [gs:bx]
	inc bx
		
	scasb
	loope checar
		
	je ok

	mov di, buffer
	pop bx
	inc bx
	jmp checar_cont
		
	
completo:
	
	
	push falha
	call escrever
	jmp fim
		
		
ok:
		
	inc bx
	push  bx
		
	call procurarsetor
	  
	  
	fim:
	
	
	mov sp, bp
	popa 
	ret

  
;;*******************************************************************

  
procurarsetor:   ;; Procura o executavel Bin S.O no disco
	
	
	pusha
	mov bp, sp
	mov bx, [bp+18]
	cld
	mov word [setor], 0
	mov cl, 10
	cont_st:
	mov al, [gs:bx]
	inc bx
	
	cmp al, ','
	jz concluido
	
	cmp al, 48
	jl compativel
	
	cmp al, 58
	jg compativel
	
	sub al, 48
	mov ah, 0 
	mov dx, ax
	mov ax, word [setor]
	mul cl
	add ax, dx
	mov word [setor], ax		
	jmp cont_st
	
	
	concluido:
	
	
	push word [setor]
		
	call carregar 	

		
	jmp ploc:0000 
	
	 
;;*******************************************************************


compativel_fim:

	mov sp, bp
	popa
	ret
	
	
compativel:
	
	
	push falha
	call escrever
	jmp compativel_fim
      
      
;;*******************************************************************

      
carregar:		   ;; Carrega aplicativo caso exista     
	
	
	pusha
	mov bp, sp
	
	mov ah, 0
	mov dl, 0x80
	int 0x13

	mov ax, ploc
	mov es, ax
	mov cl, [bp+18] 
	mov al, 4
	mov bx, 0
	mov dl, drive 
	mov dh, 0 
	mov ch, 0 
	mov ah, 2
	int 0x13
	
	jnc sucesso
	
	  
;;*******************************************************************

	  
erroaocarregar:  ;; Erro ao ler setor de disco formatado com BinFS
	
	
	push erroaocarregaro
	call escrever
	
	jmp 0x1000:0
	

;;*******************************************************************

	
sucesso:         ;; Sucesso no carregamento
	mov sp, bp
	popa
	ret
     
     
;;*******************************************************************
     
		
escrever:	     ;; Rotina para imprimir mensagens do sistema 
	
	
	pusha
	mov bp, sp
	mov si, [bp+18] 
	
	
cont:
	
	
		lodsb
		
		or al, al
		jz pronto
		
		mov ah, 0x0e
		mov bx, 0
		mov bl, 7
		int 10h
		jmp cont
	
pronto:
	
		mov sp, bp
		popa
		ret


;;*******************************************************************


parahexa:        ;; Rotina para converter caracteres em hexadecimal


	pusha
	mov bp, sp
	mov dx, [bp+18]
	
	mov cx, 4
	mov si, hexc
	mov di, hex+2
	
	guardar:
	
	rol dx, 4
	mov bx, 15
	and bx, dx
	mov al, [si+bx]
	stosb
	loop guardar
	push hex
	call escrever
	mov sp, bp
	popa
	ret
         
         
;;*******************************************************************
         
         
binescrever:     ;; Rotina protegida para imprimir caracteres na tela 
  
    lodsb        
 
   or al, al  
   jz .pronto   
 
   mov ah, 0x0E
   int 0x10      
 
   jmp binescrever

 
 .pronto:
   ret
   
   
;;*******************************************************************


emitirsom:       ;; Rotina para emitir sons pela auto-falante interno.

                 ;; Mova para ax o tom a ser emitido pelo sistema.
    
    pusha

	mov cx, ax	 ;; Som a ser emitido		

	mov al, 182  ;; Dado a ser enviado
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
	

;;*******************************************************************
	
	
desligarsom:      ;; Desliga o auto-falante interno

	
	pusha

	in al, 61h
	and al, 0FCh
	out 61h, al

	popa
	
	ret	
	

;;*******************************************************************
 
 
esperartecla:    ;; Aguarda o pressionamento da tecla ENTER


    mov ax, 0
    int 16h
    
    ret
    
    
;;******************************************************************* 

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


;;*******************************************************************


;;*******************************************************************
;;
;;
;;            Sistema Operacional Bin S.O Versao 1.0
;;
;;
;;
;;           Variaveis e constantes internas do Kernel
;;
;;
;;
;;          Copyright (C) 2013 Felipe Miguel Nery Lunkes
;;
;;
;;*******************************************************************


bemvindo  db "",10,13
          db "Iniciando o Bin S.O...",10,13
          db "",10,13
          db "Seja Bem Vindo ao Bin S.O",10,13
          db "",10,13
          db "Copyright (C) 2013 Felipe Miguel Nery Lunkes",10,13
          db "",10,13
          db "",10,13,0 
          
espaco    db "",10,13
          db "",10,13,0  
          
erroaocarregaro  db "",10,13
                 db "Erro ao carregar setor no disco. Impossivel carregar executavel Bin S.O.",10,13,0  
                                
falha     db "",10,13
          db "Arquivo executavel Bin S.O nao encontrado.",10,13,0  
          
FALHA1    db "Divisao por Zero",0 

FALHA2    db "Falha Geral de Protecao",0  

FALHA3    db "O Codigo esta corrompido e nao pode ser executado",0 

SOBRE     db "Sistema Operacional Bin S.O",0   

COPYRIGHT db "Copyright (C) 2013 Felipe Miguel Nery Lunkes",0 

RESERVADO db "Bloco de Memoria Reservado.",0 

FALTA     db "Uma falta grave foi detectada durante a execucao do sistema.",0

buffer times 30 db 0

arr times 10 db 0

primeiravez db 1

nl db 10,13,0 

prompt db 10,13, "#>",0 

contletras dw 0

hex db "0x0000",10,13,0

hexc db "0123456789ABCDEF" 

primeiro db 0  

setor dw 0

VERAPI db '"API para aplicativos do Bin S.O versao 0.1.1',0

BINFSVER db 'Sistema de Arquivos BinFS do Bin S.O versao 0.1.1 suportado.',0

FALHAAPP db 'O aplicativo requisitado foi carregado mas nao pode ser executado pelo sistema.',10,13
         db 'Aplicativo incompativel',10,13,0

ERROFORMATO db 'Formato de aplicativos Bin S.O incompativel.',0

BINFSERRO db 'Erro ao ler setor do BinFS',0

REGISTROSERRO db 'Erro ao ler registros do sistema.',0

KERVER db 'Bin S.O 0.1.1 Apollo',0

VERKER db 'Kernel Bin S.O 0.1.1 Apollo',0

BINVER db 'Sistema Operacional Bin S.O versao 0.1.1 Apollo',0

RC db 'RC1',0