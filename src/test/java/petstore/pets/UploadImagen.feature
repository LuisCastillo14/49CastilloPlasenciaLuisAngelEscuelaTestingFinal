@Pet @UploadImage
Feature: Subir una foto de una mascota existente

  Background:
    * url apiPetStore

  @HappyPath @UploadJPG
  Scenario: Subir una imagen en formato válido (JPG) para una mascota existente
    * def petId = testPetId
    Given path 'pet', petId, 'uploadImage'
    And multipart file file = { read: 'classpath:petstore/files/validFiles/perrito.jpg', filename: 'perrito.jpg', contentType: 'image/jpeg' }
    And multipart field additionalMetadata = 'Foto de perfil actualizada'
    When method post
    Then status 200
    And match response.message contains 'perrito.jpg'



  @HappyPath @UploadPNG
  Scenario: Subir una imagen en formato válido (PNG) para una mascota existente
    * def petId = testPetId
    Given path 'pet', petId, 'uploadImage'
    And multipart file file = { read: 'classpath:petstore/files/validFiles/perrito2.png', filename: 'perrito2.png', contentType: 'image/png' }
    And multipart field additionalMetadata = 'Foto de perfil actualizada'
    When method post
    Then status 200
    And match response.message contains 'perrito2.png'



  @HappyPath @EmptyMetadata
  Scenario: Subir una imagen en formato válido para una mascota existente pero dejando vacio el campo opcional "Aditional Metadata"
    * def petId = testPetId
    Given path 'pet', petId, 'uploadImage'
    And multipart file file = { read: 'classpath:petstore/files/validFiles/perrito2.png', filename: 'perrito2.png', contentType: 'image/png' }
    And multipart field additionalMetadata = ''
    When method post
    Then status 200
    And match response.message contains 'perrito2.png'


  @UnHappyPath @NonExistentPet
  Scenario: Subir una imagen válida para una mascota que no existe
    * def petId = nonExistentPetId
    Given path 'pet', petId, 'uploadImage'
    And multipart file file = { read: 'classpath:petstore/files/validFiles/perrito2.png', filename: 'perrito2.png', contentType: 'image/png' }
    And multipart field additionalMetadata = 'Foto de perfil actualizada'
    When method post
    Then status 404


  @UnHappyPath @StringID
  Scenario: Subir una imagen válida para una mascota ingresando texto como ID
    * def petId = stringPetId
    Given path 'pet', petId, 'uploadImage'
    And multipart file file = { read: 'classpath:petstore/files/validFiles/perrito2.png', filename: 'perrito2.png', contentType: 'image/png' }
    And multipart field additionalMetadata = 'Foto de perfil actualizada'
    When method post
    Then status 404
    # OBSERVACIÓN: Se esperaría un 400, pero se obtiene un 404 que indica que si intento buscar la mascota con ese ID


  @UnHappyPath @InvalidFile
  Scenario: Subir archivo no imagen a mascota existente - API no valida tipo de archivo
    * def petId = testPetId
    Given path 'pet', petId, 'uploadImage'
    And multipart file file = { read: 'classpath:petstore/files/InvalidFiles/text.txt', filename: 'text.txt', contentType: 'text/plain' }
    And multipart field additionalMetadata = 'Foto de perfil con archivo invalido'
    When method post
    Then status 200
    And match response.message contains 'text.txt'
  # OBSERVACIÓN: Se esperaría un 400, pero Petstore no implementa validación de tipo de archivo