notThe :: String -> Maybe String
notThe xs
    | xs == "the" = Nothing
    | otherwise = Just xs

replaceThe :: String -> String
replaceThe xs =  unwords $ map f $ words xs
    where f x
            | x == "the" = "a"
            | otherwise = x 

countTheBeforeVowel :: String -> Integer
countTheBeforeVowel xs =  sum $ f $ words xs
    where  f (_:[]) = [0]
           f (x:y:xs)
            | x=="the" && head y `elem` "aeiou" = 1 : f (y:xs)
            | otherwise = 0 : f (y:xs)

countVowels ::String -> Integer
countVowels xs = sum $ map sum $ map (foldr (\x -> if x `elem` "aeious" then (1:) else (0:)) []) $ words xs

newtype Word' = Word' String deriving (Eq,Show)

vowels = "aeiou"

mkWord :: String -> Maybe Word'
mkWord xs =  if (sum $ foldr (\x -> if x `elem` "aeious" then (1:) else (-1:)) [] xs) > 0 then Nothing else Just (Word' xs) 


data Nat = Zero
         | Succ Nat
         deriving (Eq,Show)

natToInteger :: Nat -> Integer
natToInteger Zero = 0
natToInteger (Succ x) = 1 + natToInteger x

integerToNat :: Integer -> Nat
integerToNat 0 = Zero
integerToNat x = (Succ $ integerToNat $ x-1)

isJust :: Maybe a -> Bool
isJust Nothing = False
isJust x = True

isNothing :: Maybe a -> Bool
isNothing Nothing = True
isNothing _ = False


mayybee :: b -> (a->b) -> Maybe a -> b
mayybee x _ Nothing = x
mayybee x f (Just y) = f y

fromMaybe :: a -> Maybe a -> a
fromMaybe x Nothing = x
fromMaybe x (Just y) = y

listToMaybe :: [a] -> Maybe a 
listToMaybe [] = Nothing
listToMaybe (x:xs) = Just x

maybeToList :: Maybe a -> [a]
maybeToList (Just x) = [x]
maybeToList Nothing = []

catMaybes :: [Maybe a] -> [a]
catMaybes [] = []
catMaybes (Nothing:xs) = catMaybes xs
catMaybes (Just x:xs) = x : catMaybes xs

flipMaybe :: (Eq a) => [Maybe a] -> Maybe [a]
flipMaybe xs
    | Nothing `elem` xs = Nothing
    | otherwise = Just $ catMaybes xs


lefts' :: [Either a b] -> [a]
lefts' xs = foldr go [] xs
            where go (Left a) = ([a] ++) 
                  go (Right b) = ([] ++) 

rights' :: [Either a b] -> [b]
rights' xs = foldr go [] xs
            where go (Left a) = ([] ++) 
                  go (Right b) = ([b] ++) 

partitionEithers' :: [Either a b] -> ([a],[b])
partitionEithers' xs = (lefts' xs, rights' xs)

eitherMaybe' :: (b-> c) -> Either a b -> Maybe c
eitherMaybe' _ (Left a) = Nothing
eitherMaybe' f (Right b) = Just (f b)

either' :: (a->c) -> (b->c) -> Either a b -> c
either' _ g (Right b) = g b
either' f _ (Left a) = f a
eitherMaybe'' :: (b-> c) -> Either a b -> Maybe c
eitherMaybe'' f x = either' (const Nothing ) (Just . f) x


iterate' :: (a->a) -> a -> [a]
iterate' f a = a : iterate' f (f a)

f b = Just (b,b+1)
myUnfoldr :: (b-> Maybe(a,b)) -> b -> [a]
myUnfoldr f x = (fst $ insideValue tmp) : myUnfoldr f (snd $ insideValue tmp)
    where tmp = f x
          insideValue (Just x) = x

betterInterate :: (a->a) -> a -> [a]
betterInterate f x = myUnfoldr go x
    where 
          go x = Just (x,f x)


data BinaryTree a = Leaf
                    | Node (BinaryTree a) a (BinaryTree a)
                    deriving (Eq,Show)
    

unfold :: (a-> Maybe (a,b,a)) -> a -> BinaryTree b
unfold f a = Node (unfold f $ first tmp) (second tmp) (unfold f $ third tmp)
    where tmp = f a
          first :: Maybe(a,b,a) -> a
          first (Just (x,_,_) ) = x
          second :: Maybe(a,b,a) -> b
          second (Just (_,x,_)) = x
          third :: Maybe(a,b,a) -> a
          third (Just (_,_,x)) =x