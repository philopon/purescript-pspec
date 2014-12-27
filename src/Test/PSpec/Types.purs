module Test.PSpec.Types
  ( Operation(..)
  , OpState()
  , initialState
  , Spec()
  , write
  , runSpec
  , Done()
  , ExecMode()
  , noneMode, skipMode, onlyMode
  , ExecModes()
  , execModes
  ) where

import Control.Monad.Eff
import Data.Maybe
import Data.String
import Data.Array()

newtype ExecMode = ExecMode Number

instance showExecMode :: Show ExecMode where
  show (ExecMode 1) = "Skip"
  show (ExecMode 2) = "Only"
  show _            = "None"

type ExecModes =
  { skip :: ExecMode
  , only :: ExecMode
  }

execModes :: ExecModes
execModes = {skip: skipMode, only: onlyMode}

noneMode :: ExecMode
noneMode = ExecMode 0

skipMode :: ExecMode
skipMode = ExecMode 1

onlyMode :: ExecMode
onlyMode = ExecMode 2

foreign import data Done :: *

data Operation e
  -- describe
  = Describe        String   [Operation e]
  -- it
  | It              String   (Eff e Unit)
  | ItAsync         String   (Done -> Eff e Unit)
  | Pending         String
  -- config
  | SetMode         ExecMode [Operation e]
  | SetTimeout      Number   [Operation e]
  -- hooks
  | Before          String   (Eff e Unit)
  | After           String   (Eff e Unit)
  | BeforeEach      String   (Eff e Unit)
  | AfterEach       String   (Eff e Unit)
  -- async hooks
  | BeforeAsync     String   (Done -> Eff e Unit)
  | AfterAsync      String   (Done -> Eff e Unit)
  | BeforeEachAsync String   (Done -> Eff e Unit)
  | AfterEachAsync  String   (Done -> Eff e Unit)

type OpState =
  { execMode :: ExecMode
  , timeout  :: Maybe Number
  }

initialState :: OpState
initialState = { execMode: noneMode, timeout: Nothing }

instance showOperation :: Show (Operation e) where
  show (Describe name ops) = joinWith " " ["Describe", show name, show ops]
  show (It       name eff) = "It " ++ show name
  show (ItAsync  name eff) = "ItAsync " ++ show name
  show (SetMode  em   ops) = show em ++ " " ++ show ops
  show (SetTimeout o  ops) = joinWith " " ["Timeout", show o, show ops]

type SpecWriter e a = {a :: a, w :: [Operation e]}

newtype Spec e a = Spec (SpecWriter e a)

unSpec :: forall e a. Spec e a -> SpecWriter e a
unSpec (Spec m) = m

instance functorSpec :: Functor (Spec e) where
  (<$>) f (Spec w) = Spec (w { a = f w.a })

instance applySpec :: Apply (Spec e) where
  (<*>) (Spec f) (Spec a) = Spec { a : f.a a.a, w : f.w ++ a.w }

instance applicativeSpec :: Applicative (Spec e) where
  pure a = Spec {a: a, w: []}

instance bindSpec :: Bind (Spec e) where
  (>>=) (Spec m) f = Spec $
    let fa = unSpec (f m.a)
    in {a: fa.a, w: m.w ++ fa.w}

instance monadSpec :: Monad (Spec e)

runSpec :: forall e a. Spec e a -> [Operation e]
runSpec (Spec m) = m.w

write :: forall e. Operation e -> Spec e Unit
write o = Spec {a: unit, w: [o]}
