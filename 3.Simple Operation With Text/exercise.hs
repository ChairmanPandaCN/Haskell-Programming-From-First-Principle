module ChapterThree where
twoA :: [Char] -> [Char]
twoA xs = xs ++ "!"

twoB :: [Char] -> Char
twoB xs =  xs !! 4

twoC :: [Char] -> [Char]
twoC = drop 9 


thirdLetter :: [Char]-> Char
thirdLetter xs = xs !! 2


letterIndex :: Int -> Char
letterIndex x = "Curry is awesome" !! x


rvrs :: String -> String
rvrs xs = drop 9 xs ++ (take 4 $ drop 5 xs)  ++ take 5 xs 

main :: IO()
main = print $ rvrs "Curry is awesome"