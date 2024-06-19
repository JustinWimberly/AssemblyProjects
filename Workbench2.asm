; Justin Wimberly
; CSC 2025
; April 10, 2024

INCLUDE Irvine32.inc

.code 
 mov  al, [esi]  ; load value from esi into AL
    shr  al, 1      ; shift right by 1 bit (rotate equivalent)
    jc   skip       ; jump if carry flag is set
    inc  al         ; increment AL without changing the carry flag

skip:
    mov [result], al  ; store the rotated value in result
    dec  esi          ; decrement ESi
    jnz  loop        ; jump back to top of loop if ESI not zero