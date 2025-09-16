# Carpeta 05 - Triggers

Esta carpeta contiene la implementación de triggers automáticos para el sistema de inventario, específicamente para la actualización automática del stock de productos.

## Archivos incluidos

- `trigger_stock.sql`: Script con función y trigger para actualización automática de stock
- `README.md`: Este archivo explicativo

## Funcionalidad del trigger

### Función actualizar_stock()
La función `actualizar_stock()` se ejecuta automáticamente cada vez que se inserta una nueva transacción y realiza las siguientes acciones:

- **Para compras**: Incrementa el stock del producto según la cantidad comprada
- **Para ventas**: Decrementa el stock del producto según la cantidad vendida
- **Validación de stock**: Verifica que haya suficiente stock antes de procesar una venta

### Validaciones implementadas

1. **Verificación de stock disponible**: Antes de procesar una venta, verifica que el stock actual sea suficiente
2. **Mensaje de error descriptivo**: Si no hay suficiente stock, muestra el stock disponible y la cantidad solicitada
3. **Prevención de stock negativo**: Evita que el stock quede en valores negativos

### Trigger trg_actualizar_stock

- **Momento de ejecución**: AFTER INSERT en la tabla transacciones
- **Frecuencia**: FOR EACH ROW (se ejecuta por cada fila insertada)
- **Función asociada**: actualizar_stock()

## Flujo de funcionamiento

1. Se inserta una nueva transacción en la tabla `transacciones`
2. El trigger se activa automáticamente
3. La función verifica el tipo de transacción (compra/venta)
4. Para ventas, valida que haya stock suficiente
5. Actualiza el stock del producto correspondiente
6. Si hay error de validación, la transacción se revierte

## Prerequisitos

Antes de ejecutar este script, asegúrate de haber ejecutado:
1. Los scripts DDL de la carpeta `02-ddl/`
2. Los scripts DML de la carpeta `03-dml/`

## Ejemplo de uso

```sql
-- Esta venta se procesará normalmente si hay stock suficiente
INSERT INTO transacciones (tipo, cantidad, producto_id, precio_unitario)
VALUES ('venta', 2, 1, 45990);

-- Esta venta fallará si no hay suficiente stock
INSERT INTO transacciones (tipo, cantidad, producto_id, precio_unitario)
VALUES ('venta', 100, 1, 45990);
```

## Consideraciones técnicas

- El trigger utiliza PL/pgSQL para lógica compleja
- Se implementa validación a nivel de aplicación además de las restricciones de base de datos
- Los errores de validación revierten toda la transacción
- El sistema mantiene consistencia automática entre transacciones y stock
