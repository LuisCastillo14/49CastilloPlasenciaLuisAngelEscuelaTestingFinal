@FindPetById
Feature: Buscar mascota por ID

  Background:
    * url apiPetStore


  @HappyPath @FindById @ExistingPet
  Scenario: Buscar mascota con ID existente
    Given path 'pet', testPetId
    When method get
    Then status 200
    And match response.id == testPetId
    And match response.name != null
    And match response.status != null


  @UnHappyPath @FindById @NonExistentPet
  Scenario: Buscar mascota con ID que no existe
    Given path 'pet', nonExistentPetIdFind
    When method get
    Then status 404
    And match response.message == "Pet not found"


  @UnHappyPath @FindById @StringID
  Scenario: Buscar mascota con ID tipo texto
    Given path 'pet', stringPetId
    When method get
    Then status 404
  # OBSERVACIÓN: Se esperaría un 400 por tipo de dato inválido,
  # pero Petstore retorna 404



  @UnHappyPath @FindById @NegativeID
  Scenario: Buscar mascota con ID negativo
    Given path 'pet', -12
    When method get
    Then status 404
  # OBSERVACIÓN: IDs negativos no deberían ser válidos, se esperaría un 400