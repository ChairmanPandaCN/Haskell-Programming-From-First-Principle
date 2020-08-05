import Data.Monoid

type Adjective = String
type Adverb = String
type Noun = String
type Exclamation = String


madlibbin' :: Exclamation -> Adjective -> Noun -> Adjective -> String
madlibbin' e adv noun adj = e <> "! he said " <> adv <> " as he jumped into his car " <> noun <> " and drove off with his " <> adj <> " wife."

madlibbinBetter' :: Exclamation -> Adjective -> Noun -> Adjective -> String
madlibbinBetter' e adv noun adj = mconcat [e,"! he said ", adv, " as he jumped into his car ",noun," and drove off with his ", adj ," wife."]