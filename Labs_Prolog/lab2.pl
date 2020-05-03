findLocalMinimums(List, Result):- findLocalMinimums(List, 0, Result), !.   % начальная функция

findLocalMinimums(_, -1, []).  %конец работы

findLocalMinimums(List, Counter, [CurrentElement|Result]):- Counter is 0, nth0(0, List, CurrentElement), nth0(1, List, RightElement), %проверяем первый элемент в списке
                                                            CurrentElement<RightElement, 
                                                            findLocalMinimums(List, 1, Result).

findLocalMinimums(List, Counter, [CurrentElement|Result]):- length(List, Length), Counter is Length-1, nth0(Counter, List, CurrentElement),  %проверяем последний элементв списке
                                                            LeftCounter is Counter-1, nth0(LeftCounter, List, LeftElement),
                                                            CurrentElement<LeftElement,
                                                            findLocalMinimums(List, -1, Result).

findLocalMinimums(List, Counter, Result):- length(List, Length), Counter is Length-1, !, findLocalMinimums(List, -1, Result). % заканчиваем, если последний эелемент не был нижней пикой

findLocalMinimums(List, Counter, [CurrentElement|Result]):- length(List, Length), Counter>0, Counter<Length-1,        % проверка всех остальных элементов кроме первого и последнего
                                                            LeftCounter is Counter-1, RightCounter is Counter + 1, 
                                                            nth0(Counter, List, CurrentElement), 
                                                            nth0(LeftCounter, List, LeftElement), 
                                                            nth0(RightCounter, List, RightElement),
                                                            CurrentElement<LeftElement, CurrentElement<RightElement,
                                                            findLocalMinimums(List, RightCounter, Result).

findLocalMinimums(List, Counter, Result):-NextCounter is Counter+1, findLocalMinimums(List, NextCounter, Result). %переход к следующему элементу, если текущий не нижняя пика