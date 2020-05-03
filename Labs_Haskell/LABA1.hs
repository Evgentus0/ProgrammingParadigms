import qualified Data.Set as Set

main = do
  let list=[1,2,3,4,5,6,5,6,5,7,7,7,8,6]
  let newList=filter (\x -> length(filter (==x) list)==3) list
  let newSet=Set.fromList newList
  print(newList)
  print(newSet)