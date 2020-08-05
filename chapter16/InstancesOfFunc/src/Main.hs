{-# LANGUAGE ScopedTypeVariables #-}
module Main where

import Test.QuickCheck

myfunctorIdentity :: (Functor f,Eq (f a)) => f a-> Bool 
myfunctorIdentity f = fmap id f == f

functorCompose :: (Eq (f c), Functor f) => Fun a b -> Fun b c-> f a -> Bool
functorCompose (Fun _ f) (Fun _ g) x = (fmap g (fmap f x)) == (fmap (g . f) x)

type IntToString = Fun Int String
type StringToChar = Fun String Char

newtype Identity a = Identity a deriving (Eq,Show)

instance (Arbitrary a) => Arbitrary (Identity a) where
  arbitrary = do
    a <- arbitrary
    return (Identity a)

instance Functor Identity where
  fmap f (Identity x) = Identity (f x)

type IdentityIdentity = Identity Int -> Bool
type IdentityCompose = IntToString -> StringToChar -> Identity Int -> Bool

data Pair a = Pair a a deriving (Eq,Show)

instance (Arbitrary a) => Arbitrary (Pair a) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    return (Pair a b)

instance Functor Pair where
  fmap f (Pair a b) = Pair (f a) (f b)

type PairIdentity = Pair Int -> Bool
type PairCompose = IntToString -> StringToChar -> Pair Int -> Bool

data Two a b = Two a b deriving (Eq, Show)

instance (Arbitrary a,Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    return (Two a b)

instance Functor (Two a) where
  fmap f (Two a b) = Two a (f b)

type TwoIdentity = Pair Int -> Bool
type TwoCompose = IntToString -> StringToChar -> Pair Int -> Bool

data Three a b c = Three a b c deriving (Eq,Show)

instance (Arbitrary a, Arbitrary b,Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (Three a b c)

instance Functor (Three a b) where
  fmap f (Three a b c) = Three a b (f c)

type ThreeIdentity = Three Int Int Int -> Bool
type ThreeCompose = IntToString -> StringToChar -> Three Int Int Int -> Bool

data Three' a b = Three' a b b deriving (Eq,Show)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Three' a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (Three' a b c)

instance Functor (Three' a) where
  fmap f (Three' a b c) = Three' a (f b) (f c)

type Three'Identity = Three' Int Int-> Bool
type Three'Compose = IntToString -> StringToChar -> Three' Int Int -> Bool


data Four a b c d = Four a b c d deriving (Eq,Show)

instance (Arbitrary a, Arbitrary b, Arbitrary c,Arbitrary d) => Arbitrary (Four a b c d) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    d <- arbitrary
    return (Four a b c d)

instance Functor (Four a b c) where
  fmap f (Four a b c d) = Four a b c (f d)

type FourIdentity = Four Int Int Int Int -> Bool
type FourCompose = IntToString -> StringToChar -> Four Int Int Int Int -> Bool


data Four' a b = Four' a a a b deriving (Eq, Show)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Four' a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    d <- arbitrary
    return (Four' a b c d)

instance Functor (Four' a) where
  fmap f (Four' a b c d) = Four' a b c (f d)

type Four'Identity = Four' Int Int -> Bool
type Four'Compose = IntToString -> StringToChar -> Four' Int Int-> Bool
 
data Possibly a = LolNope | Yeppers a deriving (Eq,Show)

instance Functor Possibly where
  fmap _ LolNope = LolNope
  fmap f (Yeppers a) = Yeppers (f a)



liftedInc::(Functor f,Num b) =>f b->f b
liftedInc = fmap (+1)
liftedShow::(Functor f,Show a) =>f a->f String
liftedShow= fmap show


data Sum a b = First a | Second b deriving (Eq, Show)

instance Functor (Sum a) where
  fmap _ (First a) = First a
  fmap f (Second b) = Second (f b)



newtype Constant a b = Constant {getConstant :: a} deriving (Eq, Show)

instance Functor (Constant m) where
  fmap _ (Constant v) = Constant v

instance (Arbitrary a, Arbitrary b) => Arbitrary (Constant a b)where
  arbitrary = do
    a <- arbitrary
    --b <- arbitrary
    return $ Constant a


type ConstantIdentity = Constant Int Int -> Bool
type ConstantCompose = IntToString -> StringToChar -> Constant Int Int-> Bool
 

data Wrap f a = Wrap (f a) deriving (Eq,Show)

instance Functor f => Functor (Wrap f) where
  fmap f (Wrap fa) = Wrap (fmap f fa)
  

getInt :: IO Int
getInt = fmap read getLine

get :: IO Float
get = fmap read getLine
main :: IO ()
main = do
  quickCheck (myfunctorIdentity::IdentityIdentity)
  quickCheck (functorCompose::IdentityCompose)
  quickCheck (myfunctorIdentity::PairIdentity)
  quickCheck (functorCompose::PairCompose)
  quickCheck (myfunctorIdentity::TwoIdentity)
  quickCheck (functorCompose::TwoCompose)
  quickCheck (myfunctorIdentity::ThreeIdentity)
  quickCheck (functorCompose::ThreeCompose)
  quickCheck (myfunctorIdentity::Three'Identity)
  quickCheck (functorCompose::Three'Compose)
  quickCheck (myfunctorIdentity::FourIdentity)
  quickCheck (functorCompose::FourCompose)
  quickCheck (myfunctorIdentity::Four'Identity)
  quickCheck (functorCompose::Four'Compose)
  quickCheck (myfunctorIdentity::ConstantIdentity)
  quickCheck (functorCompose::ConstantCompose)