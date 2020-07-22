import Data.Char

eftBool :: Bool -> Bool -> [Bool]
eftBool a b
    |a < b = a : eftBool (succ a) b
    |a == b = a : []
    |otherwise = []

eftOrd :: Ordering -> Ordering -> [Ordering]
eftOrd a b
    |a < b = a : eftOrd (succ a) b
    |a == b = a : []
    |otherwise = []

eftInt :: Integer -> Integer -> [Integer]
eftInt a b
    |a < b = a : eftInt (succ a) b
    |a == b = a : []
    |otherwise = []

eftChar :: Char -> Char -> [Char]
eftChar a b
    |a < b = a : eftChar (succ a) b
    |a == b = a : []
    |otherwise = []

myWords :: String -> [String]
myWords [] = []
myWords xs = aWord : myWords rest
    where aWord = takeWhile (/=' ') xs
          rest = dropWhile (==' ') $ dropWhile (/=' ') xs

firstSen = "Tyger Tyger, burning bright\n"
secondSen = "In the forests of the night\n"
thirdSen = "What immortal hand or eye\n"
fourthSen = "Could frame thy fearful symmetry"

sentences = firstSen ++ secondSen ++ thirdSen ++ fourthSen

myLines :: String -> [String]
myLines [] = []
myLines xs = aWord : myLines rest
    where aWord = takeWhile (/='\n') xs
          rest = dropWhile (=='\n') $ dropWhile (/='\n') xs

mySqr = [ x^2 | x<-[1..5]]
myCube = [ y^3 | y<- [1..5]]

blah = enumFromTo 'a' 'z'

threeMultiple x = x `mod` 3 == 0

filter1 = filter (\x-> x `mod` 3 ==0) [1..30]
filter1' = filter threeMultiple [1..30]

filter2 = length $ filter (\x-> x `mod` 3 ==0) [1..30]

filter3 = 
    filter (\x-> x /= "the" && x /= "an" && x /= "a")  $ words "the brown dog was a goof"


myZip _ [] = []
myZip [] _ = []
myZip (x:xs) (y:ys) = (x,y) : myZip xs ys


myZipWith _ _ [] = []
myZipWith _ [] _ = []
myZipWith f (x:xs) (y:ys) = f x y : myZipWith f xs ys

myZip' xs ys = myZipWith (,) xs ys

upperHead :: String -> Char
upperHead = toUpper . head


myOr :: [Bool] -> Bool
myOr [] = False
myOr (x:xs) = x || myOr xs

myAny :: (a -> Bool) -> [a] -> Bool
myAny pred xs = and $ map pred xs


myElem ::(Eq a) => a -> [a] ->Bool
myElem _ [] = False
myElem target (x:xs)
    | target == x = True
    | otherwise = myElem target xs

myElem' :: (Eq a) => a -> [a] ->Bool
myElem' target xs = any (\x-> x == target ) xs

myReverse :: [a] -> [a]
myReverse (x:[]) = [x]
myReverse (x:xs) = myReverse xs ++ (x:[])

myReverse' :: [a] -> [a]
myReverse' xs = foldl (\acc x -> x : acc) [] xs


squish :: [[a]] -> [a]
squish [] = []
squish (x:xs) = x ++ squish xs


squishMap :: (a->[b]) -> [a] -> [b]
squishMap f xs = squish $ map f xs
 
squishAgain :: [[a]] -> [a]
squishAgain xs = squishMap id xs

myMaximumBy :: (a->a->Ordering) -> [a] -> a
myMaximumBy comp (x:xs) = foldr (\acc x -> if comp acc x == GT then acc else x ) x xs

myMinimumBy :: (a->a->Ordering) -> [a] -> a
myMinimumBy comp (x:xs) = foldr (\acc x -> if comp acc x /= GT then acc else x ) x xs

myMinimum :: (Ord a) => [a] -> a
myMinimum = myMinimumBy compare


myMaximum :: (Ord a) => [a] -> a
myMaximum = myMaximumBy compare