# Module Documentation

## Module Test.PSpec

### Types

    type Spec = T.Spec


### Values

    after :: forall e a. Eff e a -> Spec e Unit

    after' :: forall e a. String -> Eff e a -> Spec e Unit

    afterAsync :: forall e a. (T.Done e -> Eff e a) -> Spec e Unit

    afterAsync' :: forall e a. String -> (T.Done e -> Eff e a) -> Spec e Unit

    afterEach :: forall e a. Eff e a -> Spec e Unit

    afterEach' :: forall e a. String -> Eff e a -> Spec e Unit

    afterEachAsync :: forall e a. (T.Done e -> Eff e a) -> Spec e Unit

    afterEachAsync' :: forall e a. String -> (T.Done e -> Eff e a) -> Spec e Unit

    before :: forall e a. Eff e a -> Spec e Unit

    before' :: forall e a. String -> Eff e a -> Spec e Unit

    beforeAsync :: forall e a. (T.Done e -> Eff e a) -> Spec e Unit

    beforeAsync' :: forall e a. String -> (T.Done e -> Eff e a) -> Spec e Unit

    beforeEach :: forall e a. Eff e a -> Spec e Unit

    beforeEach' :: forall e a. String -> Eff e a -> Spec e Unit

    beforeEachAsync :: forall e a. (T.Done e -> Eff e a) -> Spec e Unit

    beforeEachAsync' :: forall e a. String -> (T.Done e -> Eff e a) -> Spec e Unit

    describe :: forall e. String -> Spec e Unit -> Spec e Unit

    it :: forall e a. String -> Eff e a -> Spec e Unit

    itAsync :: forall e a. String -> (T.Done e -> Eff e a) -> Spec e Unit

    only :: forall e. Spec e Unit -> Spec e Unit

    pending :: forall e. String -> Spec e Unit

    setTimeout :: forall e. Number -> Spec e Unit -> Spec e Unit

    skip :: forall e. Spec e Unit -> Spec e Unit



