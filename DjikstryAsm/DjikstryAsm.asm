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
call assign
mov rax, 0

;iteracja 1
call addOperation
mov rcx, [rcx + 40]
call assign

;iteracja 2
call addOperation
mov rcx, [rcx + 40]
call assign

;iteracja 3
call addOperation
mov rcx, [rcx + 40]
call assign

;iteracja 4
call addOperation
mov rcx, [rcx + 40]
call assign

jmp endProgram

assign:
mov rbx, [rcx + 8]
mov rdx, [rcx + 16]
mov r8, [rcx + 24]
mov r9, [rcx + 32]
ret

addOperation:
add rax, rcx
add rax, rbx
add rax, r8
add rax, r9
call assign
ret

endProgram:
ret
exercOne endp

exercTwo proc
xor rax, rax ;zerowanie rax
xor rbx, rbx ;zerowanie rbx

movups XMM0, [rcx]
movups XMM1, [rdx]

mov rax, TWO
addps XMM0, XMM1
divps XMM0, XMM1

movups [r8], XMM0
ret
exercTwo endp
end