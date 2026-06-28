Instance: EjemploPaciente
InstanceOf: PacienteTransporteSDOH
Title: "Ejemplo de Paciente Chileno"
Description: "Paciente de ejemplo Juan Pablo Pérez, residente de la comuna de Las Cabras, con RUT e información demográfica básica."
Usage: #example

* active = true
* identifier.use = #official
* identifier.value = "12345678-9"
* identifier.system = "http://registrocivil.cl/run"

* name[NombreOficial].family = "Pérez"
* name[NombreOficial].family.extension[segundoApellido].valueString = "González"
* name[NombreOficial].given[0] = "Juan"
* name[NombreOficial].given[1] = "Pablo"

* gender = #male
* birthDate = "1980-05-15"

* address.use = #home
* address.line = "Calle General Carrera 450"
* address.city = "Las Cabras"
* address.city.extension[comunas].valueCodeableConcept = https://hl7chile.cl/fhir/ig/clcore/CodeSystem/CSCodComunasCL#06107 "Las Cabras"
