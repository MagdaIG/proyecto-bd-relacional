# Carpeta 04 - Consultas SQL

Esta carpeta contiene ejemplos de consultas SQL para el sistema de inventario, incluyendo operaciones de selección, filtrado, agrupación y uniones entre tablas.

## Archivos incluidos

- `consultas.sql`: Script con ejemplos de consultas SQL del sistema
- `README.md`: Este archivo explicativo

## Tipos de consultas incluidas

### 1. Consulta básica de productos
Lista todos los productos con su información de stock y valorización total.

### 2. Consulta con JOIN
Muestra productos con sus proveedores asociados, incluyendo productos sin proveedores.

### 3. Historial de transacciones
Consulta completa de transacciones con detalles de productos y proveedores, ordenada por fecha.

### 4. Consulta con GROUP BY y funciones agregadas
Resumen de ventas y compras por producto, mostrando totales calculados.

### 5. Consulta con filtros
Productos con stock bajo (menor o igual a 5 unidades).

## Características técnicas

- Uso de LEFT JOIN para incluir registros sin relaciones
- Aplicación de funciones agregadas (SUM, CASE)
- Filtros con WHERE y condiciones lógicas
- Ordenamiento con ORDER BY
- Cálculos de valorización de inventario

## Prerequisitos

Antes de ejecutar estas consultas, asegúrate de haber ejecutado:
1. Los scripts DDL de la carpeta `02-ddl/`
2. Los scripts DML de la carpeta `03-dml/`

## Próximos pasos

Después de explorar estas consultas, continúa con la carpeta `05-triggers/` para ver la implementación de triggers automáticos.
