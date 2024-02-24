--Ejercicio01
DECLARE @precioMinimo INT = 300;

IF EXISTS (SELECT * FROM Productos WHERE PrecioUnidad > @precioMinimo)
BEGIN
    SELECT * FROM Productos WHERE PrecioUnidad > @precioMinimo;
END
ELSE
BEGIN
    PRINT 'No hay productos con un precio mayor que ' + CAST(@precioMinimo AS VARCHAR(10)) + '.';
END;
--MOSTRAR SI CUENTA O NO CON DESCUENTO CIERTOS PRODUCTOS QUE PERTENESCAN A LA CATEGORIA BEBIDAS
SELECT NombreCategor�a, NombreProducto,IdPedido, Descuento FROM 
Categor�as c inner join Productos p ON c.IdCategor�a = p.IdCategor�a 
inner join [Detalles de pedidos] de ON p.IdProducto = de.IdProducto
WHERE NombreCategor�a LIKE 'Bebi%';

select pr.Ciudad, pr.NombreCompa��a, p.NombreProducto, c.NombreCategor�a from Categor�as c 
inner join Productos p ON c.IdCategor�a = p.IdCategor�a
inner join Proveedores pr ON pr.IdProveedor = p.IdProveedor
WHERE NombreCategor�a LIKE 'Bebi%';

--Ejercicio02
SELECT NombreProducto, PrecioUnidad,
    CASE 
        WHEN PrecioUnidad < 50 THEN 'Bajo'
        WHEN PrecioUnidad BETWEEN 50 AND 100 THEN 'Medio'
        ELSE 'Alto'
    END AS Categoria
FROM Productos;

--Ejercicio03
BEGIN TRY
    INSERT INTO Categor�as (IdCategor�a, NombreCategor�a, Descripci�n, Imagen) VALUES (1, 'Categoria duplicada', 'Descripcion duplicada', NULL);-- Este insert intentar� insertar un ID duplicado
END TRY
BEGIN CATCH
    -- Capturamos el error y mostramos un mensaje personalizado
    PRINT 'Error(EM01): ' + CAST(ERROR_MESSAGE() AS VARCHAR(MAX));
END CATCH

--Ejercicio04
declare @num numeric(10,3)
declare @var varchar(20)
declare @num2 int
set @num = 19.217
set @var = 'Hola'
set @num2 = 20
--La precisi�n es 10, lo que significa que el n�mero puede tener un total de 10 d�gitos.
--La escala es 3, lo que significa que hasta 3 de esos d�gitos pueden estar despu�s del punto decimal.
--un n�mero v�lido ser�a 12345.678, (10 - 3 = 7) donde hay 5 d�gitos antes del punto decimal y 3 d�gitos despu�s del punto decimal.
print str(@num, 10, 2)  --una cadena de caracteres con un tama�o de 10 caracteres y mostrando 2 decimales.
print cast(@var as char(20))
print cast(@num2 as char(10))
--procedure storage
CREATE PROCEDURE clientesPedidos
 @paisCliente varchar(20)
AS
BEGIN
	select FechaPedido, FechaEnv�o, FechaEntrega, CiudadDestinatario, c.Pa�s 
	from Clientes c inner join Pedidos p ON c.IdCliente = p.IdCliente
	where c.Pa�s = @paisCliente
END

--llamar al procedimiento almacenado
exec clientesPedidos @paisCliente = 'Alemania'
exec clientesPedidos @paisCliente = 'Argentina'

--FUNCIONES
CREATE FUNCTION dbo.FuncionTabla()
RETURNS TABLE
AS
RETURN 
(
    -- Definici�n de la tabla de salida
    SELECT NombreContacto,Pa�s, NombreCompa��a
    FROM Clientes
);

SELECT * FROM dbo.FuncionTabla();


CREATE FUNCTION dbo.ObtenerProductosPorPrecioMinimo
(
    @precioMinimo DECIMAL(10, 2)  -- Par�metro de entrada
)
RETURNS TABLE
AS
RETURN 
(
    -- Definici�n de la tabla de salida
    SELECT NombreProducto, CantidadPorUnidad, PrecioUnidad
    FROM Productos
    WHERE PrecioUnidad >= @precioMinimo
);

SELECT * FROM dbo.ObtenerProductosPorPrecioMinimo(50.00);


CREATE FUNCTION dbo.ObtenerEmpleadoDesdeFechaDefinida
(
    @fechaDefinida varchar(35)  -- Par�metro de entrada
)
RETURNS TABLE
AS
RETURN 
(
    -- Definici�n de la tabla de salida
	select CONCAT(Nombre,' ',Apellidos) as Nombres, FechaContrataci�n, Pa�s
	from Empleados where
	FechaContrataci�n >= @fechaDefinida
);
SELECT * FROM dbo.ObtenerEmpleadoDesdeFechaDefinida('1993-06-25 09:49:05.763');
