add(A, B, C) :- C is A + B. %добавление 
lt(A, B) :- A < B.          %оператор меньше
div(A, B, C) :- C is A / B. % деление
divisible(X, Y) :- div(X, Y, Z), integer(Z).  %деление нацело

composite(X, Y) :- Y > 1, divisible(X, Y).  % составное ли число
composite(X, Y) :- lt(Y, X / 2), composite(X, Y+1).

composite(X) :- X > 2, composite(X, 2).

prime(X) :- not(X is 1), not(composite(X)).% простое ли число

findNextPrime(Number, Number):-  prime(Number), !.  %следующее простое число 
findNextPrime(Number, Result):-Next is Number+1, 
                               findNextPrime(Next, Result).

findNthPrimeNumber(1, 2):-!.
findNthPrimeNumber(N, PrimeNumber):- findNthPrimeNumber(2, N, 3, PrimeNumber), !.                  % N-ое простое число
findNthPrimeNumber(CurrentNumber, N, CurrentPrime, PrimeNumber):- CurrentNumber<N,
                                                                  NextNumber is CurrentPrime + 1,
                                                                  findNextPrime(NextNumber, NextPrime),
                                                                  NextCounter is CurrentNumber + 1,
                                                                  findNthPrimeNumber(NextCounter, N, NextPrime, PrimeNumber).
findNthPrimeNumber(CurrentNumber, N, CurrentPrime, CurrentPrime):-CurrentNumber>=N.


findPirmesStartWith(FirstNumber, N, Result):-findNextPrime(FirstNumber, FirstPrime),         % находит N простых числе начиная с параметра.
                                             findPirmesStartWith(FirstPrime, 1, N, Result), !.
findPirmesStartWith(CurrentPrime, Count, N, [CurrentPrime|Result]):- Count=<N,
                                                     NextCounter is Count + 1,
                                                     NextNumber is CurrentPrime +1,
                                                     findNextPrime(NextNumber, NextPrime), 
                                                     findPirmesStartWith(NextPrime, NextCounter, N, Result).
findPirmesStartWith(_, Count, N, []):- Count>N.

doWork(N, Result):- Low is N + 1,                                     % находит простые числа с номерами от N+1 до N*2
                    findNthPrimeNumber(Low, FirstPrime), 
                    Upper is N*2 - N,
                    findPirmesStartWith(FirstPrime, Upper, Result).


