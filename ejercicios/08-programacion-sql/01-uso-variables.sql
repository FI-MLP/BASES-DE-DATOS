-- ==========================================================================================
-- Archivo: 01-uso-variables.sql
-- Descripción: Ejercicios de declaración, asignación y uso de variables en T-SQL.
-- ==========================================================================================

USE [262_EMPRESA_89000546];
GO

-- ---------------------------------------------------------
-- DECLARACIÓN DE VARIABLES
-- Variables locales definidas por usuario: @var_local
-- Variables globales: @@ (solo definidas en el sistema)
-- ---------------------------------------------------------

-- Ejemplo de variables globales
SELECT @@VERSION;
SELECT @@CONNECTIONS;

-- EJEMPLO 1. Variables locales
DECLARE @nombre varchar(20),
        @edad int,
        @sexo char(1) = 'H';
	
-- Asignar un valor
SET @edad = 45;
 
-- Ver el valor de la variable
SELECT @edad, @sexo;  -- Por medio de un select
PRINT @edad;          -- Por medio de un mensaje de consola
PRINT @sexo;

-- EJEMPLO 2. Asignar el valor a una variable por medio de una consulta
DECLARE @v_parentesco varchar(40);
SELECT @v_parentesco = denominacion FROM catalogo.parentesco WHERE id_parentesco = 3;

-- Ver el valor
SELECT @v_parentesco;
PRINT 'El parentesco con id=3 es: ' + @v_parentesco;

-- EJEMPLO 3. Usar el valor de una variable en una consulta
DECLARE @v_parentesco2 varchar(40);
SELECT @v_parentesco2 = denominacion FROM catalogo.parentesco WHERE id_parentesco = 3;
SELECT * FROM catalogo.parentesco WHERE denominacion = @v_parentesco2;

-- Una variable puede tener comodines:
DECLARE @patron varchar(30);
SET @patron = '%gmail.com';
SELECT @patron;
 
SELECT correo FROM trabajador.EMPLEADO WHERE correo LIKE @patron;
SELECT * FROM trabajador.EMPLEADO;

-- EJEMPLO 4. Queremos saber todos los datos de los EMPLEADOS con el sueldo más alto. 
-- Para ello podemos emplear una variable para almacenar el id del sueldo más alto:
DECLARE @idmayorsueldo INT; --- Los tipos de datos deben ser compatibles con el campo
 
SELECT @idmayorsueldo = idPuesto
FROM catalogo.puesto
WHERE sueldo = (SELECT MAX(sueldo) FROM catalogo.puesto);

SELECT 'Id de los empleados con mayor sueldo' AS Descripcion, @idmayorsueldo AS 'id del puesto';

-- Y luego mostrar todos los datos de los empleados empleando la variable anterior:
SELECT * FROM trabajador.EMPLEADO e
WHERE id_puestoActual = @idmayorsueldo;
