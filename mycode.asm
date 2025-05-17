.model small
.stack 100h
.data
    prompt db "Enter a hex byte (e.g. FF): $"
    even_set db 13, 10, "All even-positioned bits are SET.$"
    not_set db 13, 10, "All even-positioned bits are NOT set.$"
    invalid_msg db 13, 10, "Invalid hex input!$"

.code
main:
    mov ax, @data
    mov ds, ax

    ; Display prompt
    lea dx, prompt
    mov ah, 09h
    int 21h

    ; --- Read First Hex Digit ---
    call read_char
    call hex_to_bin
    jc invalid_input       ; if invalid, jump
    shl al, 4              ; shift to high nibble
    mov bl, al

    ; --- Read Second Hex Digit ---
    call read_char
    call hex_to_bin
    jc invalid_input
    or bl, al              ; combine nibbles into full byte

    ; --- Check even bits ---
    mov al, bl
    and al, 55h
    cmp al, 55h
    jne show_not_set

    ; All even bits are set
    lea dx, even_set
    mov ah, 09h
    int 21h
    jmp done

show_not_set:
    lea dx, not_set
    mov ah, 09h
    int 21h
    jmp done

invalid_input:
    lea dx, invalid_msg
    mov ah, 09h
    int 21h

done:
    mov ah, 4Ch
    int 21h

; -----------------------------
; Read one character ? AL
read_char proc
    mov ah, 01h
    int 21h
    ; echo character (optional)
    ; mov dl, al
    ; mov ah, 02h
    ; int 21h
    ret
read_char endp

; -----------------------------
; ASCII in AL ? binary (0-15)
; Returns result in AL
; Sets CF=1 if invalid
hex_to_bin proc
    cmp al, '0'
    jl invalid
    cmp al, '9'
    jle digit
    cmp al, 'A'
    jge upper
    cmp al, 'a'
    jge lower
    jmp invalid

digit:
    sub al, '0'
    clc
    ret

upper:
    cmp al, 'F'
    jg invalid
    sub al, 'A'
    add al, 10
    clc
    ret

lower:
    cmp al, 'f'
    jg invalid
    sub al, 'a'
    add al, 10
    clc
    ret

invalid:
    stc
    ret
hex_to_bin endp

end main
