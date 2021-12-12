[bits 16]   ;; Define que o aplicativo deve ser 16 Bits
[org 0]     ;; Organiza o Offset para 0


inicio:     ;; Aqui se inicia o aplicativo

mov ax, cs   ;; Ajusta a área de memória a ser executado o aplicativo
mov ds, ax
mov es, ax


mov si, msg
call escrever

jmp fim


escrever:            ;; Driver para imprimir caracteres na tela 


lodsb

or al, al
jz .pronto

mov ah, 0x0E
int 0x10    ;; Interrupção do BIOS para vídeo

jmp escrever


.pronto:
ret


;;******************************************************************


fim:         ;; Fim do aplicativo


jmp 0x1000:0 ;; Fim do aplicativo (Obrigatório)


;; Variaveis e constantes deverão ser declaradas abaixo.


SIS db 'Bin S.O', 0
msg db '',10,13
    db 'Sistema Operacional Bin S.O',10,13
    db '',10,13
    db 'Versao: 0.0.1 Apollo',10,13
    db 'Autor: Felipe Miguel Nery Lunkes',10,13
    db 'Memoria RAM disponivel: 630 Kb',10,13
    db 'Sistema Operacional de: 16 Bits',10,13
    db '',10,13
    db 'Sistema de Arquivos deste Disco: BinFS versao 1.0',10,13
    db '',10,13
    db 'Copyright (C) 2013 Felipe Miguel Nery Lunkes',10,13
    db '',10,13,0


;; Fim
