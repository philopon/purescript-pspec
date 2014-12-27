module Test.PSpec
  ( Spec(), describe, it, itAsync, skip, only, setTimeout
  , pending

  , before, after, beforeEach, afterEach
  , beforeAsync, afterAsync, beforeEachAsync, afterEachAsync

  , before', after', beforeEach', afterEach'
  , beforeAsync', afterAsync', beforeEachAsync', afterEachAsync'
  ) where

import Control.Monad.Eff
import Data.Function
import Data.Maybe
import Data.Array
import qualified Data.String as S

import qualified Test.PSpec.Types as T

type Spec = T.Spec

describe :: forall e. String -> Spec e Unit -> Spec e Unit
describe name sub = T.write (T.Describe name (T.runSpec sub))

it :: forall e a. String -> Eff e a -> Spec e Unit
it name eff = T.write (T.It name (void eff))

itAsync :: forall e a. String -> (T.Done e -> Eff e a) -> Spec e Unit
itAsync name eff = T.write (T.ItAsync name (\d -> void (eff d)))

setMode :: forall e. T.ExecMode -> Spec e Unit -> Spec e Unit
setMode mode ops = T.write (T.SetMode mode (T.runSpec ops))

skip :: forall e. Spec e Unit -> Spec e Unit
skip = setMode T.skipMode

only :: forall e. Spec e Unit -> Spec e Unit
only = setMode T.onlyMode

setTimeout :: forall e. Number -> Spec e Unit -> Spec e Unit
setTimeout to sub = T.write (T.SetTimeout to (T.runSpec sub))

pending :: forall e. String -> Spec e Unit
pending name = T.write (T.Pending name)

before'     :: forall e a. String -> Eff e a -> Spec e Unit
before'     name eff = T.write (T.Before     name (void eff))
after'      :: forall e a. String -> Eff e a -> Spec e Unit
after'      name eff = T.write (T.After      name (void eff))
beforeEach' :: forall e a. String -> Eff e a -> Spec e Unit
beforeEach' name eff = T.write (T.BeforeEach name (void eff))
afterEach'  :: forall e a. String -> Eff e a -> Spec e Unit
afterEach'  name eff = T.write (T.AfterEach  name (void eff))

beforeAsync'     :: forall e a. String -> (T.Done e -> Eff e a) -> Spec e Unit
beforeAsync'     name eff = T.write (T.BeforeAsync     name (\d -> void (eff d)))
afterAsync'      :: forall e a. String -> (T.Done e -> Eff e a) -> Spec e Unit
afterAsync'      name eff = T.write (T.AfterAsync      name (\d -> void (eff d)))
beforeEachAsync' :: forall e a. String -> (T.Done e -> Eff e a) -> Spec e Unit
beforeEachAsync' name eff = T.write (T.BeforeEachAsync name (\d -> void (eff d)))
afterEachAsync'  :: forall e a. String -> (T.Done e -> Eff e a) -> Spec e Unit
afterEachAsync'  name eff = T.write (T.AfterEachAsync  name (\d -> void (eff d)))

before :: forall e a. Eff e a -> Spec e Unit
before = before' ""
after      :: forall e a. Eff e a -> Spec e Unit
after      = after' ""
beforeEach :: forall e a. Eff e a -> Spec e Unit
beforeEach = beforeEach' ""
afterEach  :: forall e a. Eff e a -> Spec e Unit
afterEach  = afterEach' ""

beforeAsync     :: forall e a. (T.Done e -> Eff e a) -> Spec e Unit
beforeAsync     = beforeAsync' ""
afterAsync      :: forall e a. (T.Done e -> Eff e a) -> Spec e Unit
afterAsync      = afterAsync' ""
beforeEachAsync :: forall e a. (T.Done e -> Eff e a) -> Spec e Unit
beforeEachAsync = beforeEachAsync' ""
afterEachAsync  :: forall e a. (T.Done e -> Eff e a) -> Spec e Unit
afterEachAsync  = afterEachAsync' ""