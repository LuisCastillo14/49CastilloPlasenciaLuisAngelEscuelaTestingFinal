@User @GetUserByUsername
Feature: Buscar usuario por username

  Background:
    * url apiPetStore
    * def JsonCrearUnUsuario = read("classpath:petstore/jasonData/users/OneUser.json")

  @HappyPath @ExistingUser
  Scenario: Buscar usuario existente por username

    * def users = JsonCrearUnUsuario
    * def username = users[0].username
    * def email = users[0].email

    # Crear usuario usando lista
    Given path 'user', 'createWithList'
    And request users
    When method post
    Then status 200

    # Buscar usuario creado
    Given path 'user', username
    When method get
    Then status 200
    And match response.username == username
    And match response.email == email


  @UnHappyPath @NonExistingUser
  Scenario: Buscar usuario que no existe

    Given path 'user', 'usuarioInexistenteXYZ'
    When method get
    Then status 404
    And match response.message == "User not found"

  @UnHappyPath @EmptyUsername
  Scenario: Buscar usuario con username con solo un espacio

    Given path 'user', ' '
    When method get
    Then status 404
    #OBSERVACIÓN: Deberia lanzar un 400 (Bad Request), pero intenta buscar ese username y lanza un 404


  @UnHappyPath @SpecialCharacters
  Scenario: Buscar usuario con caracteres especiales

    * def invalidUsername = '@@@###$$$'

    Given path 'user', invalidUsername
    When method get
    Then status 404
  #OBSERVACIÓN: Deberia lanzar un 400 (Bad Request), pero intenta buscar ese username y lanza un 404