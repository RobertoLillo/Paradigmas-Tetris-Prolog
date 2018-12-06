/*
 * tetrisProlog.pl
 * Laboratorio 2 Paradigmas de programación (2 - 2018).
 * Fecha de entrega: 7 de Diciembre.
 *
 * Requerimientos Mínimos:
 * - Hecho en SwiProlog                 -> Listo
 * - Documentacion (Dom, Pre, Met, ...) -> Listo
 * - Orden y claridad                   -> Listo
 * - Usar TDA en tablero y piezas       -> Listo
 * - Agregar tableros no validos        -> Listo
 * - createBoard                        -> Listo
 * - checkBoard                         -> Falta contar las piezas
 * - nextPiece                          -> Listo
 * - play                               -> No empezado
 * - checkHorizontalLines               -> Listo
 * - boardToString                      -> Listo
 */

% Piezas iniciales sin ningún giro:
/*
 *   1) AA  2) B   3)  C    4)  DD   5)  E   6)  F   7)  GG
 *      AA     B      CCC      DD        E       F      GG
 *             BB                        E      FF
 *                                       E
 */

% Estos son los 6 tableros correctos (validos) ya incluidos en la base de conocimientos.
/*
1) Tablero 5x10, 3 piezas: 2, 4 y 5.
- - - - - -
|         |
|         |
|         |
|         |
|         |
|         |
|E        |
|E B D    |
|E B D D  |
|E B B D  |
- - - - - -

2) Tablero 5x10, 6 piezas: 2, 3, 3, 4, 5 y 6.
- - - - - -
|         |
|         |
|         |
|         |
|      B  |
|  B B B  |
|E C F F F|
|E C C D F|
|E C C D D|
|E C C C D|
- - - - - -

3) Tablero 5x10, 9 piezas: 1, 3, 4 y 5.
- - - - - -
|         |
|        C|
|A A   C C|
|A A   G C|
|E F F G G|
|E F   D G|
|E F E D D|
|E C E   D|
|C C E A A|
|  C E A A|
- - - - - -

4) Tablero 10x12, 5 piezas: 1, 1, 3, 4 y 5.
- - - - - - - - - - -
|                   |
|                   |
|                   |
|                   |
|                   |
|                   |
|                   |
|                   |
|                   |
|  A A D            |
|  A A D D   C   A A|
|E E E E D C C C A A|
- - - - - - - - - - -

5) Tablero 10x12, 8 piezas:
- - - - - - - - - - - 
|                   |
|                   |
|                   |
|                   |
|                   |
|                   |
|        G       B  |
|E A A   G G     B  |
|E A A   F G     B B|
|E A A   F   C   A A|
|E A A F F C C C A A|
- - - - - - - - - - -

6) Tablero 20x20, 10 piezas:
- - - - - - - - - - - - - - - - - - - - -
|                                       |
|                                       |
|                                       |
|                                       |
|                                       |
|                                       |
|                                       |
|                                       |
|                                       |
|                                       |
|                                       |
|                                       |
|                                       |
|            F                          |
|        D D F                          |
|  A A D D F F   B B   E   C   G   E   F|
|  A A   B B   D D B E E C C C G G E   F|
|  E E E E B D D   B E E F B B B G E F F|
|A A       B A A     E E F B G G C E A A|
|A A         A A     E F F G G C C C A A|
- - - - - - - - - - - - - - - - - - - - -
*/

% Estos son 3 tableros INCORRECTOS (no validos) ya incluidos en la base de conocimientos.
/*
7) Tablero 5x10, 7 piezas pero solo tiene 2: 1 y 2.
- - - - - -
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      B  |
|A A   B  |
|A A   B B|
- - - - - -

8) Tablero 10x12 pero sus medidas son de 12x12, 0 piezas.
- - - - - - - - - - - - -
|                       |
|                       |
|                       |
|                       |
|                       |
|                       |
|                       |
|                       |
|                       |
|                       |
|                       |
|                       |
- - - - - - - - - - - - -

9) Tablero 5x10 pero sus medidas son 5x13, 3 piezas: 1, 3, 5.
- - - - - -
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|  E      |
|  E      |
|  E      |
|  E      |
|A A   C  |
|A A C C C|
- - - - - -
*/


/*  ***** Dominios *****
 *
 * 
 */

