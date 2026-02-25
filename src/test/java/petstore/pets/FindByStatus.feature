@FindPetByStatus
Feature: Buscar mascotas por estado

  Background:
    * url apiPetStore


  @HappyPath @SingleStatus
  Scenario Outline: Buscar mascotas con status "<status>"
    Given path 'pet', 'findByStatus'
    And param status = '<status>'
    When method get
    Then status 200
    And match each response[*].status == '<status>'

    Examples:
      | status    |
      | available |
      | pending   |
      | sold      |


  @HappyPath @MultipleStatuses
  Scenario: Buscar mascotas enviando múltiples status a la vez
    Given path 'pet', 'findByStatus'
    And param status = 'available'
    And param status = 'pending'
    When method get
    Then status 200
    And match response[*].status contains any ['available', 'pending']


  @HappyPath @AllStatuses
  Scenario: Buscar mascotas enviando los 3 status a la vez
    Given path 'pet', 'findByStatus'
    And param status = 'available'
    And param status = 'pending'
    And param status = 'sold'
    When method get
    Then status 200
    And assert response.length > 0


  @UnHappyPath @InvalidStatus
  Scenario: Buscar mascotas con status inválido
    Given path 'pet', 'findByStatus'
    And param status = 'desconocido'
    When method get
    Then status 200
    And match response == []
  # OBSERVACIÓN: Se esperaría un 400, pero Petstore retorna 200 con lista vacía


  @UnHappyPath @EmptyStatus
  Scenario: Buscar mascotas enviando status vacío
    Given path 'pet', 'findByStatus'
    And param status = ''
    When method get
    Then status 200
  # OBSERVACIÓN: Se esperaría un 400, Petstore retorna 200


  @UnHappyPath @NoParam
  Scenario: Buscar mascotas sin enviar el parámetro status
    Given path 'pet', 'findByStatus'
    When method get
    Then status 200
  # OBSERVACIÓN: Se esperaría un 400, pero retorna un 200