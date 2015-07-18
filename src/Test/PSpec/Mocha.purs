module Test.PSpec.Mocha (Mocha(), runMocha) where

import Prelude
import Control.Monad.Eff
import Data.Maybe
import Data.List
import Test.PSpec.Types
import Data.Function

foreign import data This :: *
foreign import data Mocha :: !

foreign import describeImpl :: forall e a. Fn2
  String
  (This -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import pendingImpl :: forall e a. Fn3
  ExecModes
  ExecMode
  String
  (Eff (mocha :: Mocha | e) Unit)


foreign import itImpl :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import beforeImpl :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import afterImpl :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import beforeEachImpl :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import afterEachImpl :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import itAsyncImpl :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Done -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import beforeAsyncImpl :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Done -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import afterAsyncImpl :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Done -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import beforeEachAsyncImpl :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Done -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import afterEachAsyncImpl :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Done -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import setTimeoutImpl :: forall e. Fn2
  This
  Number
  (Eff (mocha :: Mocha | e) Unit)

setTO this to = maybe (return unit) (\ n -> runFn2 setTimeoutImpl this n) to

runMocha' :: forall e. OpState -> List (Operation (mocha :: Mocha | e)) -> Eff (mocha :: Mocha | e) Unit
runMocha' state Nil     = return unit
runMocha' state (Cons (Describe name sub) ops) = do
  runFn2 describeImpl name $ \this -> do
    setTO this state.timeout
    runMocha' state sub
  runMocha' state ops

runMocha' state (Cons (Pending name) ops) = do
  runFn3 pendingImpl execModes state.execMode name
  runMocha' state ops

runMocha' state (Cons (It name eff) ops) = do
  runFn4 itImpl execModes state.execMode name $ \this -> do
    setTO this state.timeout
    eff
  runMocha' state ops

runMocha' state (Cons (ItAsync name eff) ops) = do
  runFn4 itAsyncImpl execModes state.execMode name $ \this done -> do
    setTO this state.timeout
    eff done
  runMocha' state ops

runMocha' state (Cons (SetMode m sub) ops) = do
  runMocha' state{execMode = m} sub
  runMocha' state ops

runMocha' state (Cons (SetTimeout to sub) ops) = do
  runMocha' state{timeout = Just to} sub
  runMocha' state ops

runMocha' state (Cons (Before name eff) ops) = do
  runFn4 beforeImpl execModes state.execMode name $ \this -> do
    setTO this state.timeout
    eff
  runMocha' state ops

runMocha' state (Cons (After name eff) ops) = do
  runFn4 afterImpl execModes state.execMode name $ \this -> do
    setTO this state.timeout
    eff
  runMocha' state ops

runMocha' state (Cons (BeforeEach name eff) ops) = do
  runFn4 beforeEachImpl execModes state.execMode name $ \this -> do
    setTO this state.timeout
    eff
  runMocha' state ops

runMocha' state (Cons (AfterEach name eff) ops) = do
  runFn4 afterEachImpl execModes state.execMode name $ \this -> do
    setTO this state.timeout
    eff
  runMocha' state ops

runMocha' state (Cons (BeforeAsync name eff) ops) = do
  runFn4 beforeAsyncImpl execModes state.execMode name $ \this done -> do
    setTO this state.timeout
    eff done
  runMocha' state ops

runMocha' state (Cons (AfterAsync name eff) ops) = do
  runFn4 afterAsyncImpl execModes state.execMode name $ \this done -> do
    setTO this state.timeout
    eff done
  runMocha' state ops

runMocha' state (Cons (BeforeEachAsync name eff) ops) = do
  runFn4 beforeEachAsyncImpl execModes state.execMode name $ \this done -> do
    setTO this state.timeout
    eff done
  runMocha' state ops

runMocha' state (Cons (AfterEachAsync name eff) ops) = do
  runFn4 afterEachAsyncImpl execModes state.execMode name $ \this done -> do
    setTO this state.timeout
    eff done
  runMocha' state ops

runMocha :: forall e. Spec (mocha :: Mocha | e) Unit -> Eff (mocha :: Mocha | e) Unit
runMocha s = runMocha' initialState (runSpec s)
