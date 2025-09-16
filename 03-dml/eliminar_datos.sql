SET search_path TO inventario, public;

-- Eliminar relación producto-proveedor específica
DELETE FROM productos_proveedores pp
USING productos p, proveedores pr
WHERE pp.producto_id = p.producto_id
  AND pp.proveedor_id = pr.proveedor_id
  AND p.nombre = 'Sierra Circular'
  AND pr.nombre = 'ToolHouse SPA';

-- Intentar eliminar proveedor inactivo (bloqueado si tiene transacciones referenciadas)
-- Gracias a ON DELETE SET NULL en transacciones.proveedor_id, se permite si sólo es referencia en transacciones
DELETE FROM proveedores WHERE nombre = 'MegaProveedor' AND activo = FALSE;


