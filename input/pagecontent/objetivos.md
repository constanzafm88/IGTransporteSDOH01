# Aspectos Clínicos y Casos de Uso

El registro estandarizado de los **Determinantes Sociales de la Salud (SDOH)** en la Atención Primaria de Salud (APS) en Chile busca cerrar la brecha entre la caracterización social de las familias y la toma de decisiones clínicas en los centros de salud familiar (CESFAM). Esta sección describe los desafíos asistenciales y los casos de uso prácticos implementados en el ámbito clínico-social.

---

## 1. El Desafío Asistencial en la APS Rural

Actualmente, las evaluaciones de condiciones sociales (vivienda, transporte, redes de apoyo) se realizan de manera desconectada de la Ficha Clínica Electrónica (FCE). En establecimientos rurales con alta dispersión geográfica, como el **CESFAM Las Cabras**, esta desconexión tiene consecuencias directas sobre el cuidado clínico:

* **Invisibilidad de Barreras**: Un paciente con diabetes o hipertensión arterial crónica descompensada puede inasistir a sus controles debido a la falta de conectividad de transporte público o la imposibilidad de financiar traslados particulares. El clínico suele catalogarlo erróneamente como "no adherente" al tratamiento, cuando en realidad enfrenta una barrera geográfica-económica de transporte.
* **Datos Fragmentados**: Las evaluaciones que realizan los trabajadores sociales se registran en textos libres o registros informales en papel ("tarjetones"), impidiendo que los médicos de cabecera y enfermeros visualicen de forma oportuna las alertas de vulnerabilidad social durante la consulta clínica.
* **Falta de Gestión Poblacional**: Sin datos estructurados, es imposible que las direcciones de salud municipal (DESAM) optimicen la planificación de recursos, como programar rondas médicas domiciliarias o coordinar servicios de traslado asistencial para pacientes críticos.

---

## 2. Casos de Uso Clínico-Sociales de Referencia

La arquitectura técnica de esta guía de implementación habilita dos flujos operativos clave en los establecimientos de APS:

> [!NOTE]
> **Flexibilidad de Roles Asistenciales**: En los siguientes casos de uso e ilustraciones se mencionan específicamente los roles de **Trabajador(a) Social** y **Enfermero(a)** con fines ilustrativos para el escenario de ejemplo de *Juan Pérez*. Sin embargo, la especificación técnica es completamente flexible y compatible con que **cualquier profesional de salud de cabecera** (médico, matrona, nutricionista, kinesiólogo, etc.) o miembro autorizado del equipo de atención primaria desempeñe estas acciones de tamizaje, diagnóstico de determinantes sociales o coordinación asistencial.

### Caso de Uso 1: Identificación, Diagnóstico Social y Derivación en Control Cardiovascular

Este flujo describe cómo se evalúan las dificultades de traslado de un paciente hipertenso crónico y cómo influye en el control de su patología:

1. **Tamizaje y Evidencia (`Observation`)**: Durante la pre-consulta o en sala de espera, el paciente responde el cuestionario de transporte. Las respuestas se transforman automáticamente en observaciones estructuradas (recursos `Observation` que heredan del perfil `ObservacionSDOH`) para servir como evidencia.
2. **Evaluación Profesional y Diagnóstico (`Condition`)**: El trabajador social del CESFAM revisa la ficha digital del paciente, evalúa las observaciones resultantes y registra la condición social en la Ficha Clínica Electrónica. Al **confirmar manualmente la condición social de riesgo**, el sistema crea un recurso `Condition` (ej. Código SNOMED `713458007`), registrando al profesional como autor (`asserter`) del diagnóstico y enlazando las observaciones previas como evidencia (`Condition.evidence.detail`).
3. **Alerta y Acción Asistencial**: Posteriormente, durante el control de salud cardiovascular del paciente, el enfermero/a de cabecera visualiza en la lista de problemas una **alerta de "Inseguridad de Transporte Activa"** (el recurso `Condition` ya validado). En lugar de catalogar al paciente crónico como no adherente por sus inasistencias pasadas, el enfermero/a coordina con el equipo del sector familiar alternativas asistenciales (como visitas domiciliarias o despacho de fármacos).

#### Diagrama de Casos de Uso - Caso de Uso 1
<div style="text-align: center; margin: 20px 0;">
  {% include usecase-caso1.svg %}
</div>

---

### Caso de Uso 2: Identificación de Pacientes con Riesgo de Inasistencia por Barreras de Transporte

Este flujo permite anticiparse y gestionar la continuidad del cuidado en controles de salud preventivos o de seguimiento general en APS:

1. **Tamizaje Semántico**: El paciente responde el cuestionario de transporte digital y el sistema genera automáticamente las observaciones estructuradas (`ObservacionSDOH`).
2. **Registro de Diagnóstico Social**: El Trabajador/a Social evalúa la situación y registra manualmente la condición de inseguridad de transporte (`Condition`), quedando activa en la Ficha Clínica Electrónica (FCE).
3. **Visibilidad Asistencial**: La condición y sus evidencias de respaldo quedan disponibles de inmediato en la FCE del paciente.
4. **Visualización y Contextualización**: Cualquier profesional del equipo de cabecera (médicos, matronas, nutricionistas, etc.) que atienda o programe citas para el paciente puede visualizar esta alerta de transporte. Esto permite contextualizar a tiempo inasistencias previas, bajas adherencias o dificultades de acceso, evitando atribuirlas erróneamente a falta de compromiso o interés del paciente.

#### Diagrama de Secuencia - Caso de Uso 2
<div style="text-align: center; margin: 20px 0;">
  {% include usecase-caso2.svg %}
</div>