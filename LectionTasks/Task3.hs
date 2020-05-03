generateSequence n = [2, 4 .. n*2] --генерация списка парных элементов до заданого 2n

main = do
    let t = generateSequence 5
    print t