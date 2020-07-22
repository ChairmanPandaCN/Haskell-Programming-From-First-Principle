module Qcexample where

import Test.Hspec
import Test.QuickCheck

sayHello :: IO()
sayHello = putStrLn "Hello"

dividedBy :: Integral a => a -> a -> (a,a)
dividedBy num denom = go num denom 0
    where go n d count
            | n < d = (count,n)
            | otherwise = go (n-d) d (count+1)


main :: IO ()
main = hspec $ do
    describe "Addition" $ do
        it "1 + 1 is greater than 1" $ do
            (1+1) > 1 `shouldBe` True
        it "2 + 2 is equal to 4" $ do
            (2+2) ==4 `shouldBe` True
        it "15 / 3 is equal to (5,0)" $ do
            (15 `dividedBy` 3) == (5,0) `shouldBe` True
        it "22 / 3 is equal to (7,1)" $ do
            (22 `dividedBy` 3) == (7,1) `shouldBe` True
        it "x + 1 is greater than x" $ do
            property $ \x -> x+1 > (x::Int) 
        
