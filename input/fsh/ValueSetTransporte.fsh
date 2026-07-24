Alias: $SCT = http://snomed.info/sct
Alias: $SCTUS = http://snomed.info/sct/731000124108
Alias: $LNC = http://loinc.org

// ============================================================================
// ValueSets de la Guía de Implementación
// ============================================================================

ValueSet: VSRespuestasTransporte
Id: vs-respuestas-transporte
Title: "Respuestas Transporte"
Description: "Respuestas codificadas para preguntas de transporte SDOH"
* ^status = #active
* ^experimental = false
* include $LNC#LA6270-8 "Never"
* include $LNC#LA10082-8 "Sometimes"
* include $LNC#LA10044-8 "Often"
* include $LNC#LA33093-8 "Yes, it has kept me from medical appointments or getting medications"
* include $LNC#LA30133-5 "Yes, it has kept me from medical appointments or from getting my medications"

// ValueSet unificado para las condiciones clínicas/sociales de transporte
ValueSet: VSCondicionesTransporte
Id: vs-condiciones-transporte
Title: "Condiciones de Transporte"
Description: "Conceptos SNOMED CT utilizados para representar condiciones y barreras relacionadas con la inseguridad de transporte. Incluye conceptos internacionales y conceptos de la extensión estadounidense utilizados por Gravity Project."
* ^status = #active
* ^experimental = false

// Primer bloque: SNOMED CT International
* ^compose.include[+].system = $SCT
* ^compose.include[=].concept[+].code = #713458007
* ^compose.include[=].concept[=].display = "Lack of access to transportation"
* ^compose.include[=].concept[+].code = #160695008
* ^compose.include[=].concept[=].display = "Transport too expensive"
* ^compose.include[=].concept[+].code = #160696009
* ^compose.include[=].concept[=].display = "Transport distance too great"
* ^compose.include[=].concept[+].code = #424629004
* ^compose.include[=].concept[=].display = "Transportation barrier impedes ability to use community resources"

// Segundo bloque: SNOMED CT US Edition
* ^compose.include[+].system = $SCT
* ^compose.include[=].version = "http://snomed.info/sct/731000124108"
* ^compose.include[=].concept[+].code = #551691000124106
* ^compose.include[=].concept[=].display = "Transportation insecurity"
* ^compose.include[=].concept[+].code = #551701000124106
* ^compose.include[=].concept[=].display = "Transportation insecurity due to unsafe transportation environment"
* ^compose.include[=].concept[+].code = #551711000124109
* ^compose.include[=].concept[=].display = "Transportation insecurity due to excessive travel time to destination"
* ^compose.include[=].concept[+].code = #551721000124101
* ^compose.include[=].concept[=].display = "Transportation insecurity due to no driver's license"
* ^compose.include[=].concept[+].code = #551731000124103
* ^compose.include[=].concept[=].display = "Inability to access health care due to transportation insecurity"
* ^compose.include[=].concept[+].code = #551741000124108
* ^compose.include[=].concept[=].display = "Transportation insecurity due to no access to vehicle"
* ^compose.include[=].concept[+].code = #551751000124105
* ^compose.include[=].concept[=].display = "Inability to access community resources due to transportation insecurity"
* ^compose.include[=].concept[+].code = #551761000124107
* ^compose.include[=].concept[=].display = "Transportation insecurity due to unaffordable transportation"
* ^compose.include[=].concept[+].code = #611151000124107
* ^compose.include[=].concept[=].display = "Transportation insecurity due to route not serviced by public transportation"
* ^compose.include[=].concept[+].code = #611161000124109
* ^compose.include[=].concept[=].display = "Transportation insecurity limiting access to food"

// ValueSet que agrupa las 7 preguntas LOINC de Transporte SDOH
ValueSet: VSPreguntasTransporteLOINC
Id: vs-preguntas-transporte-loinc
Title: "Preguntas de Transporte LOINC"
Description: "Conjunto de las 7 preguntas normalizadas de LOINC utilizadas en el Cuestionario de Transporte SDOH."
* ^status = #active
* ^experimental = false
* include $LNC#93030-5 "Has lack of transportation kept you from medical appointments, meetings, work, or from getting things needed for daily living"
* include $LNC#99594-4 "Delayed medical care due to distance or lack of transportation"
* include $LNC#101351-5 "Has lack of transportation kept you from medical appointments, meetings, work, or from getting things needed for daily living during assessment period [CMS Assessment]"
* include $LNC#93671-6 "Do you have trouble finding or paying for transportation [WellRx]"
* include $LNC#104015-3 "How often did you have to reschedule an appointment because of a problem with transportation"
* include $LNC#104016-1 "How often did you skip going somewhere because of a problem with transportation"
* include $LNC#104017-9 "How often were you not able to leave the house when you wanted to because of a problem with transportation"

// ValueSet para las categorías de determinantes sociales (SDOH)
ValueSet: VSCategoriasSDOH
Id: vs-categorias-sdoh
Title: "Categorías de Determinantes Sociales de la Salud"
Description: "ValueSet de categorías para clasificar los determinantes sociales de la salud (SDOH)."
* ^status = #active
* ^experimental = false
* include http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/SDOHCC-CodeSystemTemporaryCodes#transportation-insecurity "Inseguridad de Transporte"
* include http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/SDOHCC-CodeSystemTemporaryCodes#food-insecurity "Inseguridad Alimentaria"
* include http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/SDOHCC-CodeSystemTemporaryCodes#housing-instability "Inestabilidad de Vivienda"