Alias: $SDOHCC-TemporaryCodes = http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/SDOHCC-CodeSystemTemporaryCodes

Profile: ObservacionSDOH
Parent: Observation
Id: observacion-sdoh
Title: "Observación de Determinante Social de la Salud"
Description: "Perfil de Observación genérico para registrar respuestas de tamizaje de determinantes sociales de la salud (SDOH) en la APS chilena."

* status = #final
* status MS

// Slicing de Categorías (Gravity Style Multi-Dominio)
* category MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open

* category contains social-history 1..1 MS and sdoh 1..1 MS and sdoh-domain 0..* MS

* category[social-history] = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* category[social-history] ^short = "Categoría requerida para antecedentes sociales (social-history)"

* category[sdoh] = $SDOHCC-TemporaryCodes#sdoh
* category[sdoh] ^short = "Categoría general de determinantes sociales de la salud (sdoh)"

* category[sdoh-domain] from vs-categorias-sdoh (required)
* category[sdoh-domain] ^short = "Dominio SDOH específico (ej: inseguridad de transporte, alimentaria, vivienda)"

* subject 1..1 MS
* subject only Reference(Patient)
* subject ^short = "Paciente que responde la pregunta del determinante social"

* effective[x] 0..1 MS
* effective[x] only dateTime
* effectiveDateTime ^short = "Fecha y hora en que se registró la observación"

// Restringimos el código de la pregunta usando el binding general extensible
* code 1..1 MS
* code from vs-preguntas-transporte-loinc (extensible)
* code ^short = "Código LOINC de la pregunta del determinante social"

// El valor puede ser booleano o codificado
* value[x] 1..1 MS
* value[x] only boolean or CodeableConcept
* value[x] ^short = "Respuesta a la pregunta (Booleano o Código de LOINC/SNOMED)"

* valueCodeableConcept from vs-respuestas-transporte (preferred)
* valueCodeableConcept MS
* valueCodeableConcept ^short = "Respuesta codificada (si aplica)"

// --- TABLA DE BINDINGS ADICIONALES CONDICIONALES (Gravity Style Multi-Dominio) ---
* code ^binding.extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/additional-binding"
* code ^binding.extension[=].extension[+].url = "key"
* code ^binding.extension[=].extension[=].valueId = "transportation-insecurity-questions"
* code ^binding.extension[=].extension[+].url = "purpose"
* code ^binding.extension[=].extension[=].valueCode = #extensible
* code ^binding.extension[=].extension[+].url = "valueSet"
* code ^binding.extension[=].extension[=].valueCanonical = Canonical(vs-preguntas-transporte-loinc)
* code ^binding.extension[=].extension[+].url = "usage"
* code ^binding.extension[=].extension[=].valueUsageContext.code = http://terminology.hl7.org/CodeSystem/usage-context-type#focus
* code ^binding.extension[=].extension[=].valueUsageContext.valueCodeableConcept = $SDOHCC-TemporaryCodes#transportation-insecurity "Transportation Insecurity"

* valueCodeableConcept ^binding.extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/additional-binding"
* valueCodeableConcept ^binding.extension[=].extension[+].url = "key"
* valueCodeableConcept ^binding.extension[=].extension[=].valueId = "transportation-insecurity-answers"
* valueCodeableConcept ^binding.extension[=].extension[+].url = "purpose"
* valueCodeableConcept ^binding.extension[=].extension[=].valueCode = #preferred
* valueCodeableConcept ^binding.extension[=].extension[+].url = "valueSet"
* valueCodeableConcept ^binding.extension[=].extension[=].valueCanonical = Canonical(vs-respuestas-transporte)
* valueCodeableConcept ^binding.extension[=].extension[+].url = "usage"
* valueCodeableConcept ^binding.extension[=].extension[=].valueUsageContext.code = http://terminology.hl7.org/CodeSystem/usage-context-type#focus
* valueCodeableConcept ^binding.extension[=].extension[=].valueUsageContext.valueCodeableConcept = $SDOHCC-TemporaryCodes#transportation-insecurity "Transportation Insecurity"