-- ==========================================================================================
-- Archivo: 03-ciclos-while.sql
-- Descripción: Ejercicios de iteración y ciclos utilizando WHILE, CONTINUE y BREAK.
-- ==========================================================================================

USE [262_EMPRESA_89000546];
GO

-- ---------------------------------------------------------
-- EJEMPLOS BÁSICOS
-- ---------------------------------------------------------
DECLARE @contador integer;
SET @contador = 0; 
WHILE (@contador < 100) 
BEGIN 
   SET @contador = @contador + 1; 
   IF (@contador % 2 = 0) 
      PRINT CAST(@contador AS varchar) + ' es un Número Par'; 
   ELSE 
      PRINT CAST(@contador AS varchar) + ' es un Número Impar'; 
END;
GO

-- ---------------------------------------------------------
-- EJERCICIOS PRÁCTICOS
-- ---------------------------------------------------------

/* EJERCICIO 1. Ponga la fecha de término a cada proyecto que aún no la tenga, ponga la fecha del sistema */
DECLARE @v_id_proyecto int, @v_contador smallint, @v_total smallint;
SET @v_contador = 1;

SELECT @v_total = count(*) FROM proyecto.proyectos;

WHILE @v_contador <= @v_total
BEGIN
    IF EXISTS (SELECT * FROM proyecto.proyectos WHERE id_proyecto = @v_contador AND fechafin IS NULL)
    BEGIN
        UPDATE proyecto.proyectos
        SET fechafin = GETDATE()
        WHERE id_proyecto = @v_contador;

        SELECT * FROM proyecto.proyectos WHERE id_proyecto = @v_contador;
    END
    ELSE
    BEGIN
        SELECT 'El proyecto tiene fecha fin' AS Estatus, * FROM proyecto.proyectos WHERE id_proyecto = @v_contador;
    END
    
    SET @v_contador = @v_contador + 1;
END
GO

/* EJERCICIO 2. Para cada empleado registre por lo menos 1 domicilio, si ya tiene envíe mensaje 
   ‘El empleado (nombre del empleado) ya tiene domicilio’ */
BEGIN TRAN

    DECLARE @contador2 int;
    SET @contador2 = 1;
    
    WHILE @contador2 <= (SELECT MAX(idempleado) FROM trabajador.empleado)
    BEGIN
        IF EXISTS(SELECT idempleado FROM trabajador.empleado WHERE idempleado = @contador2)
        BEGIN
            IF NOT EXISTS (SELECT idempleado FROM trabajador.domicilio WHERE idempleado = @contador2) 
            BEGIN
                INSERT INTO trabajador.domicilio (idEmpleado, calle, colonia, numero, alcaldia, tipo, CP)
                VALUES (@contador2, CONCAT('CALLE: ', @contador2), CONCAT('COLONIA: ', @contador2), CONCAT('NO: ', @contador2), 'COYOACAN', 'P', '00256');
                
                SELECT CONCAT('SE INSERTO REGISTRO PARA EL EMPLEADO: ', @contador2) AS Mensaje;
            END
            ELSE
            BEGIN
                PRINT 'El empleado: ' + LTRIM(RTRIM(CAST(@contador2 AS char))) + ' ya tiene domicilio';
            END
        END
        SET @contador2 = @contador2 + 1;
    END

    -- Visualizar resultados finales
    SELECT e.idempleado, paterno, materno, nombre, calle, colonia, numero, alcaldia, E.tipoEmpleado
    FROM trabajador.empleado AS e
    LEFT JOIN trabajador.domicilio AS d ON e.idempleado = d.idempleado;
    
ROLLBACK TRAN
GO
