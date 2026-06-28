### Notas de Implementación

#### Identificación del Paciente (RUN)
* Es obligatorio registrar el identificador nacional (RUN) utilizando el sistema oficial de codificación chileno en `identifier` para asegurar la unicidad del paciente en la Ficha Clínica Electrónica.

#### Codificación Geográfica (CUT)
* La dirección física del paciente en `address.state` y `address.district` debe estar codificada con el estándar del Instituto Nacional de Estadísticas de Chile (INE) mediante el código CUT de comunas y provincias. Esto permite realizar consultas avanzadas para identificar agrupaciones geográficas de vulnerabilidad (clústeres de riesgo social).
