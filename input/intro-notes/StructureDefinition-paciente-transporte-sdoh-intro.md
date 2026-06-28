### Introducción al Perfil del Paciente SDOH

El perfil **Paciente - Transporte SDOH** (`PacienteTransporteSDOH`) adapta el recurso estándar `Patient` de FHIR para representar a los pacientes de Atención Primaria de Salud (APS) en Chile bajo el contexto de la evaluación de Determinantes Sociales de la Salud (SDOH).

#### Propósito del Perfil
* **Estandarización Nacional**: Hereda directamente del perfil `CorePacienteCl` de la Guía HL7 Chile (Core CL), asegurando el cumplimiento de la normativa nacional para el registro de datos demográficos y administrativos.
* **Georreferenciación Local**: Restringe el registro de residencia para exigir el uso del **Código Único Territorial (CUT)** oficial chileno a nivel de comunas, lo que facilita el análisis epidemiológico y social por sector familiar.