/* ***** Predicados ***** (Ordenados por aparicion del TDA)
 * 
 * - TDA Pieza:
 * pieza(numero, numero, pieza)
 * crearPieza(numero, pieza)
 * esPieza(pieza)
 * getIdPieza(pieza, numero)
 * getCantidadDeGiros(pieza, numero)
 * girarPieza(pieza)
 * 
 * - TDA Board:
 * tablero(numero, numero, numero, board)
 * createBoard(numero, numero, numero, numero, board)
 * checkBoard(board)
 * medirAncho(numero, lista)
 * medirAlto(numero, lista)
 * medir(lista, numero)
 * getDimensiones(board)
 * getCantidadDePiezas(Board)
 * getListaDePiezas(Board)
 * "play"
 * nextPiece(board, numero, pieza)
 * siguientePieza(numero, pieza)
 * checkHorizontalLines(board, lista)
 * revisarLineasHorizontales(numero, lista, lista, lista)
 * agregar(lista, lista, string)
 * boardToString(board, string)
 * crearTapa(numero, string, string)
 * crearString(lista, string, string)   
 */

/* ***** Metas *****
 * Principal:
 *  Creacion y verificacion de tableros validos (createBoard y checkBoard)
 * 
 * Secundarias:
 *  Conseguir piezas aleatorias para jugar (nextPiece),
 *  jugar una pieza (play),
 *  revisar lineas completas en un tablero (checkHorizontalLines),
 *  crear un string que represente el tablero (boardToString).
 */


% ***** Clausulas de Horn *****

% ******************** TDA Pieza ********************
% ***** Hechos *****
pieza(1, 0, [[1, 0], [0, 0], [0, 1], [1, 0], [1, 1]]).

pieza(2, 0, [[2, 0], [0, 0], [0, 1], [1, 0], [2, 0]]).
pieza(2, 1, [[2, 1], [0, 0], [0, 1], [0, 2], [1, 2]]).
pieza(2, 2, [[2, 2], [0, 1], [1, 1], [2, 0], [2, 1]]).
pieza(2, 3, [[2, 3], [0, 0], [1, 0], [1, 1], [1, 2]]).

pieza(3, 0, [[3, 0], [0, 0], [0, 1], [0, 2], [1, 1]]).
pieza(3, 1, [[3, 1], [0, 1], [1, 0], [1, 1], [2, 1]]).
pieza(3, 2, [[3, 2], [0, 1], [1, 0], [1, 1], [1, 2]]).
pieza(3, 3, [[3, 3], [0, 0], [1, 0], [1, 1], [2, 0]]).

pieza(4, 0, [[4, 0], [0, 0], [0, 1], [1, 1], [1, 2]]).
pieza(4, 1, [[4, 1], [0, 1], [1, 0], [1, 1], [2, 0]]).

pieza(5, 0, [[5, 0], [0, 0], [1, 0], [2, 0], [3, 0]]).
pieza(5, 1, [[5, 1], [0, 0], [0, 1], [0, 2], [0, 3]]).

pieza(6, 0, [[6, 0], [0, 0], [0, 1], [1, 1], [2, 1]]).
pieza(6, 1, [[6, 1], [0, 2], [1, 0], [1, 1], [1, 2]]).
pieza(6, 2, [[6, 2], [0, 0], [1, 0], [2, 0], [2, 1]]).
pieza(6, 3, [[6, 3], [0, 0], [0, 1], [0, 2], [1, 0]]).

pieza(7, 0, [[7, 0], [0, 1], [0, 2], [1, 0], [1, 1]]).
pieza(7, 1, [[7, 1], [0, 0], [1, 0], [1, 1], [2, 1]]).

% ***** Reglas *****

% ***** Constructor*****
crearPieza(IdPieza, Salida):-
    IdPieza >= 1, IdPieza =< 7, pieza(IdPieza, 0, Salida), !.


% ***** Pertenencia *****
esPieza([[IdPieza, Giros]|_]):-
    IdPieza >= 1, IdPieza =< 5, Giros >= 0, Giros =< 3.


% ***** Selectores *****
getIdPieza([[IdPieza, _]|_], IdPieza):- !.

getCantidadDeGiros([[_, Giros]|_], Giros):- !.


