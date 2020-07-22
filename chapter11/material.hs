{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
data Doggies a = Husky a
                | Mastiff a 
                deriving (Eq, Show)


data PugType = PugDaga

data HuskyType a = HuskyType

data DogueDeBordeaux doge = DogueDeBordeaux doge

data Price = Price Integer deriving (Eq,Show)

data Size = Size Integer deriving (Eq,Show) 

data Manufacturer = Mini | Mazda | Tata deriving (Eq,Show)

data Airline = PapuAir | CatapultsR'Us | TakeYourChancesUnited deriving (Eq,Show)

data Vehicle = Car Manufacturer Price
            | Plane Airline Size
            deriving (Eq,Show)


myCar = Car Mini (Price 14000)
urCar = Car Mazda (Price 20000)
clownCar = Car Tata (Price 7000)
doge = Plane PapuAir (Size 747)


isCar :: Vehicle -> Bool
isCar (Car _ _) = True
isCar _ = False

getManu :: Vehicle -> Maybe Manufacturer
getManu (Car x _) = Just x
getManu _ = Nothing


data Example = MakeExample deriving Show

data Example' = MakeExample' Int deriving Show

class TooMany a where
    tooMany :: a -> Bool

instance TooMany Int where
    tooMany n = n > 42

instance TooMany (Int,String) where
    tooMany (x,y) = x > 42 && length y > 4

instance TooMany (Int,Int) where
    tooMany (x,y) = x > 42 &&  y > 42

instance  (Num a,Ord a,TooMany a) => TooMany (a,a) where
    tooMany (x,y) = x > 42 && y > 42

newtype Goats = Goats Int deriving (Eq,Show,TooMany)
newtype Cows = Cows Int deriving (Eq,Show)


data Person = MkPerson { name :: String, age :: Integer}
jm = MkPerson "Julie" 108
ca = MkPerson "chris" 16


data GuessWhat = ChickenButt deriving (Eq,Show)

data Id a = MkId a deriving (Eq,Show)

data Product a b = Product a b deriving (Eq,Show)

data Sum a b = First a 
            | Second b
            deriving (Eq, Show)

data RecordProduct a b = RecordProduct {pfirst :: a , psecond :: b} deriving (Eq,Show)


newtype NumCow = NumCow Int deriving (Eq,Show)

newtype NumPig = NumPig Int deriving (Eq,Show)

newtype NumSheep = NumSheep Int deriving (Eq,Show)

data Farmhouse = Farmhouse NumCow NumPig deriving (Eq,Show)

type Farmhouse' = Product NumCow NumPig

data BigFarmhouse = BigFarmhouse NumCow NumPig NumSheep deriving (Eq,Show)

type BigFarmhouse' = Product NumCow (Product NumPig NumSheep) 


type Name = String
type Age = Int
type LovesMud = Bool
type PoundsOfWool = Int

data CowInfo = CowInfo Name Age deriving (Eq,Show)

data PigInfo = PigInfo Name Age LovesMud deriving (Eq,Show)

data SheepInfo = SheepInfo Name Age PoundsOfWool deriving (Eq,Show)

data Animal = Cow CowInfo
        | Pig PigInfo
        | Sheep SheepInfo deriving (Eq,Show)

type Animal' = Sum CowInfo (Sum PigInfo SheepInfo)


bess' = CowInfo "Bess" 4

sheep = Second $ SheepInfo "Elmer" 5 5 


data OperatingSystem = GnuPlusLinux
                    | OpenBSD
                    | Max
                    | Windows deriving (Eq,Show)

data ProgLang = Haskell 
            | Agda
            | Idris
            | Purescript
            deriving (Eq, Show)

data Programmer = Programmer { os :: OperatingSystem, lang :: ProgLang} deriving (Eq,Show)

allOperatingSystems :: [OperatingSystem]
allOperatingSystems = [GnuPlusLinux,OpenBSD,Max,Windows]

allLanguage :: [ProgLang]
allLanguage = [Haskell,Agda,Idris,Purescript]

allProgrammer :: [OperatingSystem]->[ProgLang]->[Programmer]
allProgrammer os lang = [Programmer x y | x<- os, y <- lang]