-- ==========================================================================================
-- Archivo: 04-condicionales-case.sql
-- Descripción: Uso de la estructura CASE en consultas SELECT, ORDER BY, UPDATE y HAVING.
-- ==========================================================================================

USE [262_EMPRESA_89000546];
GO

-- ---------------------------------------------------------
-- EJEMPLOS BÁSICOS (SELECT, ORDER BY, UPDATE, HAVING)
-- ---------------------------------------------------------

-- En un SELECT
SELECT idempleado, paterno, materno, tipoempleado,   
       tipo = CASE tipoempleado 
           WHEN 'C' THEN 'CONFIANZA'  
           WHEN 'H' THEN 'HONORARIOS'  
           ELSE 'SIN ASIGNACION'  
       END
FROM trabajador.empleado  
ORDER BY tipo;  

-- En un UPDATE
BEGIN TRAN
    UPDATE empleadosEjemplo
    SET aguinaldo = ( 
        CASE  
            WHEN ((sueldo * 0.15) > 5000) THEN sueldo + 5000  
            ELSE (sueldo + 2000)  
        END  
    )  
    WHERE tipo = 'C';   
ROLLBACK TRAN

-- En un HAVING (Obtener para cada puesto el pago máximo)
SELECT puesto, MAX(sueldo) AS maximoSueldo, tipo
FROM empleadosEjemplo
GROUP BY puesto, tipo
HAVING (
    MAX(CASE WHEN tipo = 'C' THEN sueldo ELSE NULL END) > 25000
    OR 
    MAX(CASE WHEN tipo = 'H' THEN sueldo ELSE NULL END) > 30000
)  
ORDER BY maximoSueldo DESC;  

-- ---------------------------------------------------------
-- EJERCICIOS PRÁCTICOS
-- ---------------------------------------------------------

/* EJERCICIO: Liste nombre completo de cada proyecto, el número de empleados que trabajan en él, 
   costo del proyecto y si el costo es menor o igual que 265,000 muestre ‘PAGO BAJO’, etc. */

SELECT p.nombre, 
       COUNT(ep.idempleado) AS totalEmpleados, 
       SUM(pa.monto) AS montopagado,
       DescripcionDelPago = CASE
           WHEN SUM(pa.monto) <= 265000 THEN 'PAGO BAJO'
           WHEN SUM(pa.monto) > 265000 AND SUM(pa.monto) < 300000 THEN 'PAGO MEDIO'
           WHEN SUM(pa.monto) >= 300000 AND SUM(pa.monto) < 500000 THEN 'PAGO ACEPTABLE'
           ELSE 'CASI PAGADO'
       END
FROM proyecto.proyectos p
INNER JOIN proyecto.EMPLEADO_PROYECTO ep ON p.id_proyecto = ep.id_proyecto
INNER JOIN proyecto.pagos pa ON p.id_proyecto = pa.id_proyecto
GROUP BY p.nombre;
GO
