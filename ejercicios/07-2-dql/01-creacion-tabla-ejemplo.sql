-- ==========================================================================================
-- Archivo: 01-creacion-tabla-ejemplo.sql
-- Descripción: Creación y poblado de la tabla 'empleadosEjemplo' para pruebas de consultas básicas.
-- Semestre: 2026-2
-- ==========================================================================================

-- ABRIR SU BASE DE DATOS
USE [262_EMPRESA_89000546];
GO

-- CREAR TABLA EJEMPLO
CREATE TABLE empleadosEjemplo (
    clave int identity primary key,
    paterno varchar(30) not null,
    materno varchar(30)  null,
    nombre varchar(30) not null,
    sueldo money,
    claveDepto smallint,
    tipo varchar(40),
    puesto varchar(80),
    aguinaldo money,
    ciudad varchar(40)
);
GO
 
-- Insertamos en nuestra tabla de ejemplos extrayendo datos de la tabla real
INSERT INTO empleadosEjemplo (paterno, materno, nombre) 
SELECT paterno, materno, nombre FROM trabajador.empleado;
GO
 
-- Modificaciones para generar datos dummy de prueba
UPDATE empleadosEjemplo
SET aguinaldo= 73000
WHERE CLAVE IN (10, 15, 5);

UPDATE empleadosEjemplo
SET aguinaldo= 65000
WHERE CLAVE not IN (10, 15, 5) and aguinaldo is null;

UPDATE empleadosEjemplo
SET sueldo=35000
WHERE clave<=7;

UPDATE empleadosEjemplo
SET sueldo=25000
WHERE clave<=12 and clave>7;

UPDATE empleadosEjemplo
SET sueldo=28000
WHERE clave>12;

UPDATE empleadosEjemplo
SET ciudad='TORREON'
WHERE clave in (1,3,5,7);

UPDATE empleadosEjemplo
SET ciudad='JUAREZ'
WHERE clave in (2,6,8);

UPDATE empleadosEjemplo
SET ciudad='JALISCO'
WHERE clave in (9,10,11,12);

UPDATE empleadosEjemplo
SET ciudad='CIUDAD DE MEXICO'
WHERE clave in (4, 13,14);

-- Asignación de Puestos
UPDATE empleadosEjemplo
SET puesto='DISEÑADOR'
WHERE clave in (1,4);

UPDATE empleadosEjemplo
SET puesto='ANALISTA'
WHERE clave in (8,10);

UPDATE empleadosEjemplo
SET puesto='DBA'
WHERE clave in (2,3);

UPDATE empleadosEjemplo
SET puesto='TESTER'
WHERE clave in (5,6,7);

UPDATE empleadosEjemplo
SET puesto='DESARROLLADOR'
WHERE clave in (10,9,11);

UPDATE empleadosEjemplo
SET puesto='LIDER DE PROYECTO'
WHERE clave=12;

UPDATE empleadosEjemplo
SET puesto='ANALISTA DB'
WHERE clave in (13,14);

-- Tipo de Empleado
UPDATE empleadosEjemplo
SET tipo='C'
WHERE clave in (1,3,5,7,9,11,13);

UPDATE empleadosEjemplo
SET tipo='H'
WHERE clave in (2,4,6,8,10,12,14);

-- Departamento
UPDATE empleadosEjemplo
SET claveDepto=25
WHERE clave in (10,7);

UPDATE empleadosEjemplo
SET claveDepto=13
WHERE clave in (1,4,8,11,12);

UPDATE empleadosEjemplo
SET claveDepto=123
WHERE clave in (2,3,5);

UPDATE empleadosEjemplo
SET claveDepto=123
WHERE clave in (6,9,13);

UPDATE empleadosEjemplo
SET PATERNO='AVALOS'
WHERE Materno='AGUIRRE' AND nombre='SOFIA';

UPDATE empleadosEjemplo
SET ciudad='CHETUMAL'
WHERE clave in (14,15,16,17);

UPDATE empleadosEjemplo
SET aguinaldo=NULL
WHERE clave in (14,15,16,17);

UPDATE empleadosEjemplo
SET sueldo=14000
WHERE clave=15;

-- Verificamos los datos resultantes
SELECT * FROM empleadosEjemplo;
GO
