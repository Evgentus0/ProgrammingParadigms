doWork(List, N, Result) :- length(List, Length), getList(List, N, Length, Result), !.  % беру эелемнты списка начиная с заданого

getList(List, Count, Length, [Element|Result]) :- Count<Length,                 
                                                 nth0(Count, List, Element),
                                                 NextCount is Count+1,
                                                 getList(List, NextCount, Length, Result).
getList(_, Count, Length, []) :- Count>=Length.