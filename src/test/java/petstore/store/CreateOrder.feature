@Store @Order
Feature: Crear orden en la tienda

  Background:
    * url apiPetStore
    * def JsonCrearOrden = read("classpath:petstore/jasonData/store/newOrder.json")

  @HappyPath @ValidOrder
  Scenario: Crear orden válida correctamente

    * def order = JsonCrearOrden

    Given path 'store', 'order'
    And request order
    When method post
    Then status 200
    And match response ==
      """
      {
        id: '#number',
        petId: '#number',
        quantity: '#number',
        shipDate: '#string',
        status: '#string',
        complete: '#boolean'
      }
      """


  @UnHappyPath @InvalidStructure
  Scenario: Crear orden con estructura inválida

    * def invalidOrder =
      """
      {
        "invalid": "data"
      }
      """

    Given path 'store', 'order'
    And request invalidOrder
    When method post
    Then status 200
    #OBSERVACION: Deberia devoñver error 400, pero devuelve 200, petstore no valida la estructura de una orden


  @UnHappyPath @EmptyBody
  Scenario: Crear orden enviando body vacío

    Given path 'store', 'order'
    And request {}
    When method post
    Then status 200

  #OBSERVACION: Deberia devoñver error 400, pero devuelve 200, petstore no valida que exista una orden