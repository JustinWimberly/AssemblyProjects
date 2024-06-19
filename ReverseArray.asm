.386                                    ; Set instruction set architecture to 80386
.model flat, stdcall                    ; Set memory model and calling convention
.stack 4096                             ; Define stack size
ExitProcess PROTO, dwExitCode:DWORD     ; Declare ExitProcess API function

.data                                   ; Data section
decimalArray DWORD 1,2,3,4,5,6,7,8      ; Define an array of DWORDs

.code                                   ; Code section
main PROC                               ; Start of main procedure

 MOV ESI, OFFSET decimalArray          ; Initialize source index to the address of decimalArray
 MOV EDI, OFFSET decimalArray          ; Initialize destination index to the address of decimalArray
 ADD EDI, SIZEOF decimalArray          ; Move destination index to the end of decimalArray
 SUB EDI, TYPE decimalArray            ; Move destination index to the last element of decimalArray 

 mov ecx, LENGTHOF decimalArray        ; Initialize loop counter with the length of decimalArray
L2:                                    ; Start of loop
 MOV EAX, [ESI]                        ; Load value from source index into EAX
 MOV EBX, [EDI]                        ; Load value from destination index into EBX
 XCHG EAX, EBX                         ; Exchange values of EAX and EBX
 MOV [ESI], EAX                        ; Store the value of EAX to source index
 MOV [EDI], EBX                        ; Store the value of EBX to destination index

 ADD ESI, TYPE decimalArray            ; Move source index to the next element
 SUB EDI, TYPE decimalArray            ; Move destination index to the previous element
 DEC ECX                               ; Decrement loop counter

 LOOP L2                               ; Repeat loop until ECX becomes zero


INVOKE ExitProcess, 0                  ; Invoke ExitProcess API function to exit the program
main ENDP                              ; End of main procedure
END main                               ; End of program
