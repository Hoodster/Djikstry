.data
;parametry funkcji
results QWORD 0
operationType QWORD 0

;sta≥e
PLUS QWORD 0
MINUS QWORD 1
MULT QWORD 2
DIVID QWORD 3
.code

djikstryAssembly proc
; ..........................................
; przekazujemy:
; [rcx] wskaünik na wskaünik tablicy [results]x[results] (macierz)
; [rdx] wskaønik na tablicÍ wyjúciowπ Node[results]
; [r8] rozmiar macierzy kwadratowej oraz tablicy wyjúciowej
; [r9] poczπtkowy wierzcho≥ek
xor rax, rax ;zerowanie rax
xor rbx, rbx ;zerowanie rbx

mov rax, r9 ;przypisanie operationType
mov operationType, rax

movups XMM0, [rcx]
movups XMM1, [rdx]

mov rax, PLUS
cmp operationType, rax
je plusOperation
mov rax, MINUS
cmp operationType, rax
je minusOperation
mov rax, MULT
cmp operationType, rax
je multOperation
mov rax, DIVID
cmp operationType, rax
je divOperation

plusOperation:
addps XMM0, XMM1
jmp finish

minusOperation:
subps XMM0, XMM1
jmp finish

multOperation:
mulps XMM0, XMM1
jmp finish

divOperation:
divps XMM0, XMM1
jmp finish

finish:
movups [r8], XMM0
ret
djikstryAssembly endp
end