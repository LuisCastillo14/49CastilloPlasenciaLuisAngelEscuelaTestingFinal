@User @Login
Feature: Login (Aqui lanza 200 para cualquier username y password, asi que no e sposible hacer validaciones)

  Background:
    * url apiPetStore
    * def JsonUsuario = read("classpath:petstore/jasonData/users/UpdateUser.json")


  @HappyPath @ValidLogin
  Scenario: Login con credenciales válidas

    Given path 'user', 'login'
    And param username = "username"
    And param password = "password"
    When method get
    Then status 200
    And match response.message contains 'logged'


  # SOLO PARA CUESTION PRACTICA HACEMOS ESCENARIOS AUNQUE SIEMPRE DEVUELVA 200
  @UnHappyPath @LoginNonExistingUser
  Scenario: Login con usuario que no existe

    Given path 'user', 'login'
    And param username = 'userDoesNotExistXYZ'
    And param password = '12345'
    When method get
    Then status 200

  @UnHappyPath @EmptyUsername
  Scenario: Login con username vacío

    Given path 'user', 'login'
    And param username = ''
    And param password = '12345'
    When method get
    Then status 200