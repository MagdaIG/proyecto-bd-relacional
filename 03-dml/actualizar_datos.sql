SET search_path TO inventario, public;

-- Cambiar precio de un producto
UPDATE productos SET precio = 46990
WHERE nombre = 'Taladro';

-- Marcar proveedor inactivo
UPDATE proveedores SET activo = FALSE
WHERE nombre = 'MegaProveedor';

-- Registrar ventas/ compras como actualizaciones del historial (se insertan en transacciones)
-- Venta de 2 taladros
INSERT INTO transacciones (tipo, cantidad, producto_id, precio_unitario, observacion)
VALUES ('venta', 2, (SELECT producto_id FROM productos WHERE nombre='Taladro'), 46990, 'Venta mostrador');


