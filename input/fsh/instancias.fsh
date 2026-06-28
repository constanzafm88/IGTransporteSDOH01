Alias: $SDOHCC-TemporaryCodes = http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/sdohcc-temporary-codes
Alias: $ObsCat = http://terminology.hl7.org/CodeSystem/observation-category

// ============================================================================
// Instancias de Ejemplo - Respuestas de Observación de Transporte (Inline)
// ============================================================================

// Pregunta 1: ¿Ha dejado de recibir atención por no tener cómo llegar? (12 meses)
Instance: ObsTransporte01
InstanceOf: ObservacionSDOH
Usage: #inline
* status = #final
* category[social-history] = $ObsCat#social-history
* category[sdoh-category] = $SDOHCC-TemporaryCodes#sdoh
* category[2] = $SDOHCC-TemporaryCodes#transportation-insecurity
* code = http://loinc.org#93030-5 "Has lack of transportation kept you from medical appointments, meetings, work, or from getting things needed for daily living"
* subject = Reference(EjemploPaciente)
* performer = Reference(RolProfesionalSocialEjemplo)
* effectiveDateTime = "2026-06-03T10:00:00Z"
* valueBoolean = true 

// Pregunta 2: ¿Ha pospuesto o evitado ir al médico por problemas de transporte?
Instance: ObsTransporte02
InstanceOf: ObservacionSDOH
Usage: #inline
* status = #final
* category[social-history] = $ObsCat#social-history
* category[sdoh-category] = $SDOHCC-TemporaryCodes#sdoh
* category[2] = $SDOHCC-TemporaryCodes#transportation-insecurity
* code = http://loinc.org#99594-4 "Delayed medical care due to distance or lack of transportation"
* subject = Reference(EjemploPaciente)
* performer = Reference(RolProfesionalSocialEjemplo)
* effectiveDateTime = "2026-06-03T10:00:00Z"
* valueCodeableConcept = http://loinc.org#LA33093-8 "Yes, it has kept me from medical appointments or getting medications"

// Pregunta 3: ¿Falta de transporte le ha impedido asistir a citas, trabajo o actividades?
Instance: ObsTransporte03
InstanceOf: ObservacionSDOH
Usage: #inline
* status = #final
* category[social-history] = $ObsCat#social-history
* category[sdoh-category] = $SDOHCC-TemporaryCodes#sdoh
* category[2] = $SDOHCC-TemporaryCodes#transportation-insecurity
* code = http://loinc.org#101351-5 "Has lack of transportation kept you from medical appointments, meetings, work, or from getting things needed for daily living during assessment period [CMS Assessment]"
* subject = Reference(EjemploPaciente)
* performer = Reference(RolProfesionalSocialEjemplo)
* effectiveDateTime = "2026-06-03T10:00:00Z"
* valueCodeableConcept = http://loinc.org#LA30133-5 "Yes, it has kept me from medical appointments or from getting my medications"

// Pregunta 4: ¿Tiene problemas para encontrar o pagar transporte?
Instance: ObsTransporte04
InstanceOf: ObservacionSDOH
Usage: #inline
* status = #final
* category[social-history] = $ObsCat#social-history
* category[sdoh-category] = $SDOHCC-TemporaryCodes#sdoh
* category[2] = $SDOHCC-TemporaryCodes#transportation-insecurity
* code = http://loinc.org#93671-6 "Do you have trouble finding or paying for transportation [WellRx]"
* subject = Reference(EjemploPaciente)
* performer = Reference(RolProfesionalSocialEjemplo)
* effectiveDateTime = "2026-06-03T10:00:00Z"
* valueBoolean = true

// Pregunta 5: ¿Ha tenido que reprogramar una cita por problemas de transporte? (30 días)
Instance: ObsTransporte05
InstanceOf: ObservacionSDOH
Usage: #inline
* status = #final
* category[social-history] = $ObsCat#social-history
* category[sdoh-category] = $SDOHCC-TemporaryCodes#sdoh
* category[2] = $SDOHCC-TemporaryCodes#transportation-insecurity
* code = http://loinc.org#104015-3 "How often did you have to reschedule an appointment because of a problem with transportation"
* subject = Reference(EjemploPaciente)
* performer = Reference(RolProfesionalSocialEjemplo)
* effectiveDateTime = "2026-06-03T10:00:00Z"
* valueCodeableConcept = http://loinc.org#LA10082-8 "Sometimes"

