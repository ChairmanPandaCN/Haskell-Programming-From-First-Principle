type Name = String
type Age = Integer

type ValidatePerson a = Either [PersonInvalid] a

data Person = Person Name Age deriving Show

data PersonInvalid = NameEmpty
                    | AgeTooLow deriving (Eq,Show)


ageOkay :: Age -> Either [PersonInvalid] Age
ageOkay age
    | age >= 0 = Right age
    | otherwise = Left [AgeTooLow]

nameOkay :: Name -> Either [PersonInvalid] Name
nameOkay name
    | name /="" = Right name
    | otherwise = Left [NameEmpty]

mkPerson :: Name -> Age -> ValidatePerson Person
mkPerson name age = mkPerson' (nameOkay name) (ageOkay age)

mkPerson' :: ValidatePerson Name -> ValidatePerson Age -> ValidatePerson Person
mkPerson' (Right nameOk) (Right ageOk) = Right (Person nameOk ageOk)
mkPerson' (Left nameNotOk) (Left ageNotOk) = Left (nameNotOk ++ ageNotOk)
mkPerson' (Left nameNotOk) _ = Left nameNotOk
mkPerson' _ (Left ageNotOk) = Left ageNotOk
