section .text
    global int_to_string

%define n [EBP+8]

int_to_string:
    enter 0,0

    mov eax, n
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
    je exit
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

exit:
    leave
    ret