Declare @num int;
Declare @suma int;

-- OBTENER DATOS
set @num=1;
set @suma=0;

-- ESTRUCTURA DE CONTROL
While @num<=100
BEGIN
	set @suma=@suma +@num
	set @num=@num +1
END
print @suma
GO
----



-- MOSTRAR INFORMACI�N
DECLARE @contador INT = 1;
WHILE @contador <= 10
BEGIN
    -- Obtener los valores de la fila actual
    DECLARE @id INT, @columna1 VARCHAR(50), @columna2 VARCHAR(50);
    
    SELECT @id = IdCategoría, @columna1 = NombreCategoría, @columna2 = Descripción
    FROM Categorías
    WHERE IdCategoría = @contador;

    -- Imprimir los valores de la fila actual
    PRINT 'Registro ' + CAST(@contador AS VARCHAR) + ':';
    PRINT 'Id: ' + CAST(@id AS VARCHAR);
    PRINT 'Columna1: ' + @columna1;
    PRINT 'Columna2: ' + @columna2;
    -- Imprimir las otras columnas según sea necesario

    -- Incrementar el contador
    SET @contador = @contador + 1;
END;

--------------
/*p3_Cursor*/
-- Realizar un reporte con las siguientes columnas: idCliente, 
-- NombreCompañia,CargoContacto,Pais 
-- utilizando la tabla Clientes implementado en un cursor..
sELECT * FROM clientes

Declare @id varchar(5),
@nombrecia varchar(100),
@cargo varchar(100),
@ppais varchar(100)
Declare p3_Cursor Cursor
for select idCliente, NombreCompañía,CargoContacto,País
from Clientes
-- Abrir Cursor
Open p3_Cursor
fetch p3_Cursor into @id,@nombrecia,@cargo,@ppais
print replicate('=',160)
print space(70) + 'REPORTE'
While(@@FETCH_STATUS=0)
BEGIN
print @id + ' - ' + @nombrecia + ' - ' + @cargo + ' - ' + @ppais
fetch p3_Cursor into @id, @nombrecia,@cargo,@ppais
END
close p3_Cursor
deallocate p3_Cursor

---------
CREATE OR ALTER FUNCTION FN_TBLProductos()
RETURNS TABLE
AS
RETURN (
		SELECT NombreProducto, PrecioUnidad,
		CASE 
			WHEN PrecioUnidad < 50 THEN 'Bajo'
			WHEN PrecioUnidad BETWEEN 50 AND 100 THEN 'Medio'
			ELSE 'Alto'
		END AS Categoria FROM Productos
		)
GO

---EJECUTAR
SELECT * FROM dbo.FN_TBLProductos()

-------------------------
CREATE OR ALTER PROCEDURE pedidosC
 @paisCliente varchar(20)
AS
BEGIN
	select FechaPedido, FechaEnvío, FechaEntrega, CiudadDestinatario, c.País 
	from Clientes c inner join Pedidos p ON c.IdCliente = p.IdCliente
	where c.País = @paisCliente
END

--llamar al procedimiento almacenado
exec pedidosC @paisCliente = 'Alemania'
exec pedidosC @paisCliente = 'Argentina'