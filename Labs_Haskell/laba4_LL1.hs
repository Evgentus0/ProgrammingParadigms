import qualified Data.Set as Set
import Data.List as List
import Data.Maybe as Maybe

grammar = [("S", "TK"), ("K", "+TK"), ("K", "e"), ("T", "ML"), ("L", "*MT"), ("L", "e"), ("M", "(S)"), ("M", "c")]
--grammar = [("S", "X"), ("S", "Y"), ("X", "aXab"), ("X", "ab"), ("Y", "aYd"), ("Y", "b")]
--grammar = [("S", "XS"), ("S", "X"), ("X", "aXb"), ("X", "bXa"), ("X", "c")]
--grammar = [("X", "Yz"), ("X", "a"), ("Y", "bZ"), ("Y", "e"), ("Z", "e")]
--grammar = [("S", "TP"), ("T", "t"), ("P", "M"), ("P", "e"), ("M", "m")]
--grammar = [("T", "M"), ("M", "M")]
--grammar = [("T", "Tt"), ("T", "e")]

globalNonTerminals = Set.fromList ([fst c | c <- grammar])

------------------------Общие методы------------------------------

isTerminal symb = not (symb `elem` globalNonTerminals) --проверяет, является ли символ терминалом

getPosition nonTerminal rule = Maybe.fromJust (List.elemIndex (nonTerminal!!0) rule) -- возвращает позицию нетерминала в правиле

getRules nonTerminal = [snd res | res<-(filter(\x-> fst x == nonTerminal) grammar)] --правила, слева в которых стоит неТерминал, переданный параметром

getNonTerminals_Rules nonTerminal = filter(\x-> List.isInfixOf nonTerminal (snd x)) grammar --возвращает пары неТерминал - правило, где в парвило входить неТерминал, переданный параметром

hasEps nonTerminal = hasEps' nonTerminal nonTerminal --есть ли у неТерминала вывод эпс или пустое правило
hasEps' nonTerminal checkedNonTerminals = "e" `elem` (getRules nonTerminal) || hasAllEpsNonTerminals (getRules nonTerminal) checkedNonTerminals

hasAllEpsNonTerminals' rules checkedNonTerminals count max | count>=max = False
                                       | consistOfOnlyNonTerminals (rules!!count) = if isEpsEveryNonTerminal' (rules!!count) checkedNonTerminals
                                           then True
                                           else hasAllEpsNonTerminals' rules checkedNonTerminals (count+1) max
                                       | otherwise = hasAllEpsNonTerminals' rules checkedNonTerminals (count+1) max
hasAllEpsNonTerminals rules checkedNonTerminals = hasAllEpsNonTerminals' rules checkedNonTerminals 0 (length rules) --есть ли хотя бы одно пустое правило

isEpsEveryNonTerminal'' rule checkedNonTerminals count max  | count>=max = True
                                                            | (rule!!count) `elem` checkedNonTerminals = False
                                                            | otherwise = if hasEps' ([(rule!!count)]) (checkedNonTerminals++[(rule!!count)]) 
                                                                then isEpsEveryNonTerminal'' rule checkedNonTerminals (count+1) max
                                                                else False
isEpsEveryNonTerminal' rule checkedNonTerminals  = isEpsEveryNonTerminal'' rule checkedNonTerminals 0 (length rule) 
isEpsEveryNonTerminal rule = isEpsEveryNonTerminal' rule ""   -- пустое ли правило

consistOfOnlyNonTerminals' rule count max | count>=max = True
                                          | isTerminal [(rule!!count)] = False
                                          | otherwise = consistOfOnlyNonTerminals' rule (count+1) max
consistOfOnlyNonTerminals rule = consistOfOnlyNonTerminals' rule 0 (length rule) -- состоит ли правило из одних только терминалов

------------------------Нахождение first---------------------------------------------------

findFirstForRule result checkedNonTerminals rule count max  | count>=max = result    
                                        | isTerminal [(rule!!count)] =  result ++ [(rule!!count)]
                                        | (rule!!count) `elem` checkedNonTerminals = if hasEps [(rule!!count)] 
                                            then findFirstForRule result checkedNonTerminals rule (count+1) max
                                            else result
                                        | otherwise = if hasEps [(rule!!count)] 
                                            then findFirstForRule (findFirstForNonTerminal result (checkedNonTerminals ++ [(rule!!count)]) (getRules [(rule!!count)]) 0 (length (getRules [(rule!!count)]))) checkedNonTerminals rule (count+1) max
                                            else findFirstForNonTerminal result (checkedNonTerminals ++ [(rule!!count)]) (getRules [(rule!!count)]) 0 (length (getRules [(rule!!count)]))

