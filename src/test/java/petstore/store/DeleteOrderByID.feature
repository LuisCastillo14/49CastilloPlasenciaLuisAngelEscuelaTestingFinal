@Store @DeleteOrder
Feature: Eliminar orden de compra

  Background:
    * url apiPetStore
    * def JsonCrearOrden = read("classpath:petstore/jasonData/store/newOrder.json")

  @HappyPath @DeleteExistingOrder
  Scenario: Crear orden y luego eliminarla correctamente

    * def order = JsonCrearOrden
    * set order.id = 7

    # Crear orden
    Given path 'store', 'order'
    And request order
    When method post
    Then status 200

    # Eliminar orden
    Given path 'store', 'order', order.id
    When method delete
    Then status 200

    # Validar que ya no existe
    Given path 'store', 'order', order.id
    When method get
    Then status 404


  @UnHappyPath @DeleteNonExistingOrder
  Scenario: Intentar eliminar orden inexistente

    Given path 'store', 'order', 99999
    When method delete
    Then status 404
    And match response.message contains "Order Not Found"

  @UnHappyPath @DeleteNegativeId
  Scenario: Intentar eliminar orden con ID negativo

    Given path 'store', 'order', -5
    When method delete
    Then status 404
    And match response.message contains "Order Not Found"
    #OBSERVACION: Segun la documentacion no debe aceptar numero negativos, pero probamos y si busca ordenes con un ID negativo


  @UnHappyPath @DeleteInvalidFormat
  Scenario: Intentar eliminar orden con ID no numérico

    Given path 'store', 'order', 'abc'
    When method delete
    Then status 404
    And match response.message contains "NumberFormatException"

