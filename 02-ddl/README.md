# 📂 02-ddl

Este archivo contiene las instrucciones DDL (Data Definition Language) para crear la base de datos relacional de un sistema de gestión de inventario.

## Estructura:

- **Esquema `inventario`**: organización lógica de las tablas.
- **Tabla `proveedores`**: almacena información de contacto y estado.
- **Tabla `productos`**: almacena nombre, precio y stock actual.
- **Tabla intermedia `productos_proveedores`**: permite una relación muchos a muchos entre productos y proveedores.
- **Tabla `transacciones`**: registro de compras y ventas, incluyendo cantidades, precios y observaciones.
- **Índices**: optimización de consultas frecuentes por `producto_id`, `fecha`, y `tipo`.
- **Vista `vw_stock_productos`**: muestra el stock valorizado por producto.

## Notas:

- Se asegura la normalización hasta 3FN.
- Se aplican restricciones (`CHECK`, `NOT NULL`, `UNIQUE`), claves primarias y foráneas.
- Soporta operaciones de mantenimiento con `ON UPDATE` y `ON DELETE`.

Recomendado ejecutar sobre una base de datos vacía de PostgreSQL.
