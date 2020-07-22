import Data.List(intercalate)
applyTimes :: (Eq a, Num a ) => a -> (b->b) ->b -> b

applyTimes 0 f b = b
applyTimes n f b = f . applyTimes (n-1) f $ b



fibonacci :: Integer -> Integer
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci x = fibonacci (x-2) + fibonacci (x-1)


cattyConny :: String -> String -> String
cattyConny x y = x ++ " mrow" ++ y

flippy = flip cattyConny

appendCatty = cattyConny "woops"
frappe = flippy "haha"

recursiveSum :: (Eq a, Num a) => a -> a
recursiveSum 1 = 1
recursiveSum x = x + recursiveSum (x-1)


rec_Mul_Using_Sum :: (Integral a ) => a -> a -> a
rec_Mul_Using_Sum x 1 = x
rec_Mul_Using_Sum x y = x + rec_Mul_Using_Sum x (y-1)


dividedBy :: (Integral a) => a -> a -> (a,a)
dividedBy num denom = go num denom 0
    where go n d count
            |n < d = (count,n)
            |otherwise = go (n-d) d (count+1)


mc91 n
    | n > 100 = n -10
    | otherwise = (mc91.mc91) $ (n+11)


digitToWord :: Int -> String
digitToWord x
    | x == 1 = "One"
    | x == 2 = "Two"
    | x == 3 = "Three"
    | x == 4 = "Four"
    | x == 5 = "Five"
    | x == 6 = "Six"
    | x == 7 = "Seven"
    | x == 8 = "Eight"
    | x == 9 = "Nine"
    | otherwise = "Zero"

digits :: Int -> [Int]
digits n = go n (length . show $ n) []
    where go n count list
            |count /= 0 = go (n `div` 10) (count-1) (n `mod` 10 : list)
            |otherwise =  list

wordNumber :: Int -> String
wordNumber n = intercalate "-" $ map digitToWord (digits n) 