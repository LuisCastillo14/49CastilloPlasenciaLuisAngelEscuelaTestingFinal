package petstore.store;

import com.intuit.karate.junit5.Karate;

public class StoreRunner {
    @Karate.Test
    Karate testPets() {
        return Karate.run("classpath:petstore/store").relativeTo(getClass());
    }
}
