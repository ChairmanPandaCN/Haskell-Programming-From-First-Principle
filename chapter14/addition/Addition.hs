module Addition where

import Test.Hspec
import Test.QuickCheck

genBool :: Gen Bool
genBool = choose (False,True)

genBool' :: Gen Bool
genBool' = elements [False,True]

genOrdering :: Gen Ordering
genOrdering = elements [LT,EQ,GT]

data Identity a = Identity a deriving (Eq,Show)

identityGen ::Arbitrary a => Gen (Identity a)
identityGen = do
    a <- arbitrary
    return (Identity a)

instance Arbitrary a => Arbitrary (Identity a) where 
   arbitrary = identityGen

data Pair a b = Pair a b deriving (Eq,Show)
pairGen :: (Arbitrary a, Arbitrary b) => Gen (Pair a b)
pairGen = do
    a <- arbitrary
    b <- arbitrary
    return (Pair a b)
instance (Arbitrary a, Arbitrary b) => Arbitrary (Pair a b) where
    arbitrary = pairGen


data Sum a b = First a | Second b deriving (Eq,Show)
sumGenEqual :: (Arbitrary a, Arbitrary b) => Gen (Sum a b)
sumGenEqual = do
    a <- arbitrary
    b <- arbitrary 
    oneof [return $ First a , return $ Second b]

sumGenFirstPls :: (Arbitrary a, Arbitrary b) => Gen (Sum a b)
sumGenFirstPls = do
    a <- arbitrary
    b <- arbitrary
    frequency [(10,return $ First a),(1, return$ Second b)]

instance (Arbitrary a,Arbitrary b) => Arbitrary (Sum a b) where
    arbitrary = sumGenFirstPls

genTuple :: (Arbitrary a,Arbitrary b) => Gen (a,b)
genTuple = do
    a <- arbitrary
    b <- arbitrary
    return (a,b)

genTripleTuple :: (Arbitrary a,Arbitrary b,Arbitrary c) => Gen (a,b,c)
genTripleTuple = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (a,b,c)


genEither :: (Arbitrary a, Arbitrary b) => Gen (Either a b)
genEither = do
    a <- arbitrary
    b <- arbitrary
    elements [Left a,Right b]

genMaybe :: Arbitrary a => Gen (Maybe a)
genMaybe = do 
    a <- arbitrary
    elements [Nothing,Just a]

genMaybe' :: Arbitrary a => Gen (Maybe a)
genMaybe' = do
    a <- arbitrary
    frequency [(4,return Nothing),(3,return (Just a))]

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
        
