### Notas de Implementación y Justificación de Diseño

#### 1. Justificación de la Categoría 59284-0 (Consent Document)

El perfil fija la categoría al código LOINC 59284-0 ("Consent Document") con el objetivo de identificar el recurso como un registro estructurado del consentimiento informado asociado al intercambio de información sobre determinantes sociales de la salud.

* **Representación estructurada del consentimiento:** El recurso `Consent` registra de forma interoperable el estado del consentimiento, el paciente, la organización responsable, la fecha de otorgamiento y las condiciones bajo las cuales se autoriza el tratamiento de la información. La validez jurídica del consentimiento depende de la normativa y de los mecanismos implementados por cada institución de salud.
* **Independencia de la interfaz:** La forma en que el consentimiento es obtenido (por ejemplo, mediante un formulario digital, firma electrónica, firma biométrica o digitalización de un documento físico) corresponde a la aplicación implementadora. El recurso `Consent` representa el permiso otorgado y, cuando sea necesario, puede vincularse con los documentos o evidencias que respalden dicho consentimiento.

#### 2. Advertencia de Compilación: "This Profile is not used by any profiles..."

Es posible que el compilador FHIR indique que este perfil no es referenciado directamente por otros perfiles de la Guía de Implementación.

* **Justificación:** Este mensaje no representa necesariamente un error de modelado. El recurso `Consent` es un recurso independiente dentro del modelo FHIR y puede utilizarse sin estar contenido o referenciado por otro perfil. Su relación con el paciente, la organización y los demás recursos definidos en esta guía se establece mediante referencias (Reference) en tiempo de ejecución y mediante instancias que declaran conformidad con este perfil (`meta.profile`), por lo que esta advertencia no debe interpretarse como una omisión de diseño.

#### 3. Resolución de la Regla Invariante `ppc-1` (Policy vs. PolicyRule)

En HL7 FHIR R4, el invariante `ppc-1` exige que toda instancia del recurso `Consent` declare al menos un elemento `policy` o `policyRule`. Al retirar del perfil el valor fijo de `policyRule` (para mantener la especificación reutilizable y evitar asociarla a normativas extranjeras de investigación como la *Common Rule* estadounidense):
* **Implementación en la Instancia:** La instancia de ejemplo incorpora el elemento `policy` (`policy.authority` y `policy.uri`), cuya URI apunta temporalmente a una política de consentimiento ficticia de la Universidad de Valparaíso (`https://biomedica.uv.cl`).
* **Recomendación para Implementadores:** La institución implementadora deberá reemplazar esta URI por la política normativa o el marco legal institucional aplicable en su jurisdicción local. De esta manera, se satisface el invariante base de FHIR sin forzar en el perfil una regla fija rígida para todos los desarrolladores.
