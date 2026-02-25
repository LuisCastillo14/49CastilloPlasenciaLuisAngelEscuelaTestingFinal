# Escuela Testing - Automatización API PetStore con Karate

Este proyecto implementa pruebas automatizadas para la API de PetStore usando Karate y JUnit5. El objetivo es validar los endpoints de mascotas, usuarios y tienda, cubriendo escenarios tanto positivos (Happy Path) como negativos (UnHappy Path).

## Estructura del proyecto

- **src/test/java/petstore/pets/**: Pruebas de endpoints de mascotas (features y runner).
- **src/test/java/petstore/store/**: Pruebas de endpoints de tienda (features y runner).
- **src/test/java/petstore/users/**: Pruebas de endpoints de usuarios (features y runner).
- **src/test/java/petstore/jasonData/**: Archivos JSON para datos de prueba.
- **karate-config.js**: Configuración de entornos y variables globales.
- **pom.xml**: Configuración de Maven y dependencias.

## ¿Qué hace la automatización?

- Valida la creación, actualización, búsqueda y eliminación de mascotas.
- Prueba la gestión de usuarios y órdenes de tienda.
- Ejecuta pruebas en diferentes entornos (`dev`, `cert`).
- Permite filtrar pruebas por tags: @Pet, @User, @Store, @HappyPath, @UnHappyPath.

## ¿Cómo se ejecuta?

Asegúrate de tener Java y Maven instalados. Ejecuta los siguientes comandos según lo que quieras probar:

- **Todos los tests en entorno dev:**
   ```
   mvn clean test -Dkarate.env=dev
   ```
- **Todos los tests en entorno cert:**
   ```
   mvn clean test -Dkarate.env=cert
   ```
- **Solo tests de Pets:**
   ```
   mvn clean test -Dtest=PetsRunner -Dkarate.options="--tags @Pet"
   ```
- **Solo tests de User:**
   ```
   mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @User"
   ```
- **Solo tests de Store:**
   ```
   mvn clean test -Dtest=StoreRunner -Dkarate.options="--tags @Store"
   ```
- **Tests HappyPath:**
   ```
   mvn clean test -Dkarate.options="--tags @HappyPath"
   ```
- **Tests UnHappyPath:**
   ```
   mvn clean test -Dkarate.options="--tags @UnHappyPath"
   ```
- **Tests HappyPath de una carpeta específica:**
   ```
   mvn clean test -Dkarate.options="--tags @HappyPath @Pet"
   mvn clean test -Dkarate.options="--tags @HappyPath @User"
   mvn clean test -Dkarate.options="--tags @HappyPath @Store"
   ```

Los reportes se generan en la carpeta `target/karate-reports`.

## Observaciones importantes

Durante la automatización se detectaron varios comportamientos inesperados en la API de PetStore:

- **Validaciones insuficientes:** La API acepta nombres vacíos, status inválidos y IDs tipo texto en la creación y actualización de mascotas, cuando lo correcto sería retornar errores 400.
- **Eliminación sin autenticación:** El endpoint permite eliminar mascotas sin apikey o con apikey inválida, retornando 200 en vez de 401.
- **Búsqueda por status:** Cuando se envía un status inválido o vacío, la API retorna 200 y una lista vacía, en vez de un error.
- **Actualización y eliminación de recursos inexistentes:** Al intentar actualizar o eliminar recursos que no existen, la API retorna 200 o 404, pero no siempre de forma consistente.
- **IDs negativos o tipo texto:** En algunos endpoints, IDs negativos o tipo texto no son validados correctamente, retornando 404 o 500 en vez de 400.

Estas observaciones están documentadas en los escenarios UnHappyPath de los archivos `.feature`.

