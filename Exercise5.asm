INCLUDE Irvine32.inc

.data
    max DWORD 1000
    primes DWORD 1000 DUP(1)

.code
main PROC
mov edx,1
   mov eax,7FFFh
   cmp eax,8000h
   jb  L1
   mov edx,0
L1:

call writestring

    exit
main ENDP
END main
