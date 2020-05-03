generateFibonacciSequence' count n result | count >=n = result
                                          | otherwise = generateFibonacciSequence' (count+1) n (result++[((result!!(count-1))+(result!!(count-2)))]) --генерация элементов фибоначчи

generateFibonacciSequence 0 = []
generateFibonacciSequence 1 = [0]
generateFibonacciSequence 2 = [0, 1]

generateFibonacciSequence n = generateFibonacciSequence' 2 n [0, 1]

main = do
    let a = generateFibonacciSequence 2
    print a