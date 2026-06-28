### Notas de Implementación

#### Slicing Obligatorio de Categorías
Para cumplir con los estándares internacionales de HL7 Gravity, el campo `category` está segmentado en tres slices obligatorios que deben estar presentes en cada instancia:
1. **`social-history`**: Indica que el dato pertenece a los antecedentes sociales del paciente (`http://terminology.hl7.org/CodeSystem/observation-category#social-history`).
2. **`sdoh-category`**: Clasifica la observación dentro del marco general de Determinantes Sociales de la Salud (`http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/sdoh-category-code#sdoh-category-unspecified`).
3. **`domain-category`**: Especifica el dominio social concreto al que corresponde el tamizaje, que para este perfil piloto es la inseguridad de transporte (`http://hl7.org/fhir/us/sdoh-clinicalcare/CodeSystem/sdoh-category-code#transportation`).

Esta triple clasificación garantiza que los sistemas puedan agrupar y filtrar rápidamente todas las observaciones relacionadas con transporte social.
