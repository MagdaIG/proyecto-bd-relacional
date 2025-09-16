SET search_path TO inventario, public;

-- 1) Listado de productos con stock y valorización
SELECT producto_id, nombre, stock, precio, (stock*precio) AS stock_valorizado
FROM productos
ORDER BY nombre;

-- 2) Productos con su(s) proveedor(es)
SELECT p.nombre AS producto, pr.nombre AS proveedor
FROM productos p
LEFT JOIN productos_proveedores pp ON pp.producto_id = p.producto_id
LEFT JOIN proveedores pr ON pr.proveedor_id = pp.proveedor_id
ORDER BY p.nombre, pr.nombre;

-- 3) Historial de transacciones con detalles
SELECT t.transaccion_id, t.fecha, t.tipo, t.cantidad,
       p.nombre AS producto, pr.nombre AS proveedor, t.precio_unitario
FROM transacciones t
JOIN productos p ON p.producto_id = t.producto_id
LEFT JOIN proveedores pr ON pr.proveedor_id = t.proveedor_id
ORDER BY t.fecha DESC;

-- 4) Resumen de ventas y compras por producto
SELECT p.nombre,
       SUM(CASE WHEN t.tipo='venta' THEN t.cantidad ELSE 0 END) AS total_vendido,
       SUM(CASE WHEN t.tipo='compra' THEN t.cantidad ELSE 0 END) AS total_comprado
FROM productos p
LEFT JOIN transacciones t ON t.producto_id = p.producto_id
GROUP BY p.nombre
ORDER BY p.nombre;

-- 5) Filtro: productos con stock bajo (<=5)
SELECT * FROM productos WHERE stock <= 5 ORDER BY stock ASC;


