.data
;parametry funkcji
nodes QWORD 0
matrix QWORD 0
arrayLen QWORD 0
startPosition QWORD 0

;wewnêtrzne zmienne
nodeSize QWORD 12 ; 3 * 4 (3 razy int)
minTemp QWORD 0
distanceTemp QWORD 0
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
xor rbx, rbx ;zerowanie rbx
; ...........................................
mov	rbx, rcx ;przypisanie matrix
mov	matrix, rbx
mov rbx, rdx ;przypisanie nodes
mov nodes, rbx
mov rax, r8 ;przypisanie arrayLen
mov arrayLen, rax
mov rax, r9 ;przypisanie startPosition
mov startPosition, rax

mov rcx,0 ;i=0
firstLoop: 
mov rax, nodes
mov rax, nodeSize ;przeniesienie rozmiaru struktury do akumulatora
mul rcx ;przemno¿enie przez rcx
add rax, nodes ;dodajemy adres nodes
mov rbx, rax ;pobranie elementu tablicy 

cmp rcx, startPosition ;porównanie startPosition i rcx
je  ifSame1 ;jeœli takie same skocz do ifSame
jne ifNotSame1 ;jeœli ró¿ne skocz do ifNotSame
ifSame1:
mov rdx, rax ;rax do wartoœci tymczasowej
mov rax, 0 ;przekazanie rax wartoœci 0
mov [rbx], rax ;ustaw pierwsz¹ wartoœæ w strukturze na 0
jmp endFirstLoop ;skocz do endFirstLoop

ifNotSame1:
mov rdx, rax ;rax do wartoœci tymczasowej
mov rax, MAX_INT ;przekazanie rax MAX_INT
mov [rbx], rax ;ustaw pierwsz¹ wartoœæ w strukturze jako MAX_INT (ekwiwalent nieskoñczonoœci)
jmp endFirstLoop ;skocz do endFirstLoop

endFirstLoop:
mov rax, rdx ;przywrócenie adresu do rax
add rax, 4 ;nastêpny int
mov rbx, rax ;przeniesienie adresu do rbx
mov rax, 0 ;ustawienie rax na 0
mov [rbx], rax ;przypisanie wartoœci 0 jako false
mov rax, rbx ;przeniesienie rbx do rax
add rax, 4 ;podniesienie adresu o kolejny int
mov rbx, rax ;przeniesienie adresu do rbx
mov rdx, rax ;przeniesienie adresu do wartoœci tymczasowej
mov rax, MINUS_ONE ;ustawienie rax na -1
mov [rbx], rax ;przypisanie wartoœci -1
inc rcx ;i++
mov rax, arrayLen
cmp rcx, rax    ;sprawdŸ czy mniejsze od arrayLen
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

;100% works

;pêtla
mov rcx, 0
thirdLoop:
mov rax, nodeSize ;przeniesienie rozmiaru struktury do akumulatora
mul rcx ;przemno¿enie przez rcx
add rax, nodes
mov rbx, rax ;pobranie elementu tablicy 
mov eax, [rbx]

condition31:
cmp rax, minDist ;if distance < minDist
jb condition32
jmp endThirdLoop
condition32:

mov rax, rbx
add rax, 4
mov rbx, rax ;if isPristine == 0 => isPristine == false
mov eax, [rbx]
cmp rax, 0
jne endThirdLoop
mov minTemp, rcx ;przekazanie licznika do minTemp
mov rax, rbx
sub rax, 4
mov rbx, rax ;przekazanie pierwszego pola struktury (odjêcie z powodu condition32)
mov eax, [rbx]
mov [minDist], rax
endThirdLoop:
inc rcx ;i++
cmp rcx, arrayLen ;i < arrayLen
jb thirdLoop ;kolejna iteracja pêtli
mov rax, minTemp ;przenieœ minTemp do rax
ret ;zwrot wartoœci

;100% works

;pêtla
executeWhile:
mov rax, nodeSize ;przekazanie wielkoœci struktury do akumulatora
mul u ;pomno¿enie przez u
add rax, nodes
add rax, 4
mov rbx, rax ;pobranie elementu z tablicy o odpowiednim indeksie
mov rax, 1
mov [rbx], eax ;przypisanie 1 polu
;pêtla
mov rcx, 0 ;i=0
secondLoop:
mov rax, 4 ;przeniesienie rozmiaru int do akumulatora
mul rcx ;przemno¿enie przez rcx
mov r9, rax ;przeniesienie rax do rdx
mov rdx, r9
mov rax, 4 ;przeniesienie rozmiaru int do akumulatora
mul u ;przemno¿enie przez u

matrixTempVal:
add rax, r9;dodanie r9 ---> macierz[u,i]
add rax, matrix
mov rbx, rax ;pobranie matrix[u,i]
xor rax, rax
mov eax, [rbx] ;???????
mov [matrixTemp], rax ;przekazanie wartoœci do zmiennej pomocniczej
mov rax, [matrixTemp]

condition22Value:
mov rax, nodeSize
mul u
add rax, nodes 
mov rbx, rax ;pobranie adresu tab[u]
mov eax, [rbx] ;pobranie wartoœci tab[u]
mov [distanceTemp], rax
add rax, matrixTemp
mov [condition22Temp], rax
mov rax, [condition22Temp]


condition21: ;matrix[u,i] <= 0
mov rax, [matrixTemp]
cmp rax, 0
jbe endSecondLoop


condition22: ;(tab[u].distance + matrix[u,i]) > tab[i].distance
xor rax, rax
mov rax, [condition22Temp]
mov r8, rax ;przenieœ do rbx wskazany element tablicy

getTabI:
mov rax, nodeSize ;przekazanie wielkoœci struktury do akumulatora
mul rcx ;pomno¿enie przez i
add rax, nodes
mov rbx, rax ;pobranie elementu z tablicy o odpowiednim indeksie
mov eax, [rbx]

cmp r8, rax ;condition22Temp >= tab[i].distance
jae endSecondLoop

condition2Body:
mov rax, nodeSize ;przekazanie wielkoœci struktury do akumulatora
mul rcx ;pomno¿enie przez i
add rax, nodes
mov rbx, rax ;pobranie elementu z tablicy o odpowiednim indeksie
mov rax, [condition22Temp]
mov [rbx], rax ;przenieœ wartoœæ do 1. pola struktury
mov rax, rbx
add rax, 4
mov rbx, rax ;przejdŸ do 3. pola struktury
mov rax, [u]
mov [rbx], rax ;przypisz polu wartoœæ u

endSecondLoop:
inc rcx ;i++
cmp rcx, arrayLen ;i < arrayLen
jb secondLoop ;kolejna iteracja pêtli
call findMinimal ; przejdŸ do findMinimal
mov u, rax ;przeniesienie wartoœci z rax do u
jmp whileL ;nastêpna iteracja while
endProg:
mov rdx, [nodes]
ret
djikstryAssembly endp
end