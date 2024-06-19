include Irvine32.inc

.data
prompt1 BYTE "Enter a decimal number with at least 5 decimal places: ", 0
prompt2 BYTE "You selected to set the precision to %d decimal places.", 13, 10, 0
prompt3 BYTE "Precision value must be between 1 and 4.", 13, 10, 0
error1 BYTE "Invalid input. Please enter a valid decimal number.", 13, 10, 0
error2 BYTE "Invalid precision value. Please enter a value between 1 and 4.", 13, 10, 0
originalPrompt BYTE "The original number entered was %.5f.", 13, 10, 0
resultPrompt BYTE "Original Number: %.5f", 13, 10, "Precision - %d: %.5f", 13, 10, 0

precisionValue DWORD ?
originalNumber REAL4 ?
precision REAL4 ?

.code
main PROC
    ; Prompt the user to enter a decimal number
    mov edx, OFFSET prompt1
    call WriteString

    ; Read the user input
    call ReadFloat
    mov originalNumber, eax

    ; Display the original number
    mov edx, OFFSET originalPrompt
    call WriteString
    fld originalNumber
    call WriteFloat
    call Crlf

    ; Prompt the user to enter precision value
    mov edx, OFFSET prompt2
    call WriteString

    ; Read the precision value
    call ReadDec
    mov precisionValue, eax

    ; Check if precision value is between 1 and 4
    cmp precisionValue, 1
    jl errorPrecision
    cmp precisionValue, 4
    jg errorPrecision

    ; Display the selected precision value
    mov edx, precisionValue
    call WriteDec
    call Crlf

    ; Calculate precision
    mov eax, 10
    mov ecx, precisionValue
    xor edx, edx
    mov ebx, 1
    @@powLoop:
        mul eax   ; multiply eax by 10
        inc edx   ; increment power counter
        cmp edx, ecx
        jl @@powLoop
    mov dword ptr [precision], eax

    ; Round the original number to the specified precision
    fld originalNumber
    fmul precision
    fstp originalNumber
    call WriteFloat
    call Crlf

    jmp exitProgram

errorPrecision:
    mov edx, OFFSET error2
    call WriteString
    jmp exitProgram

exitProgram:
    call WaitMsg
    exit
main ENDP

END main
include Irvine32.inc

.data
prompt1 BYTE "Enter a decimal number with at least 5 decimal places: ", 0
prompt2 BYTE "You selected to set the precision to %d decimal places.", 13, 10, 0
prompt3 BYTE "Precision value must be between 1 and 4.", 13, 10, 0
error1 BYTE "Invalid input. Please enter a valid decimal number.", 13, 10, 0
error2 BYTE "Invalid precision value. Please enter a value between 1 and 4.", 13, 10, 0
originalPrompt BYTE "The original number entered was %.5f.", 13, 10, 0
resultPrompt BYTE "Original Number: %.5f", 13, 10, "Precision - %d: %.5f", 13, 10, 0

precisionValue DWORD ?
originalNumber REAL4 ?
precision REAL4 ?

.code
main PROC
    ; Prompt the user to enter a decimal number
    mov edx, OFFSET prompt1
    call WriteString

    ; Read the user input
    call ReadFloat
    mov originalNumber, eax

    ; Display the original number
    mov edx, OFFSET originalPrompt
    call WriteString
    fld originalNumber
    call WriteFloat
    call Crlf

    ; Prompt the user to enter precision value
    mov edx, OFFSET prompt2
    call WriteString

    ; Read the precision value
    call ReadDec
    mov precisionValue, eax

    ; Check if precision value is between 1 and 4
    cmp precisionValue, 1
    jl errorPrecision
    cmp precisionValue, 4
    jg errorPrecision

    ; Display the selected precision value
    mov edx, precisionValue
    call WriteDec
    call Crlf

    ; Calculate precision
    mov eax, 10
    mov ecx, precisionValue
    xor edx, edx
    mov ebx, 1
    @@powLoop:
        mul eax   ; multiply eax by 10
        inc edx   ; increment power counter
        cmp edx, ecx
        jl @@powLoop
    mov dword ptr [precision], eax

    ; Round the original number to the specified precision
    fld originalNumber
    fmul precision
    fstp originalNumber
    call WriteFloat
    call Crlf

    jmp exitProgram

errorPrecision:
    mov edx, OFFSET error2
    call WriteString
    jmp exitProgram

exitProgram:
    call WaitMsg
    exit
main ENDP

END main
