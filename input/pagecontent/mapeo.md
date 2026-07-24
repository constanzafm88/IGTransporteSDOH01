# Mapeo Estructural y Transformación Automática (FML)

Uno de los principales aportes de ingeniería de software de esta especificación es la automatización del flujo de datos mediante el lenguaje de mapeo oficial de FHIR: **FHIR Mapping Language (FML)** y la definición del recurso **StructureMap**. Esto reduce la necesidad de registrar manualmente la misma información en múltiples estructuras del sistema y agiliza la toma de decisiones.

---

## 1. El Desafío de la Carga Administrativa (Doble Digitación)

En la red de salud pública chilena, los profesionales de APS dedican un porcentaje significativo de su tiempo al ingreso manual de datos en múltiples plataformas locales y nacionales. Para mitigar esta sobrecarga, la guía establece el siguiente flujo automatizado:

1. **Captura Única**: El encuestador registra las respuestas del tamizaje una sola vez en un formulario digital del software del CESFAM, el cual genera y guarda un recurso consolidado `QuestionnaireResponse`.
2. **Transformación en Background**: Sin intervención humana, un motor de mapeo FHIR ejecuta el `StructureMap` aplicando las reglas FML.
3. **Transformación Estructurada**: El motor traduce de manera automática cada respuesta del formulario y genera recursos de tipo `Observation` (observaciones clínicas estructuradas y codificadas) vinculados a la FCE del paciente, dejándolos disponibles para que los algoritmos de apoyo a la decisión y los profesionales de la salud los consulten o procesen de inmediato.

---

## 2. Implementación del StructureMap en FHIR Mapping Language (FML) (`TransporteToObs`)

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

## 3. Escenario de Referencia: CESFAM Las Cabras

Con el propósito de contextualizar la implementación propuesta en un escenario representativo de la Atención Primaria de Salud rural, la presente guía utiliza como referencia el CESFAM Las Cabras. La selección de este establecimiento permitió definir un caso de uso alineado con las necesidades observadas durante el levantamiento de requerimientos y ejemplificar los artefactos desarrollados en la guía.

1. **Localización**: Se utiliza como referencia el CESFAM Las Cabras y su contexto territorial.
2. **Profesional**: Se modela un rol profesional representativo del proceso de tamizaje.
3. **Paciente**: Se define un paciente ficticio representativo del contexto rural.
4. **Consentimiento**: Se incluye el consentimiento informado como parte del flujo propuesto.
5. **Caso de ejemplo**: A partir de un `QuestionnaireResponse` simulado, el `StructureMap` genera automáticamente siete recursos `Observation`, ilustrando el funcionamiento de la transformación.

---

## 4. Recomendaciones de Implementación (Collection vs. Transaction)

Para los desarrolladores de sistemas informáticos clínicos (EHR), la especificación provee dos tipos de Bundles adaptados a distintas fases del flujo de integración:

### A. Bundle de tipo `collection` ([Ejemplo: BundleTransporteLasCabras](Bundle-BundleTransporteLasCabras.html))
El Bundle de tipo `collection` representa únicamente el resultado de la transformación realizada por el `StructureMap`. No está diseñado para persistir recursos en un servidor FHIR. Su propósito es agrupar en memoria de la aplicación las 7 observaciones generadas a partir de la encuesta.

### B. Bundle de tipo `transaction` ([Ejemplo: BundleTransaccionLasCabras](Bundle-BundleTransaccionLasCabras.html))
Para persistir los recursos de forma individual e indexada, es necesario construir un Bundle de tipo `transaction`, incorporando las instrucciones REST correspondientes (`PUT` o `POST` y la URL destino) para cada entrada. Al ser enviado al endpoint raíz del servidor FHIR, este procesa los recursos de forma atómica y los almacena por separado, habilitando futuras búsquedas clínicas.