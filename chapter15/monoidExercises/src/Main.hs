module Main where

import Test.QuickCheck
import Data.Monoid
import Test.QuickCheck.Gen

semigroupAssoc :: (Eq m,Semigroup m)=>m->m->m->Bool
semigroupAssoc a b c= (a<>(b<>c))==((a<>b)<>c)

rightIdentity :: (Eq m,Monoid m) => m ->Bool
rightIdentity a = a <> mempty == a

leftIdentity :: (Eq m,Monoid m) => m ->Bool
leftIdentity a = mempty <> a == a

data Trivial = Trivial deriving (Eq, Show)

instance Semigroup Trivial where
  (<>) _ _ = Trivial

instance Monoid Trivial where
  mempty = Trivial
 
instance Arbitrary Trivial where
  arbitrary = return Trivial

type TrivialIdentity = Trivial -> Bool


newtype Identity a = Identity a deriving (Eq,Show)

instance Semigroup a => Semigroup (Identity a) where
  (<>) (Identity a) (Identity b) = Identity (a <> b)

instance Monoid a => Monoid (Identity a) where
  mempty = Identity mempty
instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = do
    a <- arbitrary
    return (Identity a)

type IdentityIdentity = Identity String -> Bool



data Two a b = Two a b deriving (Eq, Show)

instance (Semigroup a, Semigroup b) => Semigroup (Two a b) where
  (<>) (Two a b) (Two x y) = Two (a <> x) (b <> y)

instance (Monoid a, Monoid b) => Monoid (Two a b) where
  mempty = Two mempty mempty

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    return (Two a b)

type TwoIdentity = Two (Sum Int) String -> Bool

data Three a b c = Three a b c deriving (Eq, Show)

instance (Semigroup a, Semigroup b, Semigroup c) => Semigroup (Three a b c) where
  (<>) (Three a b c) (Three x y z) = Three (a <> x) (b <> y) (c <> z)

instance (Monoid a, Monoid b, Monoid c) => Monoid (Three a b c) where
  mempty = Three mempty mempty mempty
instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (Three a b c)

type ThreeIdentity = Three (Sum Int) String (Product Int) -> Bool


newtype BoolConj = BoolConj Bool deriving (Eq, Show)

instance Semigroup BoolConj where
  (<>) (BoolConj True) (BoolConj True) = BoolConj True
  (<>) _ _ = BoolConj False

instance Monoid BoolConj where
  mempty = BoolConj True

instance Arbitrary BoolConj where
  arbitrary = frequency [(1,return $ BoolConj True),(1,return $ BoolConj False)]
    
type BoolConjIdentity = BoolConj-> Bool

newtype BoolDisj = BoolDisj Bool deriving (Eq, Show)

instance Semigroup BoolDisj where
  (<>) (BoolDisj False) (BoolDisj False) = BoolDisj False
  (<>) _ _ = BoolDisj True

instance Monoid BoolDisj where
  mempty = BoolDisj False

instance Arbitrary BoolDisj where
  arbitrary = frequency [(1,return $ BoolDisj True),(1,return $ BoolDisj False)]
    
type BoolDisjIdentity = BoolDisj -> Bool

newtype Combine a b = Combine { unCombine :: (a->b)}

instance (CoArbitrary a, Arbitrary b) => Arbitrary (Combine a b) where
  arbitrary = do 
    f <- arbitrary
    return $ Combine f
    
instance (Semigroup b) => Semigroup (Combine a b) where
  (<>) (Combine f) (Combine g) = Combine (\x ->  f x <> g x)

instance (Monoid b) => Monoid (Combine a b) where
  mempty = Combine mempty

type CombineAssoc =Combine Integer (Sum Integer) -> Combine Integer (Sum Integer) -> Combine Integer (Sum Integer) -> Bool

--combineAssoc' :: (Eq x,Semigroup x,Eq m,Semigroup m)=>m->m->m->x ->Bool
--combineAssoc' a b c x= (a x<>(b x<>c x))==((a x<>b x)<>c x)

f = Combine $ \n -> Sum (n+1)
g = Combine $ \n -> Sum (n-1)

--prop :: Fun String Integer -> Bool
--prop (Fun _ f) = f "monkey" == f "monkey"
test1 = unCombine (mappend f mempty) $ 1

newtype Comp a = Comp { unComp :: a-> a}

instance (CoArbitrary a, Arbitrary a) => Arbitrary (Comp a) where
  arbitrary = do 
    f <- arbitrary
    return $ Comp f

instance Semigroup a => Semigroup (Comp a) where
  (<>) (Comp f) (Comp g) = Comp (\x -> f x <> g x)

instance (Monoid a) => Monoid (Comp a) where
  mempty = Comp mempty

f' = Comp $ \n -> n <> Sum 1


test3 = unComp (mappend f' mempty) $ Sum 0

newtype Mem s a = Mem {runMem :: s-> (a,s)}

instance Semigroup a => Semigroup (Mem s a) where
  (<>) = undefined

instance Monoid a => Monoid (Mem s a) where
  mempty =  undefined

funtion = Mem $ \s -> ("hi",s+1)

mem = do
  let rmzero = runMem mempty 0
      rmleft = runMen (function <> mempty) 0
      rmright = runMen (mempty <> function ) 0
  print $ rmleft
  print $ rmright
  print $ (rmzero :: (String,Int))
  print $ rmleft == runMen function 0
  print $ rmright == runMen function 0

main::IO()
main= do
  quickCheck(leftIdentity::TrivialIdentity)
  quickCheck(rightIdentity::TrivialIdentity)
  quickCheck(leftIdentity::IdentityIdentity)
  quickCheck(rightIdentity::IdentityIdentity)
  quickCheck(leftIdentity::TwoIdentity)
  quickCheck(rightIdentity::TwoIdentity)
  quickCheck(leftIdentity::ThreeIdentity)
  quickCheck(rightIdentity::ThreeIdentity)
  quickCheck(leftIdentity::BoolConjIdentity)
  quickCheck(rightIdentity::BoolConjIdentity)
  quickCheck(leftIdentity::BoolDisjIdentity)
  quickCheck(rightIdentity::BoolDisjIdentity)
  --quickCheck prop
  --quickCheck(semigroupAssoc::CombineAssoc)
  quickCheck(leftIdentity::ValidationIdentity)
  quickCheck(rightIdentity::ValidationIdentity)

