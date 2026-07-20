### Notas de Implementación y Justificación de Diseño

#### 1. Justificación de la Categoría `59284-0` (Consent Document)
El perfil fuerza la categoría al código LOINC `59284-0` ("Consent Document"). Esto se justifica de la siguiente manera para el desarrollo e implementación del software clínico:
* **Representación del Acto Legal**: Este perfil representa el registro jurídico inmutable de que el consentimiento ha sido otorgado, funcionando como el "documento o registro de consentimiento".
* **Independencia de Interfaz**: La forma en que se recopila la firma del paciente (ya sea a través de un cuestionario digital interactivo `QuestionnaireResponse`, firma biométrica o digitalización de papel firmado físicamente) es parte de la capa de aplicación. El recurso `Consent` actúa como el repositorio consolidado del permiso y puede enlazarse a esos otros artefactos en caso de requerirse.

#### 2. Advertencia de Compilación "This Profile is not used by any profiles..."
Es posible que el compilador FHIR genere una advertencia indicando que este perfil no es usado por ningún otro perfil de la Guía de Implementación. 
* **Justificación**: Esto es un comportamiento estándar y correcto en FHIR. El recurso `Consent` es un recurso raíz independiente. No está anidado estructuralmente dentro de otros perfiles (como sí lo está una extensión). El enlace con el paciente u otros recursos de la guía se realiza a través de referencias lógicas (`Reference`) en tiempo de ejecución, por lo que no debe interpretarse como una omisión de diseño.
