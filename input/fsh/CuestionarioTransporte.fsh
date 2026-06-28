// Alias para facilitar la lectura
Alias: $LNC = http://loinc.org
Alias: $item-control = http://hl7.org/fhir/questionnaire-item-control

Instance: CuestionarioTransporteSDOH
InstanceOf: Questionnaire
Title: "Cuestionario de Determinantes Sociales - Transporte"
Description: "Evaluación de barreras de transporte para el acceso a la salud y actividades diarias."
Usage: #example

* status = #draft
* version = "1.0.0"
* name = "SDOHTransporteQuestionnaire"
* title = "Cuestionario de Transporte SDOH"
* date = "2026-05-06"
* publisher = "Proyecto Ingeniería Biomédica"

/////////////////////////////////////////////////////////////////////////////////
// Grupo Principal: Evaluación de Transporte
/////////////////////////////////////////////////////////////////////////////////
* item[0].type = #group
* item[=].linkId = "evaluacionTransporte"
* item[=].text = "Evaluación de barreras de transporte"
* item[=].required = true

// --- PREGUNTA 1: Falta de atención médica (12 meses) ---
* item[=].item[+].type = #boolean
* item[=].item[=].linkId = "93030-5"
* item[=].item[=].code = $LNC#93030-5 "Has lack of transportation kept you from medical appointments, meetings, work, or from getting things needed for daily living"
* item[=].item[=].text = "En los últimos 12 meses, ¿ha dejado de recibir atención de salud por no tener cómo llegar?"
* item[=].item[=].required = false

// --- PREGUNTA 2: Pospuesto o evitado médico ---
* item[=].item[+].type = #choice
* item[=].item[=].linkId = "99594-4"
* item[=].item[=].code = $LNC#99594-4 "Delayed medical care due to distance or lack of transportation"
* item[=].item[=].text = "¿Ha pospuesto o evitado ir al médico por problemas de transporte o distancia?"
* item[=].item[=].answerValueSet = "http://loinc.org/vs/LL6155-7"
* item[=].item[=].required = false

// --- PREGUNTA 3: Impedimento actividades diarias (12 meses) ---
* item[=].item[+].type = #choice
* item[=].item[=].linkId = "101351-5"
* item[=].item[=].code = $LNC#101351-5 "Has lack of transportation kept you from medical appointments, meetings, work, or from getting things needed for daily living during assessment period [CMS Assessment]"
* item[=].item[=].text = "En los últimos 12 meses, ¿la falta de transporte le ha impedido asistir a citas, trabajo o actividades diarias?"
* item[=].item[=].answerValueSet = "http://loinc.org/vs/LL6295-1"
* item[=].item[=].required = false

// --- PREGUNTA 4: Problemas para pagar transporte ---
* item[=].item[+].type = #boolean
* item[=].item[=].linkId = "93671-6"
* item[=].item[=].code = $LNC#93671-6 "Do you have trouble finding or paying for transportation [WellRx]"
* item[=].item[=].text = "¿Tiene problemas para encontrar o pagar transporte?"
* item[=].item[=].required = false

// --- PREGUNTA 5: Reprogramar cita (30 días) ---
* item[=].item[+].type = #choice
* item[=].item[=].linkId = "104015-3"
* item[=].item[=].code = $LNC#104015-3 "How often did you have to reschedule an appointment because of a problem with transportation"
* item[=].item[=].text = "En los últimos 30 días, ¿ha tenido que reprogramar una cita por problemas de transporte?"
* item[=].item[=].answerValueSet = "http://loinc.org/vs/LL6511-1"
* item[=].item[=].required = false

// --- PREGUNTA 6: Dejado de ir a algún lugar (30 días) ---
* item[=].item[+].type = #choice
* item[=].item[=].linkId = "104016-1"
* item[=].item[=].code = $LNC#104016-1 "How often did you skip going somewhere because of a problem with transportation"
* item[=].item[=].text = "En los últimos 30 días, ¿ha dejado de ir a algún lugar por problemas de transporte?"
* item[=].item[=].answerValueSet = "http://loinc.org/vs/LL6511-1"
* item[=].item[=].required = false

// --- PREGUNTA 7: No ha podido salir de casa (30 días) ---
* item[=].item[+].type = #choice
* item[=].item[=].linkId = "104017-9"
* item[=].item[=].code = $LNC#104017-9 "How often were you not able to leave the house when you wanted to because of a problem with transportation"
* item[=].item[=].text = "En los últimos 30 días, ¿no ha podido salir de su casa por problemas de transporte?"
* item[=].item[=].answerValueSet = "http://loinc.org/vs/LL6511-1"
* item[=].item[=].required = false