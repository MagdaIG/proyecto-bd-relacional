# 07 - Validaciones

Esta carpeta contiene scripts de validación para verificar la integridad y consistencia de los datos en el sistema de inventario. Estas validaciones son útiles para auditorías, mantenimiento y detección de problemas en la base de datos.

---

## Archivos incluidos

- `validaciones_integridad.sql`: Script para verificar integridad referencial y restricciones básicas
- `validaciones_consistencia.sql`: Script para verificar consistencia lógica de negocio
- `README.md`: Este archivo explicativo

---

## Tipos de validaciones

### validaciones_integridad.sql

Verifica aspectos fundamentales de integridad de datos:

1. **Claves foráneas huérfanas**: Detecta registros que referencian entidades inexistentes
2. **Duplicados**: Identifica registros duplicados en campos únicos
3. **Restricciones de negocio**: Verifica que se cumplan las reglas de validación (stock >= 0, precios > 0, etc.)
4. **Valores nulos**: Detecta campos obligatorios con valores nulos

### validaciones_consistencia.sql

Verifica la consistencia lógica del sistema:

1. **Consistencia de stock**: Compara el stock actual vs el calculado por transacciones
2. **Ventas sin stock**: Detecta ventas que exceden el stock disponible
3. **Precios inconsistentes**: Identifica transacciones con precios muy diferentes al producto
4. **Fechas inconsistentes**: Detecta transacciones con fechas futuras o muy antiguas
5. **Proveedores inactivos**: Verifica proveedores inactivos con transacciones recientes
6. **Productos huérfanos**: Identifica productos sin transacciones o sin proveedores

---

## Cómo usar

### Ejecución individual
```sql
-- Ejecutar validaciones de integridad
\i 07-validaciones/validaciones_integridad.sql

-- Ejecutar validaciones de consistencia
\i 07-validaciones/validaciones_consistencia.sql
```

### Ejecución completa
```sql
-- Ejecutar todas las validaciones
\i 07-validaciones/validaciones_integridad.sql
\i 07-validaciones/validaciones_consistencia.sql
```

---

## Interpretación de resultados

- **0 registros problemáticos**: La validación pasó correctamente
- **>0 registros problemáticos**: Se encontraron inconsistencias que requieren atención
- **Mensajes de error**: Indican problemas críticos que impiden la ejecución

---

## Recomendaciones

- Ejecutar estas validaciones regularmente en entornos de producción
- Integrar en procesos de CI/CD para validación automática
- Documentar y corregir cualquier inconsistencia encontrada
- Considerar crear alertas automáticas para validaciones críticas

---

## Prerequisitos

Antes de ejecutar estos scripts, asegúrate de haber ejecutado:
1. Los scripts DDL de la carpeta `02-ddl/`
2. Los scripts DML de la carpeta `03-dml/`
3. Los triggers de la carpeta `05-triggers/`
