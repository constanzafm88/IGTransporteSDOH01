# Aspectos Técnicos y Puente Semántico

El intercambio seguro, fluido y comprensible de información sobre determinantes sociales (SDOH) exige una traducción rigurosa entre el lenguaje del tamizaje respondido por el paciente, el lenguaje clínico-social del profesional y la codificación estadística exigida por la normativa ministerial. Esta sección describe la justificación técnica de la terminología seleccionada y el diseño del "puente semántico" implementado.

---

## 1. Justificación de la Terminología Seleccionada

Para posibilitar un intercambio semántico seguro y transparente, esta guía implementa un **"puente semántico"** utilizando tres vocabularios estándar mundiales y locales:

| Estándar | Componente FHIR | Rol y Justificación Técnica |
| :--- | :--- | :--- |
| **LOINC** | `QuestionnaireResponse`<br>`Observation.code` | **Codificación de Preguntas y Respuestas**: LOINC (Logical Observation Identifiers Names and Codes) permite definir y estandarizar de forma inequívoca las preguntas del tamizaje de transporte (ej: código `93030-5` para la pregunta sobre problemas de transporte en el último año). Garantiza la consistencia semántica independientemente del software que implemente la encuesta. |
| **SNOMED CT** | `Condition.code` | **Codificación del Diagnóstico Clínico-Social**: SNOMED CT (Systematized Nomenclature of Medicine) provee la granularidad clínica necesaria para registrar formalmente el diagnóstico de vulnerabilidad en la lista de problemas del paciente. Se utiliza el concepto estándar internacional `713458007` (*Lack of access to transportation*). |
| **CIE-10 (Códigos Z)** | `Condition.category`<br>`Condition.code.coding` | **Reportabilidad Estadística Nacional**: La Clasificación Internacional de Enfermedades (CIE-10) es obligatoria para reportar al Ministerio de Salud de Chile (registros REM). Al mapear secundariamente la condición a los códigos Z de determinantes sociales (como el código `Z59.82` para Inseguridad de Transporte), la FCE genera de forma automatizada las estadísticas reglamentarias sin requerir doble digitación del clínico. |

---

## 2. Coherencia Semántica en el Proceso

El puente semántico garantiza que el dato recolectado siga un ciclo de vida coherente:
1. **Captura en LOINC**: El paciente responde preguntas codificadas con códigos LOINC específicos del cuestionario de tamizaje.
2. **Representación en LOINC**: Cada respuesta se convierte en una instancia del perfil `ObservacionSDOH`, manteniendo el código LOINC de la pregunta como identificador único.
3. **Diagnóstico en SNOMED CT**: El profesional de salud evalúa estas observaciones LOINC y confirma el diagnóstico de riesgo social, codificándolo con el concepto clínico SNOMED CT correspondiente.
4. **Reportabilidad en CIE-10**: Para efectos de reportabilidad estadística al nivel central de salud chileno (MINSAL), el recurso `Condition` también incluye la codificación CIE-10 (Código Z) en paralelo.

Esta arquitectura evita silos de información y asegura que los sistemas de registro clínico electrónico (RCE) en Chile puedan comunicarse e interoperar con estándares mundiales de salud.

---

## 3. Flujo de Transformación Semántica (FML)

Para automatizar la extracción de datos desde el cuestionario de tamizaje hacia observaciones clínicas estructuradas, la guía define reglas de mapeo mediante el lenguaje **FML (FHIR Mapping Language)** a través de un `StructureMap`. Esto evita que el personal clínico deba digitalizar doblemente la información.

A continuación, se detalla el flujo de secuencia lógico del motor de transformación:

<div style="text-align: center; margin: 25px 0;">
  {% include fml-flow.svg %}
</div>
