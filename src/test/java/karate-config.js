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
        testPetId: 10,
        nonExistentPetId: 9099887656556,
        nonExistentPetIdFind: 123456788,
        stringPetId: 'text',

        // ── Auth ──
        apiKey: karate.properties['API_KEY'] || 'api-key'
    };

    return config;
}