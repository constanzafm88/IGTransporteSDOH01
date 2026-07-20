# Mapeo Estructural y Transformación Automática (FML)

Uno de los principales aportes de ingeniería de software de esta especificación es la automatización del flujo de datos mediante el lenguaje de mapeo oficial de FHIR: **FHIR Mapping Language (FML)** y la definición del recurso **StructureMap**. Esto elimina de raíz la doble digitación y agiliza la toma de decisiones.

---

## 1. El Desafío de la Carga Administrativa (Doble Digitación)

En la red de salud pública chilena, los profesionales de APS dedican un porcentaje significativo de su tiempo al ingreso manual de datos en múltiples plataformas locales y nacionales. Para mitigar esta sobrecarga, la guía establece el siguiente flujo automatizado:

1. **Captura Única**: El encuestador registra las respuestas del tamizaje una sola vez en un formulario digital del software del CESFAM, el cual genera y guarda un recurso consolidado `QuestionnaireResponse`.
2. **Transformación en Background**: Sin intervención humana, un motor de mapeo FHIR ejecuta el `StructureMap` aplicando las reglas FML.
3. **Transformación Estructurada**: El motor traduce de manera automática cada respuesta del formulario y genera recursos de tipo `Observation` (observaciones clínicas estructuradas y codificadas) vinculados a la FCE del paciente, dejándolos disponibles para que los algoritmos de apoyo a la decisión y los profesionales de la salud los consulten o procesen de inmediato.

---

## 2. Definición del Mapa Lógico en FML (`TransporteToObs`)

A continuación, se detalla el código completo del mapa de transformación computable definido en la guía de implementación ([TransporteToObs.fml](StructureMap-TransporteToObs.html)):

```fml
map "http://biomedica.uv.cl/fhir/ig/transporte/StructureMap/TransporteToObs" = "TransporteToObs"

uses "http://hl7.org/fhir/StructureDefinition/QuestionnaireResponse" alias QResponse as source
uses "http://hl7.org/fhir/StructureDefinition/Bundle"                alias Bundle    as target
uses "http://hl7.org/fhir/StructureDefinition/Observation"           alias Obs       as target

group TransporteToObs(source src : QResponse, target tgt : Bundle) {
  src -> tgt.type = 'collection' "ruleBundleType";
  src.item as grp -> tgt then ProcessGrupo(grp, tgt, src) "ruleGroup";
}

group ProcessGrupo(source grp, target tgt : Bundle, source parent) {
  grp.item as item -> tgt.entry as entry then ProcessEntry(item, entry, parent) "ruleEntry";
}

group ProcessEntry(source item, target entry, source parent) {
  item -> entry.fullUrl = uuid() "ruleFullUrl";
  item -> entry.resource = create('Observation') as obs then TransformItemToObservation(item, obs, parent) "ruleObs";
}

group TransformItemToObservation(source item, target obs : Obs, source parent) {
  parent.subject as sub -> obs.subject = sub "ruleSubject";
  item -> obs.status = 'final' "ruleStatus";
  
  // Category 1: social-history (Core CL)
  item -> obs.category = create('CodeableConcept') as cat1 then {
    item -> cat1.coding = create('Coding') as cod1 then {
      item -> cod1.system = 'http://terminology.hl7.org/CodeSystem/observation-category' "cat1Sys";
      item -> cod1.code = 'social-history' "cat1Code";
    } "cat1Coding";
  } "cat1";

  // Category 2: sdoh (Gravity Flag)
  item -> obs.category = create('CodeableConcept') as cat2 then {
    item -> cat2.coding = create('Coding') as cod2 then {
      item -> cod2.system = 'http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/sdohcc-temporary-codes' "cat2Sys";
      item -> cod2.code = 'sdoh' "cat2Code";
    } "cat2Coding";
  } "cat2";

  // Category 3: transportation-insecurity (Domain)
  item -> obs.category = create('CodeableConcept') as cat3 then {
    item -> cat3.coding = create('Coding') as cod3 then {
      item -> cod3.system = 'http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/sdohcc-temporary-codes' "cat3Sys";
      item -> cod3.code = 'transportation-insecurity' "cat3Code";
    } "cat3Coding";
  } "cat3";

  item.linkId as id -> obs.code = create('CodeableConcept') as code then SetCode(id, code) "ruleCode";
  item.answer as ans -> obs then SetAnswer(ans, obs) "ruleAnswer";
}

group SetCode(source id, target code : CodeableConcept) {
  id -> code.coding = create('Coding') as coding then SetCoding(id, coding) "ruleCoding";
}

group SetCoding(source id, target coding : Coding) {
  id -> coding.code = id "ruleCodeVal";
  id -> coding.system = 'http://loinc.org' "ruleSystemVal";
}

group SetAnswer(source ans, target obs : Obs) {
  ans.value : boolean as v -> obs.value = v "ruleAnsBool";
  ans.value : Coding as v -> obs.value = create('CodeableConcept') as cc then SetCC(v, cc) "ruleAnsCoding";
}

group SetCC(source v, target cc : CodeableConcept) {
  v -> cc.coding = v "ruleSetCodingVal";
}
```