% ***** Modificadores *****
girarPieza([[IdPieza, Giros]|_], Salida):-
    pieza(IdPieza, _, _), IdPieza = 1, pieza(IdPieza, _, Salida), !;
    pieza(IdPieza, _, _), IdPieza = 2, Giros < 3, NuevoGiro is Giros + 1, pieza(IdPieza, NuevoGiro, Salida), !;
    pieza(IdPieza, _, _), IdPieza = 2, Giros = 3, pieza(IdPieza, 0, Salida), !;
    pieza(IdPieza, _, _), IdPieza = 3, Giros < 3, NuevoGiro is Giros + 1, pieza(IdPieza, NuevoGiro, Salida), !;
    pieza(IdPieza, _, _), IdPieza = 3, Giros = 3, pieza(IdPieza, 0, Salida), !;
    pieza(IdPieza, _, _), IdPieza = 4, Giros = 0, pieza(IdPieza, 1, Salida), !;
    pieza(IdPieza, _, _), IdPieza = 4, Giros = 1, pieza(IdPieza, 0, Salida), !;
    pieza(IdPieza, _, _), IdPieza = 5, Giros = 0, pieza(IdPieza, 1, Salida), !;
    pieza(IdPieza, _, _), IdPieza = 5, Giros = 1, pieza(IdPieza, 0, Salida), !;
    pieza(IdPieza, _, _), IdPieza = 6, Giros < 3, NuevoGiro is Giros + 1, pieza(IdPieza, NuevoGiro, Salida), !;
    pieza(IdPieza, _, _), IdPieza = 6, Giros = 3, pieza(IdPieza, 0, Salida), !;
    pieza(IdPieza, _, _), IdPieza = 7, Giros = 0, pieza(IdPieza, 1, Salida), !;
    pieza(IdPieza, _, _), IdPieza = 7, Giros = 1, pieza(IdPieza, 0, Salida), !.

% ***** Operadores *****
% No Hay


% ******************** TDA Tablero ********************
% ***** Hechos *****
% Tablero 1
tablero(5, 10, 3, [5, 10, 3, [
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    ['E', ' ', ' ', ' ', ' '],
    ['E', 'B', 'D', ' ', ' '],
    ['E', 'B', 'D', 'D', ' '],
    ['E', 'B', 'B', 'D', ' ']]]).

% Tablero 2
tablero(5, 10, 6, [5, 10, 6, [
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', 'B', ' '],
    [' ', 'B', 'B', 'B', ' '],
    ['E', 'C', 'F', 'F', 'F'],
    ['E', 'C', 'C', 'D', 'F'],
    ['E', 'C', 'C', 'D', 'D'],
    ['E', 'C', 'C', 'C', 'D']]]).

% Tablero 3
tablero(5, 10, 9, [5, 10, 9, [
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', 'C'],
    ['A', 'A', ' ', 'C', 'C'],
    ['A', 'A', ' ', 'G', 'C'],
    ['E', 'F', 'F', 'G', 'G'],
    ['E', 'F', ' ', 'D', 'G'],
    ['E', 'F', 'E', 'D', 'D'],
    ['E', 'C', 'E', ' ', 'D'],
    ['C', 'C', 'E', 'A', 'A'],
    [' ', 'C', 'E', 'A', 'A']]]).

% Tablero 4
tablero(10, 12, 5, [10, 12, 5, [
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', 'A', 'A', 'D', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', 'A', 'A', 'D', 'D', ' ', 'C', ' ', 'A', 'A'],
    ['E', 'E', 'E', 'E', 'D', 'C', 'C', 'C', 'A', 'A']]]).

% Tablero 5
tablero(10, 12, 8, [10, 12, 8, [
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', 'G', ' ', ' ', ' ', 'B', ' '],
    ['E', 'A', 'A', ' ', 'G', 'G', ' ', ' ', 'B', ' '],
    ['E', 'A', 'A', ' ', 'F', 'G', ' ', ' ', 'B', 'B'],
    ['E', 'A', 'A', ' ', 'F', ' ', 'C', ' ', 'A', 'A'],
    ['E', 'A', 'A', 'F', 'F', 'C', 'C', 'C', 'A', 'A']]]).

% Tablero 6
tablero(20, 20, 10, [20, 20, 10, [
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', 'F', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', 'D', 'D', 'F', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', 'A', 'A', 'D', 'D', 'F', 'F', ' ', 'B', 'B', ' ', 'E', ' ', 'C', ' ', 'G', ' ', 'E', ' ', 'F'],
    [' ', 'A', 'A', ' ', 'B', 'B', ' ', 'D', 'D', 'B', 'E', 'E', 'C', 'C', 'C', 'G', 'G', 'E', ' ', 'F'],
    [' ', 'E', 'E', 'E', 'E', 'B', 'D', 'D', ' ', 'B', 'E', 'E', 'F', 'B', 'B', 'B', 'G', 'E', 'F', 'F'],
    ['A', 'A', ' ', ' ', ' ', 'B', 'A', 'A', ' ', ' ', 'E', 'E', 'F', 'B', 'G', 'G', 'C', 'E', 'A', 'A'],
    ['A', 'A', ' ', ' ', ' ', ' ', 'A', 'A', ' ', ' ', 'E', 'F', 'F', 'G', 'G', 'C', 'C', 'C', 'A', 'A']]]).

