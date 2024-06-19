INCLUDE Irvine32.inc

.data
key BYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
plaintext1 BYTE "This is a test message.",0
plaintext2 BYTE "Another test message here.",0
encrypted1 BYTE SIZEOF plaintext1 DUP(0)
encrypted2 BYTE SIZEOF plaintext2 DUP(0)

.code
Encrypt PROC
    ; Parameters: 
    ;   esi = address of plaintext message
    ;   edi = address of encrypted message
    ;   edx = address of key array
    ;   ecx = length of plaintext message

    push ebp
    mov ebp, esp

    mov esi, [ebp + 8]  ; address of plaintext
    mov edi, [ebp + 12] ; address of encrypted message
    mov edx, [ebp + 16] ; address of key array
    mov ecx, [ebp + 20] ; length of plaintext message

    xor ebx, ebx ; ebx will hold the index of the key array

    mov eax, ecx ; eax will hold the loop counter

    @@encrypt_loop:
        mov al, [esi] ; load plaintext byte
        mov bl, [edx] ; load rotation value from key array

        add esi, 1 ; move to the next plaintext byte
        add edx, 1 ; move to the next rotation value in the key array

        ; Rotate byte to the right if positive, to the left if negative
        test bl, bl
        jns @@rotate_right
        neg bl

    @@rotate_left:
        rol al, cl ; rotate left by the rotation value
        jmp @@store_byte

    @@rotate_right:
        ror al, cl ; rotate right by the rotation value

    @@store_byte:
        mov [edi], al ; store encrypted byte
        add edi, 1 ; move to the next byte in the encrypted message

        inc ebx ; move to the next key array index
        cmp ebx, 10 ; check if we've reached the end of the key array
        jl @@next_byte ; if not, continue to the next byte

        mov ebx, 0 ; reset key array index to 0
        mov edx, [ebp + 16] ; reset key array pointer to the beginning

    @@next_byte:
        dec eax ; decrement loop counter
        jnz @@encrypt_loop ; if not zero, continue looping

    pop ebp
    ret 16 ; clean up stack and return
Encrypt ENDP

main PROC
    ; Call Encrypt procedure with plaintext1 and key array
    mov esi, OFFSET plaintext1
    mov edi, OFFSET encrypted1
    mov edx, OFFSET key
    mov ecx, LENGTHOF plaintext1 - 1 ; excluding null terminator
    call Encrypt

    ; Display encrypted message 1
    mov esi, OFFSET encrypted1
    call WriteString
    call Crlf

    ; Call Encrypt procedure with plaintext2 and key array
    mov esi, OFFSET plaintext2
    mov edi, OFFSET encrypted2
    mov edx, OFFSET key
    mov ecx, LENGTHOF plaintext2 - 1 ; excluding null terminator
    call Encrypt

    ; Display encrypted message 2
    mov esi, OFFSET encrypted2
    call WriteString
    call Crlf

    exit
main ENDP

END main
