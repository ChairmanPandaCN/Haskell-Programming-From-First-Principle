module VigenereCipher where


import Data.Char
import System.IO (BufferMode(NoBuffering), hSetBuffering, stdout)
import Text.Read(readMaybe)
import Data.Maybe

vigenereCipher :: String -> String -> String
vigenereCipher plainText mask= vigenere plainText extendedMask
    where extendedMask = take (length plainText) $ cycle mask

vigenere :: String -> String -> String
vigenere [] _ = []
vigenere (x:xs) (y:ys) =shift offset x : vigenere xs ys
    where offset = ord y - 65
          shift :: Int -> Char -> Char
          shift offset x = chr . (+65) $ (ord x - 65 + offset) `mod` 26

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering
    putStr "Give a string : "
    plainText <- getLine
    putStr "Give a mask : "
    maskString <- getLine
    putStrLn $ vigenereCipher plainText maskString
    return ()


    