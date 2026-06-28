Profile: LocalizacionFisicaSDOH
Parent: CoreLocalizacionCl
Id: localizacion-fisica-sdoh
Title: "Localización Física - APS SDOH"
Description: "Perfil de Localización Física para registrar centros de atención o locaciones geográficas en APS asociadas a determinantes sociales de la salud, heredado del perfil de Localización Nacional (CL Core)."

* status 1..1 MS
* name 1..1 MS
* name ^short = "Nombre de la localización física (ej: CESFAM Las Cabras)"
* address 1..1 MS
* address ^short = "Dirección física completa de la ubicación"
* position 0..1 MS
* position ^short = "Coordenadas geográficas de la localización"
* managingOrganization 0..1 MS
* managingOrganization only Reference(CoreOrganizacionCl)
* managingOrganization ^short = "Organización de salud a la que pertenece la localización"
