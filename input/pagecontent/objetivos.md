# Aspectos Clínicos y Casos de Uso

El registro estandarizado de los Determinantes Sociales de la Salud (SDOH) en la Atención Primaria de Salud (APS) busca estrechar la relación entre la realidad social de las personas y su cuidado clínico continuo. Esta sección detalla los retos asistenciales, el aporte técnico de esta especificación y los escenarios clínicos típicos de la implementación.

---

## 1. El Desafío Asistencial en la APS Rural

Actualmente, las evaluaciones de condiciones sociales (vivienda, transporte, redes de apoyo) se realizan de manera desconectada de la Ficha Clínica Electrónica (FCE). En establecimientos rurales con alta dispersión geográfica, como el **CESFAM Las Cabras**, esta desconexión tiene consecuencias directas sobre el cuidado clínico:

* **Invisibilidad de Barreras:** Un paciente con patologías crónicas descompensadas (como diabetes o hipertensión) puede faltar a sus controles debido a la falta de transporte público o la imposibilidad de financiar traslados. Sin esta información, el clínico suele catalogarlo erróneamente como "no adherente" al tratamiento, ignorando la barrera geográfica subyacente.
* **Datos Fragmentados:** Las evaluaciones sociales suelen registrarse en textos libres o fichas de papel separadas. Esto impide que los médicos, enfermeros y otros miembros de la APS visualicen oportunamente las alertas de vulnerabilidad social durante la consulta regular.
* **Dificultad para Planificar (Gestión Poblacional):** Sin datos sociales codificados y estructurados, las direcciones de salud municipal (DESAM) no pueden prever ni gestionar de forma poblacional el apoyo asistencial, como programar traslados o visitas domiciliarias organizadas.

---

## 2. Aporte de la Guía de Implementación

La presente guía propone una forma estandarizada de representar la información asociada a los Determinantes Sociales de la Salud utilizando HL7 FHIR. En lugar de registrar las evaluaciones sociales como texto libre o documentos independientes, la información queda estructurada mediante recursos interoperables, facilitando su reutilización durante la atención clínica.

La implementación propuesta permite:
* Registrar los resultados del tamizaje utilizando recursos `Observation`;
* Documentar la evaluación profesional mediante un recurso `Condition`;
* Reutilizar la información durante controles posteriores;
* Favorecer el intercambio de información entre sistemas compatibles con HL7 FHIR;
* Disponer de información estructurada para apoyar la toma de decisiones clínicas y de gestión.

---

## 3. Consideración sobre los Roles Asistenciales

Los casos de uso presentados consideran la participación de trabajadores sociales y profesionales de enfermería debido a su relación con el escenario utilizado como ejemplo. Sin embargo, la guía no restringe la utilización de estos artefactos a dichas profesiones. Cualquier profesional autorizado del equipo de Atención Primaria puede realizar actividades de tamizaje, evaluación o seguimiento, de acuerdo con la organización asistencial de cada establecimiento.

---

## 4. Casos de Uso Clínico-Sociales

### Caso de Uso 1: Identificación y Diagnóstico Social en Control Cardiovascular

Este caso de uso representa el proceso de identificación de una barrera de transporte durante el control cardiovascular de un paciente con enfermedad crónica. Tras completar el cuestionario de tamizaje, las respuestas son transformadas automáticamente en recursos `Observation`. Posteriormente, un profesional registra la condición social correspondiente mediante un recurso `Condition`, permitiendo que la información quede disponible para apoyar la continuidad de la atención.

#### Diagrama de Casos de Uso - Caso 1
<div style="text-align: center; margin: 20px 0;">
  {% include usecase-caso1.svg %}
</div>

#### Diagrama de Secuencia - Caso 1
<div style="text-align: center; margin: 20px 0;">
  {% include sequence-caso1.svg %}
</div>

---

### Caso de Uso 2: Identificación de Riesgo de Inasistencia en Controles Preventivos

Este caso de uso representa la identificación proactiva de barreras de transporte en pacientes que asisten a controles preventivos o de seguimiento. Al estructurar y persistir la alerta de inseguridad de transporte en la Ficha Clínica Electrónica, cualquier profesional del equipo de cabecera puede visualizar la condición del paciente, contextualizar de manera oportuna inasistencias previas y optimizar la programación de futuras citas.

#### Diagrama de Casos de Uso - Caso 2
<div style="text-align: center; margin: 20px 0;">
  {% include usecase-caso2.svg %}
</div>

#### Diagrama de Secuencia - Caso 2
<div style="text-align: center; margin: 20px 0;">
  {% include sequence-caso2.svg %}
</div>