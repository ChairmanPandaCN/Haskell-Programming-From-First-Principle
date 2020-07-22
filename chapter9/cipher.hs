module Cipher where 

import Data.Char


caesar :: Int -> String -> String
caesar _ [] = []
caesar offset (x:xs) = shift offset x : caesar offset xs
    where shift :: Int -> Char -> Char
          shift offset x = chr . (+97) $ (ord x - 97 + offset) `mod` 26


unCaesar :: Int -> String -> String
unCaesar _ [] = []
unCaesar offset (x:xs) = unShift offset x : unCaesar offset xs
    where unShift :: Int -> Char -> Char
          unShift offset x = chr . (+97) $ (ord x - 97 + offset) `mod` 26
