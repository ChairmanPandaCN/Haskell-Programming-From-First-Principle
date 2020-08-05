module Main where

import Test.QuickCheck
import Data.Monoid
import Test.QuickCheck.Gen

semigroupAssoc :: (Eq m,Semigroup m)=>m->m->m->Bool
semigroupAssoc a b c= (a<>(b<>c))==((a<>b)<>c)


data Trivial = Trivial deriving (Eq, Show)

instance Semigroup Trivial where
  (<>) _ _ = Trivial

instance Arbitrary Trivial where
  arbitrary = return Trivial




type TrivAssoc=Trivial->Trivial->Trivial->Bool

newtype Identity a = Identity a deriving (Eq,Show)

instance Semigroup a => Semigroup (Identity a) where
  (<>) (Identity a) (Identity b) = Identity (a <> b)

instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = do
    a <- arbitrary
    return (Identity a)

type IdentityAssoc = Identity String -> Identity String -> Identity String -> Bool

data Two a b = Two a b deriving (Eq, Show)

instance (Semigroup a, Semigroup b) => Semigroup (Two a b) where
  (<>) (Two a b) (Two x y) = Two (a <> x) (b <> y)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    return (Two a b)

type TwoAssoc = Two (Sum Int) String -> Two (Sum Int) String -> Two (Sum Int) String -> Bool

data Three a b c = Three a b c deriving (Eq, Show)

instance (Semigroup a, Semigroup b, Semigroup c) => Semigroup (Three a b c) where
  (<>) (Three a b c) (Three x y z) = Three (a <> x) (b <> y) (c <> z)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (Three a b c)

type ThreeAssoc = Three (Sum Int) String (Product Int) ->Three (Sum Int) String (Product Int) -> Three (Sum Int) String (Product Int) -> Bool

newtype BoolConj = BoolConj Bool deriving (Eq, Show)

instance Semigroup BoolConj where
  (<>) (BoolConj True) (BoolConj True) = BoolConj True
  (<>) _ _ = BoolConj False

instance Arbitrary BoolConj where
  arbitrary = frequency [(1,return $ BoolConj True),(1,return $ BoolConj False)]
    
type BoolConjAssoc = BoolConj -> BoolConj -> BoolConj -> Bool

newtype BoolDisj = BoolDisj Bool deriving (Eq, Show)

instance Semigroup BoolDisj where
  (<>) (BoolDisj False) (BoolDisj False) = BoolDisj False
  (<>) _ _ = BoolDisj True

instance Arbitrary BoolDisj where
  arbitrary = frequency [(1,return $ BoolDisj True),(1,return $ BoolDisj False)]
    
type BoolDisjAssoc = BoolDisj -> BoolDisj -> BoolDisj -> Bool

data Or a b = Fst a | Snd a deriving (Eq, Show)

instance (Arbitrary a , Arbitrary b) => Arbitrary (Or a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    frequency [(1,return $ Fst a),(1,return $ Snd b)]

instance Semigroup (Or a b) where
  (<>) (Fst a) (Snd b) = Snd b
  (<>) (Fst a) (Fst b) = Fst b
  (<>) (Snd a) (Fst b) = Snd a
  (<>) (Snd a) (Snd b) = Snd a

type OrAssoc = Or Int Int -> Or Int Int -> Or Int Int -> Bool

newtype Combine a b = Combine { unCombine :: (a->b)}

instance (CoArbitrary a, Arbitrary b) => Arbitrary (Combine a b) where
  arbitrary = do 
    f <- arbitrary
    return $ Combine f
    
instance (Semigroup b) => Semigroup (Combine a b) where
  (<>) (Combine f) (Combine g) = Combine (\x ->  f x <> g x)

type CombineAssoc =Combine Integer (Sum Integer) -> Combine Integer (Sum Integer) -> Combine Integer (Sum Integer) -> Bool

--combineAssoc' :: (Eq x,Semigroup x,Eq m,Semigroup m)=>m->m->m->x ->Bool
--combineAssoc' a b c x= (a x<>(b x<>c x))==((a x<>b x)<>c x)

f = Combine $ \n -> Sum (n+1)
g = Combine $ \n -> Sum (n-1)

--prop :: Fun String Integer -> Bool
--prop (Fun _ f) = f "monkey" == f "monkey"
test1 = unCombine (f <> g ) $ 0
test2 = unCombine (f <> f ) $ 0


newtype Comp a = Comp { unComp :: a-> a}

instance (CoArbitrary a, Arbitrary a) => Arbitrary (Comp a) where
  arbitrary = do 
    f <- arbitrary
    return $ Comp f

instance Semigroup a => Semigroup (Comp a) where
  (<>) (Comp f) (Comp g) = Comp (\x -> f x <> g x)


f' = Comp $ \n -> n <> Sum 1
g' = Comp $ \n -> n <> Sum (-1)

test3 = unComp (f' <> g') $ Sum 0
test4 = unComp (f' <> f') $ Sum 0

data Validation a b = MyFailure a | MySuccess b deriving (Eq, Show)

instance Semigroup a => Semigroup (Validation a b) where
  (<>) (MySuccess b) (MySuccess _) = MySuccess b
  (<>) (MySuccess b) (MyFailure _) = MySuccess b
  (<>) (MyFailure _) (MySuccess b) = MySuccess b
  (<>) (MyFailure a) (MyFailure a') = MyFailure (a <> a')

instance (Arbitrary a, Arbitrary b) => Arbitrary (Validation a b) where
   arbitrary = do
     a <- arbitrary
     b <- arbitrary
     frequency [(1,return $ MyFailure a),(1,return $ MySuccess b)]

type ValidationAssoc = Validation (Sum Int) (Product Int) -> Validation (Sum Int) (Product Int)->Validation (Sum Int) (Product Int) -> Bool
main::IO()
main= do
  quickCheck(semigroupAssoc::TrivAssoc)
  quickCheck(semigroupAssoc::IdentityAssoc)
  quickCheck(semigroupAssoc::TwoAssoc)
  quickCheck(semigroupAssoc::ThreeAssoc)
  quickCheck(semigroupAssoc::BoolConjAssoc)
  quickCheck(semigroupAssoc::BoolDisjAssoc)
  --quickCheck prop
  --quickCheck(semigroupAssoc::CombineAssoc)
  quickCheck(semigroupAssoc::ValidationAssoc)

