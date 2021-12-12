[bits 16]

[org 0]

push ax
mov ax,cs
mov ds,ax
mov es,ax
pop ax




    mov si, processador_msg
    call escrever
	
    mov eax, 0
	cpuid
	
	mov [processador], ebx
	mov [processador + 4], edx
	mov [processador + 8], ecx
	
	mov si, processador
    call escrever 
	
    mov si, espaco_msg
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
     
    processador times 13 db 0   ;; Tamanho do registro: 13 bits 
    
    
    processador_msg db "",10,13
                    db "Sistema Operacional Bin S.O",10,13
                    db "",10,13
                    db "Sistema de Gerenciamento de Hardware do Bin S.O",10,13
                    db "",10,13
                    db "",10,13
                    db "Processador atualmente instalado em seu computador:",10,13
                    db "",10,13
                    db "",10,13,0
                    
    espaco_msg      db "",10,13
                    db "",10,13,0                
    
