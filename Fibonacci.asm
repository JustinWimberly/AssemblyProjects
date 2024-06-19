.386                                   ; Set instruction set architecture to 80386
.model flat, stdcall                   ; Set memory model and calling convention
.stack 4096                            ; Define stack size
ExitProcess PROTO, dwExitCode:DWORD    ; Declare ExitProcess API function

.data                                  ; Data section
count DWORD 5                          ; Define variable 'count' with value 5
array DWORD 7 DUP (1,1,?,?,?,?,?)      ; Define an array 'array' with 7 elements initialized to 1, followed by uninitialized elements

.code                                  ; Code section
main PROC                              ; Start of main procedure

  mov ecx, count                       ; Initialize loop counter with the value of 'count'
  mov ESI, OFFSET array                ; Initialize source index to the address of 'array'

  ; Advance the source index to the 3rd element of the array (since we are adding two elements in each iteration)
  Add ESI, TYPE array
  Add ESI, TYPE array

  L1:                                  ; Start of loop 'L1'
    MOV EAX,[ESI-4]                    ; Load the value of the previous element into EAX
    MOV EBX,[ESI-8]                    ; Load the value of the element before the previous element into EBX
    ADD EAX,EBX                        ; Add the values of the two elements
    MOV [ESI],EAX                      ; Store the result in the current element

    ADD ESI, TYPE array                ; Move the source index to the next element
    Loop L1                            ; Repeat loop 'L1' until ECX becomes zero

  INVOKE ExitProcess,0                 ; Invoke ExitProcess API function to exit the program

main ENDP                             ; End of main procedure
END main                              ; End of program
