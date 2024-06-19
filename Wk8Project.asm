INCLUDE C:\Irvine\Irvine32.inc
INCLUDELIB C:\Irvine\Irvine32.lib

.DATA
    precision1Multiplier DWORD 1      ; Multiplier for precision 1
    precision2Multiplier DWORD 100    ; Multiplier for precision 2
    precision3Multiplier DWORD 1000   ; Multiplier for precision 3
    precision4Multiplier DWORD 10000  ; Multiplier for precision 4
    precisionDivisor     DWORD 10     ; Divisor for precision 2, 3, and 4
    prompt              BYTE "Enter a decimal number with at least 5 decimal places: ", 0Ah, 0Dh, 0
    precisionPrompt     BYTE "Enter a precision (1-4): ", 0Ah, 0Dh, 0
    multipliedFloat    BYTE "Multiplied by 100 the floating point value is: ", 0Ah, 0Dh, 0
    integerConvert     BYTE "Converted to an Integer the multiplied floating point value is: ", 0Ah, 0Dh, 0
    precVal            BYTE "The final floating point value with is: ", 0Ah, 0Dh, 0
    origFloat          REAL4 ?
    tempInt            DWORD ?
    finalFloat         REAL4 ?
    multiplierDivisor  DWORD ?
    precision           DWORD ?

.CODE
main PROC
    FINIT                           ; Initialize the Floating Point Unit

    ; Prompt the user to enter a decimal value with at least 5 decimal places
    MOV EDX, OFFSET prompt         
    Call WriteString               
    Call ReadFloat                 

    ; Prompt the user to enter the precision value
    MOV EDX, OFFSET precisionPrompt     
    Call WriteString
    Call ReadInt                       
    MOV precision, EAX

    ; Determine the multiplier/divisor based on precision entered by the user
    CMP precision, 1
    JE precision1
    CMP precision, 2
    JE precision2
    CMP precision, 3
    JE precision3
    CMP precision, 4
    JE precision4
    JMP exitProgram

precision1:
    MOV EAX, precision1Multiplier
    JMP setMultiplierDivisor

precision2:
    MOV EAX, precision2Multiplier
    JMP setMultiplierDivisor

precision3:
    MOV EAX, precision3Multiplier
    JMP setMultiplierDivisor

precision4:
    MOV EAX, precision4Multiplier
    JMP setMultiplierDivisor

setMultiplierDivisor:
    MOV multiplierDivisor, EAX
    JMP calculateAndDisplay

calculateAndDisplay:
    ; Multiply the entered floating-point value by the determined multiplier
    FLD origFloat
    FILD DWORD PTR multiplierDivisor
    FMUL

    ; Display the multiplied value
    MOV EDX, OFFSET multipliedFloat
    CALL WriteString
    CALL WriteFloat
    CALL Crlf
    CALL Crlf

    ; Convert multiplied value to an integer and pop from the stack
    FISTP tempInt

    ; Display the integer value
    MOV EDX, OFFSET integerConvert
    CALL WriteString
    MOV EAX, tempInt
    CALL WriteInt
    CALL Crlf
    CALL Crlf

    ; Convert back to float and divide by the multiplier
    FILD tempInt
    FLD1
    FDIV DWORD PTR multiplierDivisor

    ; Display the final float value with the specified precision
    MOV EDX, OFFSET precVal
    CALL WriteString
    CALL WriteFloat
    CALL Crlf
    CALL Crlf

    JMP exitProgram

exitProgram:
    INVOKE ExitProcess, 0
    
main ENDP
END main
