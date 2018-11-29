% tetrisProlog
% Laboratorio 2 Paradigmas de programación (2 - 2018).
% Fecha de entrega: 7 de Diciembre.

% Dominios


% Predicados


% Metas


% Clausulas de Horn
% Hechos

% Piezas iniciales sin ningún giro, son las siguientes:
%   0) ##   1) #    2)  #    3)  ##   4)  #
%      ##      #       ###      ##        #
%              ##                         #
%                                         #
pieza(0, 0, [[0, 0], [0, 0], [0, 1], [1, 0], [1, 1]]).
pieza(1, 0, [[1, 0], [0, 0], [0, 1], [1, 0], [2, 0]]).
pieza(2, 0, [[2, 0], [0, 0], [0, 1], [0, 2], [1, 1]]).
pieza(3, 0, [[3, 0], [0, 0], [0, 1], [1, 1], [1, 2]]).
pieza(4, 0, [[4, 0], [0, 0], [1, 0], [2, 0], [3, 0]]).

% Reglas

% TDA Pieza
% Constructor
crearPieza(IdPieza, Salida):-
    pieza(IdPieza, _, _), pieza(IdPieza, _, Salida), !.

% Funciones de pertenencia
esPieza([[IdPieza, Giros]|_]):-
    IdPieza >= 0, IdPieza =< 4, Giros >= 0, Giros =< 3.

% Selectores

% Modificadores

% Operadores


%------------------------------%

% Papeo
esPar(X) :- 0 is X mod 2.
