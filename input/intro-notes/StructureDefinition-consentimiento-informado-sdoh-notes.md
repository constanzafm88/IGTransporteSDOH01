### Notas de Implementación y Justificación de Diseño

#### 1. Justificación de la Categoría 59284-0 (Consent Document)

El perfil fija la categoría al código LOINC 59284-0 ("Consent Document") con el objetivo de identificar el recurso como un registro estructurado del consentimiento informado asociado al intercambio de información sobre determinantes sociales de la salud.

* **Representación estructurada del consentimiento:** El recurso `Consent` registra de forma interoperable el estado del consentimiento, el paciente, la organización responsable, la fecha de otorgamiento y las condiciones bajo las cuales se autoriza el tratamiento de la información. La validez jurídica del consentimiento depende de la normativa y de los mecanismos implementados por cada institución de salud.
* **Independencia de la interfaz:** La forma en que el consentimiento es obtenido (por ejemplo, mediante un formulario digital, firma electrónica, firma biométrica o digitalización de un documento físico) corresponde a la aplicación implementadora. El recurso `Consent` representa el permiso otorgado y, cuando sea necesario, puede vincularse con los documentos o evidencias que respalden dicho consentimiento.

#### 2. Advertencia de Compilación: "This Profile is not used by any profiles..."

Es posible que el compilador FHIR indique que este perfil no es referenciado directamente por otros perfiles de la Guía de Implementación.

* **Justificación:** Este mensaje no representa necesariamente un error de modelado. El recurso `Consent` es un recurso independiente dentro del modelo FHIR y puede utilizarse sin estar contenido o referenciado por otro perfil. Su relación con el paciente, la organización y los demás recursos definidos en esta guía se establece mediante referencias (Reference) en tiempo de ejecución y mediante instancias que declaran conformidad con este perfil (`meta.profile`), por lo que esta advertencia no debe interpretarse como una omisión de diseño.
