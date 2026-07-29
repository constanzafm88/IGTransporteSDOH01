Profile: RespuestaTransporteSDOH
Parent: QuestionnaireResponse
Id: respuesta-transporte-sdoh
Title: "Perfil de Respuesta al Cuestionario de Transporte"
Description: "Este perfil define las reglas para las respuestas del cuestionario de determinantes sociales de transporte."

// 1. Identificador obligatorio
* identifier 1..1 MS
* identifier.value 1..1 MS
* identifier ^short = "ID único del set de respuestas (UUID)"
* identifier.system ^short = "Namespace del identificador (ej: URL de tu CESFAM)"

// 2. Referencia obligatoria al Cuestionario 
* questionnaire 1..1 MS
* questionnaire ^short = "Cuestionario de origen"
// IMPORTANTE: Aquí vinculamos con la URL de tu instancia de cuestionario
* questionnaire = "http://biomedica.uv.cl/fhir/ig/transporte/Questionnaire/CuestionarioTransporteSDOH"

// 2b. Referencia obligatoria al Paciente
* subject 1..1 MS
* subject only Reference(PacienteTransporteSDOH)
* subject ^short = "Paciente que responde el cuestionario"

// 3. Estado de la respuesta
* status MS
* status ^short = "Estado: in-progress | completed | amended"
* status from http://hl7.org/fhir/ValueSet/questionnaire-answers-status

// 4. Fecha de autoría obligatoria
* authored 1..1 MS
* authored ^short = "Fecha en que se completó el formulario"

// 5. Restricciones de los ítems
* item MS
* item ^short = "Respuestas agrupadas por linkId"
* item.answer MS
* item.answer.value[x] MS // Asegura que los valores de respuesta sean procesables