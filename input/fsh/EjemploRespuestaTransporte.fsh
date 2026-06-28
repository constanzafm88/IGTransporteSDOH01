Instance: EjemploRespuestaPaciente01
InstanceOf: RespuestaTransporteSDOH // Usamos el Perfil que creamos recién
Title: "Ejemplo de Respuesta de Paciente Real"
Description: "Ejemplo de cómo se guardan las respuestas de transporte usando los códigos de tu tabla."
Usage: #example

* status = #completed
* authored = "2026-05-06T11:00:00Z"
* questionnaire = "http://example.org/ig/transporte/Questionnaire/CuestionarioTransporteSDOH"
* subject = Reference(EjemploPaciente)

* identifier.value = "uuid-ejemplo-12345"
* identifier.system = "http://CESFAM-biomedica.cl/ids"

// --- Grupo principal de respuestas ---
* item[0].linkId = "evaluacionTransporte"

// --- Respuesta a la Pregunta 1 (Booleano) ---
* item[0].item[0].linkId = "93030-5"
* item[0].item[=].answer.valueBoolean = true

// --- Respuesta a la Pregunta 2 (Lista LOINC LL6155-7) ---
* item[0].item[+].linkId = "99594-4"
* item[0].item[=].answer.valueCoding = $LNC#LA33093-8 "Yes, it has kept me from medical appointments or getting medications"

// --- Respuesta a la Pregunta 3 (Lista LOINC LL6295-1) ---
* item[0].item[+].linkId = "101351-5"
* item[0].item[=].answer.valueCoding = $LNC#LA30133-5 "Yes, it has kept me from medical appointments or from getting my medications"

// --- Respuesta a la Pregunta 4 (Booleano) ---
* item[0].item[+].linkId = "93671-6"
* item[0].item[=].answer.valueBoolean = true

// --- Respuesta a la Pregunta 5 (Lista LOINC LL6511-1) ---
* item[0].item[+].linkId = "104015-3"
* item[0].item[=].answer.valueCoding = $LNC#LA10082-8 "Sometimes"

// --- Respuesta a la Pregunta 6 (Lista LOINC LL6511-1) ---
* item[0].item[+].linkId = "104016-1"
* item[0].item[=].answer.valueCoding = $LNC#LA10044-8 "Often"

// --- Respuesta a la Pregunta 7 (Lista LOINC LL6511-1) ---
* item[0].item[+].linkId = "104017-9"
* item[0].item[=].answer.valueCoding = $LNC#LA6270-8 "Never"