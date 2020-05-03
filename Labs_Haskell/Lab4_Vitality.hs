import Data.List

first (requiredElement, _) = requiredElement
second (_, requiredElement) = requiredElement

nonTerminalsAlphabet :: [Char]
nonTerminalsAlphabet = ['A'..'Z']

-- 1 test:
--rules = [('S', "X"),('S', "Y"),('X', "aXab"),('X', "ab"),('Y', "aYd"),('Y', "b")]

--2 test:
--rules = [('S', "XS"),('S', "X"),('X', "aXb"),('X', "bXa"),('X', "c")]

--3 test:
--rules = [('S', "TK"),('K', "+TK"),('K', "e"),('T', "ML"),('L', "*MT"),('L', "e"),('M', "(S)"),('M', "e")]

rules = [('S', "TS"), ('T', "T"), ('T', "ML"), ('M', "e"), ('L', "e")]

--rules = [ ('S',"aBD"),('S',"D"),('S',"AC"),('S',"b"), ('A',"SCB"), ('A',"SABC"), ('A',"CbD"), ('A',"e"), ('B',"CA"), ('B',"d"), ('C',"ADc"), ('C',"a"), ('C',"e"), ('D',"EaC"), ('D',"SC"), ('E',"BCS"), ('E',"a")] 
--rules = [('S', "AbS"),('S', "AC"),('A', "BD"),('C', "Sa"),('C', "e"),('B', "BC"),('B', "e"),('D', "aB"),('D', "BA")]

depth = length rules + 10
epsilonNonTerminals = getEpsilonNonTerminals getInitENonTerminal
nonTerminals = nub [first x | x <- rules]


------------------------------------------------------------------
getInitENonTerminal :: [Char]
getInitENonTerminal = [ first x | x <- rules, second x == "e" ]

getCurrentENonTerminals :: [Char] -> [Char]
getCurrentENonTerminals listOfENonTerminals = [ first x | x <- rules, intersect (second x) listOfENonTerminals == second x, not(elem (first x) listOfENonTerminals) ]

getEpsilonNonTerminals :: [Char] -> [Char]
getEpsilonNonTerminals listOfEpsilonNonTerminals | length (getCurrentENonTerminals listOfEpsilonNonTerminals) == 0 = listOfEpsilonNonTerminals
                                                 | otherwise = getEpsilonNonTerminals (listOfEpsilonNonTerminals ++ (getCurrentENonTerminals listOfEpsilonNonTerminals))


-------------------------------------------------------------------


getPossibleRules :: [Char] -> [(Char, String)] -> [(Char, (Char, String))]
getPossibleRules currentNonTerminals rules = [(x,y) | x <- currentNonTerminals, y <- rules, first y == x, elem (first(y)) (nonTerminalsAlphabet)]

getAdjustedRules :: [Char] -> [Char] -> Int -> [Char]
getAdjustedRules word eNonTerminals current | (current == 0) && elem (word !! current) eNonTerminals = (word !! current) : getAdjustedRules word eNonTerminals (current + 1)
                                            | (current == 0) = (word !! current) : []
                                            | (current < length word) && (elem (word !! current) eNonTerminals) = word !! current : getAdjustedRules word eNonTerminals (current + 1)
                                            | (current < length word) && (notElem (word !! current) eNonTerminals) && (elem (word !! current) nonTerminals) = word !! current : []
                                            | otherwise = []

getFirstElementOfRightSideOfRule :: [(a1, (a2, [Char]))] -> [[Char]]
getFirstElementOfRightSideOfRule customRules  = [ getAdjustedRules (second (second y)) epsilonNonTerminals 0 | y <- customRules]

getPossibleNonTerminals :: [Char] -> [Char]
getPossibleNonTerminals rightSideOfRule = nub [x | x <- rightSideOfRule, (isNonTerminal x == True)]

isNonTerminal :: Char -> Bool
isNonTerminal symbol | symbol `elem` nonTerminalsAlphabet = True
                     | otherwise = False


start :: [Char]
start = walkThroughRules ['S'] 1

walkThroughRules :: [Char] -> Int -> [Char]
walkThroughRules currentNonTerminals counter = if nub (getPossibleNonTerminals (concat((getFirstElementOfRightSideOfRule (getPossibleRules currentNonTerminals rules))))) == nub (getPossibleNonTerminals (concat((getFirstElementOfRightSideOfRule (getPossibleRules (getPossibleNonTerminals (concat((getFirstElementOfRightSideOfRule (getPossibleRules currentNonTerminals rules))))) rules)))))
                                               then getPossibleNonTerminals (concat((getFirstElementOfRightSideOfRule (getPossibleRules currentNonTerminals rules)))) 
                                               else getPossibleNonTerminals (concat((getFirstElementOfRightSideOfRule (getPossibleRules currentNonTerminals rules)))) ++ walkThroughRules (getPossibleNonTerminals (concat((getFirstElementOfRightSideOfRule (getPossibleRules currentNonTerminals rules))))) (counter + 1)
                                        
main :: IO ()
main = do
 let possibleNonTerminals = nub start
 let lefRecursiveNonTerminals = [x | x <- nonTerminals, x `elem` walkThroughRules ([x]) (1)]
 let test = nub (walkThroughRules ['B'] 1 )
 --print test
 --print epsilonNonTerminals
 --print possibleNonTerminals
 print lefRecursiveNonTerminals