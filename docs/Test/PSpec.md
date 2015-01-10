# Module Documentation

## Module Test.PSpec

### Types


    type Spec = T.Spec


### Values


    after :: forall e. Eff e _ -> Spec e Unit


    after' :: forall e. String -> Eff e _ -> Spec e Unit


    afterAsync :: forall e. (T.Done -> Eff e _) -> Spec e Unit


    afterAsync' :: forall e. String -> (T.Done -> Eff e _) -> Spec e Unit


    afterEach :: forall e. Eff e _ -> Spec e Unit


    afterEach' :: forall e. String -> Eff e _ -> Spec e Unit


    afterEachAsync :: forall e. (T.Done -> Eff e _) -> Spec e Unit


    afterEachAsync' :: forall e. String -> (T.Done -> Eff e _) -> Spec e Unit


    before :: forall e. Eff e _ -> Spec e Unit


    before' :: forall e. String -> Eff e _ -> Spec e Unit


    beforeAsync :: forall e. (T.Done -> Eff e _) -> Spec e Unit


    beforeAsync' :: forall e. String -> (T.Done -> Eff e _) -> Spec e Unit


    beforeEach :: forall e. Eff e _ -> Spec e Unit


    beforeEach' :: forall e. String -> Eff e _ -> Spec e Unit


    beforeEachAsync :: forall e. (T.Done -> Eff e _) -> Spec e Unit


    beforeEachAsync' :: forall e. String -> (T.Done -> Eff e _) -> Spec e Unit


    describe :: forall e. String -> Spec e Unit -> Spec e Unit


    it :: forall e. String -> Eff e _ -> Spec e Unit


    itAsync :: forall e. String -> (T.Done -> Eff e _) -> Spec e Unit


    itIs :: forall e a. T.Done -> Eff e a


    itIsNot :: forall e a. T.Done -> String -> Eff e a


    itIsNot' :: forall a. T.Done -> String -> a


    only :: forall e. Spec e Unit -> Spec e Unit


    onlyIf :: forall e. Boolean -> Spec e Unit -> Spec e Unit


    onlyUnless :: forall e. Boolean -> Spec e Unit -> Spec e Unit


    pending :: forall e. String -> Spec e Unit


    setTimeout :: forall e. Number -> Spec e Unit -> Spec e Unit


    skip :: forall e. Spec e Unit -> Spec e Unit


    skipIf :: forall e. Boolean -> Spec e Unit -> Spec e Unit


    skipUnless :: forall e. Boolean -> Spec e Unit -> Spec e Unit



