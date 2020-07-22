module MakePerson where

import Data.Char
import Control.Monad(forever)
import Data.Maybe
import Text.Read
type Name = String
type Age = Integer

data Person = Person Name Age deriving (Eq,Show)

data PersonInvalid = NameEmpty
                    | AgeTooLow
                    | PersonInvalidUnknow String deriving (Eq,Show)


mkPerson :: Name -> Age -> Either PersonInvalid Person

mkPerson name age
    | name /= "" && age > 0 = Right $ Person name age
    | name == "" = Left NameEmpty
    | age <= 0 = Left AgeTooLow
    | otherwise = Left $ PersonInvalidUnknow $ "Name was : " ++ show name ++ " Age was :" ++ show age

gimmePerson :: IO ()
gimmePerson = forever $ do
    putStr "Input a name : "
    name <- getLine
    putStr "Input the age for this person : "
    ageStr <- getLine
    let ageMaybe = readMaybe ageStr :: Maybe Integer

    if isJust ageMaybe
    then
        putStrLn $ "Yay! Successfully got a person with " ++ (show $ mkPerson name (fromJust ageMaybe))
    else putStrLn "Invalid age"
    return ()


