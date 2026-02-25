@Store @GetOrder
Feature: Buscar orden por ID

  Background:
    * url apiPetStore
    * def JsonCrearOrden = read("classpath:petstore/jasonData/store/newOrder.json")


  @HappyPath @ExistingOrder
  Scenario: Crear orden y luego buscarla por ID

    * def order = JsonCrearOrden
    * set order.id = 5

    # Crear orden
    Given path 'store', 'order'
    And request order
    When method post
    Then status 200

    # Buscar orden
    Given path 'store', 'order', order.id
    When method get
    Then status 200
    And match response.id == order.id
    And match response.petId == order.petId
    And match response.quantity == order.quantity


  @UnHappyPath @OrderNotFound
  Scenario: Buscar orden con ID inexistente

    Given path 'store', 'order', 99999
    When method get
    Then status 404
    And match response.message contains "Order not found"


  @UnHappyPath @InvalidIdFormat
  Scenario: Buscar orden con ID no numérico

    Given path 'store', 'order', 'abc'
    When method get
    Then status 404
    And match response.message contains "NumberFormatException"