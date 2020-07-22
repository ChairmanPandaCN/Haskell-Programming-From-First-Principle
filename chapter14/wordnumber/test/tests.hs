module WordNumberTest where

import Test.Hspec
import WordNumber
import Test.QuickCheck


main :: IO ()
main = do
    hspec $ do
    describe "digitToWord" $ do
        it "returns Zero for 0" $ do
            digitToWord 0 `shouldBe` "Zero"
        it "returns One for 1" $ do
            digitToWord 1 `shouldBe` "One"
    
    describe "digits" $ do
        it "returns [1,2] for 12" $ do
            digits 12 `shouldBe` [1,2]
        it "returns [0] for 0" $ do
            digits 0 `shouldBe` [0]
    
    describe "wordNumber" $ do
        it "returns One-Two for 12" $ do
            wordNumber 12 `shouldBe` "One-Two"
