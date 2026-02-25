@User @CreateUser
Feature: Crear usuario individual

  Background:
    * url apiPetStore
    * def JsonCrearUsuario = read("classpath:petstore/jasonData/users/SingleUser.json")


  @HappyPath @ValidUser
  Scenario: Crear usuario válido correctamente

    * def user = JsonCrearUsuario

    Given path 'user'
    And request user
    When method post
    Then status 200



  @UnHappyPath @EmptyBody
  Scenario: Crear usuario enviando body vacío

    Given path 'user'
    And request {}
    When method post
    Then status 200

    #OBSERVACION: Deberia lanzar error 500 o 400, pero lanza un 200