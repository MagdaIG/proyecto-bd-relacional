SET search_path TO inventario, public;

-- ======================================
-- Validaciones de Integridad de Datos
-- ======================================
-- Script para verificar la integridad referencial y consistencia de datos

-- 1. Verificar claves foráneas huérfanas
SELECT 'Transacciones con productos inexistentes' AS validacion,
       COUNT(*) AS registros_problematicos
FROM transacciones t
LEFT JOIN productos p ON p.producto_id = t.producto_id
WHERE p.producto_id IS NULL;

SELECT 'Transacciones con proveedores inexistentes' AS validacion,
       COUNT(*) AS registros_problematicos
FROM transacciones t
LEFT JOIN proveedores pr ON pr.proveedor_id = t.proveedor_id
WHERE t.proveedor_id IS NOT NULL AND pr.proveedor_id IS NULL;

SELECT 'Relaciones producto-proveedor con productos inexistentes' AS validacion,
       COUNT(*) AS registros_problematicos
FROM productos_proveedores pp
LEFT JOIN productos p ON p.producto_id = pp.producto_id
WHERE p.producto_id IS NULL;

SELECT 'Relaciones producto-proveedor con proveedores inexistentes' AS validacion,
       COUNT(*) AS registros_problematicos
FROM productos_proveedores pp
LEFT JOIN proveedores pr ON pr.proveedor_id = pp.proveedor_id
WHERE pr.proveedor_id IS NULL;

-- 2. Verificar duplicados en claves primarias
SELECT 'Productos duplicados por nombre' AS validacion,
       COUNT(*) AS registros_duplicados
FROM (
  SELECT nombre, COUNT(*) as cnt
  FROM productos
  GROUP BY nombre
  HAVING COUNT(*) > 1
) duplicados;

SELECT 'Proveedores duplicados por email' AS validacion,
       COUNT(*) AS registros_duplicados
FROM (
  SELECT email, COUNT(*) as cnt
  FROM proveedores
  WHERE email IS NOT NULL
  GROUP BY email
  HAVING COUNT(*) > 1
) duplicados;

-- 3. Verificar restricciones de negocio
SELECT 'Productos con stock negativo' AS validacion,
       COUNT(*) AS registros_problematicos
FROM productos
WHERE stock < 0;

SELECT 'Productos con precio negativo o cero' AS validacion,
       COUNT(*) AS registros_problematicos
FROM productos
WHERE precio <= 0;

SELECT 'Transacciones con cantidad negativa o cero' AS validacion,
       COUNT(*) AS registros_problematicos
FROM transacciones
WHERE cantidad <= 0;

SELECT 'Transacciones con tipo inválido' AS validacion,
       COUNT(*) AS registros_problematicos
FROM transacciones
WHERE tipo NOT IN ('compra', 'venta');

-- 4. Verificar valores nulos en campos obligatorios
SELECT 'Productos con nombre nulo' AS validacion,
       COUNT(*) AS registros_problematicos
FROM productos
WHERE nombre IS NULL;

SELECT 'Proveedores con nombre nulo' AS validacion,
       COUNT(*) AS registros_problematicos
FROM proveedores
WHERE nombre IS NULL;

SELECT 'Transacciones con producto_id nulo' AS validacion,
       COUNT(*) AS registros_problematicos
FROM transacciones
WHERE producto_id IS NULL;

-- 5. Resumen de validaciones
SELECT 'RESUMEN: Todas las validaciones de integridad completadas' AS estado;

-- Nota: Si alguna validación devuelve registros_problematicos > 0, 
-- es necesario revisar y corregir los datos antes de continuar.
