# Guía de Implementación: Determinantes Sociales de la Salud (SDOH) en la APS Chilena

Bienvenido a la **Guía de Implementación (IG) de Determinantes Sociales de la Salud (SDOH) para la Atención Primaria de Salud (APS) en Chile**. Esta especificación establece un estándar técnico y semántico basado en **HL7 FHIR** y los lineamientos del **Proyecto Gravity** internacional para el registro, intercambio y gestión de los factores sociales que determinan el estado de salud de la población chilena.

> [!NOTE]
> **Enfoque Modular y Piloto Inicial**:  
> Esta guía ha sido diseñada bajo un modelo de arquitectura extensible. Define una **Base Administrativa Común** que cumple con los estándares de interoperabilidad nacional de la **Guía Core CL (HL7 Chile)**. Sobre esta base, los determinantes sociales se estructuran como módulos específicos independientes. En esta primera versión, el dominio de **Inseguridad de Transporte** actúa como el **módulo piloto inicial** para validar el modelo técnico.

---

## 1. Arquitectura Modular del Marco SDOH-Chile

Para optimizar el desarrollo de software en los centros de salud familiar (CESFAM) y evitar la duplicidad de esfuerzos lógicos, la guía estructura los artefactos en dos capas:

### A. Base Común Administrativa
Perfiles que definen las entidades administrativas, organizacionales y de resguardo de privacidad necesarias para cualquier tipo de evaluación social en Chile. Exigen la conformidad con estándares nacionales (como el RUN y el código de comuna CUT).

* [Paciente SDOH (PacienteTransporteSDOH)](StructureDefinition-paciente-transporte-sdoh.html): Restringe el recurso `Patient` exigiendo RUN chileno y residencia con código CUT oficial de comuna.
* [Localización Física (LocalizacionFisicaSDOH)](StructureDefinition-localizacion-fisica-sdoh.html): Perfil de `Location` para especificar la ubicación física del CESFAM de origen del sector familiar.
* [Rol Profesional APS (RolProfesionalSDOH)](StructureDefinition-rol-profesional-sdoh.html): Perfil de `PractitionerRole` para identificar al profesional o técnico (como Trabajador/a Social) responsable de la encuesta.
* [Consentimiento Informado (ConsentimientoInformadoSDOH)](StructureDefinition-consentimiento-informado-sdoh.html): Perfil de `Consent` para registrar la autorización del paciente para compartir sus datos socioeconómicos y de vulnerabilidad.

### B. Módulos Temáticos de SDOH (Piloto: Transporte)
Perfiles que estructuran el proceso clínico-social de un dominio específico. El piloto de transporte define:

* [Cuestionario de Tamizaje (CuestionarioTransporteSDOH)](Questionnaire-CuestionarioTransporteSDOH.html): Recurso `Questionnaire` estructurado con códigos LOINC para capturar las barreras y costos de transporte.
* [Respuestas de Tamizaje (RespuestaTransporteSDOH)](StructureDefinition-respuesta-transporte-sdoh.html): Recurso `QuestionnaireResponse` que almacena los datos declarados por el paciente.
* [Observación de Determinante Social de la Salud (ObservacionSDOH)](StructureDefinition-observacion-sdoh.html): Recurso `Observation` que modela cada respuesta de forma estructurada para facilitar su análisis semántico.
* [Condición de Determinante Social de la Salud (CondicionSDOHSDOH)](StructureDefinition-condicion-sdoh.html): Recurso `Condition` que registra formalmente el diagnóstico social (con códigos SNOMED CT y CIE-10 Código Z) en la lista de problemas del paciente.

<div style="text-align: center; margin: 30px 0;">
  {% include architecture-modular.svg %}
</div>

<div style="text-align: center; margin: 30px 0;">
  <img src="gravity-cycle.png" alt="Conceptual Framework Gravity" style="max-width: 80%; height: auto; border: 1px solid #ddd; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.08);" />
</div>