// Pregunta 6: ¿Ha dejado de ir a algún lugar por problemas de transporte? (30 días)
Instance: ObsTransporte06
InstanceOf: ObservacionSDOH
Usage: #inline
* status = #final
* category[social-history] = $ObsCat#social-history
* category[sdoh-category] = $SDOHCC-TemporaryCodes#sdoh
* category[2] = $SDOHCC-TemporaryCodes#transportation-insecurity
* code = http://loinc.org#104016-1 "How often did you skip going somewhere because of a problem with transportation"
* subject = Reference(EjemploPaciente)
* performer = Reference(RolProfesionalSocialEjemplo)
* effectiveDateTime = "2026-06-03T10:00:00Z"
* valueCodeableConcept = http://loinc.org#LA10044-8 "Often"

// Pregunta 7: ¿No ha podido salir de su casa por problemas de transporte? (30 días)
Instance: ObsTransporte07
InstanceOf: ObservacionSDOH
Usage: #inline
* status = #final
* category[social-history] = $ObsCat#social-history
* category[sdoh-category] = $SDOHCC-TemporaryCodes#sdoh
* category[2] = $SDOHCC-TemporaryCodes#transportation-insecurity
* code = http://loinc.org#104017-9 "How often were you not able to leave the house when you wanted to because of a problem with transportation"
* subject = Reference(EjemploPaciente)
* performer = Reference(RolProfesionalSocialEjemplo)
* effectiveDateTime = "2026-06-03T10:00:00Z"
* valueCodeableConcept = http://loinc.org#LA6270-8 "Never"


// ============================================================================
// Bundle de Ejemplo - Agrupa todo el caso de Juan Pérez de Las Cabras
// ============================================================================

Instance: BundleTransporteLasCabras
InstanceOf: Bundle
Title: "Bundle de Respuesta Completa - Caso Juan Pérez"
Description: "Bundle de ejemplo tipo colección que agrupa todos los recursos del caso clínico-social de Juan Pérez en el CESFAM Las Cabras: Paciente, Cuestionario, Respuestas de Observación, Profesional de salud y Condición final de Transporte."
Usage: #example

* type = #collection

// Paciente
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Patient/EjemploPaciente"
* entry[=].resource = EjemploPaciente

// Profesional Prestador
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Practitioner/ProfesionalSocialEjemplo"
* entry[=].resource = ProfesionalSocialEjemplo

// Organización
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Organization/CESFAMLasCabras"
* entry[=].resource = CESFAMLasCabras

// Rol Profesional
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/PractitionerRole/RolProfesionalSocialEjemplo"
* entry[=].resource = RolProfesionalSocialEjemplo

// CuestionarioResponse (Respuestas generales del cuestionario)
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/QuestionnaireResponse/EjemploRespuestaPaciente01"
* entry[=].resource = EjemploRespuestaPaciente01

// Observación 1
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Observation/ObsTransporte01"
* entry[=].resource = ObsTransporte01

// Observación 2
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Observation/ObsTransporte02"
* entry[=].resource = ObsTransporte02

// Observación 3
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Observation/ObsTransporte03"
* entry[=].resource = ObsTransporte03

// Observación 4
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Observation/ObsTransporte04"
* entry[=].resource = ObsTransporte04

// Observación 5
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Observation/ObsTransporte05"
* entry[=].resource = ObsTransporte05

// Observación 6
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Observation/ObsTransporte06"
* entry[=].resource = ObsTransporte06

// Observación 7
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Observation/ObsTransporte07"
* entry[=].resource = ObsTransporte07

// Condición de Inseguridad de Transporte (Diagnóstico manual del profesional)
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Condition/CondicionTransporteJuan"
* entry[=].resource = CondicionTransporteJuan

// Consentimiento Informado (Autorización del paciente)
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Consent/ConsentimientoEjemploJuan"
* entry[=].resource = ConsentimientoEjemploJuan

// Ubicación física de atención
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Location/LocalizacionCESFAMLasCabras"
* entry[=].resource = LocalizacionCESFAMLasCabras
