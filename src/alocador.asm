section .data
msg1 db 'Foi possivel alocar o programa no bloco: ', 0dH, 0ah
msg2 db 'entre os endenrecos: ', 0dH, 0ah
msg3 db 'Nao foi possivel alocar o programa.', 0dH, 0ah

section .bss
; sz_file, begin, sz


section .text

global _start

_start:
    %define sz_file dword [EBP + 4]
    %define begin0  dword [EBP + 8]
    %define sz0     dword [EBP + 12]
    %define begin1  dword [EBP + 16]
    %define sz1     dword [EBP + 20]
    %define begin2  dword [EBP + 24]
    %define sz2     dword [EBP + 28]
    %define begin3  dword [EBP + 32]
    %define sz3     dword [EBP + 36]

    ;cabe_algum_bloco --> se cabe retorna qual bloco, caso contrario retorna -1

    ;printa_bloco --> printa bloco e endereco incial e final de alocacao no bloco

    ;distribui_entre_blocos --> faz a alocacao parcial entre os blocos

    mov EAX, sz_file    ; EAX = sz_file
    mov EBX, sz0        ; EBC = sz0
    sub EAX, EBX        ; EAX = sz_file - sz0
    cmp EAX, 0          ; se <= 0 coube
    ;falta empilhar os argumentos do print
    push     
    jle _print 
    pop


    mov EAX, sz_file    ; EAX = sz_file
    mov EBX, sz1        ; EBC = sz1
    sub EAX, EBX        ; EAX = sz_file - sz1
    cmp EAX, 0          ; se <= 0 coube
    ;falta empilhar os     pop EBX             ; EBX = begin_n 
    pop EDX             ; EDX = sz_nargumentos do print
    jle _print
     
    mov EAX, sz_file    ; EAX = sz_file
    mov EBX, sz2       ; EBC = sz2
    sub EAX, EBX        ; EAX = sz_file - sz2
    cmp EAX, 0          ; se <= 0 coube
    ;falta empilhar os argumentos do print
    jle _print 

    mov EAX, sz_file    ; EAX = sz_file
    mov EBX, sz3        ; EBC = sz3
    sub EAX, EBX        ; EAX = sz_file - sz3
    cmp EAX, 0          ; se <= 0 coube
    ;falta empilhar os argumentos do print
    jle _print 



    ;nao coube em nenhum endereco
    mov EAX, sz_file    ; EAX = sz_file
    mov EBX, begin0     ; EBX = begin0
    mov ECX, sz0        ; ECX = sz0 

    sub EAX, ECX        ; EAX = sz_file - sz0
    push EAX            ; guarda o valor restante a ser alocado
    cmp EAX, 0          ; se <= 0 -> alocou tudo ---- se > 0 -> restante a ser alocado
    ;empilha os argumentos do print
    call print

    pop EAX             ; recupera o valor restante a ser alocado

    mov EBX, begin1     ; EBX = begin1
    mov ECX, sz1        ; ECX = sz1 
    sub EAX, ECX        ; EAX = restante - sz1
    push EAX            ; guarda o valor restante a ser alocado
    cmp EAX, 0          ; se <= 0 -> alocou tudo ---- se > 0 -> restante a ser alocado
    ;empilha os argumentos do print
    call print

    pop EAX             ; recupera o valor restante a ser alocado

    mov EBX, begin2     ; EBX = begin2
    mov ECX, sz2        ; ECX = sz2
    sub EAX, ECX        ; EAX = restante - sz2
    push EAX            ; guarda o valor restante a ser alocado
    cmp EAX, 0          ; se <= 0 -> alocou tudo ---- se > 0 -> restante a ser alocado
    ;empilha os argumentos do print
    call print

    pop EAX             ; recupera o valor restante a ser alocado
    
    mov EBX, begin3     ; EBX = begin3
    mov ECX, sz3        ; ECX = sz3 
    sub EAX, ECX        ; EAX = restante - sz3
    push EAX            ; guarda o valor restante a ser alocado
    cmp EAX, 0          ; se <= 0 -> alocou tudo ---- se > 0 -> restante a ser alocado
    ;empilha os argumentos do print
    call print

    pop EAX             ; recupera o valor restante a ser alocado
    cmp EAX, 0          ; programa grande demais
    ;empilha os argumentos do print
    call print

    ;EXIT

    _print:
    call print
    pop
    ;EXIT

    print:

    