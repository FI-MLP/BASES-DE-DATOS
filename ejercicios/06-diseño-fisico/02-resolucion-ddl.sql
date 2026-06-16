-- ==========================================================================================
-- Archivo: 02-resolucion-ddl.sql
-- Descripción: Resolución de los ejercicios prácticos de DDL (Tema 6).
-- ==========================================================================================

USE [262_EMPRESA_89000546]; -- Asegúrate de que coincida con el nombre de tu base de datos
GO

-- 1. Crear los esquemas catálogo, trabajador, proyecto y nómina --profesora


-- 2. Crear la tabla concepto en el esquema catálogo, la llave identity, el tipo de concepto Po D, el importe del concepto no debe pasar los $80,000 --profesora


-- 3. Crear la tabla empleado con constraints de tabla en el esquema trabajador --profesora


-- 4. Crear las tablas honorarios y confianza en el esquema trabajador --profesora


-- 5. Cree la tabla recibo pago en el esquema nomina --profesora


-- 6. Cree la tabla detalle recibo --profesora


-- 7. Agregue la tabla detalle recibo al esquema nomina -profesora


-- 8. Agregue a la tabla empleado el campo horario varchar(50) opcional --profesora


-- 9. Crear la tabla proyecto en el esquema proyecto con constraints de columna --profesora


/* 10. Cree la tabla domicilio en el esquema trabajador --profesora 
   Nota: con la condición on delete cascade, la llave foránea con nombre fk_empleado Domicilio, 
   el check de tipo con nombre ck_tipo. Todo debe ir dentro del comando créate table 
   y declarando los constraint de columna. */


-- 11. El cliente le pide que, si algún trabador no registra la calle de su domicilio, de manera automática se almacene en la base de datos domicilio conocido. --profesora


-- 12. Cree la integridad referencial del supervisor del proyecto


-- 13. Implemente la tabla puesto en el esquema catálogo, con constraint de columna


-- 14. Implemente la integridad referencial de la tabla empleado y puesto


/* 15. Cree la tabla parentesco en el esquema catálogo, con su clave primaria que se genere automáticamente.
   El esquema de la tabla es el siguiente: 
   PARENTESCO= {idparentesco (tinyint, PK), demoninacion varchar(80), vigente bit, CS8 }
   CS8. 1-vigente, 0 no vigente */


-- 16. Crear la tabla dependiente en el esquema trabajador como entidad débil por identificación de empleado


/* 17. Agrega a la tabla empleado las siguientes columnas:
   a) TELEFONO carácter de 10 y que solo acepte 10 dígitos del 0 al 9
   b) coloque el campo RFC como clave candidata, nombrela ak_rfc */


-- 18. El negocio tiene como regla que los sueldos oscilan entre $15,000 y $75,000. Implemente dicha regla en la base de datos. (ck_PagoPermitido)


-- 19. Valide que el campo plaza sea único (subtipo confianza) mediante índices (idx_plaza) --profesora


-- 20. Cambie el tamaño de la columna correo de la tabla empleado a 60


-- 21. En la tabla parentesco agregue el valor por default (DF_parentescoVigente) vigente en 1


-- 22. Borrar el constraint DF_parentescoVigente


-- 23. Modifique la columna correo de la tabla empleado a obligatoria


-- 24. Agregue la columna fecha de nacimiento a la tabla empleado con tipo de dato date y opcional


-- 25. Elimine la columna género de la tabla empleado


-- 26. Implemente el constraint a la columna quincena de la tabla reciboPago a fin de que únicamente acepte los siguientes valores 01,02, 03...24, nombre el constraint ck_quincena


-- 27. Crea índice a la tabla empleado para los apellidos (apellido paterno y apellido materno) --PROFESORA


-- 28. Cree la tabla histórico de puestos en el esquema trabajador con constraints de columna en el esquema trabajador


-- 29. Cree un índice non clustered a la tabla histórico puesto por el campo idpuesto


-- 30. Implementa el puesto actual a la tabla empleado (por medio de integridad referencial)


-- 31. Crear la columna calculada a la tabla recibopago, nombre la columna pagototalcalculada persistente que obtenga la diferencia (total percepciones -totaldeducciones) --profesora


-- 32. Cree la foreign key id_empleado_jefe


-- 33. Cree la tabla empleado proyecto con constraint de tabla --profesora


-- 34. Agregue la tabla empleado proyecto al esquema proyecto --profesora


-- 35. Crear la tabla tarjeta en el esquema trabajador con constraint de columna --profesora


-- 36. Crear la tabla pagos en el esquema proyecto con constraint de tabla
