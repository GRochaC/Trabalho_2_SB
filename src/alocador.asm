section .data
msg0 db 'Foi possivel alocar parte do programa no bloco: ', 0dh
sz_msg0 EQU $-msg0
msg1 db 'Foi possivel alocar totalmente o programa no bloco: '
sz_msg1 EQU $-msg1

msg2 db 'entre os enderecos: '
sz_msg2 EQU $-msg2

msg3 db 'Nao foi possivel alocar o programa totalmente.', 0dh, 0ah
sz_msg3 EQU $-msg3

section .bss

section .text
global alloc

alloc:
    %define sz3     dword [EBP + 40]
    %define begin3  dword [EBP + 36]
    %define sz2     dword [EBP + 32]
    %define begin2  dword [EBP + 28]
    %define sz1     dword [EBP + 24]
    %define begin1  dword [EBP + 20]
    %define sz0     dword [EBP + 16]
    %define begin0  dword [EBP + 12]
    %define sz_file dword [EBP + 8]
    %define return_adress dword [EBP + 4]    

    enter 0,0           ; empilhando o velho EBP

    mov EAX, sz_file    ; EAX = sz_file
    mov EBX, sz0        ; EBC = sz0

    cmp EBX, 0          ; pula se acabaram as chunks
    jl  alocacao_parcial

    sub EAX, EBX        ; EAX = sz_file - sz0
    cmp EAX, 0          ; se <= 0 coube
    jg aloca_tudo_1
    ; preparar para printar
    push '1 '
    push begin0       ; valor do endereco de inicio
    mov EAX, begin0
    add EAX, sz_file 
    sub EAX, 1          ; programa alocado nos enderecos [begin0, begin0 + sz_file - 1]
    push EAX            ; empilha o endereco final 
    jle possivel_alocar 
    add ESP, 10         ; desempilhar os argumentos caso o jmp nao ocorra
    jmp return


aloca_tudo_1:    
    mov EAX, sz_file    ; EAX = sz_file
    mov EBX, sz1        ; EBC = sz1

    cmp EBX, 0          ; pula se acabaram as chunks
    jl  alocacao_parcial

    sub EAX, EBX        ; EAX = sz_file - sz1
    cmp EAX, 0          ; se <= 0 coube
    jg aloca_tudo_3
    ; preparar para printar
    push '2 '
    push begin1      ; valor do endereco de inicio
    mov EAX, begin2
    add EAX, sz_file 
    sub EAX, 1          ; programa alocado nos enderecos [begin1, begin1 + sz_file - 1]
    push EAX            ; empilha o endereco final 
    jle possivel_alocar 
    add ESP, 10         ; desempilhar os argumentos caso o jmp nao ocorra
    jmp return
 
 aloca_tudo_3:
    mov EAX, sz_file    ; EAX = sz_file
    mov EBX, sz2        ; EBC = sz2

    cmp EBX, 0          ; pula se acabaram as chunks
    jl  alocacao_parcial

    sub EAX, EBX        ; EAX = sz_file - sz2
    cmp EAX, 0          ; se <= 0 coube
    jg aloca_tudo_4

    ;preparar  para printar
    push '3 '
    push begin2       ; valor do endereco de inicio
    mov EAX, begin2
    add EAX, sz_file 
    sub EAX, 1          ; programa alocado nos enderecos [begin2, begin2 + sz_file - 1]
    push EAX            ; empilha o endereco final 
    jle possivel_alocar 
    add ESP, 10          ; desempilhar os argumentos caso o jmp nao ocorra
    jmp return


aloca_tudo_4:
    mov EAX, sz_file    ; EAX = sz_file
    mov EBX, sz3        ; EBC = sz3

    cmp EBX, 0          ; pula se acabaram as chunks
    jl  alocacao_parcial

    sub EAX, EBX        ; EAX = sz_file - sz3
    cmp EAX, 0          ; se <= 0 coube
    jg alocacao_parcial
    ; preparar para printar
    push '4 '
    push begin3       ; valor do endereco de inicio
    mov EAX, begin3
    add EAX, sz_file 
    sub EAX, 1          ; programa alocado nos enderecos [begin0, begin0 + sz_file - 1]
    push EAX            ; empilha o endereco final 
    jle possivel_alocar 
    add ESP, 10          ; desempilhar os argumentos caso o jmp nao ocorra
    jmp return



    ;nao coube em nenhum endereco
