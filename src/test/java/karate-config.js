function fn() {
    var env = karate.env;
    karate.log('karate.env system property was:', env);

    if (!env) {
        env = 'dev';
    }

    var apiPetStore;

    if (env === 'dev') {
        apiPetStore = 'https://petstore.swagger.io/v2';
    } else if (env === 'cert') {
        apiPetStore = 'https://petstore.swagger.io/v2';
    }

    var config = {
        env: env,
        apiPetStore: apiPetStore,

        // ── Pet ──
        testPetId: 60,
        nonExistentPetId: 9099887656556,
        stringPetId: 'text',

        // ── Store ───
        testOrderId: 1,
        nonExistentOrderId: 999999,

        // ── User ──
        testUsername: 'testUser123',
        testUserPassword: karate.properties['USER_PASSWORD'] || 'password123',

        // ── Auth ──
        apiKey: karate.properties['API_KEY'] || 'api-key'
    };

    return config;
}