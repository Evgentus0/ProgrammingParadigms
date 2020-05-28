n = 23 --6 8 3

f6 :: Double -> Maybe Double
f6 x = if (x*x - n*x + 1) /= 0 
        then Just (1 / (x*x - n*x + 1))
        else Nothing

f8 :: Double -> Maybe Double
f8 x = if (x > (1/n)) 
        then Just (logBase 10 (x - 1/n))
        else Nothing

f3 :: Double -> Maybe Double
f3 x = if ((x>0) &&  (( logBase 10 x + sqrt n) /= 0))
        then Just (1 / ((logBase 10 x) + (sqrt n)))
        else Nothing

f >=> g = \x -> (f x >>= g)

h :: Double -> Maybe Double
h = f3 >=> f8 >=> f6

h_do :: Double -> Maybe Double
h_do x = do 
           c1 <- f3 x
           c2 <- f8 c1
           f6 c2    
