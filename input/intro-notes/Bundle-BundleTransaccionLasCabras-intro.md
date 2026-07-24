### ¿Por qué y cómo utilizar el Bundle de Transacción?

Este ejemplo representa el recurso **Bundle de tipo `transaction`** (`BundleTransaccionLasCabras`). Es el payload de datos oficial y recomendado para persistir los resultados del tamizaje de transporte en la APS chilena.

---

#### 1. ¿Por qué utilizar un Bundle de tipo Transacción?

En los flujos de integración FHIR reales, **no es recomendable guardar la encuesta completa como un bloque único indivisible (como sucedería con un Bundle de tipo `collection`)**. Se debe utilizar un Bundle `transaction` por las siguientes razones:

* **Persistencia Atómica e Integridad:** Funciona como una transacción clásica de base de datos ("todo o nada"). Si el registro de una sola observación falla por problemas de validación, el servidor FHIR realiza un *rollback* completo de la operación. Esto garantiza que no queden encuestas incompletas o huérfanas en la ficha clínica del paciente.
* **Indexación Individual para Búsquedas:** Al recibir la transacción, el servidor FHIR **desempaqueta el Bundle** y persiste de forma independiente el cuestionario (`QuestionnaireResponse`) y cada una de las observaciones (`Observation`). Esto permite realizar consultas clínicas y análisis poblacionales directos sobre los datos (ej: consultar a cuántos pacientes les falta locomoción mediante `GET /Observation?code=93030-5`).

---

#### 2. ¿Cómo y cuándo implementarlo?

Este Bundle de transacción es construido y orquestado directamente por la aplicación clínica implementadora (RCE/EHR):

1. **Destino de Envío:** Se envía mediante un único método **`POST`** al endpoint raíz del servidor FHIR (ej: `POST https://api.servidor-fhir.cl/r4/`).
2. **Instrucciones de Persistencia:** Cada elemento dentro del arreglo `entry` debe llevar una instrucción `request` que le indique al servidor qué hacer con el recurso:
   * **`request.method = #PUT`**: Ordena crear o actualizar el recurso específico.
   * **`request.url`**: Especifica la ruta lógica y el ID específico asignado al recurso dentro de la base de datos (ej: `Observation/ObsTransporte01`).
3. **Referencias Cruzadas:** Las observaciones y el cuestionario deben referenciar correctamente el ID del paciente (`Patient`) y del prestador (`PractitionerRole`) que participaron en el tamizaje, asegurando la trazabilidad clínica y social.
