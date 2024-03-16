USE master;
GO

-- Crear un nuevo inicio de sesión (login)
CREATE LOGIN julio WITH PASSWORD = 'julio';
-------------------
USE neptuno2;
GO

-- Crear un usuario en la base de datos y asociarlo al inicio de sesión
CREATE USER julio FOR LOGIN julio;
------------crear rol de reading
USE master;
GO

-- Crear un nuevo rol de servidor para lectura
CREATE SERVER ROLE solo_lectura;

---------asignar permisos
USE master;
GO

-- Asignar permisos de solo lectura al rol
GRANT VIEW ANY DATABASE TO solo_lectura;
GRANT SELECT ALL USER SECURABLES TO solo_lectura;
--------agregar un usuario a rol solo lectura
USE master;
GO

-- Agregar un usuario existente al rol de solo lectura
ALTER SERVER ROLE solo_lectura ADD MEMBER [julio];