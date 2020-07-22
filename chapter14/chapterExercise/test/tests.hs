module ChapterExerciseTest where

import Test.Hspec
import Test.QuickCheck
import Exercises


main :: IO ()
main = do
    hspec $ do
    describe "propertyListOrdered" $ do
        it "For any sorted list, preceding elements are samller or equal to ones after" $ do
            property $ \x ->propertyListOrdered (x:: [Int])
    
    describe "Plus" $ do
        it "has associativity" $ do
            property $ \x y z->  plusAssociativity (x:: Int) (y:: Int) (z:: Int)
    
    describe "doubleReverse" $ do
        it "is equal to Identity function" $ do
            property $  \x -> doubleReverse (x::[Int])
    
    describe "Dollar Notation" $ do
        it "do nothing except the fact that it change the order of executions" $ do
            property $ \ y -> dollarNotation (1+) (y::Int)

    describe "dot Notation" $ do
        it "combines 2 functions into a, the output of the latter is the input of the former" $ do
            property $ \z -> dotNotation (1+) (2+) (z::Int)
    
    describe "Question91" $ do
        it "proves foldr (:) not exactly have the same functionality as (++)" $ do
            property $ \x y-> question91 (x ::[Int]) (y ::[Int])

    describe "Question 10" $ do
        it "fails to prove f n xs = length (take n xs) == n" $ do
            property $ \x xs -> question10 (x::Int) (xs::[Int])
    describe "Question92" $ do
        it "proves foldr (++) [] have the same functionality as concat" $ do
            property $ \x -> question92 (x ::[String]) 

    describe "SquareIdentity" $ do
        it "hold false for numbers whose square root is not an Int " $ do
            property $ \x -> squareIdentity (x::Double)

    describe "Idepotence1" $ do
        it "verifies capitalizeWord is a idempotenet function" $ do
            property $ \x -> idempotence1 (x::String)
    
    describe "Idepotence2" $ do 
         it "verifies Sort is a idempotenet function" $ do
            property $ \x -> idempotence2 (x::[Int])