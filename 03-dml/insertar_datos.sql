-- Establecer el esquema activo
SET search_path TO inventario, public;

-- ======================================
-- Inserción de Datos Iniciales
-- ======================================

-- Tabla: proveedores
INSERT INTO proveedores (nombre, contacto, telefono, email)
VALUES
  ('Ferremax Ltda.', 'Carla Pizarro', '+56 9 1111 1111', 'contacto@ferremax.cl'),
  ('ToolHouse SPA', 'Luis Soto', '+56 9 2222 2222', 'ventas@toolhouse.cl'),
  ('MegaProveedor', 'Ana Díaz', '+56 2 2345 6789', 'ana@megaprov.cl')
ON CONFLICT DO NOTHING;

-- Tabla: productos
INSERT INTO productos (nombre, precio, stock)
VALUES
  ('Taladro', 45990, 10),
  ('Martillo', 8990, 30),
  ('Sierra Circular', 79990, 5),
  ('Destornillador', 2990, 50)
ON CONFLICT DO NOTHING;

-- Tabla intermedia: productos_proveedores
INSERT INTO productos_proveedores (producto_id, proveedor_id, precio_acordado)
SELECT p.producto_id, pr.proveedor_id,
       CASE
         WHEN p.nombre = 'Taladro' THEN 42000
         WHEN p.nombre = 'Sierra Circular' THEN 76000
         ELSE NULL
       END
FROM productos p
JOIN proveedores pr ON pr.nombre IN ('Ferremax Ltda.', 'ToolHouse SPA')
WHERE p.nombre IN ('Taladro', 'Sierra Circular')
ON CONFLICT DO NOTHING;

-- Tabla: transacciones (compras iniciales)
INSERT INTO transacciones (tipo, cantidad, producto_id, proveedor_id, precio_unitario, observacion)
VALUES
  ('compra', 5, (SELECT producto_id FROM productos WHERE nombre = 'Taladro'),
             (SELECT proveedor_id FROM proveedores WHERE nombre = 'Ferremax Ltda.'),
             42000,
             'Reposición de stock'),

  ('compra', 10, (SELECT producto_id FROM productos WHERE nombre = 'Martillo'),
              (SELECT proveedor_id FROM proveedores WHERE nombre = 'MegaProveedor'),
              7000,
