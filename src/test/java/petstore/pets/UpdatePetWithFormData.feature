@Pet @UpdatePetFormData
Feature: Actualizar mascota con form data

  Background:
    * url apiPetStore


  @HappyPath @UpdateName
  Scenario: Actualizar nombre de mascota existente
    Given path 'pet', testPetId
    And form field name = 'Firulais'
    When method post
    Then status 200



  @HappyPath @UpdateStatus
  Scenario: Actualizar status de mascota existente
    Given path 'pet', testPetId
    And form field status = 'sold'
    When method post
    Then status 200



  @HappyPath @UpdateBothFields
  Scenario: Actualizar nombre y status a la vez
    Given path 'pet', testPetId
    And form field name = 'Rex'
    And form field status = 'pending'
    When method post
    Then status 200



  @HappyPath @AllStatuses
  Scenario Outline: Actualizar mascota con cada status valido - <status>
    Given path 'pet', testPetId
    And form field name = 'Benji'
    And form field status = '<status>'
    When method post
    Then status 200

    Examples:
      | status    |
      | available |
      | pending   |
      | sold      |


  @UnHappyPath @NonExistentPet
  Scenario: Actualizar mascota con ID que no existe via form data
    Given path 'pet', nonExistentPetId
    And form field name = 'Firulais'
    And form field status = 'available'
    When method post
    Then status 404
  # OBSERVACIÓN: Se esperaría un 404 indicando que la mascota no existe


  @UnHappyPath @StringID
  Scenario: Actualizar mascota con ID tipo texto
    Given path 'pet', stringPetId
    And form field name = 'Firulais'
    And form field status = 'available'
    When method post
    Then status 404
  # OBSERVACIÓN: Se esperaría un 400 por tipo de dato inválido, pero se obtiene un 200


  @UnHappyPath @InvalidStatus
  Scenario: Actualizar mascota con status inválido via form data
    Given path 'pet', testPetId
    And form field status = 'desconocido'
    When method post
    Then status 200
  # OBSERVACIÓN: Se esperaría un 400, pero se recibe un 200 por que no valida el valor del status


  @UnHappyPath @NoFields
  Scenario: Actualizar mascota sin enviar ningún campo
    Given path 'pet', testPetId
    When method post
    Then status 200
  # OBSERVACIÓN: Se esperaría un 400, pero retorna un 200