@User @DeleteUser
Feature: Eliminar un usuario por el username

  Background:
    * url apiPetStore
    * def JsonUsuario = read("classpath:petstore/jasonData/users/DeleteUser.json")


  @HappyPath @DeleteExistingUser
  Scenario: Eliminar usuario existente correctamente

    * def user = JsonUsuario
    * def username = user.username

    # Crear usuario
    Given path 'user'
    And request user
    When method post
    Then status 200

    # Eliminar usuario
    Given path 'user', username
    When method delete
    Then status 200

    # Validar que ya no existe
    Given path 'user', username
    When method get
    Then status 404


  @UnHappyPath @DeleteNonExistingUser
  Scenario: Eliminar usuario que no existe

    * def nonExistingUsername = 'userDoesNotExistXYZ123XYZ'

    Given path 'user', nonExistingUsername
    When method delete
    Then status 404


  @UnHappyPath @DeleteEmptyUsername
  Scenario: Eliminar usuario con username con solo un espacio

    Given path 'user', ' '
    When method delete
    Then status 404


  @UnHappyPath @DeleteSpecialCharacters
  Scenario: Eliminar usuario con caracteres especiales

    * def invalidUsername = '@@@###'

    Given path 'user', invalidUsername
    When method delete
    Then status 404
