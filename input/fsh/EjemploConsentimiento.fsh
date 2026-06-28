Instance: ConsentimientoEjemploJuan
InstanceOf: ConsentimientoInformadoSDOH
Title: "Ejemplo de Consentimiento Informado - Juan Pérez"
Description: "Consentimiento firmado por el paciente Juan Pérez que autoriza el registro e intercambio de información sobre determinantes sociales (transporte) en el CESFAM Las Cabras."
Usage: #inline

* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category = http://loinc.org#59284-0 "Consent Document"
* patient = Reference(EjemploPaciente)
* dateTime = "2026-06-03T10:00:00Z"
* performer[0] = Reference(EjemploPaciente)
* organization = Reference(CESFAMLasCabras)
* policyRule = http://terminology.hl7.org/CodeSystem/consentpolicycodes#cric
* provision.type = #permit
