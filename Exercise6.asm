; Justin Wimberly
; CSC 2025
; 04/27/2024
; Homework Assignment 11 PE6

INCLUDE Irvine32.inc

.data
    test_x_values DWORD 10, 20, 30, 36, 48    ; Test values for x
    test_y_values DWORD 5, 10, 15, 18, 24     ; Test values for y

.code
                                            ; Function to calculate the greatest common divisor (GCD) of two integers
GCD PROC
    PUSH EBP
    MOV EBP, ESP

                                            ; Retrieve parameters x and y from the stack
    MOV EAX, [EBP + 8]                      ; x
    MOV EBX, [EBP + 12]                     ; y

                                            ; Absolute value of x
    CMP EAX, 0
    JGE skipNegX
    NEG EAX
skipNegX:

                                            ; Absolute value of y
    CMP EBX, 0
    JGE skipNegY
    NEG EBX
skipNegY:

gcdLoop:
                                            ; Calculate remainder (n = x % y)
    MOV EDX, 0                              ; Clear EDX for division
    DIV EBX                                 ; Divide EAX (x) by EBX (y), result in EAX (quotient), remainder in EDX

                                            ; Update x with y
    MOV EAX, EBX

                                            ; Update y with n
    MOV EBX, EDX

                                            ; Check if y > 0
    CMP EBX, 0
    JG gcdLoop                              ; Jump back to gcdLoop if y > 0

                                            ; GCD is stored in x, return it
    MOV EAX, EBX                            ; Move result to EAX

                                            ; Function epilogue
    POP EBP
    RET 8                                   ; Clean up stack and return
GCD ENDP

main PROC
    MOV ECX, LENGTHOF test_x_values         ; Number of test cases

                                            ; Loop through test cases
    MOV ESI, OFFSET test_x_values           ; Pointer to test_x_values
    MOV EDI, OFFSET test_y_values           ; Pointer to test_y_values
testLoop:
                                            ; Call GCD function for current test case
    PUSH DWORD PTR [ESI]                    ; Push x
    PUSH DWORD PTR [EDI]                    ; Push y
    CALL GCD                                ; Call GCD function
    ADD ESP, 8                              ; Clean up stack

                                            ; Display result
    MOV EAX, [ESI]                          ; Load x
    CALL WriteDec                           ; Display x
    MOV EDX, OFFSET msg1                    ; Display message
    CALL WriteString
    MOV EAX, [EDI]                          ; Load y
    CALL WriteDec                           ; Display y
    MOV EDX, OFFSET msg2                    ; Display message
    CALL WriteString
    CALL WriteDec                           ; Display GCD
    CALL Crlf                               ; Move to next line

    ADD ESI, 4                              ; Move to next x value
    ADD EDI, 4                              ; Move to next y value
    LOOP testLoop                           ; Loop until all test cases are processed

    CALL WaitMsg                            ; Wait for user input before closing the console
    CALL ExitProcess

main ENDP

msg1 BYTE " and ", 0                        ; Message for " and "
msg2 BYTE ": GCD = ", 0                     ; Message for  ": GCD = "

END main
