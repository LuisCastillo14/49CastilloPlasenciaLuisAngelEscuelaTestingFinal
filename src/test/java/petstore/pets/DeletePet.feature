@Pet @DeletePet
Feature: Eliminar una mascota

  Background:
    * url 'https://petstore.swagger.io/v2'
    * def JsonCrearMascota = read("classpath:petstore/jasonData/AddPet.json")


  @HappyPath @DeleteExistingPet
  Scenario: Eliminar una mascota existente (creamos una para validad que existe)
    #LLamamos al escenario de crear para poder eliminar
    * def create = call read("classpath:petstore/pets/AddNewPet.feature@CreateOnePet")

    * def id = create.id
    Given path 'pet', id
    And header api_key = apiKey
    When method delete
    Then status 200

    Given path 'pet', id
    When method get
    Then status 404


  @UnHappyPath @DeleteNonExistingPet
  Scenario: Eliminar una mascota que no exxiste
    #LLamamos al escenario de crear para poder eliminar
    * def create = call read("classpath:petstore/pets/AddNewPet.feature@CreateOnePet")

    * def id = create.id
    Given path 'pet', id
    And header api_key = apiKey
    When method delete
    Then status 200

    #Borramos la mascota que acabamos de borrar
    Given path 'pet', id
    And header api_key = apiKey
    When method delete
    Then status 404

  @UnHappyPath @NonApiKey
  Scenario: Eliminar una mascota existente sin usar apikey
    #LLamamos al escenario de crear para poder eliminar
    * def create = call read("classpath:petstore/pets/AddNewPet.feature@CreateOnePet")

    * def id = create.id
    Given path 'pet', id
    When method delete
    Then status 200
    #OBSERVACIÓN: En casos reales se esperaria un 401, pero como es prueba se recibe un 200


  @UnHappyPath @InvalidApiKey
  Scenario: Eliminar una mascota existente usando apikey invalida
    #LLamamos al escenario de crear para poder eliminar
    * def create = call read("classpath:petstore/pets/AddNewPet.feature@CreateOnePet")

    * def id = create.id
    Given path 'pet', id
    And header api_key = "invalid"
    When method delete
    Then status 200
  #OBSERVACIÓN: En casos reales se esperaria un 401, pero como es prueba se recibe un 200


  @UnHappyPath @StringID
  Scenario: Eliminar una mascota usando el id como texto
    #LLamamos al escenario de crear para poder eliminar
    * def create = call read("classpath:petstore/pets/AddNewPet.feature@CreateOnePet")

    * def id = create.id
    Given path 'pet', stringPetId
    And header api_key = apiKey
    When method delete
    Then status 404
  #OBSERVACIÓN: Se esperaria un error 400, pero si intenta buscar ese ID, y recibe un 404

