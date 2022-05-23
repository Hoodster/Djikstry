.data
;parametry funkcji
array QWORD 0
arraySize QWORD 0
result QWORD 0

;wewn�trzne zmienne
counter QWORD 1
TWO QWORD 2

.code

exercOne proc
; ..........................................
; przekazujemy:
; [rcx] wska�nik na wska�nik tablicy [arrayLen]x[arrayLen] (macierz)
; [rdx] wska�nik na tablic� wyj�ciow� Node[arrayLen]
; [r8] rozmiar macierzy kwadratowej oraz tablicy wyj�ciowej
; [r9] pocz�tkowy wierzcho�ek
xor rax, rax ;zerowanie rax
; ...........................................
mov rax, rcx
call assign
mov result, 0

;iteracja 1
call addOperation
add rcx, 12
call assign

;iteracja 2
call addOperation
mov rax, rcx
add rax, 12
mov rcx, rax
call assign

;iteracja 3
call addOperation
mov rax, rcx
add rax, 12
mov rcx, rax
call assign

;iteracja 3
call addOperation
mov rax, rcx
add rax, 12
mov rcx, rax
call assign

;iteracja 3
call addOperation
mov rax, rcx
add rax, 12
mov rcx, rax
call assign

;iteracja 4
call addOperation
mov rax, rcx
add rax, 12
mov rcx, rax
add rax, 4
mov rbx, rax
mov rax, 0
add rax, [rcx]
add rax, [rbx]
add rax, [result]
mov [result], rax
jmp endProgram

assign:
mov rax, rcx
add rax, 4
mov rbx, rax
add rax, 4
mov rdx, rax
ret

addOperation:
mov rax, 0
add eax, [rcx]
add eax, [rbx]
add eax, [rdx]
add rax, [result]
mov [result], rax
ret

endProgram:
mov rax, [result]
ret
exercOne endp

exercTwo proc
xor rax, rax ;zerowanie rax
xor rbx, rbx ;zerowanie rbx

;iteration 1
movups XMM0, [rcx]
movups XMM1, [rdx]

addps XMM0, XMM1
movups XMM1, [r9]
divps XMM0, XMM1
movups [r8], XMM0

;iteration 2
movups XMM0, [rcx + 16]
movups XMM1, [rdx + 16]
mov rax, r8
add rax, 16
mov r8, rax

addps XMM0, XMM1
movups XMM1, [r9]
divps XMM0, XMM1
movups [r8], XMM0

;iteration 3
movups XMM0, [rcx + 32]
movups XMM1, [rdx + 32]
mov rax, r8
add rax, 16
mov r8, rax

addps XMM0, XMM1
movups XMM1, [r9]
divps XMM0, XMM1
movups [r8], XMM0

;iteration 4
movups XMM0, [rcx + 48]
movups XMM1, [rdx + 48]
mov rax, r8
add rax, 16
mov r8, rax

addps XMM0, XMM1
movups XMM1, [r9]
divps XMM0, XMM1
movups [r8], XMM0

ret
exercTwo endp
end