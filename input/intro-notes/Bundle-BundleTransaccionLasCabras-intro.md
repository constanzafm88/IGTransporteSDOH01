### ¿Qué es el Bundle de Transacción y cómo funciona?

Este ejemplo representa el recurso **Bundle de tipo `transaction`** (`BundleTransaccionLasCabras`). Es el payload de datos oficial y recomendado que un Registro Clínico Electrónico (RCE/EHR) de APS envía al servidor FHIR para persistir los resultados del tamizaje de transporte.

---

#### 1. Propósito Operativo: La Persistencia Indexada
A diferencia de un documento estático, un Bundle de tipo `transaction` funciona como una **orden de base de datos atómica**. 
Al ser enviado al endpoint raíz del servidor FHIR (ej: `POST http://servidor-fhir.cl/r4/`), le ordena al servidor:
* **Desempaquetar la caja:** El servidor debe abrir el Bundle y extraer cada uno de los recursos que vienen dentro.
* **Persistir de forma independiente:** Debe guardar el recurso `QuestionnaireResponse` y cada una de las siete recursos `Observation` de forma independiente.
* **Permitir búsquedas futuras:** Al quedar guardados individualmente, los datos se indexan, permitiendo búsquedas clínicas directas como `GET /Observation?code=93030-5` (cosa que es improbable si se guardan en un Bundle de tipo `collection` sin desempaquetar).

---

#### 2. Diferencia Crítica: `collection` vs. `transaction`

| Característica | Bundle Collection (FML) | Bundle Transaction (Persistencia) |
| :--- | :--- | :--- |
| **Origen** | Salida directa generada por las reglas del `StructureMap` (FML). | Construido por la aplicación clínica implementadora a partir de los datos mapeados. |
| **Comportamiento** | Funciona como un "documento asociativo" (como un ZIP). Guarda todos los datos en un solo bloque. | Funciona como una "transacción de base de datos atómica". |
| **Indexación** | Por sí solo no define operaciones de persistencia ni garantiza el almacenamiento indexado de los recursos. | **Indexa.** Cada observación se almacena como un recurso clínico suelto asociado al paciente. |
| **Búsquedas** | No permite hacer consultas individuales de observaciones desde sistemas externos si se almacena como recurso completo. | Permite explotar los datos de forma atómica para analítica y salud poblacional. |

---

#### 3. Anatomía del Código del Ejemplo
En la especificación de este ejemplo, notarás la siguiente estructura clave:
* **`type = #transaction`**: Fija el comportamiento operativo atómico. O se guardan todos los recursos con éxito, o el servidor hace un *rollback* completo (no se guarda nada si uno falla), garantizando la integridad de la ficha clínica.
* **`entry.resource`**: Contiene el recurso clínico real (las observaciones del tamizaje y la respuesta al cuestionario).
* **`entry.request.method = #PUT`**: Indica la operación HTTP que debe aplicar el servidor (crear o actualizar).
* **`entry.request.url`**: Especifica la ruta lógica y el ID específico donde debe alojarse cada recurso (ej: `Observation/ObsTransporte01`).

---

#### 4. Flujo Clínico de Persistencia (Paso a Paso)
1. **Tamizaje:** El paciente responde el cuestionario de transporte y el sistema genera un recurso `QuestionnaireResponse`.
2. **Mapeo FML:** El motor de transformación ejecuta el `StructureMap` (FML) y produce como resultado un `Bundle` de tipo `collection` que contiene las siete `Observation` estructuradas y codificadas mediante LOINC.
3. **Orquestación:** La aplicación clínica reutiliza el `QuestionnaireResponse` original y las `Observation` generadas por el `StructureMap`, agrega las instrucciones `request` (método `PUT`) correspondientes y construye un `Bundle` de tipo `transaction`.
4. **Persistencia:** El sistema del CESFAM envía el `Bundle` `Transaction` al servidor FHIR mediante una única operación transaccional.
5. **Almacenamiento:** El servidor FHIR procesa la transacción y persiste de forma independiente el `QuestionnaireResponse` y cada una de las `Observation`, permitiendo su indexación y posterior consulta mediante los mecanismos estándar de búsqueda de FHIR.
