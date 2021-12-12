[bits 16]
[org 0]


inicio:

	mov ax,cs
	mov ds,ax
	mov es,ax


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
    db "Sistema Operacional Bin S.O", 10,13
    db "", 10,13
    db "echo        - Exibe na tela o que foi digitado pelo usuario.",10,13
    db "ajuda       - Exibe este topico de ajuda.",10,13
    db "clear       - Limpa a tela.",10,13
    db "desligar    - Finaliza o Bin S.O e prepara para desligar o computador.",10,13
    db "reiniciar   - Finaliza o Bin S.O e reinicia o computador.",10,13
    db "processador - Exibe o processador instalado em seu computador.",10,13
    db "mem         - Exibe a quantidade de memoria convencional disponivel.",10,13
    db "ver         - Exibe a versao atual do Bin S.O",10,13
    db "",10,13,0
	
binver db "0.1.1 Apollo",0	
