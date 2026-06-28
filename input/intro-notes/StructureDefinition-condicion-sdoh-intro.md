### Introducción al Perfil de Condición SDOH

El perfil **Condición de Determinante Social de la Salud** (`CondicionSDOHSDOH`) adapta el recurso `Condition` de FHIR para registrar formalmente los diagnósticos de riesgo social en la lista de problemas activa del paciente en la Atención Primaria de Salud (APS) de Chile.

#### Propósito del Perfil
* **Formalización Diagnóstica**: Registra de forma oficial el diagnóstico de vulnerabilidad social evaluado por el/la profesional (ej: Trabajador/a Social).
* **Vinculación con la Evidencia**: Enlaza directamente las respuestas de tamizaje (`ObservacionSDOH`) que sirvieron como sustento para realizar la confirmación del diagnóstico.
* **Visibilidad en el Control de Salud**: Permite que cualquier médico, enfermero o profesional del equipo de cabecera visualice la alerta activa de riesgo de transporte durante la consulta clínica habitual.
