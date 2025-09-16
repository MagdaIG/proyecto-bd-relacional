# Proyecto BD Relacional - Inventario

Este repositorio contiene un sistema de ejemplo en PostgreSQL para gestionar productos, proveedores y transacciones.

## Cómo ejecutar
1. Ejecuta `02-ddl/crear_tablas.sql`.
2. Ejecuta `05-triggers/trigger_stock.sql`.
3. Inserta datos con `03-dml/insertar_datos.sql`.
4. Prueba actualizaciones/ventas con `03-dml/actualizar_datos.sql`.
5. Explora consultas en `04-consultas/consultas.sql`.

## Normalización (hasta 3FN)
- 1FN: Todas las tablas tienen valores atómicos y claves primarias.
- 2FN: No hay dependencias parciales porque las claves son simples excepto en `productos_proveedores` cuya PK compuesta depende totalmente de ambas columnas.
- 3FN: No existen dependencias transitivas; datos de contacto del proveedor están en `proveedores`. Información de productos no se repite en `transacciones` (sólo FK). La relación N:M se modela en `productos_proveedores`.

## Diagrama ER
Archivo en `01-modelado/diagrama-ERD.drawio`.

## Trigger de stock
Al insertar en `transacciones` una fila con `tipo` `venta` o `compra`, se ajusta `productos.stock` automáticamente.

## Tecnologías
- PostgreSQL 15+
- DBeaver o pgAdmin
- HTML/CSS para presentación
- Git para control de versiones


