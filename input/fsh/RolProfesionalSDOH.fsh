Profile: RolProfesionalSDOH
Parent: CoreRolClinicoCl
Id: rol-profesional-sdoh
Title: "Rol Profesional - Transporte SDOH"
Description: "Perfil de Rol Clínico/Profesional para profesionales de APS involucrados en el registro y evaluación de determinantes sociales de la salud (SDOH)."
* ^experimental = true

* active 1..1 MS
* practitioner 1..1 MS
* practitioner only Reference(CorePrestadorCl)
* organization 1..1 MS
* organization only Reference(CoreOrganizacionCl)
* code 1..* MS
* code from https://interoperabilidad.minsal.cl/fhir/ig/eis/ValueSet/eis-titulo-profesional-vs (preferred)
* code ^short = "Rol o título profesional del encuestador"
* location 0..* MS
* location only Reference(LocalizacionFisicaSDOH)
* location ^short = "Ubicación física donde el profesional desempeña su rol"
