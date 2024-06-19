.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD

.data
the_array dd 1, 2, 3, 4, 5
array_size equ LENGTHOF the_array
sum dd 0

.code
main PROC
	mov esi, 0                ; Initialize index to 0
	mov eax, 0                ; Initialize sum to 0

sum_loop:
	cmp esi, array_size      ; Compare index with array size
	jge loop_ends            ; Jump if index >= array size
	add eax, the_array[esi*4]; Add current element to sum
	add esi, 1               ; Increment index
	jmp sum_loop             ; Jump back to sum_loop

loop_ends:
    ; Exit the program
    invoke ExitProcess, 0

main ENDP
END main
