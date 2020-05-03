findFirstSignificantNumber number | number < 10 = number                                      --поиск первой значащей цифры
                                  | otherwise = findFirstSignificantNumber (number `div` 10)

main = do
    let t = findFirstSignificantNumber 007056349802076842
    print t