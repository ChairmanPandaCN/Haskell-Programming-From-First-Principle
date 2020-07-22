module Cipher where 

import Data.Char
import System.IO (BufferMode(NoBuffering), hSetBuffering, stdout)
import Text.Read(readMaybe)
import Data.Maybe

caesar :: Int -> String -> String
caesar _ [] = []
caesar offset (x:xs) = shift offset x : caesar offset xs
    where shift :: Int -> Char -> Char
          shift offset x = chr . (+97) $ (ord x - 97 + offset) `mod` 26

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering
    putStr "Give a string : "
    plainText <- getLine
    putStr "Give a mask : "
    maskString <- getLine
    let mask = readMaybe maskString :: Maybe Int
    case isJust mask of
        true -> putStrLn $ caesar (fromJust mask) plainText
        false -> putStrLn "Invalid mask" 