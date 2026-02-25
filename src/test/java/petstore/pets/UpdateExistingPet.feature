@Pet @UpdatePet
Feature: Actualizar una mascota existente

  Background:
    * url apiPetStore
    * def JsonActualizarMascota = read("classpath:petstore/jasonData/pets/UpdatePet.json")


  @HappyPath @AllStatuses
  Scenario Outline: Actualizar mascota cambiando el status - <status>
    Given path 'pet'
    And def body = JsonActualizarMascota
    And set body.status = '<status>'
    And request body
    When method put
    Then status 200
    And match response.status == '<status>'
    And match response.id == 60

    Examples:
      | status    |
      | available |
      | pending   |
      | sold      |


  @HappyPath @UpdateName
  Scenario: Actualizar el nombre de una mascota existente
    Given path 'pet'
    And def body = JsonActualizarMascota
    And set body.name = 'Firulais'
    And request body
    When method put
    Then status 200
    And match response.name == "Firulais"
    And match response.id == 60


  @HappyPath @UpdateCategory
  Scenario: Actualizar la categoría de una mascota existente
    Given path 'pet'
    And def body = JsonActualizarMascota
    And set body.category.id = 2
    And set body.category.name = 'Gatos'
    And request body
    When method put
    Then status 200
    And match response.category.name == "Gatos"
    And match response.category.id == 2


  @HappyPath @UpdateMultipleFields
  Scenario: Actualizar varios campos a la vez de una mascota existente
    Given path 'pet'
    And def body = JsonActualizarMascota
    And set body.name = 'Rex'
    And set body.status = 'available'
    And set body.category.name = 'Perros'
    And request body
    When method put
    Then status 200
    And match response.name == "Rex"
    And match response.status == "available"
    And match response.category.name == "Perros"


  @UnHappyPath @NonExistentPet
  Scenario: Actualizar una mascota que no existe
    Given path 'pet'
    And def body = JsonActualizarMascota
    And set body.id = nonExistentPetId
    And request body
    When method put
    Then status 200
  # OBSERVACIÓN: retorna 200 aunque el ID no exista (Fue comprobada con el endpoint "ObtenerPorID"),
  # se esperaría un 404 indicando que la mascota no fue encontrada


  @UnHappyPath @EmptyName
  Scenario: Actualizar mascota dejando el nombre vacío
    Given path 'pet'
    And def body = JsonActualizarMascota
    And set body.name = ''
    And request body
    When method put
    Then status 200
    And match response.name == ""
  # OBSERVACIÓN: Se esperaría un 400, Petstore no valida nombre vacío


  @UnHappyPath @InvalidStatus
  Scenario: Actualizar mascota con un status inválido
    Given path 'pet'
    And def body = JsonActualizarMascota
    And set body.status = 'desconocido'
    And request body
    When method put
    Then status 200
    And match response.status == "desconocido"
  # OBSERVACIÓN: Se esperaría un 400, Petstore acepta cualquier valor en status


  @UnHappyPath @UpdatePet @StringID
  Scenario: Actualizar mascota con ID tipo texto
    Given path 'pet'
    And def body = JsonActualizarMascota
    And set body.id = 'texto'
    And request body
    When method put
    Then status 500
    And match response.code == 500
    And match response.message == "something bad happened"
  # OBSERVACIÓN: Se esperaría un 400 indicando tipo de dato inválido