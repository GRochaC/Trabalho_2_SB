section .text
global alloc
extern print_aloc
extern int_to_string

%define tam [ebp+8]
%define b0 [ebp+12]
%define t0 [ebp+16]
%define b1 [ebp+20]
%define t1 [ebp+24]
%define b2 [ebp+28]
%define t2 [ebp+32]
%define b3 [ebp+36]
%define t3 [ebp+40]

alloc:
    enter 0,0

    mov eax, tam
    push eax
    push 1
    mov eax, b0
    push eax
    mov eax, t0
    push eax
    call cabe_no_bloco
    add esp, 16

    cmp eax, 1
    je exit

    mov eax, tam
    push eax
    push 2
    mov eax, b1
    push eax
    mov eax, t1
    push eax
    call cabe_no_bloco
    add esp, 16

    cmp eax, 1
    je exit

    mov eax, tam
    push eax
    push 3
    mov eax, b2
    push eax
    mov eax, t2
    push eax
    call cabe_no_bloco
    add esp, 16

    cmp eax, 1
    je exit

    mov eax, tam
    push eax
    push 4
    mov eax, b3
    push eax
    mov eax, t3
    push eax
    call cabe_no_bloco
    add esp, 16

    cmp eax, 1
    je exit

    ; calcula se o programa pode ser carregado
    mov eax, tam
    mov ebx, t0
    add ebx, t1
    add ebx, t2
    add ebx, t3

    cmp eax, ebx    
    jg impossivel
possivel:
    mov eax, tam
endereco_0:
    sub eax, t0     ;restante - t0
    push eax
    mov eax, b0     
    mov ebx, t0
    add ebx, eax
    ;sub ebx, 1
    push ebx        ;e0
    push eax        ;b0
    push 1          ;bloco
    push 0          ;flag
    call print_aloc
    add esp, 16

endereco_1:
    mov eax, [esp]
    cmp eax, t1
    jle aloc_final_1  
    pop eax
    sub eax, t1     ; restante - t1 
    push eax 
    mov eax, b1    
    mov ebx, t1
    add ebx, eax
    ;sub ebx, 1
    push ebx        ;e1
    push eax        ;b1
    push 2         ;bloco
    push 0          ;flag
    call print_aloc
    add esp, 16


endereco_2:
    mov eax, [esp]
    cmp eax, t2
    jle aloc_final_2
    pop eax
    sub eax, t2    ;restante - t2
    push eax    
    mov eax, b2  
    mov ebx, t2
    add ebx, eax
    ;sub ebx, 1
    push ebx        ;e2
    push eax        ;b2
    push 3         ;bloco
    push 0          ;flag
    call print_aloc
    add esp, 16

endereco_3:
    ;mov eax, b3 
    ;mov ebx, t3
    ;add ebx, eax
    ;;sub ebx, 1
    ;push ebx        ;e3
    ;push eax        ;b3
    ;push 4          ;bloco
    ;push 0          ;flag
    ;call print_aloc
    ;add esp, 16

    push 4
    mov eax, b3
    push eax
    mov eax, t3 
    push eax
    call cabe_no_bloco
    add esp, 16
    jmp exit

impossivel:
    push 1
    call print_aloc
    add esp, 4

exit:
    leave
    ret

cabe_no_bloco:
    ; tam [ebp+20]
    ; bloco [ebp+16]
    ; bi [ebp+12]
    ; ti [ebp+8]

    enter 0,0
    mov eax, [ebp+20]
    mov ebx, [ebp+8]

    cmp eax,ebx
    mov eax, 0          ; return false
    jg return           ; tam > ti -> return
    mov eax, [ebp+20]   
    add eax, [ebp+12]
    ;sub eax, 1
    push eax            ; eax = tam + bi 
    mov ecx, [ebp+12]
    push ecx            ; bi
    mov ecx, [ebp+16]
    push ecx            ; bloco
    push 0              ; flag
    call print_aloc
    add esp, 16

    mov eax, 1           ; return true
return:
    leave
    ret

aloc_final_1:
    push 2
    mov eax, b1
    push eax
    mov eax, t1
    push eax
    call cabe_no_bloco
    add esp, 16
    jmp exit

aloc_final_2:
    push 3
    mov eax, b2
    push eax
    mov eax, t2
    push eax
    call cabe_no_bloco
    add esp, 16
    jmp exit   