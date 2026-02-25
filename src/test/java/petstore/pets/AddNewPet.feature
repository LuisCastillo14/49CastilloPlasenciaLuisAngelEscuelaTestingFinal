@Pet @CreatePet
Feature: Agregar nueva mascota

  Background:
    * url apiPetStore
    * def JsonCrearMascota = read("classpath:petstore/jasonData/AddPet.json")

  @CreateOnePet
  Scenario: Crear una mascota
    Given path 'pet'
    And request JsonCrearMascota
    When method post
    Then status 200

    * def id = response.id

  @HappyPath @AllStatus
  Scenario Outline: Crear mascota con diferentes estatus - <status>
    Given path 'pet'
    And def body = JsonCrearMascota
    And set body.status = '<status>'
    And set body.id = <id>
    And request body
    When method post
    Then status 200
    And match response.status == '<status>'
    And match response.name == "Benji"

    Examples:
      | status    | id  |
      | available | 61  |
      | pending   | 62  |
      | sold      | 63  |



  @UnHappyPath @EmptyName
  Scenario: Crear mascota con nombre vacío
    Given path 'pet'
    And def body = JsonCrearMascota
    And set body.name = ''
    And request body
    When method post
    Then status 200
    And match response.name == ""
  # OBSERVACIÓN: Se esperaría un 400, Petstore no valida nombre vacío



  @UnHappyPath @InvalidStatus
  Scenario: Crear mascota con status inválido
    Given path 'pet'
    And def body = JsonCrearMascota
    And set body.status = 'desconocido'
    And request body
    When method post
    Then status 200
    And match response.status == "desconocido"
  # OBSERVACIÓN: Se esperaría un 400, Petstore acepta cualquier valor en status


  @UnHappyPath @StringID
  Scenario: Crear mascota con ID tipo texto
    Given path 'pet'
    And def body = JsonCrearMascota
    And set body.id = 'texto'
    And request body
    When method post
    Then status 500
    And match response.code == 500
    And match response.message == "something bad happened"
  # OBSERVACIÓN: El servidor no maneja adecuadamente IDs no numéricos,
  # se esperaría un 400 indicando tipo de dato inválido