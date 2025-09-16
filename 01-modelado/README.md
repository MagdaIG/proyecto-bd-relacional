# Carpeta 01 - Modelado de Datos

Esta carpeta contiene el **modelo entidad-relación (ERD)** del sistema de inventario relacional diseñado para gestionar productos, proveedores y transacciones en una organización.

## Objetivo del Modelado

El objetivo es representar de forma visual y estructurada las entidades principales del sistema, sus atributos y las relaciones entre ellas, para garantizar una base de datos **normalizada** y eficiente antes de la implementación en SQL.

## Archivos incluidos

- `ERD_transacciones_diagrama.png`: Imagen del diagrama entidad-relación del sistema.
- `README.md`: Este archivo explicativo.

## Entidades Principales

1. **Productos**
   - `producto_id` (PK)
   - `nombre`
   - `precio`
   - `stock`

2. **Proveedores**
   - `proveedor_id` (PK)
   - `nombre`
   - `direccion`
   - `telefono`
   - `email`

3. **Transacciones**
   - `transaccion_id` (PK)
   - `tipo` ('COMPRA' o 'VENTA')
   - `fecha`
   - `cantidad`
   - `producto_id` (FK)
   - `proveedor_id` (FK)

## Relaciones

- Un **producto** puede tener varios **movimientos de transacción** (1:N).
- Un **proveedor** puede estar relacionado con múltiples **productos** a través de una tabla puente (N:M) y con transacciones.

## Normalización aplicada

Se aplicó el proceso de **normalización hasta Tercera Forma Normal (3FN)** para evitar redundancia de datos y garantizar la integridad:

- Cada entidad tiene una clave primaria única.
- Los datos repetitivos (como proveedor dentro de productos) se separaron en su propia tabla.
- Las relaciones se gestionan mediante claves foráneas (foreign keys).

---

Continúa con la carpeta `02-ddl/` para ver cómo se implementa este modelo en SQL mediante el lenguaje de definición de datos (DDL).
