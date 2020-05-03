generateSequence(N, Result):-generateSequence(1, N, Result), !.             % генерирует последовательность синусов
generateSequence(Count, N, [NextElement|Result]):- Count=<N,
                                                   sin(Count, NextElement),
                                                   NextCount is Count + 1,
                                                   generateSequence(NextCount, N, Result).
generateSequence(Count, N, []):-Count>N.

doWork(N, Result):-generateSequence(N, Seq), sort(Seq, Result). % берет последовательносьт синусов и сортирует