.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitcode: DWORD
MessageBoxA PROTO, hWnd:DWORD, lpText:DWORD, lpCaption:DWORD, uType:DWORD

.data
source BYTE "I love you Kochanie", 0                ;source string
target BYTE SIZEOF source DUP(0)                    ;target string
caption BYTE "Target String", 0                     ;message box caption / Window Title

.code
main PROC

mov esi, OFFSET source                              ;point esi to source
mov edi, OFFSET target                              ;point edi to target
mov ecx, SIZEOF source - 1                          ;set loop counter
add esi, ecx                                        ;point esi to end of source
dec esi                                             ;skip null byte

l1:
    mov al, [esi]                                   ;get a character from source
    mov [edi],al                                    ;store character in target
    dec esi                                         ;move to previous character in source
    inc edi                                         ;move to next character in target
    loop l1                                         ;repeat unitl ex is zero

mov al, 0                                           ;null terminator for target string
mov [edi], al

; Display target string in a message box
INVOKE MessageBoxA, 0, OFFSET target, OFFSET caption, 0

; Exit the program
INVOKE ExitProcess, 0
main ENDP
END main


