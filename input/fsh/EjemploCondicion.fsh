Alias: $SDOHCC-TemporaryCodes = http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/sdohcc-temporary-codes
Alias: $SCT = http://snomed.info/sct

Instance: CondicionTransporteJuan
InstanceOf: CondicionSDOHSDOH
Title: "Ejemplo de Diagnóstico de Inseguridad de Transporte"
Description: "Diagnóstico activo de inseguridad de transporte para un paciente rural de Las Cabras, registrado por el profesional de salud basándose en la encuesta."
Usage: #inline

* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed
* category[problem-list-item] = http://terminology.hl7.org/CodeSystem/condition-category#problem-list-item
* category[sdoh-category] = $SDOHCC-TemporaryCodes#transportation-insecurity
* code = $SCT#713458007 "Lack of access to transportation"
* subject = Reference(EjemploPaciente) // Coherente con los ejemplos de observaciones
* onsetDateTime = "2026-06-03"
* asserter = Reference(RolProfesionalSocialEjemplo) // Apunta al Rol Clínico
* evidence[0].detail = Reference(ObsTransporte01) // Apoya el diagnóstico en base a haber dejado de recibir atención médica

Instance: ProfesionalSocialEjemplo
InstanceOf: CorePrestadorCl
Title: "Profesional de Salud de Ejemplo"
Description: "Profesional de salud (Trabajadora Social) del CESFAM Las Cabras encargada de evaluar y registrar la condición de transporte."
Usage: #inline

* active = true
* name[0].family = "Valenzuela"
* name[0].family.extension[segundoApellido].valueString = "Díaz"
* name[0].given[0] = "Ana"
* identifier[run].use = #official
* identifier[run].system = "http://registrocivil.cl/run"
* identifier[run].value = "15678901-2"
* identifier[run].type.coding.system = "https://hl7chile.cl/fhir/ig/clcore/CodeSystem/CSTipoIdentificador"
* identifier[run].type.coding.code = #01
* identifier[run].type.coding.display = "RUN"

Instance: CESFAMLasCabras
InstanceOf: CoreOrganizacionCl
Title: "Centro de Salud Familiar Las Cabras"
Description: "Establecimiento de atención primaria de salud en Las Cabras donde se realiza la encuesta de transporte."
Usage: #inline

* active = true
* name = "CESFAM Las Cabras"
* identifier[0].value = "106301" // Código de ejemplo del establecimiento
* identifier[0].system = "https://registrodeestablecimientos.minsal.cl"

Instance: LocalizacionCESFAMLasCabras
InstanceOf: LocalizacionFisicaSDOH
Title: "Ubicación del CESFAM Las Cabras"
Description: "Ubicación física y geográfica del Centro de Salud Familiar Las Cabras."
Usage: #inline

* status = #active
* name = "CESFAM Las Cabras - Sector Azul"
* address.line = "Calle General Carrera 450"
* address.city = "Las Cabras"
* address.city.extension[comunas].valueCodeableConcept = https://hl7chile.cl/fhir/ig/clcore/CodeSystem/CSCodComunasCL#06107 "Las Cabras"
* managingOrganization = Reference(CESFAMLasCabras)
* position.longitude = -71.3094
* position.latitude = -34.2889

Instance: RolProfesionalSocialEjemplo
InstanceOf: RolProfesionalSDOH
Title: "Rol de Trabajadora Social - Ana Valenzuela"
Description: "Rol institucional y profesional de la Trabajadora Social Ana Valenzuela en el CESFAM Las Cabras, con codificación del MINSAL."
Usage: #inline

* active = true
* practitioner = Reference(ProfesionalSocialEjemplo)
* organization = Reference(CESFAMLasCabras)
* code = https://interoperabilidad.minsal.cl/fhir/ig/eis/CodeSystem/eis-TituloProfesional-CS#7 "Psicólogos/as" // Código representativo del MINSAL
* code.text = "Trabajadora Social"
* location = Reference(LocalizacionCESFAMLasCabras)
