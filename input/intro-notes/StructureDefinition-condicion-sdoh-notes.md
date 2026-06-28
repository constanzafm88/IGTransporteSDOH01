### Notas de Implementación

#### Codificación del Diagnóstico (SNOMED CT)
* El campo `code` está ligado de forma obligatoria al ValueSet local `VSCondicionesTransporte`, el cual contiene los códigos clínicos estándar de SNOMED CT que describen problemas y riesgos relacionados con el acceso al transporte (ej: código SNOMED `713458007`).

#### Evidencia del Diagnóstico (`evidence.detail`)
* Es altamente recomendable poblar el campo `evidence.detail` con las referencias a los recursos `ObservacionSDOH` generados a partir del tamizaje. Esto permite la trazabilidad completa, de modo que el clínico pueda verificar el cuestionario y las respuestas que fundamentaron el diagnóstico.

#### Reportabilidad Ministerial (CIE-10)
* Para cumplir con los informes REM del Ministerio de Salud (MINSAL), se debe incluir en `code.coding` el mapeo correspondiente al código Z de CIE-10 (ej: `Z59.82` para Inseguridad de Transporte), asegurando la automatización de estadísticas.
