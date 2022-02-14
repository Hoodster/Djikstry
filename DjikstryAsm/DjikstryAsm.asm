.data
;parametry funkcji
nodes QWORD 0
matrix QWORD 0
arrayLen QWORD 0
startPosition QWORD 0

;wewnêtrzne zmienne
nodeSize QWORD 96 ; 3 * 32 (3 razy int)
cNodePos QWORD 0
minTemp QWORD 0
matrixTemp QWORD 0
minDist QWORD 0
condition22Temp QWORD 0
u QWORD 0

;sta³e
MAX_INT QWORD 2147483647
MINUS_ONE QWORD -1
.code

djikstryAssembly proc
; ..........................................
; przekazujemy:
; [rcx] wskaŸnik na wskaŸnik tablicy [arrayLen]x[arrayLen] (macierz)
; [rdx] wska¿nik na tablicê wyjœciow¹ Node[arrayLen]
; [r8] rozmiar macierzy kwadratowej oraz tablicy wyjœciowej
; [r9] pocz¹tkowy wierzcho³ek
xor rax, rax ;zerowanie rax
; ...........................................
mov	rbx, [rcx] ;przypisanie matrix
mov	matrix, rbx
mov rbx, [rdx] ;przypisanie nodes
mov nodes, rbx
mov rax, [r8] ;przypisanie arrayLen
mov arrayLen, rax
mov rax, [r9] ;przypisanie startPosition
mov startPosition, rax

mov rcx,0 ;i=0
firstLoop: 
mov rax, nodeSize ;przeniesienie rozmiaru struktury do akumulatora
mul rcx ;przemno¿enie przez rcx
add rax, nodes
mov rbx, [rax] ;pobranie elementu tablicy 

cmp rcx, startPosition ;porównanie startPosition i rcx
je  ifSame1 ;jeœli takie same skocz do ifSame
jne ifNotSame1 ;jeœli ró¿ne skocz do ifNotSame
ifSame1:
mov rbx, 0 ;ustaw pierwsz¹ wartoœæ w strukturze na 0
jmp endFirstLoop ;skocz do endFirstLoop

ifNotSame1:
mov rbx, MAX_INT ;ustaw pierwsz¹ wartoœæ w strukturze jako MAX_INT (ekwiwalent nieskoñczonoœci)
jmp endFirstLoop ;skocz do endFirstLoop

endFirstLoop:
mov rbx, [rbx + 32] ;przejœcie do nastêpnego adresu
mov rbx, 0 ;przypisanie wartoœci 0 jako false
mov rbx, [rbx + 32] ;przejœcie do nastêpnego adresu
mov rbx, MINUS_ONE ;przypisanie wartoœci -1
add nodes, rax
mov [nodes], rbx ;przeka¿ przypisany wska¿nik na element tablicy
inc rcx ;i++
cmp rcx,arrayLen    ;sprawdŸ czy mniejsze od arrayLen
jb firstLoop    ;nastêpna iteracja jeœli prawda

mov rax, startPosition ;przypisanie u wartoœci ze startPosition
mov u, rax
call whileL ;przejd¿ do pêtli while
jmp endProg ;przejdŸ do koñca programu

whileL:
mov rcx, u ;przekazanie u do rcx
cmp MINUS_ONE, rcx ;sprawdzenie czy wartoœæ równa -1
jne executeWhile ;jeœli nie to przejdŸ to koñca pêtli
ret ;zwrot wartoœci

findMinimal:
mov rax, MINUS_ONE ;przeniesienie wartoœci z MIUNS_ONE do zmiennej minTemp
mov minTemp, rax
mov rax, MAX_INT ;przeniesienie MAX_INT do minDist
mov minDist, rax
;pêtla
mov rcx, 0
thirdLoop:
mov rax, nodeSize ;przeniesienie rozmiaru struktury do akumulatora
mul rcx ;przemno¿enie przez rcx
add rax, nodes
mov rbx, [rax] ;pobranie elementu tablicy 
condition31:
cmp rbx, minDist ;if distance < minDist
jb condition32
jmp endThirdLoop
condition32:
mov rbx, [rbx+32] ;if isPristine == 0 => isPristine == false
cmp rbx, 0
jne endThirdLoop
mov minTemp, rcx ;przekazanie licznika do minTemp
mov rax, [rbx-32] ;przekazanie pierwszego pola struktury (odjêcie z powodu condition32)
mov minDist, rax
endThirdLoop:
inc rcx ;i++
cmp rcx, arrayLen ;i < arrayLen
jb thirdLoop ;kolejna iteracja pêtli
mov rax, minTemp ;przenieœ minTemp do rax
ret ;zwrot wartoœci

;pêtla
executeWhile:
mov rax, nodeSize ;przekazanie wielkoœci struktury do akumulatora
mul u ;pomno¿enie przez u
add rax, nodes
mov rbx, [rax] ;pobranie elementu z tablicy o odpowiednim indeksie
mov rbx, [rbx + 32] ;przejœcie do drugiego pola struktury
mov rbx, 1 ;przypisanie 1 polu
;pêtla
mov rcx, 0 ;i=0
secondLoop:
mov rax, nodeSize ;przeniesienie rozmiaru struktury do akumulatora
mul rcx ;przemno¿enie przez rcx
mov rdx, rcx ;przeniesienie rcx do rdx
mov rax, nodeSize ;przeniesienie rozmiaru struktury do akumulatora
mul u ;przemno¿enie przez u
add rax, rdx;dodanie rdx
add rax, nodes
mov rbx, [rax] ;pobranie matrix[i,u]
mov matrixTemp, rbx ;przekazanie wartoœci do zmiennej pomocniczej

condition21: ;matrix[u,i] > 0
cmp matrixTemp, 0
jnbe endSecondLoop
condition22: ;(tab[u].distance + matrix[u,i]) > tab[i].distance
mov rax, nodeSize ;przeniesienie rozmiaru struktury do akumulatora
mul u ;przemnó¿ przez u
add rax, nodes
mov rbx, [rax] ;pobierz tab[u]
mov rax, rbx ;przenieœ wartoœæ do akumulatora
add matrixTemp, rax ;dodaj matrixTemp
mov condition22Temp, rax ;przenieœ sumê do zmiennej

mov rax, nodeSize ;pobierz wielkoœæ struktury do rax
mul rcx ;pomnó¿ przez licznik pêtli
add rax, nodes
mov rbx, [rax] ;przenieœ do rbx wskazany element tablicy
cmp matrixTemp, rbx ;matrixTemp >= tab[i].distance
jnbe endSecondLoop
mov rbx, matrixTemp ;przenieœ wartoœæ do pola struktury
mov rbx, [rbx+64] ;przejdŸ do 3. pola struktury
mov rbx, u ;przypisz polu wartoœæ u

endSecondLoop:
inc rcx ;i++
cmp rcx, arrayLen ;i < arrayLen
jb thirdLoop ;kolejna iteracja pêtli
call findMinimal ; przejdŸ do findMinimal
mov u, rax ;przeniesienie wartoœci z rax do u
jmp whileL ;nastêpna iteracja while
endProg:
mov rdx, [nodes]
ret
djikstryAssembly endp
end