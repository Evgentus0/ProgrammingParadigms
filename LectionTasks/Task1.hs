findNotPairElements' list count max result | count>=max = result                                        --поиск количества непарных элементов в списке
                                           | otherwise = if not (even (list!!count))
                                                then findNotPairElements' list (count+1) max (result+1)
                                                else findNotPairElements' list (count+1) max result

findNotPairElements list = findNotPairElements' list 0 (length list) 0



main = do
    let t = [3, 3, 3, 2]
    let res = findNotPairElements t

    print res