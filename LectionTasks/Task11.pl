append([], List, List).
append([Head|Tail], List, [Head|Rest]) :- append(Tail, List, Rest).    % соединяю два списка.

doWork([], _, []).
doWork(List, _, List) :- length(List, Length), Length is 1.

doWork(List, N, Result) :-  length(List, Length),                       % перестаановка головы в конец -  по сути цикличный свди влево, делаю N сдвигов влево
                            Shift is (N mod Length),
                            getList(List, 0, Shift, L2),
                            getList(List, Shift, Length, L1),
                            append(L1, L2, Result), !.

getList(List, Current, Max, [Element|Result]) :- Current<Max,                   % нахожу список с заданого текущего до заданого максимального элементов.
                                                 nth0(Current, List, Element),
                                                 NextCount is Current+1,
                                                 getList(List, NextCount, Max, Result).

getList(_, Current, Max, []) :- Current >= Max.