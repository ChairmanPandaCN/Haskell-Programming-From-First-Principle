replaceWithP :: a -> Char
replaceWithP = const 'p'

replaceWithP' :: [Maybe [Char]] -> Char
replaceWithP' = replaceWithP

ha = Just ["Ha", "Ha"]
lmls = [ha,Nothing,Just []]

doubleFmap = (fmap . fmap) replaceWithP lmls

tripFmap= (fmap.fmap.fmap) replaceWithP lmls


lms :: [Maybe [Char]]
lms = [Just "Ave",Nothing,Just "woohoo"]


liftedReplace :: Functor f => f a -> f Char
liftedReplace = fmap replaceWithP


liftedReplace' :: [Maybe [Char]] -> [Char]
liftedReplace' = liftedReplace

twiceLifted :: (Functor f1, Functor f2) => f2 (f1 a) -> f2 (f1 Char)
twiceLifted = (fmap.fmap) replaceWithP

twiceLifted' :: [Maybe [Char]] -> [Maybe Char]
twiceLifted' = twiceLifted

thriceLifted::(Functor f2 ,Functor f1 ,Functor f) => f ( f1 (f2 a))->f (f1 ( f2 Char))
thriceLifted= (fmap.fmap.fmap) replaceWithP


thriceLifted'::[Maybe[Char]]->[Maybe[Char]]
thriceLifted'=thriceLifted


main::IO()
main=do
    putStr "replaceWithP' lms:   "
    print(replaceWithP' lms)
    putStr"liftedReplace lms:   "
    print(liftedReplace lms)
    putStr "liftedReplace' lms:   "
    print(liftedReplace' lms)
    putStr"twiceLifted  lms:  "
    print(twiceLifted lms)
    putStr"twiceLifted' lms:    "
    print(twiceLifted' lms)
    putStr"thriceLifted lms:    "
    print(thriceLifted lms)
    putStr "thriceLifted'lms:   "
    print(thriceLifted' lms)


a= fmap (+1) $ read "[1]" :: [Int]

b= (fmap .fmap) (++"lol") (Just ["Hi,","Hello"])

c= fmap (*2) $ (\x->x-2)


d= fmap ((return '1' ++) . show) $ (\x->[x,1..3])


e :: IO Integer
e = let ioi = readIO "21" :: IO Integer
        changed = fmap (read . ("123"++) . show) ioi
    in fmap (*3) changed