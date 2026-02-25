@Store @Inventory
Feature: Obtener inventario de la tienda

  Background:
    * url apiPetStore

  @HappyPath @ValidateInventoryStructure
  Scenario: Validar que el inventario tenga valores numéricos

    Given path 'store', 'inventory'
    When method get
    Then status 200
