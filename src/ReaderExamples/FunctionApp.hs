module ReaderExamples.FunctionApp where

import Control.Applicative (liftA2)

newtype HumanName =
    HumanName String
    deriving (Eq, Show)

newtype DogName =
    DogName String
    deriving (Eq, Show)

newtype Address =
    Address String
    deriving (Eq, Show)

data Person =
    Person {
        humanName :: HumanName
      , dogName :: DogName
      , address :: Address
    } deriving (Eq, Show)

data Dog =
    Dog {
      dogsName :: DogName
    , dogsAddress :: Address
    } deriving (Eq, Show)

pers :: Person
pers =
    Person (HumanName "Big Bird")
           (DogName "Barkley")
           (Address "Sesame Street")

franco :: Person
franco = 
    Person (HumanName "Franco Sosa")
           (DogName "Pascal")
           (Address "Guatemala")

getDog :: Person -> Dog
getDog p =
    Dog (dogName p) (address p)

getDogR :: Person -> Dog
getDogR =
    Dog <$> dogName <*> address

getDogR' :: Person -> Dog
getDogR' = liftA2 Dog dogName address

liftA2' :: Applicative f =>
           (a -> b -> c)
        -> f a -> f b -> f c
liftA2' f g h = f <$> g <*> h

getDogRM :: Person -> Dog
getDogRM = do
    name <- dogName
    addy <- address
    return $ Dog name addy