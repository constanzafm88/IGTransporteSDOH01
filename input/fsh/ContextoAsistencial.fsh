Profile: PacienteTransporteSDOH
Parent: CorePacienteCl
Id: paciente-transporte-sdoh
Title: "Paciente - Transporte SDOH"
Description: "Perfil de Paciente adaptado para el registro de determinantes sociales de transporte en la APS chilena, heredado del perfil de Paciente Nacional (CL Core)."

* active = true
* active MS

// RUT/RUN chileno - Se registra directamente en identifier (no está sliced en CL Core)
* identifier 1..* MS
* identifier.value 1..1 MS
* identifier.value ^short = "RUN del paciente (ej: 12345678-9)"
* identifier.system 1..1 MS
* identifier.system = "http://registrocivil.cl/run"

// Nombre Oficial - Se debe restringir dentro del slice NombreOficial de CL Core
* name[NombreOficial] 1..1 MS
* name[NombreOficial].family 1..1 MS
* name[NombreOficial].family ^short = "Primer Apellido"
* name[NombreOficial].family.extension[segundoApellido] MS
* name[NombreOficial].family.extension[segundoApellido] ^short = "Segundo Apellido"
* name[NombreOficial].given 1..* MS
* name[NombreOficial].given ^short = "Nombres"

* gender 1..1 MS
* gender ^short = "Sexo administrativo registral (male | female | other | unknown)"

* birthDate 1..1 MS
* birthDate ^short = "Fecha de nacimiento del paciente"

* address 1..* MS
* address.line 1..1 MS
* address.line ^short = "Calle y número"
* address.city 1..1 MS
* address.city ^short = "Comuna de residencia"
