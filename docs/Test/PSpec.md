## Module Test.PSpec

#### `Spec`

``` purescript
type Spec = Spec
```

#### `describe`

``` purescript
describe :: forall e. String -> Spec e Unit -> Spec e Unit
```

#### `it`

``` purescript
it :: forall e. String -> Eff e _ -> Spec e Unit
```

#### `itAsync`

``` purescript
itAsync :: forall e. String -> (Done -> Eff e _) -> Spec e Unit
```

#### `skip`

``` purescript
skip :: forall e. Spec e Unit -> Spec e Unit
```

#### `only`

``` purescript
only :: forall e. Spec e Unit -> Spec e Unit
```

#### `skipIf`

``` purescript
skipIf :: forall e. Boolean -> Spec e Unit -> Spec e Unit
```

#### `skipUnless`

``` purescript
skipUnless :: forall e. Boolean -> Spec e Unit -> Spec e Unit
```

#### `onlyIf`

``` purescript
onlyIf :: forall e. Boolean -> Spec e Unit -> Spec e Unit
```

#### `onlyUnless`

``` purescript
onlyUnless :: forall e. Boolean -> Spec e Unit -> Spec e Unit
```

#### `setTimeout`

``` purescript
setTimeout :: forall e. Number -> Spec e Unit -> Spec e Unit
```

#### `pending`

``` purescript
pending :: forall e. String -> Spec e Unit
```

#### `before'`

``` purescript
before' :: forall e. String -> Eff e _ -> Spec e Unit
```

#### `after'`

``` purescript
after' :: forall e. String -> Eff e _ -> Spec e Unit
```

#### `beforeEach'`

``` purescript
beforeEach' :: forall e. String -> Eff e _ -> Spec e Unit
```

#### `afterEach'`

``` purescript
afterEach' :: forall e. String -> Eff e _ -> Spec e Unit
```

#### `beforeAsync'`

``` purescript
beforeAsync' :: forall e. String -> (Done -> Eff e _) -> Spec e Unit
```

#### `afterAsync'`

``` purescript
afterAsync' :: forall e. String -> (Done -> Eff e _) -> Spec e Unit
```

#### `beforeEachAsync'`

``` purescript
beforeEachAsync' :: forall e. String -> (Done -> Eff e _) -> Spec e Unit
```

#### `afterEachAsync'`

``` purescript
afterEachAsync' :: forall e. String -> (Done -> Eff e _) -> Spec e Unit
```

#### `before`

``` purescript
before :: forall e. Eff e _ -> Spec e Unit
```

#### `after`

``` purescript
after :: forall e. Eff e _ -> Spec e Unit
```

#### `beforeEach`

``` purescript
beforeEach :: forall e. Eff e _ -> Spec e Unit
```

#### `afterEach`

``` purescript
afterEach :: forall e. Eff e _ -> Spec e Unit
```

#### `beforeAsync`

``` purescript
beforeAsync :: forall e. (Done -> Eff e _) -> Spec e Unit
```

#### `afterAsync`

``` purescript
afterAsync :: forall e. (Done -> Eff e _) -> Spec e Unit
```

#### `beforeEachAsync`

``` purescript
beforeEachAsync :: forall e. (Done -> Eff e _) -> Spec e Unit
```

#### `afterEachAsync`

``` purescript
afterEachAsync :: forall e. (Done -> Eff e _) -> Spec e Unit
```

#### `itIs`

``` purescript
itIs :: forall e a. Done -> Eff e a
```

#### `itIsNot`

``` purescript
itIsNot :: forall e a. Done -> String -> Eff e a
```

#### `itIsNot'`

``` purescript
itIsNot' :: forall a. Done -> String -> a
```



