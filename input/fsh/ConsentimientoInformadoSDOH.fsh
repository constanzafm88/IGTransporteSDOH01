Profile: ConsentimientoInformadoSDOH
Parent: Consent
Id: consentimiento-informado-sdoh
Title: "Consentimiento Informado - Transporte SDOH"
Description: "El consentimiento representa la autorización del paciente para compartir información relacionada con determinantes sociales de la salud con entidades involucradas en la coordinación del cuidado social."

* status 1..1 MS
* status = #active
* status ^short = "Estado del consentimiento (fijo en active)"

* scope 1..1 MS
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* scope ^short = "Alcance del consentimiento (fijo en patient-privacy)"

* category 1..* MS
* category = http://loinc.org#59284-0 "Consent Document"
* category ^short = "Categoría del consentimiento (Documento de Consentimiento)"

* patient 1..1 MS
* patient only Reference(PacienteTransporteSDOH)
* patient ^short = "Paciente que otorga el consentimiento"

* dateTime 1..1 MS
* dateTime ^short = "Fecha y hora en que se firmó el consentimiento"

* performer 1..* MS
* performer only Reference(PacienteTransporteSDOH)
* performer ^short = "Firmante del consentimiento (el propio paciente)"

* organization 1..1 MS
* organization only Reference(CoreOrganizacionCl)
* organization ^short = "Organización que solicita y gestiona el consentimiento"

* provision 1..1 MS
* provision.type 1..1 MS
* provision.type = #permit
* provision.type ^short = "Permiso otorgado: permit"
