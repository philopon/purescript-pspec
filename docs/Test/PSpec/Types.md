## Module Test.PSpec.Types

#### `ExecMode`

``` purescript
newtype ExecMode
```

##### Instances
``` purescript
instance showExecMode :: Show ExecMode
```

#### `ExecModes`

``` purescript
type ExecModes = { skip :: ExecMode, only :: ExecMode }
```

#### `execModes`

``` purescript
execModes :: ExecModes
```

#### `noneMode`

``` purescript
noneMode :: ExecMode
```

#### `skipMode`

``` purescript
skipMode :: ExecMode
```

#### `onlyMode`

``` purescript
onlyMode :: ExecMode
```

#### `Done`

``` purescript
data Done :: *
```

#### `Operation`

``` purescript
data Operation e
  = Describe String (List (Operation e))
  | It String (Eff e Unit)
  | ItAsync String (Done -> Eff e Unit)
  | Pending String
  | SetMode ExecMode (List (Operation e))
  | SetTimeout Number (List (Operation e))
  | Before String (Eff e Unit)
  | After String (Eff e Unit)
  | BeforeEach String (Eff e Unit)
  | AfterEach String (Eff e Unit)
  | BeforeAsync String (Done -> Eff e Unit)
  | AfterAsync String (Done -> Eff e Unit)
  | BeforeEachAsync String (Done -> Eff e Unit)
  | AfterEachAsync String (Done -> Eff e Unit)
```

##### Instances
``` purescript
instance showOperation :: Show (Operation e)
```

#### `OpState`

``` purescript
type OpState = { execMode :: ExecMode, timeout :: Maybe Number }
```

#### `initialState`

``` purescript
initialState :: OpState
```

#### `Spec`

``` purescript
newtype Spec e a
```

##### Instances
``` purescript
instance functorSpec :: Functor (Spec e)
instance applySpec :: Apply (Spec e)
instance applicativeSpec :: Applicative (Spec e)
instance bindSpec :: Bind (Spec e)
instance monadSpec :: Monad (Spec e)
```

#### `runSpec`

``` purescript
runSpec :: forall e a. Spec e a -> List (Operation e)
```

#### `write`

``` purescript
write :: forall e. Operation e -> Spec e Unit
```



