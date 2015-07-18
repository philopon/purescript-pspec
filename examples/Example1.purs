module Example1 where

import Prelude
import Test.PSpec
import Test.PSpec.Mocha
import Test.Assert.Simple
import Test.StrongCheck
import Data.Tuple
import Math

import qualified Control.Monad.Eff.Console as Console

main = runMocha $ do
  before     $ Console.log "before called"
  after      $ Console.log "after called"
  beforeEach $ Console.log "before each called"
  afterEach  $ Console.log "after each called"

  beforeAsync     $ \done -> Console.log "beforeAsync called" >>= \_ -> itIs done
  afterAsync      $ \done -> Console.log "afterAsync called" >>= \_ -> itIs done
  beforeEachAsync $ \done -> Console.log "beforeEachAsync called" >>= \_ -> itIs done
  afterEachAsync  $ \done -> Console.log "afterEachAsync called" >>= \_ -> itIs done

  describe "title" $ do
    it "success" $ return unit
    itAsync "async success" $ \done -> itIs done

  describe "title2" $ do
    pending "pending"
    skip $ it "failure" $ assertFailure "failure"

    describe "nested" $ do

      describe "skip with predicate" $ do
        skipIf true $ do
          it "skipped" $ return unit

        skipIf false $ do
          it "not skipped" $ return unit

  describe "Math" $ do
    it "should be bigger multiply by (>= 1)" $ do
      quickCheck $ \(Tuple (Positive a) b) ->
        (max 1.0 a) * b >= b
