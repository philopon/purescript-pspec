# Module Documentation

## Module Test.PSpec.Types

### Types


    data Done :: *


    newtype ExecMode


    type ExecModes = { only :: ExecMode, skip :: ExecMode }


    type OpState = { timeout :: Maybe Number, execMode :: ExecMode }


    data Operation e where
      Describe :: String -> [Operation e] -> Operation e
      It :: String -> Eff e Unit -> Operation e
      ItAsync :: String -> (Done -> Eff e Unit) -> Operation e
      Pending :: String -> Operation e
      SetMode :: ExecMode -> [Operation e] -> Operation e
      SetTimeout :: Number -> [Operation e] -> Operation e
      Before :: String -> Eff e Unit -> Operation e
      After :: String -> Eff e Unit -> Operation e
      BeforeEach :: String -> Eff e Unit -> Operation e
      AfterEach :: String -> Eff e Unit -> Operation e
      BeforeAsync :: String -> (Done -> Eff e Unit) -> Operation e
      AfterAsync :: String -> (Done -> Eff e Unit) -> Operation e
      BeforeEachAsync :: String -> (Done -> Eff e Unit) -> Operation e
      AfterEachAsync :: String -> (Done -> Eff e Unit) -> Operation e


    newtype Spec e a


### Type Class Instances


    instance applicativeSpec :: Applicative (Spec e)


    instance applySpec :: Apply (Spec e)


    instance bindSpec :: Bind (Spec e)


    instance functorSpec :: Functor (Spec e)


    instance monadSpec :: Monad (Spec e)


    instance showExecMode :: Show ExecMode


    instance showOperation :: Show (Operation e)


### Values


    execModes :: ExecModes


    initialState :: OpState


    noneMode :: ExecMode


    onlyMode :: ExecMode


    runSpec :: forall e a. Spec e a -> [Operation e]


    skipMode :: ExecMode


    write :: forall e. Operation e -> Spec e Unit