### Explicación Lógica del Mapeo
* **Grupo Principal**: Toma el recurso `QuestionnaireResponse` de entrada y lo transforma en un `Bundle` de tipo `collection`.
* **Procesamiento de Items**: Recorre recursivamente los grupos de preguntas (`item`) y genera una entrada (`Bundle.entry`) por cada pregunta de la encuesta, estructurándola de forma independiente.
* **Instanciación**: Por cada item, crea una `Observation` con estado `#final` e inyecta la referencia al sujeto (`Patient`) heredada del formulario original.
* **Resolución Semántica**: Asigna el identificador de la pregunta (`linkId`) como el código de la observación en el sistema LOINC (`http://loinc.org`).
* **Tratamiento Polimórfico**: Evalúa el tipo de respuesta. Si la respuesta es de tipo booleano, la mapea directamente al valor del elemento `Observation.value[x]`. Si es una respuesta codificada (tipo `Coding`), la transforma en una estructura de `CodeableConcept` para preservar la codificación.

### Diagrama de Secuencia del Mapeo FML

A continuación se detalla visualmente cómo el motor FML procesa el cuestionario y va poblando de manera iterativa los campos clave de cada `Observation` dentro del `Bundle` de destino:

<div style="text-align: center; margin: 25px 0;">
  {% include mapping-sequence.svg %}
</div>

---

## 3. Escenario de Prueba Global: CESFAM Las Cabras

Para validar la aplicabilidad en el ecosistema de salud pública nacional, la guía define un **Caso de Prueba Extremo a Extremo** basado en el **CESFAM Las Cabras** (Provincia de Cachapoal):

1. **Localización**: Se define el centro de salud familiar real con su dirección y código comunal CUT (`06107`).
2. **Rol Encuestador**: Se define a la Trabajadora Social Ana Valenzuela (`PractitionerRole` y `Practitioner` de APS) con su respectiva credencial del Registro Nacional de Prestadores Individuales del MINSAL.
3. **Paciente**: Se modela al paciente Juan Pérez, residente rural del sector Las Cabras, con RUN chileno oficial.
4. **Consentimiento**: Se registra el consentimiento informado (`Consent`) en el cual Juan autoriza compartir sus evaluaciones sociales con los profesionales del CESFAM para optimizar su plan de tratamiento.
5. **Simulación**: Al procesar la encuesta simulada (`EjemploRespuestaPaciente01`), el motor FML procesa correctamente las 7 respuestas y genera automáticamente las observaciones estructuradas de transporte que respaldan clínicamente la posterior asignación del diagnóstico social en su lista de problemas.

---

## 4. Recomendaciones de Implementación (Collection vs. Transaction)

Para los desarrolladores de sistemas informáticos clínicos (EHR), la guía de implementación proporciona dos ejemplos de Bundles diseñados para propósitos diferentes en el flujo de integración:

> [!NOTE]
> **Nota de implementación:** El `StructureMap` `TransporteToObs` transforma un `QuestionnaireResponse` en un `Bundle` de tipo `collection` que contiene las observaciones estructuradas resultantes del tamizaje. Posteriormente, una aplicación implementadora puede reutilizar dichas observaciones para construir un `Bundle` de tipo `transaction`, agregando las instrucciones `request` necesarias para persistir los recursos en un servidor FHIR mediante una única operación transaccional. Por ende, **el Bundle Transaction es un ejemplo de persistencia construido por la aplicación implementadora a partir de los recursos generados por el StructureMap.**

### A. Bundle de tipo `collection` ([Ejemplo: BundleTransporteLasCabras](Bundle-BundleTransporteLasCabras.html))
* **Propósito:** Es el formato de salida directa del motor de mapeo (FML) en la memoria de la aplicación.
* **Características:** Agrupa de manera lógica y limpia las 7 `Observations` generadas a partir del formulario.
* **Limitación en Servidores:** Si se guarda este bundle completo como un único recurso Bundle (`POST /Bundle`) en el servidor FHIR, las observaciones quedarán anidadas en el documento y **no** se indexarán como recursos independientes, impidiendo realizar búsquedas poblacionales (ej. `GET /Observation?code=...`).

### B. Bundle de tipo `transaction` ([Ejemplo: BundleTransaccionLasCabras](Bundle-BundleTransaccionLasCabras.html))
* **Propósito:** Es el formato **oficial y recomendado para la persistencia** de los resultados en el servidor FHIR central de la institución.
* **Estructura Real en Producción:** Contiene únicamente los recursos dinámicos generados por el acto clínico: la respuesta a la encuesta (`QuestionnaireResponse`) y las 7 observaciones (`Observation`). Hace referencia a los recursos lógicos que ya existen de forma previa en el servidor (Paciente, Localización, Profesional).
* **Funcionamiento:** Se envía mediante un único `POST /` al endpoint raíz del servidor FHIR. Cada recurso dentro de las entradas (`entry`) lleva una instrucción `PUT` con su respectiva URL relativa. El servidor FHIR procesa la transacción de manera atómica (guarda todo o nada) y almacena cada observación como un recurso suelto e indexado en el expediente clínico del paciente.