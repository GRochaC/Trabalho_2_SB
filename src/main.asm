section .text
global _start
extern alloc
_start:
    ;e3
    push 0
    push 0

    ;e2
    push 0
    push 0

    ;e1 
    push 0
    push 0

    ;e0
    push 100
    push 50

    ; tam
    push 100

    call alloc

    add esp, 40 ;desempilha

    mov eax, 1
    mov ebx, 0
    int 80h
