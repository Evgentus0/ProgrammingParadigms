is_square::Int->Bool
is_square n = sq * sq == n
    where sq = floor $ sqrt $ (fromIntegral n::Double)

getIndex::[Int]->Int->[Int]->[Int]

getIndex xs num res | num>=length xs= res
                    | not (is_square num) = getIndex xs (1+num) res
                    | is_square num = getIndex xs (1+num) (res++[xs!!num])

main = do
  let ar=[0,1,2,3,4,5,6,7]
  let res = getIndex ar 0 []
  print(res)