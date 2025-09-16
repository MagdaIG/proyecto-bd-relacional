-- Esquema: Inventario - PostgreSQL
-- Crea tablas normalizadas hasta 3FN: productos, proveedores, transacciones
-- Ejecutar en un DB vacío o con esquema dedicado

-- Crear esquema lógico para el sistema de inventario
CREATE SCHEMA IF NOT EXISTS inventario;
SET search_path TO inventario, public;

-- Comentario: Este esquema contiene todas las tablas del sistema de inventario

-- Tabla: proveedores
CREATE TABLE IF NOT EXISTS proveedores (
    proveedor_id SERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    contacto VARCHAR(120),
    telefono VARCHAR(30),
    email VARCHAR(120) UNIQUE,
    activo BOOLEAN NOT NULL DEFAULT TRUE
);

-- Tabla: productos
CREATE TABLE IF NOT EXISTS productos (
    producto_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio NUMERIC(12,2) NOT NULL CHECK (precio >= 0),
    stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0)
);

-- Relación N:M productos-proveedores (un producto puede tener varios proveedores)
CREATE TABLE IF NOT EXISTS productos_proveedores (
    producto_id INTEGER NOT NULL REFERENCES productos(producto_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    proveedor_id INTEGER NOT NULL REFERENCES proveedores(proveedor_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    precio_acordado NUMERIC(12,2) CHECK (precio_acordado IS NULL OR precio_acordado >= 0),
    PRIMARY KEY (producto_id, proveedor_id)
);

-- Tabla: transacciones (compra/venta)
CREATE TABLE IF NOT EXISTS transacciones (
    transaccion_id SERIAL PRIMARY KEY,
    tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('compra','venta')),
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    producto_id INTEGER NOT NULL REFERENCES productos(producto_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    proveedor_id INTEGER REFERENCES proveedores(proveedor_id) ON UPDATE CASCADE ON DELETE SET NULL,
    precio_unitario NUMERIC(12,2) CHECK (precio_unitario IS NULL OR precio_unitario >= 0),
    fecha TIMESTAMP NOT NULL DEFAULT NOW(),
    observacion TEXT
);

-- Índices útiles
CREATE INDEX IF NOT EXISTS idx_transacciones_producto_fecha ON transacciones(producto_id, fecha DESC);
CREATE INDEX IF NOT EXISTS idx_transacciones_tipo ON transacciones(tipo);

-- Vista de apoyo: stock valorizado
CREATE OR REPLACE VIEW vw_stock_productos AS
SELECT p.producto_id,
       p.nombre,
        p.stock,
        p.precio,
        (p.stock * p.precio) AS stock_valorizado
FROM productos p;


