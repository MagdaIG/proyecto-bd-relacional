SET search_path TO inventario, public;

-- ======================================
-- Validaciones de Consistencia de Negocio
-- ======================================
-- Script para verificar la consistencia lógica del sistema de inventario

-- 1. Verificar consistencia de stock vs transacciones
SELECT 'Inconsistencias de stock calculado vs stock actual' AS validacion,
       p.nombre,
       p.stock AS stock_actual,
       COALESCE(SUM(CASE WHEN t.tipo = 'compra' THEN t.cantidad ELSE 0 END), 0) -
       COALESCE(SUM(CASE WHEN t.tipo = 'venta' THEN t.cantidad ELSE 0 END), 0) AS stock_calculado,
       p.stock - (COALESCE(SUM(CASE WHEN t.tipo = 'compra' THEN t.cantidad ELSE 0 END), 0) -
                  COALESCE(SUM(CASE WHEN t.tipo = 'venta' THEN t.cantidad ELSE 0 END), 0)) AS diferencia
FROM productos p
LEFT JOIN transacciones t ON t.producto_id = p.producto_id
GROUP BY p.producto_id, p.nombre, p.stock
HAVING p.stock != (COALESCE(SUM(CASE WHEN t.tipo = 'compra' THEN t.cantidad ELSE 0 END), 0) -
                   COALESCE(SUM(CASE WHEN t.tipo = 'venta' THEN t.cantidad ELSE 0 END), 0));

-- 2. Verificar transacciones de venta sin stock suficiente
SELECT 'Ventas que exceden el stock disponible' AS validacion,
       t.transaccion_id,
       p.nombre AS producto,
       p.stock AS stock_disponible,
       t.cantidad AS cantidad_vendida,
       (t.cantidad - p.stock) AS exceso
FROM transacciones t
JOIN productos p ON p.producto_id = t.producto_id
WHERE t.tipo = 'venta' AND t.cantidad > p.stock;

-- 3. Verificar precios inconsistentes
SELECT 'Transacciones con precios muy diferentes al precio del producto' AS validacion,
       t.transaccion_id,
       p.nombre AS producto,
       p.precio AS precio_producto,
       t.precio_unitario AS precio_transaccion,
       ROUND(((t.precio_unitario - p.precio) / p.precio * 100)::numeric, 2) AS diferencia_porcentual
FROM transacciones t
JOIN productos p ON p.producto_id = t.producto_id
WHERE t.precio_unitario IS NOT NULL
  AND ABS(t.precio_unitario - p.precio) > (p.precio * 0.5); -- Más del 50% de diferencia

-- 4. Verificar fechas inconsistentes
SELECT 'Transacciones con fechas futuras' AS validacion,
       COUNT(*) AS registros_problematicos
FROM transacciones
WHERE fecha > NOW();

SELECT 'Transacciones muy antiguas (más de 10 años)' AS validacion,
       COUNT(*) AS registros_problematicos
FROM transacciones
WHERE fecha < NOW() - INTERVAL '10 years';

-- 5. Verificar proveedores inactivos con transacciones recientes
SELECT 'Proveedores inactivos con transacciones recientes' AS validacion,
       pr.nombre AS proveedor,
       COUNT(t.transaccion_id) AS transacciones_recientes,
       MAX(t.fecha) AS ultima_transaccion
FROM proveedores pr
JOIN transacciones t ON t.proveedor_id = pr.proveedor_id
WHERE pr.activo = FALSE
  AND t.fecha > NOW() - INTERVAL '30 days'
GROUP BY pr.proveedor_id, pr.nombre;

-- 6. Verificar productos sin transacciones
SELECT 'Productos sin transacciones' AS validacion,
       p.nombre AS producto,
       p.stock,
       p.precio
FROM productos p
LEFT JOIN transacciones t ON t.producto_id = p.producto_id
WHERE t.producto_id IS NULL;

-- 7. Verificar productos con stock pero sin proveedores
SELECT 'Productos con stock pero sin proveedores' AS validacion,
       p.nombre AS producto,
       p.stock
FROM productos p
LEFT JOIN productos_proveedores pp ON pp.producto_id = p.producto_id
WHERE p.stock > 0 AND pp.producto_id IS NULL;

-- 8. Resumen de consistencia
SELECT 'RESUMEN: Validaciones de consistencia completadas' AS estado;
