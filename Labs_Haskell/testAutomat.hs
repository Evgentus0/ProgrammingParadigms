first (requiredElement, _, _) = requiredElement
second (_, requiredElement, _) = requiredElement
third (_, _, requiredElement) = requiredElement

state = [1, 2, 3, 4]
s_0 = 1
s_f = [3, 4]
transition = [(1, 'a', 2), (1, 'b', 1), (2, 'a', 3), (2, 'b', 4)]

getTrans::Int->[(Int, Char, Int)]

getTrans state = filter(\x-> first x == state) transition

getDest state symb = third ((filter(\x-> first x == state && second x == symb) transition)!!0)
checkWhatState' word state k | k>=length word = (state, word)
                            | otherwise = checkWhatState' word (getDest state (word!!k)) (k+1)
checkWhatState word = checkWhatState' word s_0 0



main = do
    let t= checkWhatState "bbbaa"
    print t