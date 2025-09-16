# Carpeta 03 - Manipulación de Datos (DML)

Esta carpeta contiene los scripts de **Data Manipulation Language (DML)** para insertar, actualizar y eliminar datos en el sistema de inventario.

## Archivos incluidos

- `insertar_datos.sql`: Script para insertar datos iniciales en todas las tablas
- `actualizar_datos.sql`: Script con ejemplos de actualización de registros
- `eliminar_datos.sql`: Script con ejemplos de eliminación de datos
- `README.md`: Este archivo explicativo

## Orden de ejecución

1. **insertar_datos.sql**: Ejecutar primero para poblar las tablas con datos de prueba
2. **actualizar_datos.sql**: Ejecutar después para ver ejemplos de modificaciones
3. **eliminar_datos.sql**: Ejecutar al final para ver ejemplos de eliminaciones

## Descripción de los scripts

### insertar_datos.sql
- Inserta 3 proveedores de ejemplo
- Inserta 4 productos con precios y stock inicial
- Establece relaciones N:M entre productos y proveedores
- Registra transacciones iniciales de compra para poblar el historial

### actualizar_datos.sql
- Actualiza precios de productos
- Marca proveedores como inactivos
- Registra ventas como nuevas transacciones

### eliminar_datos.sql
- Elimina relaciones específicas producto-proveedor
- Elimina proveedores inactivos (respetando restricciones de integridad)

## Consideraciones importantes

- Todos los scripts usan `ON CONFLICT DO NOTHING` para evitar errores en ejecuciones repetidas
- Las eliminaciones respetan las restricciones de claves foráneas
- Los scripts están diseñados para ejecutarse múltiples veces sin generar errores
- Se incluyen comentarios explicativos en cada sección

## Próximos pasos

Después de ejecutar estos scripts DML, continúa con la carpeta `04-consultas/` para explorar las consultas SQL del sistema.
