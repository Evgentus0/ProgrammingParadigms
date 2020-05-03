

sepHelp xs num par (firstAr, secondAr)| num>=length xs= (firstAr, secondAr)
                                      | par = sepHelp xs (num+1) False (firstAr++[xs!!num], secondAr)
                                      | not par = sepHelp xs (num+1) True (firstAr, secondAr++[xs!!num])

separate x = sepHelp x 0 True ([], [])

main = do
  let ar=[1,2,3,4,5,6,7,8,9,100]
  let res = separate ar
  print(res)