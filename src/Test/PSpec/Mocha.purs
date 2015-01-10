module Test.PSpec.Mocha (Mocha(), runMocha) where

import Control.Monad.Eff
import Data.Maybe
import Test.PSpec.Types
import Data.Function

foreign import data This :: *
foreign import data Mocha :: !

foreign import describeImpl """
function describeImpl(name, test){
  return function describeImplEff(){
    describe(name, function(){test(this)()});
  }
}""" :: forall e a. Fn2
  String
  (This -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import pendingImpl """
function pendingImpl(e, mode, name){
  return function pendingImplEff(){
    if(mode === e.skip){
      it.skip(name);
    } else if(mode === e.only) {
      it.only(name);
    } else {
      it(name);
    }
  }
}""" :: forall e a. Fn3
  ExecModes
  ExecMode
  String
  (Eff (mocha :: Mocha | e) Unit)


foreign import itImpl """
function itImpl(e, mode, name, test){
  return function itImplEff(){
    if(mode === e.skip){
      it.skip(name, function(){test(this)()});
    } else if(mode === e.only) {
      it.only(name, function(){test(this)()});
    } else {
      it(name, function(){test(this)()});
    }
  }
}""" :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import beforeImpl """
function beforeImpl(e, mode, name, hook){
  return function beforeImplEff(){
    if(name) before(name, function(){hook(this)()});
    else     before(function(){hook(this)()});
  }
}""" :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import afterImpl """
function afterImpl(e, mode, name, hook){
  return function afterImplEff(){
    if(name) after(name, function(){hook(this)()});
    else     after(function(){hook(this)()});
  }
}""" :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import beforeEachImpl """
function beforeEachImpl(e, mode, name, hook){
  return function beforeEachImplEff(){
    if(name) beforeEach(name, function(){hook(this)()});
    else     beforeEach(function(){hook(this)()});
  }
}""" :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import afterEachImpl """
function afterEachImpl(e, mode, name, hook){
  return function afterEachImplEff(){
    if(name) afterEach(name, function(){hook(this)()});
    else     afterEach(function(){hook(this)()});
  }
}""" :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import itAsyncImpl """
function itAsyncImpl(e, mode, name, test){
  return function itAsyncImplEff(){
    if(mode === e.skip){
      it.skip(name, function(done){test(this)(done)()});
    } else if(mode === e.only) {
      it.only(name, function(done){test(this)(done)()});
    } else {
      it(name, function(done){test(this)(done)()});
    }
  }
}""" :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Done -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import beforeAsyncImpl """
function beforeAsyncImpl(e, mode, name, hook){
  return function beforeAsyncImplEff(){
    if(name) before(name, function(done){hook(this)(done)()});
    else     before(function(done){hook(this)(done)()});
  }
}""" :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Done -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import afterAsyncImpl """
function afterAsyncImpl(e, mode, name, hook){
  return function afterAsyncImplEff(){
    if(name) after(name, function(done){hook(this)(done)()});
    else     after(function(done){hook(this)(done)()});
  }
}""" :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Done -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import beforeEachAsyncImpl """
function beforeEachAsyncImpl(e, mode, name, hook){
  return function beforeEachAsyncImplEff(){
    if(name) beforeEach(name, function(done){hook(this)(done)()});
    else     beforeEach(function(done){hook(this)(done)()});
  }
}""" :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Done -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import afterEachAsyncImpl """
function afterEachAsyncImpl(e, mode, name, hook){
  return function afterEachAsyncImplEff(){
    if(name) afterEach(name, function(done){hook(this)(done)()});
    else     afterEach(function(done){hook(this)(done)()});
  }
}""" :: forall e a. Fn4
  ExecModes
  ExecMode
  String
  (This -> Done -> Eff (mocha :: Mocha | e) a)
  (Eff (mocha :: Mocha | e) Unit)

foreign import setTimeoutImpl """
function setTimeoutImpl(_this, to){
  return function setTimeoutImplEff(){
    _this.timeout(to);
  }
}""" :: forall e. Fn2
  This
  Number
  (Eff (mocha :: Mocha | e) Unit)

setTO this to = maybe (return unit) (\ n -> runFn2 setTimeoutImpl this n) to

runMocha' :: forall e. OpState -> [Operation (mocha :: Mocha | e)] -> Eff (mocha :: Mocha | e) Unit
runMocha' state []     = return unit
runMocha' state (Describe name sub:ops) = do
  runFn2 describeImpl name $ \this -> do
    setTO this state.timeout
    runMocha' state sub
  runMocha' state ops

runMocha' state (Pending name:ops) = do
  runFn3 pendingImpl execModes state.execMode name
  runMocha' state ops

runMocha' state (It name eff:ops) = do
  runFn4 itImpl execModes state.execMode name $ \this -> do
    setTO this state.timeout
    eff
  runMocha' state ops

runMocha' state (ItAsync name eff:ops) = do
  runFn4 itAsyncImpl execModes state.execMode name $ \this done -> do
    setTO this state.timeout
    eff done
  runMocha' state ops

runMocha' state (SetMode m sub:ops) = do
  runMocha' state{execMode = m} sub
  runMocha' state ops

runMocha' state (SetTimeout to sub:ops) = do
  runMocha' state{timeout = Just to} sub
  runMocha' state ops

runMocha' state (Before name eff:ops) = do
  runFn4 beforeImpl execModes state.execMode name $ \this -> do
    setTO this state.timeout
    eff
  runMocha' state ops

runMocha' state (After name eff:ops) = do
  runFn4 afterImpl execModes state.execMode name $ \this -> do
    setTO this state.timeout
    eff
  runMocha' state ops

runMocha' state (BeforeEach name eff:ops) = do
  runFn4 beforeEachImpl execModes state.execMode name $ \this -> do
    setTO this state.timeout
    eff
  runMocha' state ops

runMocha' state (AfterEach name eff:ops) = do
  runFn4 afterEachImpl execModes state.execMode name $ \this -> do
    setTO this state.timeout
    eff
  runMocha' state ops

runMocha' state (BeforeAsync name eff:ops) = do
  runFn4 beforeAsyncImpl execModes state.execMode name $ \this done -> do
    setTO this state.timeout
    eff done
  runMocha' state ops

runMocha' state (AfterAsync name eff:ops) = do
  runFn4 afterAsyncImpl execModes state.execMode name $ \this done -> do
    setTO this state.timeout
    eff done
  runMocha' state ops

runMocha' state (BeforeEachAsync name eff:ops) = do
  runFn4 beforeEachAsyncImpl execModes state.execMode name $ \this done -> do
    setTO this state.timeout
    eff done
  runMocha' state ops

runMocha' state (AfterEachAsync name eff:ops) = do
  runFn4 afterEachAsyncImpl execModes state.execMode name $ \this done -> do
    setTO this state.timeout
    eff done
  runMocha' state ops

runMocha :: forall e. Spec (mocha :: Mocha | e) Unit -> Eff (mocha :: Mocha | e) Unit
runMocha s = runMocha' initialState (runSpec s)