% Tablero 7 (Faltan piezas)
tablero(5, 10, 7, [5, 10, 7, [
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', 'B', ' '],
    ['A', 'A', ' ', 'B', ' '],
    ['A', 'A', ' ', 'B', 'B']]]).

% Tablero 8 (Es de ancho 12 en vez de 10)
tablero(10, 12, 0, [10, 12, 0, [
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']]]).

% Tablero 9 (Es de alto 13 en vez de 10)
tablero(5, 10, 3, [5, 10, 3, [
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', 'E', ' ', ' ', ' '],
    [' ', 'E', ' ', ' ', ' '],
    [' ', 'E', ' ', ' ', ' '],
    [' ', 'E', ' ', ' ', ' '],
    ['A', 'A', ' ', 'C', ' '],
    ['A', 'A', 'C', 'C', 'C']]]).


% ***** Reglas *****

% ***** Constructor *****
createBoard(N, M, GamePieces, _, Board):-
    tablero(N, M, GamePieces, _), tablero(N, M, GamePieces, Board), !.


% ***** Pertenencia *****
% Predicado checkBoard y predicados de apoyo:
checkBoard([Ancho, Alto, _, ListaPiezas]):-
    medirAncho(Ancho, ListaPiezas), medirAlto(Alto, ListaPiezas).

medirAncho(_,[]):- !.
medirAncho(Ancho,[X|Xs]):-
    medir(X, Cantidad), Cantidad is Ancho, medirAncho(Ancho, Xs).

medirAlto(Alto, ListaPiezas):-
    medir(ListaPiezas, Cantidad), Cantidad is Alto.

medir([], 0):- !.
medir([_|Xs], Cantidad):-
    medir(Xs, CantidadAnterior), Cantidad is CantidadAnterior + 1.
% ----------


% ***** Selector *****
getDimensiones([Ancho, Alto | _], Ancho, Alto):- !.

getCantidadDePiezas([_, _, CantidadDePiezas, _], CantidadDePiezas):- !.

getListaDePiezas([_, _, _, ListaDePiezas], ListaDePiezas):- !.

% ***** Modificador *****
% play


% ***** Operadores *****
% Predicado nextPiece y predicados de apoyo:
nextPiece(Board, Seed, Piece):-
    checkBoard(Board), siguientePieza(Seed, Piece), !.
    
siguientePieza(Seed, Piece):-
    set_random(seed(Seed)), random(1, 7, IdPieza), pieza(IdPieza, 0, Piece).
% ----------

% Predicado checkHorizontalLines y predicados de apoyo:
checkHorizontalLines(Board, PosLines):-
    getDimensiones(Board, _, Alto),
    getListaDePiezas(Board, ListaDePiezas),
    revisarLineasHorizontales(Alto, ListaDePiezas, [], PosLines).

revisarLineasHorizontales(0, [], Auxiliar, Auxiliar):- !.
revisarLineasHorizontales(Alto, [X|Xs], Auxiliar, SalidaFinal):-
    not(member(' ', X)) ->
        (agregar(Auxiliar, Salida, Alto), NAlto is Alto - 1, revisarLineasHorizontales(NAlto, Xs, Salida, SalidaFinal));
        (NAlto is Alto - 1, revisarLineasHorizontales(NAlto, Xs, Auxiliar, SalidaFinal)).

agregar([], [Elemento], Elemento).
agregar([X|Xs], [X|Ys], Elemento):- agregar(Xs, Ys, Elemento).
% ----------

% Predicado boartToString y predicados de apoyo:
boardToString(Board, BoardStr):-
    checkBoard(Board),
    getDimensiones(Board, Ancho, _),
    getListaDePiezas(Board, ListaDePiezas),
    AnchoTecho is Ancho + 2,
    crearTapa(AnchoTecho, '',TapaStr),
    string_concat(TapaStr, '\n', TapaStr2),
    crearString(ListaDePiezas, TapaStr2, StringTablero),
    string_concat(StringTablero, TapaStr2, BoardStr).

crearTapa(0, String, String):- !.
crearTapa(AnchoTecho, Entrada, TapaStr):-
    AnchoTechoN is AnchoTecho - 1,
    string_concat(Entrada, '-', Salida),
    crearTapa(AnchoTechoN, Salida, TapaStr).

crearString([], String, String):- !.
crearString([X|Xs], String, BoardStr):-
    string_to_list(Salida, X),
    string_concat('|', Salida, Salida2),
    string_concat(Salida2, '|', Salida3),
    string_concat(String, Salida3, Salida4),
    string_concat(Salida4, '\n', Salida5),
    crearString(Xs, Salida5, BoardStr).
% ----------

%------------------------------%