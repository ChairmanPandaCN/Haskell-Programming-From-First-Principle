module Main where
import Test.QuickCheck
import Data.Monoid
import Optional

newtype First' a = First' { getFirst' :: Optional a} deriving (Eq,Show)

first'Gen :: Arbitrary a => Gen (First' a)
first'Gen = do
  a <- arbitrary
  return (First' a)

instance Arbitrary a => Arbitrary (First' a) where
  arbitrary = first'Gen

instance Semigroup a => Semigroup (First' a) where
  (<>) (First' Nada) x = x
  (<>) x (First' Nada) = x
  (<>) (First' x) (First' y) = First' (x <> y)

instance Monoid a => Monoid (First' a) where
  mempty = First' Nada

firstMappend ::Monoid a => First' a -> First' a -> First' a
firstMappend = mappend

type FirstMappend= First' String ->First' String ->First' String ->Bool
type FstId= First' String->Bool
type SecondMappend= First' [Int] ->First' [Int] ->First' [Int] ->Bool

monoidAssoc :: (Monoid a,Eq a) => a -> a -> a -> Bool
monoidAssoc a b c = ((a <> b) <> c) == (a<> (b <> c))

monoidLeftIdentity :: (Eq m, Monoid m) => m -> Bool
monoidLeftIdentity a = (mempty <> a ) == a
monoidRightIdentity :: (Eq m, Monoid m) => m -> Bool
monoidRightIdentity a = (a <> mempty) == a

type SA = String -> String -> String -> Bool
type ListA = [Int] -> [Int] -> [Int] -> Bool
main :: IO ()
main = do
  quickCheck (monoidAssoc :: SA)
  verboseCheck (monoidAssoc :: ListA )
  quickCheck (monoidAssoc :: FirstMappend)
  quickCheck (monoidLeftIdentity :: FstId)
  quickCheck (monoidRightIdentity :: FstId)
  quickCheck (monoidAssoc :: SecondMappend)

