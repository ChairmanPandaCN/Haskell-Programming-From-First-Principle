module Main where


import Test.Hspec
import Test.QuickCheck
import Exercises

main :: IO ()
main = do
  sample' (arbitrary :: Gen Fool)
  
