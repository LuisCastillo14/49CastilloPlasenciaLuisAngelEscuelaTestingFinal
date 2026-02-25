@User @Logout
Feature: Cerrar sesión

  Background:
    * url apiPetStore


  @HappyPath @LoginAndLogout
  Scenario: Login y luego logout (Un flujo logico real)

    # Login
    Given path 'user', 'login'
    And param username = 'cualquierUser'
    And param password = 'cualquierPassword'
    When method get
    Then status 200

    # Logout
    Given path 'user', 'logout'
    When method get
    Then status 200
    And match response.message == 'ok'