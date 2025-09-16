SET search_path TO inventario, public;

-- 1) obtener_stock_actual(nombre_producto TEXT)
CREATE OR REPLACE FUNCTION obtener_stock_actual(nombre_producto TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_stock INTEGER;
BEGIN
  SELECT stock INTO v_stock
  FROM productos
  WHERE LOWER(nombre) = LOWER(nombre_producto);

  IF v_stock IS NULL THEN
    RAISE EXCEPTION 'El producto % no existe', nombre_producto;
  END IF;

  RETURN v_stock;
END;
$$ LANGUAGE plpgsql STABLE;

-- 2) resumen_transacciones_producto(producto_nombre TEXT)
-- Devuelve totales de compra y venta para un producto
CREATE OR REPLACE FUNCTION resumen_transacciones_producto(producto_nombre TEXT)
RETURNS TABLE (
  producto TEXT,
  total_comprado INTEGER,
  total_vendido INTEGER
) AS $$
BEGIN
  RETURN QUERY
  SELECT p.nombre AS producto,
         COALESCE(SUM(CASE WHEN t.tipo = 'compra' THEN t.cantidad END), 0) AS total_comprado,
         COALESCE(SUM(CASE WHEN t.tipo = 'venta' THEN t.cantidad END), 0) AS total_vendido
  FROM productos p
  LEFT JOIN transacciones t ON t.producto_id = p.producto_id
  WHERE LOWER(p.nombre) = LOWER(producto_nombre)
  GROUP BY p.nombre;
END;
$$ LANGUAGE plpgsql STABLE;

-- 3) productos_con_stock_bajo(limite INTEGER DEFAULT 5)
CREATE OR REPLACE FUNCTION productos_con_stock_bajo(limite INTEGER DEFAULT 5)
RETURNS TABLE (
  producto_id INTEGER,
  nombre TEXT,
  stock INTEGER
) AS $$
BEGIN
  RETURN QUERY
  SELECT p.producto_id, p.nombre, p.stock
  FROM productos p
  WHERE p.stock <= limite
  ORDER BY p.stock ASC, p.nombre ASC;
END;
$$ LANGUAGE plpgsql STABLE;


