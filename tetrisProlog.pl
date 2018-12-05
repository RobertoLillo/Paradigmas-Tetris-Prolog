/*
 * tetrisProlog
 * Laboratorio 2 Paradigmas de programación (2 - 2018).
 * Fecha de entrega: 7 de Diciembre.
 *
 * Requerimientos Mínimos:
 * - Hecho en SwiProlog -> Listo
 * - Documentacion (Dominios, Predicados, Metas, Hechos, Reglas, Descripcion del programa) ->
 * - Orden y claridad ->
 * - Usar TDA en tablero y piezas -> Listo
 * - createBoard -> Listo
 * - checkBoard -> Falta contar las piezas
 * - nextPiece -> Listo
 * - play -> No lo he empezado
 * - checkHorizontalLines -> Listo
 * - boardToString -> Listo
 */

/* Dominios
 *
 * 
 */

/* Predicados
 *
 * 
 */

/* Metas
 *
 * 
 */


% Clausulas de Horn

% ******************** TDA Pieza ********************
% Piezas iniciales sin ningún giro:
%   1) AA  2) B   3)  C    4)  DD   5)  E   6)  F   7)  GG
%      AA     B      CCC      DD        E       F      GG
%             BB                        E      FF
%                                       E

% Hechos
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

% Reglas
% Constructor
crearPieza(IdPieza, Salida):-
    IdPieza >= 1, IdPieza =< 7, pieza(IdPieza, 0, Salida), !.

% Pertenencia
esPieza([[IdPieza, Giros]|_]):-
    IdPieza >= 1, IdPieza =< 5, Giros >= 0, Giros =< 3.

% Selectores
getIdPieza([[IdPieza, _]|_], IdPieza):- !.

getCantidadDeGiros([[_, Giros]|_], Giros):- !.

% Modificadores
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

% Operadores
% No Hay

% ******************** TDA Tablero ********************
% Estos son los tableros ya incluidos en la base de conocimientos.
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

3) Tablero 5x10, 9 piezas: 1, 3, 4 y 5 (Faltan piezas, tablero no valido).
- - - - - -
|         |
|         |
|         |
|         |
|         |
|      D  |
|    E D D|
|  C E   D|
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

5) Tablero 10x12(Tablero no valido, medidas 12x12), 8 piezas:
- - - - - - - - - - - - -
|                       |
|                       |
|                       |
|                       |
|                       |
|                       |
|        G       B      |
|E       G G     B      |
|E       F G     B B D  |
|E A A   F   C   A A D D|
|E A A F F C C C A A   D|
- - - - - - - - - - - - -

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

% Hechos
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

% Tablero 3 (FALTAN PIEZAS)
tablero(5, 10, 9, [5, 10, 9, [
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', 'D', ' '],
    [' ', ' ', 'E', 'D', 'D'],
    [' ', 'C', 'E', ' ', 'D'],
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

% Tablero 5 (MEDIDAS 12X12)
tablero(10, 12, 8, [10, 12, 8, [
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', 'G', ' ', ' ', ' ', 'B', ' ', ' ', ' '],
    ['E', ' ', ' ', ' ', 'G', 'G', ' ', ' ', 'B', ' ', ' ', ' '],
    ['E', ' ', ' ', ' ', 'F', 'G', ' ', ' ', 'B', 'B', 'D', ' '],
    ['E', 'A', 'A', ' ', 'F', ' ', 'C', ' ', 'A', 'A', 'D', 'D'],
    ['E', 'A', 'A', 'F', 'F', 'C', 'C', 'C', 'A', 'A', ' ', 'D']]]).

%Tablero 6
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

% Reglas
% Constructor
createBoard(N, M, GamePieces, _, Board):-
    tablero(N, M, GamePieces, _), tablero(N, M, GamePieces, Board), !.

% Pertenencia
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

% Selector
getDimensiones([Ancho, Alto | _], Ancho, Alto):- !.

getCantidadDePiezas([_, _, CantidadDePiezas, _], CantidadDePiezas):- !.

getListaDePiezas([_, _, _, ListaDePiezas], ListaDePiezas):- !.

% Modificador
% play

% Operadores
nextPiece(Board, Seed, Piece):-
    checkBoard(Board), siguientePieza(Seed, Piece), !.
    
siguientePieza(Seed, Piece):-
    set_random(seed(Seed)), random(1, 7, IdPieza), pieza(IdPieza, 0, Piece).

checkHorizontalLines(Board, PosLines):-
    getDimensiones(Board, _, Alto),
    getListaDePiezas(Board, ListaDePiezas),
    revisarLineasHorizontales(Alto, ListaDePiezas, [], PosLines).

revisarLineasHorizontales(0, [], Auxiliar, Auxiliar):- !.
revisarLineasHorizontales(Alto, [X|Xs], Auxiliar, SalidaFinal):-
    not(member(' ', X)) ->
        (agregar(Auxiliar, Salida, Alto), NAlto is Alto - 1, revisarLineasHorizontales(NAlto, Xs, Salida, SalidaFinal));
        (NAlto is Alto - 1, revisarLineasHorizontales(NAlto, Xs, Auxiliar, SalidaFinal)).


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



%------------------------------%

agregar([], [Elemento], Elemento).
agregar([X|Xs], [X|Ys], Elemento):- agregar(Xs, Ys, Elemento).