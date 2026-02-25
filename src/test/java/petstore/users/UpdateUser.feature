@User @UpdateUser
Feature: Actualizar usuario

  Background:
    * url apiPetStore
    * def JsonUsuario = read("classpath:petstore/jasonData/users/UpdateUser.json")

  @HappyPath @UpdateExistingUser
  Scenario: Actualizar usuario existente correctamente

    * def user = JsonUsuario
    * def username = user.username

    # Crear usuario primero
    Given path 'user'
    And request user
    When method post
    Then status 200

    # Modificamos datos
    * set user.firstName = "NombreActualizado"
    * set user.email = "nuevo@email.com"

    # Hacemos update
    Given path 'user', username
    And request user
    When method put
    Then status 200


  @UnHappyPath @UpdateNonExistingUser
  Scenario: Actualizar usuario que no existe

    * def user = JsonUsuario
    * set user.username = "userDoesNotExistXYZ"

    Given path 'user', user.username
    And request user
    When method put
    Then status 200


  @UnHappyPath @UsernameMismatch
  Scenario: Username en path diferente al del body

    * def user = JsonUsuario

    # Crear usuario
    Given path 'user'
    And request user
    When method post
    Then status 200

    * def originalUsername = user.username
    * set user.username = "otroUsername"

    Given path 'user', originalUsername
    And request user
    When method put
    Then status 200


  @UnHappyPath @InvalidBodyStructure
  Scenario: Enviar estructura inválida en update

    * def invalidBody =
      """
      {
        "invalid": "data"
      }
      """

    Given path 'user', 'cualquierUser'
    And request invalidBody
    When method put
    Then status 200


  @UnHappyPath @EmptyUsernamePath
  Scenario: Actualizar usuario con username con solo un espacio

    * def user = JsonUsuario

    Given path 'user', ' '
    And request user
    When method put
    Then status 200

# OBSERVACION GENERAL: La validacion sel username en el path es erronea, acepta todo, ya sea usuario existente
# O inexistente, y ya sea espacion, y todo devuelve un 200