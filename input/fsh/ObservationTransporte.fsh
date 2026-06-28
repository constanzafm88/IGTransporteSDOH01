Alias: $SDOHCC-TemporaryCodes = http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/sdohcc-temporary-codes

Profile: ObservacionSDOH
Parent: Observation
Id: observacion-sdoh
Title: "Observación de Determinante Social de la Salud"
Description: "Perfil de Observación genérico para registrar respuestas de tamizaje de determinantes sociales de la salud (SDOH) en la APS chilena."

* status = #final
* status MS

// Restringimos las categorías usando Slicing (Gravity Style)
* category MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains social-history 1..1 MS and sdoh-category 1..1 MS

* category[social-history] = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* category[social-history] ^short = "Categoría obligatoria por Core CL (social-history)"

* category[sdoh-category] = http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/sdohcc-temporary-codes#sdoh
* category[sdoh-category] ^short = "Categoría obligatoria SDOH"

* subject 1..1 MS
* subject only Reference(Patient)
* subject ^short = "Paciente que responde la pregunta del determinante social"

* effective[x] 0..1 MS
* effective[x] only dateTime
* effectiveDateTime ^short = "Fecha y hora en que se registró la observación"

// Restringimos el código de la pregunta usando el binding general extensible
* code 1..1 MS
* code from vs-preguntas-transporte-loinc (extensible) // Nota: Reemplazar por ValueSet general de preguntas al agregar más dominios
* code ^short = "Código LOINC de la pregunta del determinante social"

// El valor puede ser booleano o codificado
* value[x] 1..1 MS
* value[x] only boolean or CodeableConcept
* value[x] ^short = "Respuesta a la pregunta (Booleano o Código de LOINC/SNOMED)"

* valueCodeableConcept from vs-respuestas-transporte (preferred) // Nota: Reemplazar por ValueSet general de respuestas al agregar más dominios
* valueCodeableConcept MS
* valueCodeableConcept ^short = "Respuesta codificada (si aplica)"


// --- TABLA DE BINDINGS ADICIONALES CONDICIONALES (Gravity Style) ---

// Fila de Preguntas de Transporte: se activa si la categoría es transportation-insecurity
* code ^binding.extension[0].url = "http://hl7.org/fhir/tools/StructureDefinition/additional-binding"
* code ^binding.extension[0].extension[0].url = "key"
* code ^binding.extension[0].extension[0].valueId = "transportation-insecurity-questions"
* code ^binding.extension[0].extension[1].url = "purpose"
* code ^binding.extension[0].extension[1].valueCode = #extensible
* code ^binding.extension[0].extension[2].url = "valueSet"
* code ^binding.extension[0].extension[2].valueCanonical = "http://biomedica.uv.cl/fhir/ig/transporte/ValueSet/vs-preguntas-transporte-loinc"
* code ^binding.extension[0].extension[3].url = "usage"
* code ^binding.extension[0].extension[3].valueUsageContext.code = $SDOHCC-TemporaryCodes#Observation.category
* code ^binding.extension[0].extension[3].valueUsageContext.valueCodeableConcept = $SDOHCC-TemporaryCodes#transportation-insecurity
* code ^binding.extension[0].extension[3].valueUsageContext.valueCodeableConcept.text = "transportation-insecurity"


// Fila de Respuestas de Transporte: se activa si la categoría es transportation-insecurity
* valueCodeableConcept ^binding.extension[0].url = "http://hl7.org/fhir/tools/StructureDefinition/additional-binding"
* valueCodeableConcept ^binding.extension[0].extension[0].url = "key"
* valueCodeableConcept ^binding.extension[0].extension[0].valueId = "transportation-insecurity-answers"
* valueCodeableConcept ^binding.extension[0].extension[1].url = "purpose"
* valueCodeableConcept ^binding.extension[0].extension[1].valueCode = #preferred
* valueCodeableConcept ^binding.extension[0].extension[2].url = "valueSet"
* valueCodeableConcept ^binding.extension[0].extension[2].valueCanonical = "http://biomedica.uv.cl/fhir/ig/transporte/ValueSet/vs-respuestas-transporte"
* valueCodeableConcept ^binding.extension[0].extension[3].url = "usage"
* valueCodeableConcept ^binding.extension[0].extension[3].valueUsageContext.code = $SDOHCC-TemporaryCodes#Observation.category
* valueCodeableConcept ^binding.extension[0].extension[3].valueUsageContext.valueCodeableConcept = $SDOHCC-TemporaryCodes#transportation-insecurity
* valueCodeableConcept ^binding.extension[0].extension[3].valueUsageContext.valueCodeableConcept.text = "transportation-insecurity"