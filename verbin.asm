 [bits 16]   ;; Define que o aplicativo deve ser 16 Bits  
 [org 0]     ;; Organiza o Offset para 0 ( Obrigatório! Nao altere esta diretiva. )  
    
    
 jmp inicio  
    
 %include "lib/video.s"   
 %include 'lib/teclado.s'  
    
    
 ;;****************************************************************  
    
    
 inicio:     ;; Processao principal do aplicativo ( Obrigatório )  
    
 mov ax,cs   ;; Ajusta a área de memória a ser executado o aplicativo  
 mov ds,ax  
 mov es,ax  
    
    mov ax, Titulo
	mov bx, Rodape
	mov cx, 00100000b
	call caixadetexto
	
    mov ax, .comandos			
	mov bx, .ajuda1
	mov cx, .ajuda2
	call mostrardialogo
	
	jc near fim
	
	cmp ax, 1			
	je near oi
	
	cmp ax, 2
	je near fim

.comandos		db 'Sobre o Bin S.O,Sair', 0

	.ajuda1		db 'Selecione a opcao desejada', 0
	.ajuda2		db 'ou pressione ESC para sair...', 0


 ;; Seu código aqui  
    
    
 jmp fim      ;; Pula para o fim do aplicativo ( Obrigatório )  
   
    
 ;;******************************************************************  
    
    oi:
	
    mov ax, sobre			
	mov bx, ajuda3
	mov cx, ajuda4
	call mostrardialogo
	
	jc near fim
	
	cmp ax, 1				
	je near fim
	
	cmp ax, 2
	je near fim
	
	cmp ax, 3
	je near fim
	
	cmp ax, 4
	je near fim
	
	cmp ax, 5
	je near fim
	
	cmp ax, 6
	je near fim
	
	cmp ax, 7
	je near fim
	
	cmp ax, 8
	je near fim
		
    sobre db 'Bin S.O Apollo,Versao 0.1.1,16 Bits,BinFS versao 1.0, ,(C) 2013 Felipe Miguel Nery Lunkes, , Todos os direitos reservados.',0
	ajuda3 db 'A versao do Bin S.O instalada',0
	ajuda4 db 'em seu computador e a:',0
;;****************************************************************  
    
   
 fim:         ;; Fim do aplicativo  
   
 call clrscr   
    
 jmp 0x1000:0 ;; Fim do aplicativo (Obrigatório)  
    
    
 ;; Variaveis e constantes deverao ser declaradas abaixo.  
    
    
 SIS db 'Bin S.O', 0  
 VERSAO db 'Versao deste aplicativo: 0.1.1',0  
 LICENCA db 'Licenca deste aplicativo: Bin S.O',0  
 AUTOR db 'Autor: Felipe Miguel Nery Lunkes.',0  
 Titulo db 'Sobre o Sistema Operacional instalado em seu computador',0
 Rodape db 'Exibe a versao do Bin S.O instalada em seu PC', 0
    
	