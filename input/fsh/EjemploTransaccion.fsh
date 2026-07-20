Instance: BundleTransaccionLasCabras
InstanceOf: Bundle
Title: "Bundle de Transacción de Ejemplo - Envío de Respuestas"
Description: "Ejemplo de un Bundle de tipo transacción que muestra el payload real que un sistema clínico (EHR) envía al servidor FHIR tras procesar la encuesta de transporte. Contiene únicamente la respuesta al cuestionario (QuestionnaireResponse) y las 7 observaciones generadas, haciendo referencia a los recursos preexistentes del paciente y prestadores."
Usage: #example

* type = #transaction

// Registro de la Respuesta al Cuestionario (Origen de la transacción)
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/QuestionnaireResponse/EjemploRespuestaPaciente01"
* entry[=].resource = EjemploRespuestaPaciente01
* entry[=].request.method = #PUT
* entry[=].request.url = "QuestionnaireResponse/EjemploRespuestaPaciente01"

// Registro de la Observación 1
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Observation/ObsTransporte01"
* entry[=].resource = ObsTransporte01
* entry[=].request.method = #PUT
* entry[=].request.url = "Observation/ObsTransporte01"

// Registro de la Observación 2
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Observation/ObsTransporte02"
* entry[=].resource = ObsTransporte02
* entry[=].request.method = #PUT
* entry[=].request.url = "Observation/ObsTransporte02"

// Registro de la Observación 3
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Observation/ObsTransporte03"
* entry[=].resource = ObsTransporte03
* entry[=].request.method = #PUT
* entry[=].request.url = "Observation/ObsTransporte03"

// Registro de la Observación 4
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Observation/ObsTransporte04"
* entry[=].resource = ObsTransporte04
* entry[=].request.method = #PUT
* entry[=].request.url = "Observation/ObsTransporte04"

// Registro de la Observación 5
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Observation/ObsTransporte05"
* entry[=].resource = ObsTransporte05
* entry[=].request.method = #PUT
* entry[=].request.url = "Observation/ObsTransporte05"

// Registro de la Observación 6
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Observation/ObsTransporte06"
* entry[=].resource = ObsTransporte06
* entry[=].request.method = #PUT
* entry[=].request.url = "Observation/ObsTransporte06"

// Registro de la Observación 7
* entry[+].fullUrl = "http://biomedica.uv.cl/fhir/ig/transporte/Observation/ObsTransporte07"
* entry[=].resource = ObsTransporte07
* entry[=].request.method = #PUT
* entry[=].request.url = "Observation/ObsTransporte07"
