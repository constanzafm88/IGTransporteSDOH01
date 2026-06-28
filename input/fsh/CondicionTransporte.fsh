Alias: $SDOHCC-TemporaryCodes = http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/sdohcc-temporary-codes

Profile: CondicionSDOHSDOH
Parent: Condition
Id: condicion-sdoh
Title: "Condición de Determinante Social de la Salud"
Description: "Perfil de Condición para registrar diagnósticos clínico-sociales activos de determinantes sociales de la salud (SDOH) en la APS chilena."

// 1. Elementos obligatorios y Must Support del estado clínico y verificación
* clinicalStatus 1..1 MS
* clinicalStatus ^short = "Estado clínico del diagnóstico: active | inactive | resolved"

* verificationStatus MS
* verificationStatus ^short = "Estado de verificación: confirmed | provisional | refuted"

// 2. Slicing de Categorías para requerir problem-list-item y la categoría específica de SDOH (Gravity Style)
* category 2..* MS
* category ^slicing.discriminator.type = #value
* category ^slicing.discriminator.path = "coding.system"
* category ^slicing.rules = #open
* category contains problem-list-item 1..1 and sdoh-category 1..1

* category[problem-list-item].coding.system = "http://terminology.hl7.org/CodeSystem/condition-category"
* category[problem-list-item].coding.code = #problem-list-item
* category[problem-list-item] MS
* category[problem-list-item] ^short = "Categoría base requerida por FHIR (problem-list-item)"

* category[sdoh-category].coding.system = "http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/sdohcc-temporary-codes"
* category[sdoh-category] from vs-categorias-sdoh (extensible)
* category[sdoh-category] MS
* category[sdoh-category] ^short = "Categoría específica del determinante social (ej: transporte, alimentación)"

// 3. Restricción del código de diagnóstico usando el binding principal obligatorio de Transporte
* code 1..1 MS
* code from VSCondicionesTransporte (required)
* code ^short = "Código de diagnóstico de la condición (16 códigos SNOMED CT de transporte)"


// 4. Sujeto obligado a ser una referencia a un Paciente (flexible y compatible)
* subject 1..1 MS
* subject only Reference(Patient)
* subject ^short = "Paciente que padece la condición"

// 5. Evidencia que respalda este diagnóstico (referencia opcional a observaciones del cuestionario)
* evidence MS
* evidence ^short = "Evidencia o justificación del diagnóstico"
* evidence.detail MS
* evidence.detail only Reference(ObservacionSDOH)
* evidence.detail ^short = "Referencia a la observación del cuestionario que gatilló el diagnóstico"

// 6. Exclusión de severidad (alineado con Gravity Project)
* severity 0..0

// 7. Elementos de inicio y autor (asserter) para control clínico-social manual (Gravity Style)
* onset[x] only dateTime or Period
* onset[x] MS
* onset[x] ^short = "Fecha o período de inicio de la condición"

* asserter only Reference(RolProfesionalSDOH or Patient)
* asserter MS
* asserter ^short = "Profesional de la salud (con su rol institucional) o paciente que registró la condición"
