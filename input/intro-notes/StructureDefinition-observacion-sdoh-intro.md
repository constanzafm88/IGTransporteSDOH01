### Introducción al Perfil de Observación SDOH

El perfil **Observación de Determinante Social de la Salud** (`ObservacionSDOH`) define la estructura para representar los resultados del tamizaje de determinantes sociales de forma atómica y computable. Hereda del recurso `Observation` de FHIR.

#### Propósito del Perfil
* **Representación Semántica**: Modela de forma estructurada cada respuesta individual del cuestionario de transporte del paciente.
* **Codificación LOINC**: Cada observación utiliza un código LOINC que identifica exactamente cuál fue la pregunta realizada (ej: problemas de locomoción o costo del pasaje).
* **Evidencia Diagnóstica**: Sirve como insumo documentado para que el profesional de salud realice la posterior validación y confirmación del diagnóstico social.
