import Data.Char

vigenereCipher :: String -> String -> String
vigenereCipher plainText mask = vigenere plainText extendedMask
    where extendedMask = take (length "MEETATDAWM") $ cycle "ALLY"

vigenere :: String -> String -> String
vigenere [] _ = []
vigenere (x:xs) (y:ys) =shift offset x : vigenere xs ys
    where offset = ord y - 65
          shift :: Int -> Char -> Char
          shift offset x = chr . (+65) $ (ord x - 65 + offset) `mod` 26


isSubsetOf :: (Eq a) => [a] -> [a] -> Bool
isSubsetOf xs ys = and $ map (`elem` ys) xs


capitalizeWords :: String -> [(String,String)]
capitalizeWords [] =[([],[])]
capitalizeWords  xs=  map f $ words xs
    where f (x:xs) = (x:xs,toUpper x:xs)

    