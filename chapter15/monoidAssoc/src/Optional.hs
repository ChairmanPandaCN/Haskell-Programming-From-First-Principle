module Optional where

import Data.Monoid
import Test.QuickCheck.Gen
import Test.QuickCheck

data Optional a = Nada | Only a deriving (Eq,Show)

instance Semigroup a => Semigroup (Optional a) where
    (<>) Nada Nada = Nada
    (<>) (Only x) (Only y) = Only (x <> y)
    (<>) Nada x = x
    (<>) x Nada = x

instance Monoid a => Monoid (Optional a) where
     mempty = Nada

optionalGen :: (Arbitrary a ) => Gen (Optional a)
optionalGen = do
    a <- arbitrary
    oneof [return $ Nada, return $ Only a]

instance Arbitrary a => Arbitrary (Optional a) where
    arbitrary = optionalGen
onlySum = Only (Sum 1)
onlyFour = Only (Product 4)
onlyTwo = Only (Product 2)
