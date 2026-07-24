# Aspectos Técnicos de la Implementación

Esta sección presenta las decisiones técnicas adoptadas para la implementación de la guía, incluyendo las terminologías utilizadas, el modelo de información, el proceso de transformación mediante FHIR Mapping Language (FML) y el mecanismo de persistencia de los recursos en un servidor FHIR.

---

## 1. Justificación de la Terminología Seleccionada

Para posibilitar un intercambio semántico seguro y transparente, esta guía implementa un **"puente semántico"** utilizando tres vocabularios estándar mundiales y locales:

| Estándar | Componente FHIR | Rol y Justificación Técnica |
| :--- | :--- | :--- |
| **LOINC** | `QuestionnaireResponse`<br>`Observation.code` | **Codificación de Preguntas y Respuestas**: LOINC (Logical Observation Identifiers Names and Codes) permite definir y estandarizar de forma inequívoca las preguntas del tamizaje de transporte (ej: código `93030-5` para la pregunta sobre problemas de transporte en el último año). Garantiza la consistencia semántica independientemente del software que implemente la encuesta. |
| **SNOMED CT** | `Condition.code` | **Codificación del Diagnóstico Clínico-Social**: SNOMED CT (Systematized Nomenclature of Medicine) provee la granularidad clínica necesaria para registrar formalmente el diagnóstico de vulnerabilidad en la lista de problemas del paciente. Se utiliza el concepto estándar internacional `713458007` (*Lack of access to transportation*). |
| **CIE-10 (Códigos Z)** | `Condition.category`<br>`Condition.code.coding` | **Reportabilidad Estadística Nacional**: La Clasificación Internacional de Enfermedades (CIE-10) es obligatoria para reportar al Ministerio de Salud de Chile (registros REM). Al mapear secundariamente la condición a los códigos Z de determinantes sociales (como el código `Z59.82` para Inseguridad de Transporte), la FCE genera de forma automatizada las estadísticas reglamentarias sin requerir doble digitación del clínico. |

---

## 2. Modelo de Información (Modelado de Datos)

El modelo de información define las relaciones entre los principales perfiles desarrollados para esta guía y muestra cómo fluye la información desde el cuestionario de tamizaje hasta el registro de una condición clínica. La Figura 1 muestra las principales relaciones entre los perfiles definidos en esta guía. El flujo comienza con un `Questionnaire`, cuyas respuestas son almacenadas en un `QuestionnaireResponse`. Posteriormente, cada respuesta es transformada en recursos `Observation`, los cuales pueden servir como evidencia para una `Condition` registrada por un profesional de salud.

<div style="text-align: center; margin: 25px 0;">
  {% include data-modeling-framework.svg %}
  <p style="margin-top: 10px; font-style: italic; color: #555;">Figura 1. Modelo de datos y relaciones lógicas entre perfiles SDOH.</p>
</div>

---

## 3. Transformación mediante FHIR Mapping Language (FML)

El recurso `QuestionnaireResponse` generado tras el tamizaje es procesado mediante un recurso `StructureMap`, el cual aplica las reglas definidas en FHIR Mapping Language (FML) para generar un conjunto de recursos `Observation` agrupados en un Bundle de tipo `collection`.

<div style="text-align: center; margin: 25px 0;">
  {% include fml-transformation-simple.svg %}
  <p style="margin-top: 10px; font-style: italic; color: #555;">Figura 2. Proceso de mapeo semántico estructural.</p>
</div>

---

## 4. Persistencia y Consulta de Recursos FHIR

Para almacenar e interrogar la información, los recursos `Observation` se incorporan a un Bundle de tipo `transaction`, el cual es enviado al servidor FHIR para su persistencia. Una vez almacenados, los recursos se desempaquetan e indexan individualmente como recursos persistidos, pudiendo ser consultados mediante las operaciones estándar de búsqueda de FHIR y servir como evidencia para el registro de una `Condition`.

<div style="text-align: center; margin: 25px 0;">
  {% include persistence-simple.svg %}
  <p style="margin-top: 10px; font-style: italic; color: #555;">Figura 3. Flujo de persistencia transaccional y consultas clínicas.</p>
</div>
