Alias: $SCT = http://snomed.info/sct
Alias: $LNC = http://loinc.org
Alias: SNOMED_CT = http://snomed.info/sct

// ============================================================================
// CodeSystems Fragmentarios para Validación Offline (Gravity Style)
// ============================================================================

CodeSystem: SnomedCtLocalCodes
Id: snomed-ct-local
Title: "Definición Local Fragmentaria de SNOMED CT"
Description: "Definición parcial local de códigos de SNOMED CT para validación offline en la IG de transporte."
* ^url = "http://snomed.info/sct"
* ^status = #active
* ^content = #fragment
* ^experimental = false
* ^caseSensitive = true

// Códigos indicados para el ValueSet de Transporte
* #160695008 "Transport too expensive"
* #160696009 "Transport distance too great"
* #424629004 "Transportation barrier impedes ability to use community resources"
* #551691000124106 "Transportation insecurity"
* #551701000124106 "Transportation insecurity due to unsafe transportation environment"
* #551711000124109 "Transportation insecurity due to excessive travel time to destination"
* #551721000124101 "Transportation insecurity due to no driver's license"
* #551731000124103 "Inability to access health care due to transportation insecurity"
* #551741000124108 "Transportation insecurity due to no access to vehicle"
* #551751000124105 "Inability to access community resources due to transportation insecurity"
* #551761000124107 "Transportation insecurity due to unaffordable transportation"
* #611151000124107 "Transportation insecurity due to route not serviced by public transportation"
* #611161000124109 "Transportation insecurity limiting access to food"
* #713458007 "Lack of access to transportation"
* #425121008 "Lack of transportation"
* #713109004 "Difficulty finding transportation"
// Códigos requeridos para US Core Condition Codes
* #160245001 "No current problems or disability"
* #404684003 "Clinical finding"
* #243796009 "Situation with explicit context"
* #272379006 "Event"


CodeSystem: SDOHCC_TemporaryCodes_Local
Id: sdohcc-temporary-codes-local
Title: "Definición Local Fragmentaria de CodeSystem de Gravity"
Description: "Definición parcial local del CodeSystem temporal de Gravity para validación offline de categorías en la condición de transporte."
* ^url = "http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/sdohcc-temporary-codes"
* ^status = #active
* ^content = #fragment
* ^experimental = false
* ^caseSensitive = true
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-wg].valueCode = #cgp
* ^publisher = "HL7 International / Cross-Group Projects"
* ^contact[0].name = "HL7 International / Cross-Group Projects"
* ^contact[0].telecom[0].system = #url
* ^contact[0].telecom[0].value = "http://www.hl7.org/Special/committees/cgp"

* #Condition.category "Condition.category" "Category of the condition"
* #Observation.category "Observation.category" "Category of the observation"
* #sdoh "sdoh" "Social Determinants of Health category"
* #transportation-insecurity "Transportation Insecurity" "Transportation Insecurity domain"
* #food-insecurity "Food Insecurity" "Food Insecurity domain"
* #housing-instability "Housing Instability" "Housing Instability domain"


// ============================================================================
// ValueSets de la Guía de Implementación
// ============================================================================

ValueSet: VSRespuestasTransporte
Id: vs-respuestas-transporte
Title: "Respuestas Transporte"
Description: "Respuestas codificadas para preguntas de transporte SDOH"
* ^status = #active
* ^experimental = false
* http://loinc.org#LA6270-8 "Never"
* http://loinc.org#LA10082-8 "Sometimes"
* http://loinc.org#LA10044-8 "Often"
* http://loinc.org#LA33093-8 "Yes, it has kept me from medical appointments or getting medications"
* http://loinc.org#LA30133-5 "Yes, it has kept me from medical appointments or from getting my medications"

// ValueSet unificado para las condiciones clínicas/sociales de transporte
ValueSet: VSCondicionesTransporte
Id: vs-condiciones-transporte
Title: "Condiciones de Transporte"
Description: "Códigos de SNOMED CT para registrar problemas, diagnósticos y barreras de transporte en determinantes sociales."
* ^status = #active
* ^experimental = false
* $SCT#160695008 "Transport too expensive"
* $SCT#160696009 "Transport distance too great"
* $SCT#424629004 "Transportation barrier impedes ability to use community resources"
* $SCT#551691000124106 "Transportation insecurity"
* $SCT#551701000124106 "Transportation insecurity due to unsafe transportation environment"
* $SCT#551711000124109 "Transportation insecurity due to excessive travel time to destination"
* $SCT#551721000124101 "Transportation insecurity due to no driver's license"
* $SCT#551731000124103 "Inability to access health care due to transportation insecurity"
* $SCT#551741000124108 "Transportation insecurity due to no access to vehicle"
* $SCT#551751000124105 "Inability to access community resources due to transportation insecurity"
* $SCT#551761000124107 "Transportation insecurity due to unaffordable transportation"
* $SCT#611151000124107 "Transportation insecurity due to route not serviced by public transportation"
* $SCT#611161000124109 "Transportation insecurity limiting access to food"
* $SCT#713458007 "Lack of access to transportation"
* $SCT#425121008 "Lack of transportation"
* $SCT#713109004 "Difficulty finding transportation"

// ValueSet que agrupa las 7 preguntas LOINC de Transporte SDOH
ValueSet: VSPreguntasTransporteLOINC
Id: vs-preguntas-transporte-loinc
Title: "Preguntas de Transporte LOINC"
Description: "Conjunto de las 7 preguntas normalizadas de LOINC utilizadas en el Cuestionario de Transporte SDOH."
* ^status = #active
* ^experimental = false
* $LNC#93030-5 "Has lack of transportation kept you from medical appointments, meetings, work, or from getting things needed for daily living"
* $LNC#99594-4 "Delayed medical care due to distance or lack of transportation"
* $LNC#101351-5 "Has lack of transportation kept you from medical appointments, meetings, work, or from getting things needed for daily living during assessment period [CMS Assessment]"
* $LNC#93671-6 "Do you have trouble finding or paying for transportation [WellRx]"
* $LNC#104015-3 "How often did you have to reschedule an appointment because of a problem with transportation"
* $LNC#104016-1 "How often did you skip going somewhere because of a problem with transportation"
* $LNC#104017-9 "How often were you not able to leave the house when you wanted to because of a problem with transportation"

// ValueSet para las categorías de determinantes sociales (SDOH)
ValueSet: VSCategoriasSDOH
Id: vs-categorias-sdoh
Title: "Categorías de Determinantes Sociales de la Salud"
Description: "ValueSet de categorías para clasificar los determinantes sociales de la salud (SDOH)."
* ^status = #active
* ^experimental = false
* http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/sdohcc-temporary-codes#transportation-insecurity "Inseguridad de Transporte"
* http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/sdohcc-temporary-codes#food-insecurity "Inseguridad Alimentaria"
* http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/sdohcc-temporary-codes#housing-instability "Inestabilidad de Vivienda"