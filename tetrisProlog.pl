% tetrisProlog
% Laboratorio 2 Paradigmas de programación (2 - 2018).
% Fecha de entrega: 7 de Diciembre.

% Dominios


% Predicados


% Metas


% Clausulas de Horn

% TDA Pieza
% Hechos
% Piezas iniciales sin ningún giro, son las siguientes:
%   1) ##   2) #    3)  #    4)  ##   5)  #
%      ##      #       ###      ##        #
%              ##                         #
%                                         #
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
    pieza(IdPieza, _, _), pieza(IdPieza, _, Salida), !.

% Funciones de pertenencia
esPieza([[IdPieza, Giros]|_]):-
    IdPieza >= 1, IdPieza =< 5, Giros >= 0, Giros =< 3.

% Selectores
getIdPieza([[IdPieza, _]|_], Salida):-
    Salida is IdPieza.

getCantidadDeGiros([[_, Giros]|_], Salida):-
    Salida is Giros.

% Modificadores

% Operadores


%------------------------------%

% Papeo
esPar(X) :- 0 is X mod 2.
