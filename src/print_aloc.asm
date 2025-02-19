section .data
msg_aloc db 'Foi possivel alocar o programa no bloco '
sz_aloc equ $-msg_aloc

msg_aloc_imposs db 'Nao foi possivel alocar o programa totalmente.', 0dh, 0ah
sz_aloc_imposs equ $-msg_aloc_imposs

msg_endereco db ' entre os enderecos: '
sz_endereco equ $-msg_endereco

msg_e db ' e '
sz_e equ $-msg_e

lf db '', 0dh, 0ah

section .bss

section .text
global print_aloc

%define flag [EBP+8]
%define bloco [EBP+12]
%define begin [EBP+16]
%define end [EBP+20]

print_aloc: 
    
    enter 0,0
    mov eax, flag
    cmp eax, 1
    je impossivel 

possivel:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_aloc
    mov edx, sz_aloc
    int 80h

    ; int_to_string bloco
    mov eax, bloco
    push eax
    call int_to_string
    add esp, 4              ; pop na pilha

    ; print msg endereco
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_endereco
    mov edx, sz_endereco
    int 80h

    ; int_to_string begin
    mov eax, begin
    push eax
    call int_to_string
    add esp, 4              ; pop na pilha

    ; print 'e'
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_e
    mov edx, sz_e
    int 80h

    ; int_to_string end
    mov eax, end
    push eax
    call int_to_string
    add esp, 4

    ; print ln
    mov eax, 4
    mov ebx, 1
    mov ecx, lf
    mov edx, 2
    int 80h

    jmp exit

impossivel:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_aloc_imposs
    mov edx, sz_aloc_imposs
    int 80h

exit:
    leave
    ret

int_to_string:
    enter 0,0

    mov eax, [ebp+8]
    mov ebx, 10
    cmp eax, 0
    je zero     ; caso do n = 0
loop:
    mov edx, 0
    div ebx     ; eax = quociente, edx = resto
    push edx
    cmp eax, 0
    jg loop
    jmp transform

zero:
    push 0
transform:
    cmp esp, ebp
    je return
    pop eax
    add eax, 30h
    push eax

    mov eax, 4
    mov ebx, 1
    mov ecx, esp
    mov edx, 1
    int 80h
    add esp, 4  ; pop na pilha
    jmp transform

return:
    leave
    ret