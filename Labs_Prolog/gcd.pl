use_module(library(lists)).
use_module(library(lambda)). 

gcd(X, X, X).
gcd(X, Y, Z):-X>Y, F is X-Y, gcd(F, Y, Z).
gcd(X, Y, Z):- X<Y, F is Y-X, gcd(X, F, Z).

size([], 0).
size([_|T], N):-size(T, N1), N is N1+1.

add(X, List, [X|List]).

% include((\X^(X mod 2 =:= 0)), [1,2,3,4,5,6,7,8,9], L).