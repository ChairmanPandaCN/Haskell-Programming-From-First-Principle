module Palindrones where

import Control.Monad(forever)
import System.Exit
import Data.Char

palindrome::IO()
palindrome= forever $ do
    putStr "Give a string : "
    line1<-getLine
    let tmp = map toLower $ filter isLetter line1
    if tmp == reverse tmp 
    then putStrLn "It's a palindrome!"
    else do 
        putStrLn "Nope!"
        exitFailure
        
main :: IO ()
main = do
    palindrome
    return ()