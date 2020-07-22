f :: a -> a
f x = x

tensDigit :: Integral a => a -> a
tensDigit x = d
    where xLast = x `div` 10
          d     = xLast `mod` 10

tensDigit' :: Integral a => a -> a
tensDigit' x = d
    where (quo,rem) = x `divMod` 100
          d     =  rem `div` 10

hundredsDigit :: Integral a => a -> a
hundredsDigit x = d
    where (quo,rem) = x `divMod` 1000
          d     =  rem `div` 100

foldBool :: a -> a -> Bool -> a
foldBool x y bool = if bool then y else x


roundTrip :: (Show a, Read b) => a -> b
roundTrip a  = read (show a)


roundTrip' :: (Show a, Read a) => a -> a
roundTrip' = read . show 


main = do
    print (roundTrip 4)
    print (roundTrip' 4)
    print (id 4)