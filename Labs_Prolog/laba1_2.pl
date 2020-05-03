separate(List, Out1, Out2) :- separate(List, 1, Out1, Out2). % separate(List, Out1, Out2) - функция, которая записывает элементы по очереди в Out1 и Out2.

separate([], _, [], []).
separate([X | Lin], FirstOrSecond, [X | Lout1], Lout2) :- FirstOrSecond is 1, separate(Lin, 0, Lout1, Lout2).
separate([X | Lin], FirstOrSecond, Lout1, [X | Lout2]) :- FirstOrSecond is 0, separate(Lin, 1, Lout1, Lout2).

