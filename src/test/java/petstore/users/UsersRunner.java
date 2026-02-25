package petstore.users;

import com.intuit.karate.junit5.Karate;

class UsersRunner {
    
    @Karate.Test
    Karate testPets() {
        return Karate.run("classpath:petstore/users").relativeTo(getClass());
    }    

}
