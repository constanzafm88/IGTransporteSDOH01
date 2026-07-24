# Guía de Implementación: Determinantes Sociales de la Salud (SDOH) en la APS Chilena

Esta Guía de Implementación (Implementation Guide, IG) define una propuesta para representar información relacionada con los Determinantes Sociales de la Salud (SDOH) utilizando el estándar HL7 FHIR R4, adaptada al contexto de la Atención Primaria de Salud (APS) en Chile.

La guía toma como referencia los lineamientos del Gravity Project para el modelamiento de determinantes sociales y utiliza los perfiles administrativos definidos por Core CL, con el propósito de facilitar la interoperabilidad entre sistemas de información en salud.

Como caso piloto se implementa el dominio de Inseguridad de Transporte, permitiendo demostrar el flujo completo desde el registro del tamizaje hasta la representación estructurada de la información clínica.

### Organización de la guía

La guía se encuentra organizada en tres componentes principales:

* **Aspectos clínicos**, donde se presenta el contexto del dominio de transporte y el flujo de atención utilizado como referencia.
* **Aspectos técnicos**, donde se describen los recursos FHIR, terminologías y mecanismos de interoperabilidad empleados.
* **Artefactos de implementación**, donde se publican los perfiles, cuestionarios, terminologías, ejemplos y mapas de transformación desarrollados para esta implementación.

### Estructura general

El diseño de la especificación técnica se basa en una arquitectura modular que separa la base administrativa nacional común de los dominios temáticos específicos de SDOH, facilitando la escalabilidad del estándar:

<div style="text-align: center; margin: 25px 0;">
  {% include architecture-modular.svg %}
</div>

---

<div style="text-align: center; margin: 30px 0;">
  <img src="gravity-cycle.png" alt="Marco conceptual de referencia utilizado para el diseño de la guía, adaptado del Gravity Project" style="max-width: 80%; height: auto; border: 1px solid #ddd; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.08);" />
  <p style="margin-top: 10px; font-style: italic; color: #555;">Figura 1. Marco conceptual de referencia utilizado para el diseño de la guía, adaptado del Gravity Project.</p>
</div>