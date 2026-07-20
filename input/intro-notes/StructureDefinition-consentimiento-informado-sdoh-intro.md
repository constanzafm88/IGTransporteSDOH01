### Introducción al Perfil de Consentimiento Informado

El perfil **Consentimiento Informado - Transporte SDOH** (`ConsentimientoInformadoSDOH`) define la estructura para representar formalmente la autorización que otorga el paciente para compartir y procesar su información sobre determinantes sociales de la salud con fines de coordinación asistencial. Hereda del recurso `Consent` de FHIR.

#### Propósito del Perfil
* **Soporte Ético y Legal**: Registra la conformidad explícita del paciente para el intercambio de datos sensibles entre el CESFAM, profesionales APS y entidades sociales.
* **Privacidad del Paciente**: Fija el alcance del consentimiento en la privacidad (`patient-privacy`) y establece una regla de política común de consentimiento informado (`Common Rule Informed Consent`).
* **Trazabilidad**: Permite auditar en qué momento exacto (`dateTime`) y bajo qué términos el paciente (`patient`) otorgó el permiso.
