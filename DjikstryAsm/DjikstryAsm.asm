.data
;parametry funkcji
nodes QWORD 0
matrix QWORD 0
arrayLen QWORD 0
startPosition QWORD 0

;wewn�trzne zmienne
nodeSize QWORD 96 ; 3 * 32 (3 razy int)
cNodePos QWORD 0
minTemp QWORD 0
matrixTemp QWORD 0
minDist QWORD 0
condition22Temp QWORD 0
u QWORD 0

;sta�e
MAX_INT QWORD 2147483647
MINUS_ONE QWORD -1
.code

djikstryAssembly proc
; ..........................................
; przekazujemy:
; [rcx] wska�nik na wska�nik tablicy [arrayLen]x[arrayLen] (macierz)
; [rdx] wska�nik na tablic� wyj�ciow� Node[arrayLen]
; [r8] rozmiar macierzy kwadratowej oraz tablicy wyj�ciowej
; [r9] pocz�tkowy wierzcho�ek
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
mul rcx ;przemno�enie przez rcx
add rax, nodes
mov rbx, [rax] ;pobranie elementu tablicy 

cmp rcx, startPosition ;por�wnanie startPosition i rcx
je  ifSame1 ;je�li takie same skocz do ifSame
jne ifNotSame1 ;je�li r�ne skocz do ifNotSame
ifSame1:
mov rbx, 0 ;ustaw pierwsz� warto�� w strukturze na 0
jmp endFirstLoop ;skocz do endFirstLoop

ifNotSame1:
mov rbx, MAX_INT ;ustaw pierwsz� warto�� w strukturze jako MAX_INT (ekwiwalent niesko�czono�ci)
jmp endFirstLoop ;skocz do endFirstLoop

endFirstLoop:
mov rbx, [rbx + 32] ;przej�cie do nast�pnego adresu
mov rbx, 0 ;przypisanie warto�ci 0 jako false
mov rbx, [rbx + 32] ;przej�cie do nast�pnego adresu
mov rbx, MINUS_ONE ;przypisanie warto�ci -1
add nodes, rax
mov [nodes], rbx ;przeka� przypisany wska�nik na element tablicy
inc rcx ;i++
cmp rcx,arrayLen    ;sprawd� czy mniejsze od arrayLen
jb firstLoop    ;nast�pna iteracja je�li prawda

mov rax, startPosition ;przypisanie u warto�ci ze startPosition
mov u, rax
call whileL ;przejd� do p�tli while
jmp endProg ;przejd� do ko�ca programu

whileL:
mov rcx, u ;przekazanie u do rcx
cmp MINUS_ONE, rcx ;sprawdzenie czy warto�� r�wna -1
jne executeWhile ;je�li nie to przejd� to ko�ca p�tli
ret ;zwrot warto�ci

findMinimal:
mov rax, MINUS_ONE ;przeniesienie warto�ci z MIUNS_ONE do zmiennej minTemp
mov minTemp, rax
mov rax, MAX_INT ;przeniesienie MAX_INT do minDist
mov minDist, rax
;p�tla
mov rcx, 0
thirdLoop:
mov rax, nodeSize ;przeniesienie rozmiaru struktury do akumulatora
mul rcx ;przemno�enie przez rcx
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
mov rax, [rbx-32] ;przekazanie pierwszego pola struktury (odj�cie z powodu condition32)
mov minDist, rax
endThirdLoop:
inc rcx ;i++
cmp rcx, arrayLen ;i < arrayLen
jb thirdLoop ;kolejna iteracja p�tli
mov rax, minTemp ;przenie� minTemp do rax
ret ;zwrot warto�ci

;p�tla
executeWhile:
mov rax, nodeSize ;przekazanie wielko�ci struktury do akumulatora
mul u ;pomno�enie przez u
add rax, nodes
mov rbx, [rax] ;pobranie elementu z tablicy o odpowiednim indeksie
mov rbx, [rbx + 32] ;przej�cie do drugiego pola struktury
mov rbx, 1 ;przypisanie 1 polu
;p�tla
mov rcx, 0 ;i=0
secondLoop:
mov rax, nodeSize ;przeniesienie rozmiaru struktury do akumulatora
mul rcx ;przemno�enie przez rcx
mov rdx, rcx ;przeniesienie rcx do rdx
mov rax, nodeSize ;przeniesienie rozmiaru struktury do akumulatora
mul u ;przemno�enie przez u
add rax, rdx;dodanie rdx
add rax, nodes
mov rbx, [rax] ;pobranie matrix[i,u]
mov matrixTemp, rbx ;przekazanie warto�ci do zmiennej pomocniczej

condition21: ;matrix[u,i] > 0
cmp matrixTemp, 0
jnbe endSecondLoop
condition22: ;(tab[u].distance + matrix[u,i]) > tab[i].distance
mov rax, nodeSize ;przeniesienie rozmiaru struktury do akumulatora
mul u ;przemn� przez u
add rax, nodes
mov rbx, [rax] ;pobierz tab[u]
mov rax, rbx ;przenie� warto�� do akumulatora
add matrixTemp, rax ;dodaj matrixTemp
mov condition22Temp, rax ;przenie� sum� do zmiennej

mov rax, nodeSize ;pobierz wielko�� struktury do rax
mul rcx ;pomn� przez licznik p�tli
add rax, nodes
mov rbx, [rax] ;przenie� do rbx wskazany element tablicy
cmp matrixTemp, rbx ;matrixTemp >= tab[i].distance
jnbe endSecondLoop
mov rbx, matrixTemp ;przenie� warto�� do pola struktury
mov rbx, [rbx+64] ;przejd� do 3. pola struktury
mov rbx, u ;przypisz polu warto�� u

endSecondLoop:
inc rcx ;i++
cmp rcx, arrayLen ;i < arrayLen
jb thirdLoop ;kolejna iteracja p�tli
call findMinimal ; przejd� do findMinimal
mov u, rax ;przeniesienie warto�ci z rax do u
jmp whileL ;nast�pna iteracja while
endProg:
mov rdx, [nodes]
ret
djikstryAssembly endp
end