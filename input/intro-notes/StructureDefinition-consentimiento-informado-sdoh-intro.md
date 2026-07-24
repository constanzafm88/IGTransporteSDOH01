### Introducción al Perfil de Consentimiento Informado

El perfil **Consentimiento Informado - Transporte SDOH** (`ConsentimientoInformadoSDOH`) define la estructura para representar formalmente la autorización que otorga el paciente para compartir y procesar su información sobre determinantes sociales de la salud con fines de coordinación asistencial.

Este perfil no pretende redefinir el recurso `Consent` de FHIR, sino restringirlo para representar el consentimiento informado utilizado en el proceso de tamizaje SDOH descrito en esta guía.

#### Decisiones de Diseño de la Implementación
* **Derivación Estándar:** El perfil deriva directamente del recurso base `Consent` de HL7 FHIR R4, heredando toda su semántica oficial de consentimiento.
* **Reutilización del Estándar Nacional (Core CL):** En lugar de redefinir entidades administrativas, reutiliza los perfiles de la guía nacional Core CL (HL7 Chile) para el prestador de salud (`PractitionerRole` / `Practitioner`) y la organización/establecimiento (`Organization`).
* **Restricciones Específicas para APS y SDOH:** Restringe la categoría del consentimiento al código LOINC `59284-0` (*Consent Document*), fuerza el tipo de consentimiento a la privacidad del paciente (`patient-privacy`) y establece una regla de política común de consentimiento informado (*Common Rule Informed Consent*), garantizando su pertinencia en la atención primaria de salud.