findFirstForNonTerminal result checkedNonTerminals rules count max | count>=max = result
                                               | otherwise = findFirstForNonTerminal (findFirstForRule result checkedNonTerminals (rules!!count) 0 (length (rules!!count))) checkedNonTerminals rules (count+1) max

getFirstForNonTerminal' nonTerminal = filter(\x->x /='e') (findFirstForNonTerminal "" nonTerminal (getRules nonTerminal) 0 (length (getRules nonTerminal)))
getFirstForNonTerminal nonTerminal = if hasEps nonTerminal then (getFirstForNonTerminal' nonTerminal) ++ "e" else (getFirstForNonTerminal' nonTerminal)
getFirstForNonTerminalAsSet nonTerminal = Set.fromList (getFirstForNonTerminal nonTerminal) -- нахождение First для нетерминала

getFirstForRule' rule = filter(\x->x /='e') (findFirstForRule "" "" rule 0 (length rule))
getFirstForRule rule = if isEpsEveryNonTerminal rule then (getFirstForRule' rule) ++ "e" else (getFirstForRule' rule)
getFirstForRuleAsSet rule = Set.fromList (getFirstForRule rule) -- нахождене First для правила

------------------------Нахождение follow---------------------------------------------------

findFollow' result checkedNonTerminals nonTerminal nonTerminals_rules count max  | count>=max = result
                                                                            | otherwise = findFollow' (findFollowInRule result checkedNonTerminals nonTerminal (nonTerminals_rules!!count) (getPosition nonTerminal (snd (nonTerminals_rules!!count))) (length (snd (nonTerminals_rules!!count)))) checkedNonTerminals nonTerminal nonTerminals_rules (count+1) max
findFollow nonTerminal = findFollow' "" "" nonTerminal (getNonTerminals_Rules nonTerminal) 0 (length (getNonTerminals_Rules nonTerminal))                                                  

findFollowInRule result checkedNonTerminals nonTerminal nonTerminal_rule position max  | position+1>=max = if List.isInfixOf nonTerminal checkedNonTerminals   
                                                                        then result++"$"
                                                                        else findFollow' (result++"$") (checkedNonTerminals ++ nonTerminal) (fst nonTerminal_rule) (getNonTerminals_Rules (fst nonTerminal_rule)) 0 (length (getNonTerminals_Rules (fst nonTerminal_rule)))
                                                                    | isTerminal [((snd nonTerminal_rule)!!(position+1))] = result ++ [((snd nonTerminal_rule)!!(position+1))]
                                                                    | otherwise = if hasEps [((snd nonTerminal_rule)!!(position+1))]
                                                                        then findFollowInRule (result++(getFirstForNonTerminal [((snd nonTerminal_rule)!!(position+1))])) checkedNonTerminals nonTerminal nonTerminal_rule (position+1) max
                                                                        else result++(getFirstForNonTerminal [((snd nonTerminal_rule)!!(position+1))])

getFollow nonTerminal = Set.fromList (filter(\x->x/='e') (findFollow nonTerminal))  --нахождение Follow      

---------------------------------------Проверка на LL 1--------------------------------------

checkForLL1 nonTerminals count max  | count>=max = True
                                    | length (getRules (nonTerminals!!count))>1 = if checkLL1ForNonTerminal (nonTerminals!!count)
                                        then checkForLL1 nonTerminals (count+1) max
                                        else False
                                    | otherwise = checkForLL1 nonTerminals (count+1) max
finalCheckLL1 = checkForLL1 (Set.toList globalNonTerminals) 0 (length (Set.toList globalNonTerminals)) --проверка на LL(1) для каждого нетерминала

checkLL1ForNonTerminal nonTerminal | hasEps nonTerminal = if length(Set.toList (Set.intersection (getFollow nonTerminal) (getFirstForNonTerminalAsSet nonTerminal)))>0
                                    then False
                                    else True
                                   | otherwise = checkForEveryRules nonTerminal

checkForEveryRules' result rules count max | count>=max = if length result == length (Set.toList (Set.fromList result))
                                                then True
                                                else False
                                           | otherwise = checkForEveryRules' (result ++ (Set.toList (getFirstForRuleAsSet (rules!!count)))) rules (count+1) max
checkForEveryRules nonTerminal = checkForEveryRules' "" (getRules nonTerminal) 0 (length (getRules nonTerminal))

main = do
    print finalCheckLL1