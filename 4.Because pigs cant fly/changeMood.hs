data Mood = Blah | Woot deriving Show

changeMood :: Mood -> Mood
changeMood Blah = Woot
changeMood _ = Blah

ifPalindrome :: (Eq a) => [a] -> Bool
ifPalindrome xs = (==) xs $ reverse xs 

myAbs :: Integer -> Integer
myAbs x = if x < 0 
          then -x 
          else x  

x = (+)

f xs = w `x` 1
    where w = length xs