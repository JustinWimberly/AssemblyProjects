INCLUDE Irvine32.inc

.data
    val1 DWORD ?
    val2 DWORD 10
    val3 DWORD 20
    val4 DWORD 7  ; For example purposes, but make sure val4 > 3 to avoid division by zero

.code
main PROC
    mov eax, val2      ; Load val2 into EAX
    mul val3           ; Multiply val2 by val3 (result in EDX:EAX)
    sub eax, 3         ; Subtract 3 from the result in EAX
    mov ebx, eax       ; Move the result into EBX for division
    mov eax, val4      ; Load val4 into EAX
    sub eax, 3         ; Subtract 3 from val4
    cmp eax, 3         ; Compare eax with 3
    jle exit_program   ; Jump to exit_program if val4 - 3 is less than or equal to 3 (to avoid division by zero)
    div ebx            ; Divide val4 - 3 by the result stored in EBX
    mov val1, eax      ; Store the result in val1
    mov eax, val1      ; Move the result into EAX for printing
    call WriteDec      ; Write the value of EAX as a decimal
    call Crlf          ; Move to the next line
exit_program:
    call ExitProcess, 0  ; Exit the program

main ENDP
END main