alocacao_parcial:
    mov EAX, sz_file    ; EAX = sz_file
    mov EBX, begin0     ; EBX = begin0

    cmp EBX, 0          ; pula se acabaram as chunks
    jl  impossivel_alocar

    mov ECX, sz0        ; ECX = sz0 

    sub EAX, ECX        ; EAX = sz_file - sz0
    push EAX            ; guarda o valor restante a ser alocado
    cmp EAX, 0          ; se <= 0 -> alocou tudo ---- se > 0 -> restante a ser alocado
    push '1 '
    push begin0
    jle calcula_endereco_final_0        
    ; endereco final begin0 + sz0 - 1
    mov EDX, sz0
    add EDX, begin0
    sub EDX, 1
    jmp print1
calcula_endereco_final_0:
    ;endereco fina = begin0 +(rest + sz0) - 1
    mov EDX, sz0
    add EDX, EAX
    add EDX, begin0
    sub EDX, 1 
    push EDX
    push msg0
    push sz_msg0
    push msg2
    push sz_msg2
    
print0:
    call print
    add ESP, 22


    
    pop EAX             ; recupera o valor restante a ser alocado
    mov EBX, begin1     ; EBX = begin1

    cmp EBX, 0          ; pula se acabaram as chunks
    jl  impossivel_alocar

    mov ECX, sz1        ; ECX = sz1 
    sub EAX, ECX        ; EAX = restante - sz1
    push EAX            ; guarda o valor restante a ser alocado
    cmp EAX, 0          ; se <= 0 -> alocou tudo ---- se > 0 -> restante a ser alocado
    push '2 '
    push begin1
    jle calcula_endereco_final1         
    ; endereco final begin0 + sz0 - 1
    mov EDX, sz1
    add EDX, begin1
    sub EDX, 1
    jmp print1
calcula_endereco_final1:
    ;endereco fina = begin0 +(rest + sz0) - 1
    mov EDX, sz1
    add EDX, EAX
    add EDX, begin1
    sub EDX, 1 
    push EDX
    push msg0
    push sz_msg0
    push msg2
    push sz_msg2
    
print1:
    call print
    add ESP, 22




    pop EAX             ; recupera o valor restante a ser alocado
    mov EBX, begin2     ; EBX = begin2

    cmp EBX, 0          ; pula se acabaram as chunks
    jl  impossivel_alocar
    
    mov ECX, sz2        ; ECX = sz2
    sub EAX, ECX        ; EAX = restante - sz2
    push EAX            ; guarda o valor restante a ser alocado
    cmp EAX, 0          ; se <= 0 -> alocou tudo ---- se > 0 -> restante a ser alocado
    push '3 '
    push begin2
    jle calcula_endereco_final_2         
    ; endereco final begin2 + sz2 - 1
    mov EDX, sz2
    add EDX, begin2
    sub EDX, 1
    jmp print2
calcula_endereco_final_2:
    ;endereco fina = begin2 +(rest + sz2) - 1
    mov EDX, sz2
    add EDX, EAX
    add EDX, begin2
    sub EDX, 1 
    push EDX
    push msg0
    push sz_msg0
    push msg2
    push sz_msg2
    
print2:
    call print
    add ESP, 22
    

    
    pop EAX             ; recupera o valor restante a ser alocado
    mov EBX, begin3     ; EBX = begin3

    cmp EBX, 0          ; pula se acabaram as chunks
    jl  impossivel_alocar

    mov ECX, sz3        ; ECX = sz3 
    sub EAX, ECX        ; EAX = restante - sz3
    push EAX            ; guarda o valor restante a ser alocado
    cmp EAX, 0          ; se <= 0 -> alocou tudo ---- se > 0 -> restante a ser alocado
    push '4 '
    push begin3
    jle calcula_endereco_final_3        
    ; endereco final begin3 + sz3 - 1
    mov EDX, sz3
    add EDX, begin3
    sub EDX, 1
    jmp print3
