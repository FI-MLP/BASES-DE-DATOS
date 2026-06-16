-- ==========================================================================================
-- Archivo: 02-control-flujo-if.sql
-- Descripción: Ejercicios de control de flujo usando IF...ELSE y EXISTS.
-- ==========================================================================================

USE [262_EMPRESA_89000546];
GO

/* EJERCICIO 1. Verifique si algún empleado ha ganado más de 40 mil pesos, en caso afirmativo 
   obtenga nombre del empleado, correo, domicilio y el total ganado. En caso contrario muestre 
   los mismos datos para el empleado con mayor ingreso. */

SELECT * FROM nomina.reciboPago ORDER BY pagoTotalCalculado DESC;

DECLARE @variable money;
SET @variable = 54000; -- Rango de prueba
SELECT @variable;

IF EXISTS(SELECT * FROM nomina.reciboPago WHERE pagoTotalCalculado > @variable)
BEGIN
    SELECT E.idEmpleado, E.nombre+' '+E.paterno+' '+ISNULL(materno,' ') AS nombreCompleto, correo, pagoTotalCalculado, D.calle 
    FROM trabajador.EMPLEADO E
    INNER JOIN nomina.reciboPago RP ON E.idEmpleado = RP.idEmpleado
    LEFT JOIN trabajador.DOMICILIO D ON RP.idEmpleado = D.idEmpleado
    WHERE pagoTotalCalculado > @variable;
END
ELSE
BEGIN
    SELECT 'No hay empleados con un sueldo mayor a: ' + CAST(@variable AS VARCHAR(10));
    
    SELECT 'MAYOR PAGO' AS Categoria, E.idEmpleado, E.nombre+' '+E.paterno+' '+ISNULL(materno,' ') AS nombreCompleto, correo, pagoTotalCalculado, D.calle 
    FROM trabajador.EMPLEADO E
    INNER JOIN nomina.reciboPago RP ON E.idEmpleado = RP.idEmpleado
    LEFT JOIN trabajador.DOMICILIO D ON RP.idEmpleado = D.idEmpleado
    WHERE pagoTotalCalculado = (SELECT MAX(pagoTotalCalculado) FROM nomina.reciboPago);
END
GO

/* EJERCICIO 2. Revise si cada empleado tiene al menos 1 proyecto asignado, en caso afirmativo 
   envíe el siguiente mensaje ‘Todos los empleados tienen un proyecto asignado’ en caso contrario, 
   si alguno de ellos es jefe, obtenga listado de sus pagos, y saque el listado de los empleados 
   que no tienen registrado un proyecto. Cree una columna 'mensaje'. */

IF EXISTS (
    SELECT e.idempleado FROM trabajador.EMPLEADO e
    LEFT JOIN proyecto.empleado_proyecto ep ON e.idempleado = ep.idempleado
    WHERE ep.id_proyecto IS NULL 
)
BEGIN
    --- Obtener los jefes que no tienen proyecto asignado
    IF EXISTS(
        SELECT * FROM trabajador.empleado e
        WHERE idEmpleado_jefe IS NULL AND e.idEmpleado IN (
            SELECT e.idempleado FROM trabajador.EMPLEADO e
            LEFT JOIN proyecto.empleado_proyecto ep ON e.idempleado = ep.idempleado
            WHERE ep.id_proyecto IS NULL
        )
    )
    BEGIN
        SELECT 'Jefe sin proyecto asignado' AS Mensaje, e.* FROM trabajador.empleado e
        WHERE idEmpleado_jefe IS NULL AND e.idEmpleado = ANY (
            SELECT e.idempleado FROM trabajador.EMPLEADO e
            LEFT JOIN proyecto.empleado_proyecto ep ON e.idempleado = ep.idempleado
            WHERE ep.id_proyecto IS NULL
        );
        
        SELECT 'Pagos de jefes sin proyecto asignado:' AS Mensaje, rp.* FROM nomina.reciboPago rp
        WHERE idEmpleado IN (
            SELECT e.idempleado FROM trabajador.EMPLEADO e
            LEFT JOIN proyecto.empleado_proyecto ep ON e.idempleado = ep.idempleado
            WHERE ep.id_proyecto IS NULL AND idEmpleado_jefe IS NULL
        );
        
        SELECT 'Empleado sin proyecto asignado' AS mensaje, e.* FROM trabajador.EMPLEADO e
        LEFT JOIN proyecto.empleado_proyecto ep ON e.idempleado = ep.idempleado
        WHERE ep.id_proyecto IS NULL AND idEmpleado_jefe IS NOT NULL;
    END
    ELSE
    BEGIN
        --- Obtener los empleados sin proyecto asignado
        SELECT 'Empleado sin proyecto asignado' AS mensaje, e.* FROM trabajador.EMPLEADO e
        LEFT JOIN proyecto.empleado_proyecto ep ON e.idempleado = ep.idempleado
        WHERE ep.id_proyecto IS NULL;
    END
END
ELSE
BEGIN
    SELECT 'Todos tienen un proyecto asignado' AS Mensaje;
END
GO
