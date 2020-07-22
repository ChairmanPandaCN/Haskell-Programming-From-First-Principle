import Data.Time
import Data.Typeable

foldExample = foldr (\x y -> concat ["(",x,"+",y,")"]) "0" $ map show [1..5]




data DataBaseItem = DbString String
                  | DbNumber Integer
                  | DbDate UTCTime
                  deriving (Eq,Ord, Show)

theDataBase :: [DataBaseItem]
theDataBase = [DbDate (UTCTime (fromGregorian 1911 5 1)(secondsToDiffTime 34123)),DbNumber 9001, DbString "Hello World!",DbDate(UTCTime (fromGregorian 1921 5 1)(secondsToDiffTime 34123)),DbDate (UTCTime (fromGregorian 2020 5 1)(secondsToDiffTime 34123))]

filterDbDate :: [DataBaseItem]-> [UTCTime]
filterDbDate xs = foldr go [] xs
    where go (DbDate y) acc = y : acc
          go _ acc = acc

mostRecent :: [DataBaseItem] -> UTCTime
mostRecent xs = maximum $ filterDbDate xs


filterDbNumber :: [DataBaseItem] -> [Integer]
filterDbNumber = foldr go []
    where go (DbNumber x) acc = x :acc
          go _ acc = acc

avgDB :: [DataBaseItem] -> Double
avgDB xs = sum lists / itsLength 
    where lists = map (fromIntegral) $ filterDbNumber xs
          itsLength = fromIntegral . length  $ lists



whetherDbDate :: DataBaseItem -> Bool
whetherDbDate (DbDate _ ) = True
whetherDbDate _  =  False


--Dbtraverse :: [DataBaseItem] -> IO()
dbtraverse [] = return ()
dbtraverse (x:xs) = do
    putStrLn(show $ typeOf x)
    dbtraverse xs


fac n = foldr (\x g n -> g (x*n)) id [1..n] 1


fibs = 1 : scanl (+) 1 fibs
fibsN x = fibs !! x

take20fibs = take 20 fibs

takeLess100fibs = takeWhile (<100) fibs


scanFac  = scanl fac 1 [1..]
    where fac 1 1 = 1
          fac acc x =  acc * x


stops = "pbtdkg"
vowels = "aeiou"

stop_vowel_stop = [(x,y,z)| x<-stops,y<-vowels,z<-stops]

stop_vowel_stop_P_start =  [(x,y,z)| x<-stops,y<-vowels,z<-stops, x == 'p']


myOr :: [Bool] -> Bool
myOr = foldr (||) False

--myAny :: (a -> Bool) -> [a] -> Bool
--myAny f xs = foldr (\x b -> f x || b ) False xs

myAny :: (a -> Bool) -> [a] -> Bool
myAny p xs = myOr $ map p xs


myElem :: Eq a => a -> [a] -> Bool
myElem y = foldr go False
    where go x acc = x == y || acc

myElem' :: Eq a => a -> [a] -> Bool
myElem' y = myAny (==y) 

myReverse :: [a] -> [a]
myReverse = foldl (flip (:)) [] 


myMap :: (a->b) -> [a] -> [b]
myMap f = foldr (\x acc -> f x : acc) [] 


myFilter :: (a->Bool) -> [a] -> [a]
myFilter p = foldr (\x acc -> if p x then x : acc else acc) []

squish :: [[a]] -> [a]
squish = foldr (++) []


squishMap :: (a->[b]) -> [a] -> [b]
squishMap f = foldr (\x acc -> f x ++ acc) []

squishAgain :: [[a]] -> [a]
squishAgain = squishMap id