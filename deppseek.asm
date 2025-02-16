int_to_string:
    enter 12, 0          ; Allocate 12 bytes on the stack (10 for buffer, 1 for newline, 1 for padding)
    pusha                ; Save all general-purpose registers

    ; Local variables:
    ; [EBP - 10] = buffer (10 bytes)
    ; [EBP - 11] = newline (1 byte)
    ; [EBP - 12] = padding (1 byte, unused)

    ; Initialize newline character
    mov byte [EBP - 11], 10  ; Store newline character (ASCII 10) at [EBP - 11]

    ; Initialize buffer with null terminator
    mov byte [EBP - 1], 0    ; Null-terminate the buffer at [EBP - 1]

    lea EDI, [EBP - 10]      ; Point EDI to the start of the buffer (10 bytes before EBP)

convert_loop:
    dec EDI                  ; Move to the previous byte in the buffer
    xor EDX, EDX             ; Clear EDX for division
    mov ECX, 10              ; Divisor (10 for decimal)
    div ECX                  ; Divide EAX by 10, result in EAX, remainder in EDX
    add DL, '0'              ; Convert remainder to ASCII
    mov [EDI], DL            ; Store the ASCII character in the buffer
    test EAX, EAX            ; Check if EAX is zero
    jnz convert_loop         ; If not zero, continue the loop

    ; Print the string
    mov EAX, 4               ; sys_write system call
    mov EBX, 1               ; File descriptor (stdout)
    mov ECX, EDI             ; Pointer to the start of the string
    lea EDX, [EBP - 1]       ; Calculate the length of the string
    sub EDX, EDI             ; EDX = end of buffer - start of string
    int 0x80                 ; Call kernel

    ; Print newline
    mov EAX, 4               ; sys_write system call
    mov EBX, 1               ; File descriptor (stdout)
    lea ECX, [EBP - 11]      ; Pointer to the newline character
    mov EDX, 1               ; Length of the newline character
    int 0x80                 ; Call kernel

    popa                     ; Restore all general-purpose registers
    leave                    ; Destroy stack frame
    ret                      ; Return from the function