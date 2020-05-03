append([], List, List).
append([Head|Tail], List, [Head|Rest]) :- append(Tail, List, Rest). % соединяет два списка

doWork([], _, []).
doWork(List, _, List) :- length(List, Length), Length is 1.   

doWork(List, K, Result) :-  K2 is K*2,                            % делает сдвиг влево на 2К шагов. по сусти нахожу свдиг по модулю длинны списка,
                            length(List, Length),                 % беру список от начала до сдвига, и список от сдвига до конца, и соединяю в сначала второй и потом первый
                            Shift is (K2 mod Length),
                            getList(List, 0, Shift, L2),
                            getList(List, Shift, Length, L1),
                            append(L1, L2, Result), !.

getList(List, Current, Max, [Element|Result]) :- Current<Max,                   % нахожу список с заданого текущего до заданого максимального элементов.
                                                 nth0(Current, List, Element),
                                                 NextCount is Current+1,
                                                 getList(List, NextCount, Max, Result).

getList(_, Current, Max, []) :- Current >= Max.