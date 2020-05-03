reverse(L, Result):-reverse(L, Result, []), !.
reverse([],Z,Z).
reverse([H|T],Z,Acc) :- reverse(T,Z,[H|Acc]).  % менят последовательность в списке

append([], List, List).
append([Head|Tail], List, [Head|Rest]) :- append(Tail, List, Rest). % соединяет два списка

doWork(List, Result) :- reverse(List, Reverse), append(List, Reverse, Result).  % берет список, разворачивает его, и соелиняет с исходным