-- ==========================================================================================
-- Archivo: 05-cursores.sql
-- Descripción: Ejercicios de declaración, recorrido y anidamiento de Cursores.
-- ==========================================================================================

USE [262_EMPRESA_89000546];
GO

/* EJERCICIO 1. Defina un cursor dinámico que permita visualizar: el primer registro, 
   el registro en la posición 6 y el último registro de la tabla empleados */
DECLARE EmpleadoDin SCROLL CURSOR 
FOR (SELECT * FROM trabajador.empleado);

OPEN EmpleadoDin;
    FETCH FIRST FROM EmpleadoDin;    -- Apuntando a la primera fila
    FETCH ABSOLUTE 6 FROM EmpleadoDin; -- Apuntando a la sexta fila
    FETCH LAST FROM EmpleadoDin;     -- Apuntando a la última fila
CLOSE EmpleadoDin;
DEALLOCATE EmpleadoDin;
GO

/* EJERCICIO 2. Liste todos los empleados (nombre y correo), incluya fecha de pago y quincena,
   si el pago es menor que 40,000 solo envíe el mensaje correspondiente. Si es nulo, registre pago. */
SET NOCOUNT ON;

DECLARE @idempleado int, @nombre varchar(122), @correo varchar(40), 
        @fechaPago datetime, @quincena char(2), @pago money;

DECLARE cEmpleados CURSOR
FOR (
    SELECT E.idEmpleado, E.nombre+' '+E.paterno+ISNULL(' '+E.materno,'') AS NombreCompleto, E.correo, 
           RP.fechaPago, RP.quincena, RP.pagoTotalCalculado 
    FROM trabajador.EMPLEADO E
    LEFT JOIN nomina.reciboPago RP ON RP.idEmpleado = E.idEmpleado
);

OPEN cEmpleados;
    FETCH cEmpleados INTO @idempleado, @nombre, @correo, @fechaPago, @quincena, @pago;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @idempleado AS idempleado, @nombre AS NombreCompleto, @correo AS correo, 
               @fechaPago AS FechaPago, @quincena AS Quincena, @pago AS Pago;

        IF @pago IS NULL
        BEGIN
            SELECT 'Ausencia de pago para: ' + @nombre AS Mensaje;
            INSERT INTO nomina.reciboPago (idEmpleado, quincena, totalPercepcion, totalDeduccion, año, fechaPago)
            SELECT idEmpleado, '09', sueldo, 0, YEAR(GETDATE()), GETDATE()
            FROM trabajador.EMPLEADO AS e
            INNER JOIN catalogo.puesto AS p ON e.id_puestoActual = p.idPuesto
            WHERE idEmpleado = @idempleado;
        END
        ELSE
        BEGIN
            IF (@pago < 40000)
            BEGIN
                SELECT 'Pago por debajo de lo estipulado: ' + @nombre + ' - ' + CAST(@pago AS varchar) AS Mensaje;
            END 
        END
        
        FETCH cEmpleados INTO @idempleado, @nombre, @correo, @fechaPago, @quincena, @pago;
    END
CLOSE cEmpleados;
DEALLOCATE cEmpleados;
GO

/* EJERCICIO 3. Para cada empleado muestre lo siguiente: nombre completo, alcaldia de donde vive, 
   nombre de los proyectos en los que ha participado (utilice CURSORES ANIDADOS). */
DECLARE @id_emp int, @pat varchar(40), @mat varchar(40), @nom varchar(40), @estado varchar(40), @nom_proy varchar(40);

DECLARE CEMP_DOM_PROY CURSOR FOR
    SELECT E.idempleado, E.paterno, E.materno, E.nombre, D.alcaldia 
    FROM trabajador.EMPLEADO E
    LEFT JOIN trabajador.DOMICILIO D ON D.idempleado = E.idempleado;

OPEN CEMP_DOM_PROY;
    FETCH CEMP_DOM_PROY INTO @id_emp, @pat, @mat, @nom, @estado;
    
    WHILE @@FETCH_STATUS = 0 
    BEGIN
        PRINT 'EMPLEADO: ' + @nom + ' ' + @pat + ' ' + ISNULL(@mat,'') + ' | ALCALDIA: ' + ISNULL(@estado,'DOMICILIO NO REGISTRADO');

        IF NOT EXISTS (SELECT * FROM proyecto.empleado_proyecto WHERE idempleado = @id_emp) 
            PRINT '  -> NO TIENE PROYECTO ASIGNADO';
        
        -- Cursor Anidado
        DECLARE CEMP_PROY CURSOR FOR
            SELECT P.nombre 
            FROM proyecto.proyectos P
            LEFT JOIN proyecto.empleado_proyecto EP ON P.id_proyecto = EP.id_proyecto
            WHERE EP.idempleado = @id_emp;

        OPEN CEMP_PROY;
            FETCH CEMP_PROY INTO @nom_proy;
            WHILE @@FETCH_STATUS = 0 
            BEGIN
                PRINT '  -> PROYECTO: ' + ISNULL(@nom_proy, 'Sin nombre');
                FETCH CEMP_PROY INTO @nom_proy;
            END
        CLOSE CEMP_PROY;
        DEALLOCATE CEMP_PROY;
    
        FETCH CEMP_DOM_PROY INTO @id_emp, @pat, @mat, @nom, @estado;
    END
CLOSE CEMP_DOM_PROY;
DEALLOCATE CEMP_DOM_PROY;
GO
