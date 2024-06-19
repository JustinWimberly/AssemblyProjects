.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD
.data

.code
main PROC
    ; Assign integer values to the registers
    mov eax, 3      ; A = 3
    mov ebx, 8      ; B = 8
    mov ecx, 1      ; C = 1
    mov edx, 8      ; D = 8

    ; Perform calculations: A = (A+B) - (C+D)
    add eax, ebx    ; A = A + B
    add ecx, edx    ; C = C + D
    sub eax, ecx    ; A = (A + B) - (C + D)

    ; Exit the program
    invoke ExitProcess, 0

main ENDP
END main
