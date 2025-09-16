SET search_path TO inventario, public;

-- Función: actualizar stock según transacciones
CREATE OR REPLACE FUNCTION actualizar_stock()
RETURNS TRIGGER AS $$
DECLARE
  stock_actual INTEGER;
BEGIN
  -- Obtener el stock actual del producto
  SELECT stock INTO stock_actual
  FROM productos
  WHERE producto_id = NEW.producto_id;

  IF NEW.tipo = 'venta' THEN
    -- Validar que hay suficiente stock para la venta
    IF stock_actual < NEW.cantidad THEN
      RAISE EXCEPTION 'Stock insuficiente. Stock disponible: %, cantidad solicitada: %',
        stock_actual, NEW.cantidad;
    END IF;

    UPDATE productos SET stock = stock - NEW.cantidad
    WHERE producto_id = NEW.producto_id;

  ELSIF NEW.tipo = 'compra' THEN
    UPDATE productos SET stock = stock + NEW.cantidad
    WHERE producto_id = NEW.producto_id;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger: después de insertar transacciones
DROP TRIGGER IF EXISTS trg_actualizar_stock ON transacciones;
CREATE TRIGGER trg_actualizar_stock
AFTER INSERT ON transacciones
FOR EACH ROW EXECUTE FUNCTION actualizar_stock();


