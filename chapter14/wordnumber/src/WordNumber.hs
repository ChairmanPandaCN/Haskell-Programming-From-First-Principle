module WordNumber where

import Data.List

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
    where go w count list
            |count /= 0 = go (w `div` 10) (count-1) (w `mod` 10 : list)
            |otherwise =  list

wordNumber :: Int -> String
wordNumber n = intercalate "-" $ map digitToWord (digits n) 