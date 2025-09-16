# 06 - Funciones SQL

Esta carpeta contiene funciones almacenadas útiles para facilitar la consulta de información en el sistema de gestión de inventario. Son funciones independientes de los triggers y pueden utilizarse en reportes, validaciones y automatización de tareas frecuentes.

---

## Funciones incluidas

### 1. `obtener_stock_actual(nombre_producto TEXT)`
- Devuelve el stock actual de un producto por su nombre (búsqueda insensible a mayúsculas/minúsculas).
- Lanza un error si el producto no existe.

### 2. `resumen_transacciones_producto(producto_nombre TEXT)`
- Entrega una fila con el total comprado y vendido de un producto específico.
- Útil para reportes rápidos por producto.

### 3. `productos_con_stock_bajo(limite INTEGER DEFAULT 5)`
- Lista los productos con stock menor o igual al límite provisto (por defecto 5).
- Ordena por stock ascendente y nombre.

---

## Ejemplos de uso

```sql
-- 1) Stock actual
SELECT obtener_stock_actual('Destornillador');

-- 2) Resumen de transacciones para un producto
SELECT * FROM resumen_transacciones_producto('Martillo');

-- 3) Productos con stock bajo
SELECT * FROM productos_con_stock_bajo();      -- Usa el límite por defecto (5)
SELECT * FROM productos_con_stock_bajo(10);    -- Límite personalizado
```

## Recomendaciones

- Cargar primero las tablas y datos de `02-ddl/` y `03-dml/`.
- Estas funciones se declaran con `STABLE`, por lo que pueden usarse en vistas o consultas repetitivas.
- En entornos de producción, considere permisos `GRANT EXECUTE` para roles de sólo consulta.

