module Exercises where

import Test.Hspec
import Test.QuickCheck
import Data.List
import Data.Char


propertyListOrdered :: (Ord a) => [a] -> Bool
propertyListOrdered xs = 
    snd $ foldr go (Nothing,True) (sort xs)
        where go _ status@(_,False) = status
              go y (Nothing,t) = (Just y,t)
              go y (Just x,t) = (Just y, x>=y)

plusAssociativity :: (Integral a) => a -> a -> a -> Bool
plusAssociativity x y z = x + (y+z) == (x + y) + z

exponentAssociativity :: (Integral a) => a -> a -> a -> Bool
exponentAssociativity x y z = x ^ (y ^ z) == (x ^ y) ^ z

doubleReverse :: (Eq a) => [a] -> Bool
doubleReverse xs = (id xs) == (reverse . reverse $ xs) 

dollarNotation :: (Show b,Eq b) => (a->b) -> a -> Bool
dollarNotation f a = f a == (f $ a)

dotNotation :: (Show a,Eq a) => (c->a) -> (b->c) -> b -> Bool
dotNotation f1 f2 x = (f1 . f2) x == f1 (f2 x)

question91 :: (Eq a) => [a] -> [a] -> Bool
question91 xs ys = foldr (:) xs ys == (++) xs ys

question92 :: (Eq a) => [[a]] -> Bool
question92 xs  = foldr (++) [] xs == concat xs

question10 :: Int -> [a] -> Bool
question10 n xs= length (take n xs) == n

--readShow :: (Read a,Show a) => a -> Bool
--readShow x = (read (show x)) == x

square :: Double -> Double
square x = x * x

squareIdentity :: Double -> Bool
squareIdentity x = (square . sqrt $ x) == x  

twice :: (a->a) -> a -> a
twice f = f . f

fourTimes :: (a->a) -> a -> a
fourTimes = twice . twice

capitalizeWords :: String -> String
capitalizeWords [] = []
capitalizeWords (x:xs) = toUpper x : xs 

idempotence1 :: String -> Bool
idempotence1 xs = (capitalizeWords xs == twice capitalizeWords xs) && (capitalizeWords xs == fourTimes capitalizeWords xs)


idempotence2 :: (Ord a) => [a] -> Bool
idempotence2 xs = (sort xs == twice sort xs) && (sort xs == fourTimes sort xs)


data Fool = Fulse
        | Frue deriving (Eq,Show)


randomFool :: Gen Fool
randomFool = do
    oneof [return $ Fulse,return $ Frue]

randomFool' :: Gen Fool
randomFool' = do
    frequency [(2,return $ Fulse),(1,return $ Frue)]

instance Arbitrary Fool where
    arbitrary = randomFool'


caesar :: Int -> String -> String
caesar _ [] = []
caesar offset (x:xs) = shift offset x : caesar offset xs
    where shift :: Int -> Char -> Char
          shift offset x = chr . (+97) $ (ord x - 97 + offset) `mod` 52

vigenereCipher :: String -> String -> String
vigenereCipher plainText mask= vigenere plainText extendedMask
    where extendedMask = take (length plainText) $ cycle mask

vigenere :: String -> String -> String
vigenere x [] = x
vigenere [] _ = []
vigenere (x:xs) (y:ys) =shift offset x : vigenere xs ys
    where offset = ord y - 65
          shift :: Int -> Char -> Char
          shift offset x = chr . (+65) $ (ord x - 65 + offset) `mod` 26

decodeVigenere :: String -> String -> String
decodeVigenere x [] = x
decodeVigenere [] _ = []
decodeVigenere (x:xs) (y:ys) =shift offset x : decodeVigenere xs ys
    where offset = ord y - 65
          shift :: Int -> Char -> Char
          shift offset x = chr . (+65) $ ((negate $ ord x) - 65 + offset) `mod` 26

decodeVigenereCipher :: String -> String -> String
decodeVigenereCipher plainText mask= decodeVigenere plainText extendedMask
    where extendedMask = take (length plainText) $ cycle mask

caesarCheck :: Int -> String -> Bool
caesarCheck offset string = (caesar (-offset) $ caesar offset (filter isAsciiLower string)) == (filter isAsciiLower string)

-- vigenereCipher wouldn't return the same data after encoding and decoding a string, because the probability of getting an empty mask exists.
vigenereCheck ::  String -> String -> Bool
vigenereCheck xs ys = (decodeVigenereCipher (vigenereCipher target mask) mask) == target
    where target = filter isAsciiLower xs
          mask = filter isAsciiLower ys