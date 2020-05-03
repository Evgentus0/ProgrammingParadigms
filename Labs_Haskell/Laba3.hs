isMinExtr::[(Int, Int)]->Int->Bool

isMinExtr [] number = error "Empty list!"

isMinExtr xs number | number<0||number>=length xs = error "Index out of range!"
                    | length xs==1 = error "Only one element in list!"
                    | number==0 = if(fst((xs!!number))<(fst(xs!!(number+1)))) then True else False
                    | number == (length xs - 1) = if((fst(xs!!number))<(fst(xs!!(number-1)))) then True else False
                    | otherwise = if((fst(xs!!number))<(fst(xs!!(number+1)))&&(fst(xs!!number))<(fst(xs!!(number-1)))) then True else False


getMinExtr::[(Int, Int)]->Int->[(Int, Int)]->[(Int, Int)]

getMinExtr [] number result = error "Empty list!"

getMinExtr xs number result | number>= length xs = result
                            | isMinExtr xs number = getMinExtr xs (number+1) (result++[xs!!number])
                            | not (isMinExtr xs number) = getMinExtr xs (number+1) result

main  = do
  let arr = zip [5,4,2,8,3,1,6,9,5] [0..]
  let test = getMinExtr arr  0 []
  print test