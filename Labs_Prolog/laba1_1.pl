entries([], _, 0). 
entries([X | T], X, Y) :- !, entries(T, X, Z), Y is 1 + Z. % entries(List, X, Y) - функция для нахождения количества вхождений элемента X в список List.
entries([_ | T], X, Z) :- entries(T, X, Z).

filter(InitList, Out) :- filter(InitList, InitList, Out).  % filter(List, Out) - функция, которая оставляет в списке элементы, которые входят 3 раза
filter(_, [], []).
filter(InitList, [X | Lin], [X|Lout]) :- entries(InitList, X, 3), filter(InitList, Lin, Lout).
filter(InitList, [_ | Lin], Lout) :- !, filter(InitList, Lin, Lout).