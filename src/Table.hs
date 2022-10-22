{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}

module Table where

import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH
import Data.Time

type ManaCost = Text
type Typeline = Text
type PrintingIds = Text
type Rarity = Text

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
CardRow sql=cards
    name Text
    manaCost ManaCost
    oracleText Text
    typeLine Typeline
    reservedList Bool
    deriving Show

PrintingRow sql=printings
    card CardRowId OnDeleteCascade OnUpdateCascade
    ids PrintingIds
    releaseDate UTCTime
    scryfallUrl Text
    set SetRowId OnDeleteCascade OnUpdateCascade
    rarity Rarity
    prices PriceRowId
    isPromo Bool
    deriving Show

PriceRow sql=prices
    date UTCTime
    usd Int Maybe
    usdFoil Int Maybe
    usdEtched Int Maybe
    eur Int Maybe
    eurFoil Int Maybe
    deriving Show

SetRow sql=sets
    code Text
    scryfallSetId Text
    name Text
    type Text
    deriving Show
|]

