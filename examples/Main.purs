module Test.Main where

import Control.Timer

import Test.PSpec
import Test.PSpec.Mocha
import Test.Assert.Simple

import Debug.Trace

main = runMocha $ do
  before     $ trace "before called"
  after      $ trace "after called"
  beforeEach $ trace "before each called"
  afterEach  $ trace "after each called"

  beforeAsync     $ \done -> trace "beforeAsync called" >>= \_ -> itIs done
  afterAsync      $ \done -> trace "afterAsync called" >>= \_ -> itIs done
  beforeEachAsync $ \done -> trace "beforeEachAsync called" >>= \_ -> itIs done
  afterEachAsync  $ \done -> trace "afterEachAsync called" >>= \_ -> itIs done

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

      setTimeout 5000 $ do
        itAsync "long time" $ \done -> timeout 3000 (itIs done)
