@User @CreateWithList
Feature: Crear usuarios usando lista

  Background:
    * url apiPetStore
    * def JsonCrearUsuarios = read("classpath:petstore/jasonData/users/listUsers.json")
    * def JsonCrearUnUsuario = read("classpath:petstore/jasonData/users/OneUser.json")

  @HappyPath @ValidUsers
  Scenario: Crear múltiples usuarios válidos

    * def users = JsonCrearUsuarios
    Given path 'user', 'createWithList'
    And request users
    When method post
    Then status 200

  @HappyPath @ValidOneUsers
  Scenario: Crear solo un usuario

    * def users = JsonCrearUnUsuario
    Given path 'user', 'createWithList'
    And request users
    When method post
    Then status 200


  @HappyPath @EmptyList
  Scenario: Crear usuarios enviando lista vacía

    * def users = []
    Given path 'user', 'createWithList'
    And request users
    When method post
    Then status 200
    # OBSERVACION: Deberia responder con un error 400, pero petstore no valida que la lista no debe estar vacia

  @UnHappyPath @InvalidStructure
  Scenario: Enviar estructura incorrecta

    * def users =
      """
      {
        "invalid": "data"
      }
      """

    Given path 'user', 'createWithList'
    And request users
    When method post
    Then status 500