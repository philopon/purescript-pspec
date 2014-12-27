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

  beforeAsync     $ \done -> trace "beforeAsync called" >>= \_ -> done
  afterAsync      $ \done -> trace "afterAsync called" >>= \_ -> done
  beforeEachAsync $ \done -> trace "beforeEachAsync called" >>= \_ -> done
  afterEachAsync  $ \done -> trace "afterEachAsync called" >>= \_ -> done

  describe "title" $ do
    it "success" $ return unit
    itAsync "async success" $ \done -> done

  describe "title2" $ do
    pending "pending"
    skip $ it "failure" $ assertFailure "failure"

    describe "nested" $ do
      setTimeout 5000 $ do
        itAsync "long time" $ \done -> timeout 3000 done