calcula_endereco_final_3:
    ;endereco fina = begin3 +(rest + sz3) - 1
    mov EDX, sz3
    add EDX, EAX
    add EDX, begin3
    sub EDX, 1 
    push EDX
    push msg0
    push sz_msg0
    push msg2
    push sz_msg2
    
print3:
    call print
    add ESP, 22
    pop EAX             ; recupera o valor restante a ser alocado
    cmp EAX, 0          ; programa grande demais
    ;empilha os argumentos do print
    call print
    jmp return

impossivel_alocar:
    push msg3
    push sz_msg3
    call print_impossivel
    add ESP, 8
    jmp return

possivel_alocar:
    push msg1           ; ponteiro pra mensagem 1
    push sz_msg1
    push msg2           ; ponteiro pra mensagem 2
    push sz_msg2
    call print
    add ESP, 26         ; desempilha os argumentos
    jmp return

print_impossivel:
    enter 0,0
    
    mov EAX, 4
    mov EBX, 1
    mov ECX, [EBP + 12]  
    mov EDX, [EBP + 8]
    int 80h
    
    leave
    ret

print:
    enter 0,0
    ;[EBP + 32] n-esimo bloco '1 '
    ;[EBP + 30] endereco incial
    ;[EBP + 24] endereco final
    ;[EBP + 20] msg1
    ;[EBP + 16] sz_msg1
    ;[EBP + 12] msg2
    ;[EBP + 8] sz_msg2
    ;[EBP + 4] return addres
    ;[EBP] old EBP
    
    

    ;printa msg1
    mov EAX, 4
    mov EBX, 1
    mov ECX, [EBP + 20]       
    mov EDX, [EBP + 16]
    int 80h

    ;printar o bloco
    mov EAX, 4
    mov EBX, 1
    mov ECX, EBP 
    add ECX, 32
    mov EDX, 1
    int 80h

    ;printar '\n'
    push 0ah ; [ESP] '\n'
    mov EAX, 4
    mov EBX, 1
    mov ECX, ESP
    mov EDX, 1
    int 80h
    add ESP, 1
    
    ;printar msg2 "entre os enderecos"
    mov EAX, 4
    mov EBX, 1
    mov ECX, [EBP + 12]       
    mov EDX, [EBP + 8]
    int 80h

    ;printar endereco inicial

    call int_to_string

    ;printar endereco final

    call int_to_string

    ;printar '\n'
    push 0ah ; [ESP] '\n'
    mov EAX, 4
    mov EBX, 1
    mov ECX, ESP
    mov EDX, 1
    int 80h
    add ESP, 1

    mov ESP, EBP
    pop EBP
    ret

return:
    leave
    ret

int_to_string:
    enter 12, 0    
    pusha               
    ; Variaveis locais
    ; [EBP - 10] buffer 
    ; [EBP - 11] newline 
    ; [EBP - 12] padding

    ; Inicializa newline character
    mov byte [EBP - 11], 10 

    ; Inicializa o buffer com null terminator
    mov byte [EBP - 1], 0    

    lea EDI, [EBP - 10]
    ; conversao de int pra string
convert_loop:
    dec EDI                  
    xor EDX, EDX            
    mov ECX, 10              
    div ECX                  
    add DL, '0'              
    mov [EDI], DL           
    test EAX, EAX            
    jnz convert_loop         

    ; Print the string
    mov EAX, 4              
    mov EBX, 1               
    mov ECX, EDI             ; Aponta para o inicio da string
    lea EDX, [EBP - 1]       ; Tamanho da string
    sub EDX, EDI             ; EDX = final do buffer - inicio da string
    int 0x80                 

    ; Print newline
    mov EAX, 4
    mov EBX, 1               
    lea ECX, [EBP - 11]      
    mov EDX, 1               
    int 0x80                

    popa                    
    leave                    
    ret                     
    

