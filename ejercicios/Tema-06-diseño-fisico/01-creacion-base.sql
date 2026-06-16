-- ==========================================================================================
-- Archivo: 01-creacion-base.sql
-- Descripción: Script inicial para la creación de la base de datos y estructuras base.
-- Nota: Este código es el punto de partida original y no debe ser modificado.
-- ==========================================================================================

/*

AUTOR: MARTHA LÓPEZ PELCASTRE
FECHA: abril 2026
DESCRIPCION: SCRIPT PARA CREAR LA BASE DE DATOS DEL GRUPO 04 SEM 2026-2

 */

 --crear la base de datos, nombre 262_empresa_numcuenta
 CREATE DATABASE [262_EMPRESA_89000546];
 GO

 use [262_EMPRESA_89000546]
 go

 --1.	Crear los esquemas catálogo, trabajador, proyecto y nómina --profesora

 CREATE SCHEMA CATALOGO
 GO

 CREATE SCHEMA TRABAJADOR
 GO

 CREATE SCHEMA PROYECTO
 GO

  CREATE SCHEMA NOMINA
 GO

 /*
 2.	Crear la tabla concepto en el esquema catálogo, la llave identity, el tipo de concepto P o D, 
 el importe del concepto no debe pasar los $80,000 --profesora
 */

 CREATE TABLE CATALOGO.CONCEPTO(

    idConcepto             tinyint        NOT NULL identity (1,1),
    descripcionConcepto    varchar(50)    NOT NULL,
    monto                  money          NOT NULL,
    tipo                   char(1)        NOT NULL,
    CONSTRAINT pk_concepto PRIMARY KEY NONCLUSTERED (idConcepto),
	CONSTRAINT ck_tipo check (tipo in ('P','D')),
	CONSTRAINT ck_monto check (monto<=80000)
);

go

/*
3.	Crear la tabla empleado con constraints de tabla en el esquema trabajador --profesora
*/

CREATE TABLE trabajador.EMPLEADO(

    idEmpleado         int            NOT NULL,
    idEmpleado_jefe    int            NULL,
    nombre             varchar(40)    NOT NULL,
    materno            varchar(40)    NULL,
    paterno            varchar(40)    NOT NULL,
    RFC                char(13)       NOT NULL,
    correo             varchar(50)    NULL,
    tipoempleado       char(1)        NOT NULL,
    fechaIngreso       date           NULL,
    id_puestoActual    tinyint        NOT NULL,
    CONSTRAINT pk_empleado PRIMARY KEY NONCLUSTERED (idEmpleado), 
    CONSTRAINT fk_empleado_jefe FOREIGN KEY (idEmpleado_jefe) REFERENCES trabajador.EMPLEADO(idEmpleado),
	CONSTRAINT u_rfc unique (rfc)
);

go

-- ver la estructura de una tabla
execute sp_help [trabajador.empleado]



/*
4.	Crear las tablas honorarios y confianza en el esquema trabajador --profesora
*/

CREATE TABLE trabajador.confianza(
    idEmpleado    int        NOT NULL,
    numPlaza      char(5)    NOT NULL unique,
    CONSTRAINT pk_confianza PRIMARY KEY CLUSTERED (idEmpleado), 
    CONSTRAINT fk_empleado_confianza FOREIGN KEY (idEmpleado) REFERENCES trabajador.empleado(idEmpleado)

);

go



CREATE TABLE trabajador.honorarios(
    idEmpleado      int              NOT NULL,
    tipoContrato    numeric(2, 0)    NOT NULL,
	titulo          varchar(60)      not null,
	id_conyugue        int              null,
    CONSTRAINT pk_honorarios PRIMARY KEY CLUSTERED (idEmpleado), 
    CONSTRAINT fk_conyugue_honorarios FOREIGN KEY (id_conyugue) REFERENCES trabajador.honorarios(idEmpleado),
	CONSTRAINT fk_empleado_honorarios FOREIGN KEY (idEmpleado) REFERENCES trabajador.empleado(idEmpleado)
);
go

-- CONSULTAR EL DICCIONARIO DE DATOS

select * from sys.tables

select * from sys.key_constraints
where type='pk'

select distinct type from sys.key_constraints

select * from sys.key_constraints
where type='uq'


select * from sys.foreign_keys

select * from sys.check_constraints
where parent_object_id=OBJECT_ID('trabajador.empleado');

 

/*
5.	Cree la tabla recibo pago en el esquema nomina --profesora
*/

CREATE TABLE nomina.reciboPago
( 
	idrecibo             integer  NOT NULL identity(1,1),
	fechaPago            date     NOT NULL ,
	quincena             char(2)  NOT NULL ,
	totalPercepcion      money    NOT NULL ,
	totalDeduccion       money    NOT NULL ,
	pagoTotal            money    NOT NULL ,
	idEmpleado           integer  NOT NULL ,
	año                  char(4)  NULL 
)
go

ALTER TABLE nomina.reciboPago
ADD	CONSTRAINT pk_reciboPago PRIMARY KEY  CLUSTERED (idrecibo ASC),
	CONSTRAINT fk_empleado_Recibo FOREIGN KEY (idEmpleado) REFERENCES trabajador.empleado(idEmpleado)
GO

--6.	Cree la tabla detalle recibo --profesora


CREATE TABLE detalleRecibo
( 
	idrecibo             integer  NOT NULL ,
	idConcepto           tinyint  NOT NULL ,
	CONSTRAINT pk_detalleRecibo PRIMARY KEY  CLUSTERED (idrecibo ASC,idConcepto ASC),
	CONSTRAINT fk_Recibo_Detalle FOREIGN KEY (idrecibo) REFERENCES nomina.reciboPago(idrecibo)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT r_Concepto_Detalle FOREIGN KEY (idConcepto) REFERENCES catalogo.CONCEPTO(idConcepto)

);
go


--7.	Agregue la tabla detalle recibo al esquema nomina --profesora

ALTER SCHEMA nomina TRANSFER dbo.detallerecibo;  
GO  

--8.	Agregue a la tabla empleado el campo  horario  varchar(50)  opcional 

ALTER TABLE trabajador.empleado
add horario varchar(50) null;


--9.	Crear la tabla proyecto en el esquema proyecto con constraints de columna   --profesora


CREATE TABLE proyecto.proyecto(
    id_proyecto        smallint         CONSTRAINT pk_proyecto PRIMARY KEY CLUSTERED (i_proyecto),
    nombre            varchar(60)       NOT NULL,
    costo             money             NOT NULL,
    duracion          numeric(2,0)      NOT NULL,
    fechainicio      date               NOT NULL,
    fehafin          date               NULL,
	adeudo			decimal(10,3)		NULL,
    estatus          char(2)            NOT NULL CONSTRAINT ck_estatus check (estatus in ('T', 'EC', 'D')),
    idempleado       integer          NOT NULL,
);
go


--cambiar el nombre a una tabla
EXEC sp_rename 'proyecto.proyecto', 'proyectos';

go

--10.	Cree la tabla domicilio en el esquema trabajador
--Nota: con la condición on deleted cascade, la llave foránea con nombre fk_empleadoDomicilio, 
--el check de tipo con nombre ck_tipo. Todo debe ir dentro del comando créate table y declarando 
--los constraint de columna.

--* No requiere el unique ya que pasa como fk y pk

CREATE TABLE TRABAJADOR.DOMICILIO(
    idEmpleado    int            NOT NULL CONSTRAINT pk_domicilio PRIMARY KEY
										  CONSTRAINT fk_empleadoDomicilio FOREIGN KEY (idEmpleado) 
										  REFERENCES trabajador.EMPLEADO(idEmpleado)
										  on delete cascade,
    calle         varchar(60)    NOT NULL,
    numero        varchar(40)    NULL,
    colonia       varchar(40)    NOT NULL,
    alcaldia      varchar(40)    NOT NULL,
    tipo          char(1)        NOT NULL CONSTRAINT ck_tipo check (tipo in ('P','R')),
    CP            char(5)        NOT NULL, 
);
go

--11.	El cliente le pide que, si algún trabador no registra la calle de su domicilio, de manera automática se almacene en la base de datos domicilio conocido.  --profesora

alter table trabajador.domicilio
alter column calle         varchar(60)     NULL;

alter table trabajador.domicilio
ADD constraint df_calle default  'DOMICILIO CONOCIDO' FOR CALLE;


--12.	Cree la integridad referencial del supervisor del proyecto 
--13.	Implemente la tabla puesto en el esquema catálogo, con constraint de columna
--14.	Implemente la integridad referencial de la tabla empleado y puesto
--15.	Cree la tabla parentesco en el esquema catálogo, con su clave primaria que se genere automáticamente. El esquema de la tabla es el siguiente:
--PARENTESCO= {idparentesco (tinyint, PK),demoninacion varchar(80), vigente bit, CS8 }
--CS8. 1-vigente, 0 no vigente
--16.	Crear la tabla dependiente en el esquema trabajador como entidad débil por identificación de empleado
--17.	Agrega a la tabla empleado las siguientes columnas:
--a) TELEFONO carácter de 10 y que solo acepte 10 dígitos del 0 al 9
--b) Coloque el campo RFC como clave candidata, nombrela ak_rfc

--18.	El negocio tiene como regla que los sueldos oscilan entre $15,000 y $75,000. Implemente dicha regla en la base de datos. (ck_PagoPermitido)
--19.	Valide que el campo plaza sea único (subtipo confianza) mediante índices (idx_plaza)

	CREATE unique INDEX idx_plaza ON trabajador.confianza(numPlaza)

--20.	Cambie el tamaño de la columna correo de la tabla empleado a 60
--21.	En la tabla parentesco agregue el valor por default (DF_parentescoVigente) vigente en 1
--22.	Borrar el constraint DF_parentescoVigente
--24.	Agregue la columna fecha de nacimiento a la tabla empleado con tipo de dato date y opcional
--25.	Elimine la columna pagoTotal de la tabla reciboPago
--26.	Implemente el constraint a la columna quincena de la tabla reciboPago a fin de que únicamente acepte los siguientes valores 01,02, 03…24, nombre el constraint ck_quincena
--27.	Crea índice a la tabla empleado para los apellidos (apellido paterno y apellido materno)
	
	CREATE NONCLUSTERED INDEX idx_alfabetico
	ON trabajador.empleado(nombre, paterno, materno)

--28.	Cree la tabla histórico de puestos en el esquema trabajador con constraints de columna en el esquema trabajador
--29.	Cree un índice non clustered a la tabla histórico puesto por el campo idpuesto
--30.	Implementa el puesto actual a la tabla empleado (por medio de integridad referencial)
--31.	Crear la columna calculada pagototalcalculada persistente que obtenga la diferencia 
--(total percepciones -totaldeducciones)
	ALTER TABLE nomina.reciboPago
	ADD pagoTotalCalculado AS (totalPercepcion - totalDeduccion) PERSISTED;

--32.	Cree la foreign key id_empleado_jefe
--33.	Cree la tabla empleado proyecto con constraint de tabla
CREATE TABLE empleado_proyecto
(
  id_proyecto smallint not null,
  idEmpleado integer not null,
  numHoras smallint not null,
  CONSTRAINT pk_empleado_proyecto PRIMARY KEY CLUSTERED (id_proyecto,idempleado),
  CONSTRAINT fk_proyecto_emp FOREIGN KEY (id_proyecto) REFERENCES proyecto.proyectos (id_proyecto),
  CONSTRAINT fk_empleado_emp FOREIGN KEY (idempleado) REFERENCES trabajador.empleado(idempleado),

);
go


--34.	Agregue la tabla empleado proyecto al esquema proyecto

ALTER SCHEMA proyecto TRANSFER empleado_proyecto;

--35.	Crear la tabla tarjeta en el esquema trabajador con constraint de columna

CREATE TABLE TRABAJADOR.TARJETA(
    id_tarjeta    smallint       NOT NULL CONSTRAINT pk_tarjeta PRIMARY KEY  (id_tarjeta),
    numTrajeta    char(18)       NOT NULL,
    banco         varchar(50)    NOT NULL,
    idEmpleado    int            NOT NULL    CONSTRAINT FK_EMPLEADO_TARJETA FOREIGN KEY (idEmpleado) REFERENCES TRABAJADOR.HONORARIOS(idEmpleado)
	CONSTRAINT AK_ID_EMPLEADO UNIQUE (idEmpleado)
);
go

--36.	Crear la tabla pagos en el esquema proyecto con constraint de tabla








/* 

 * TABLE: PUESTO 

 */



CREATE TABLE PUESTO(

    idPuesto       tinyint        NOT NULL,

    descripcion    varchar(60)    NOT NULL,

    vigente        bit            NOT NULL,

    nivel          char(1)        NOT NULL,

    sueldo         money          NOT NULL,

    CONSTRAINT pk_puesto PRIMARY KEY NONCLUSTERED (idPuesto)

)

go









/* 

 * TABLE: EMPLEADO 

 */










/* 

 * TABLE: CONFIANZA 

 */



CREATE TABLE CONFIANZA(

    idEmpleado    int        NOT NULL,

    numPlaza      char(5)    NOT NULL,

    posgrado      bit        NOT NULL,

    CONSTRAINT pk_confianza PRIMARY KEY NONCLUSTERED (idEmpleado), 

    CONSTRAINT RefEMPLEADO8 FOREIGN KEY (idEmpleado)

    REFERENCES EMPLEADO(idEmpleado)

)

go







/* 

 * TABLE: PARENTESCO 

 */



CREATE TABLE PARENTESCO(

    idparentesco    tinyint        NOT NULL,

    denominacion    varchar(80)    NOT NULL,

    vigente         bit            NOT NULL,

    CONSTRAINT pk_parentesco PRIMARY KEY NONCLUSTERED (idparentesco)

)

go



/* 

 * TABLE: DEPENDIENTE 

 */



CREATE TABLE DEPENDIENTE(

    idEmpleado         int              NOT NULL,

    idDependiente      smallint         NOT NULL,

    nombre             varchar(40)      NOT NULL,

    paterno            varchar(40)      NOT NULL,

    materno            varchar(40)      NULL,

    fechaNacimiento    date             NOT NULL,

    edad               numeric(2, 0)    NOT NULL,

    idparentesco       tinyint          NOT NULL,

    CONSTRAINT pk_dependiente PRIMARY KEY NONCLUSTERED (idEmpleado, idDependiente), 

    CONSTRAINT RefCONFIANZA9 FOREIGN KEY (idEmpleado)

    REFERENCES CONFIANZA(idEmpleado),

    CONSTRAINT RefPARENTESCO10 FOREIGN KEY (idparentesco)

    REFERENCES PARENTESCO(idparentesco)

)

go







/* 

 * TABLE: reciboPago 

 */



CREATE TABLE reciboPago(

    idRecibo           int              NOT NULL,

    fechaPago          date             NOT NULL,

    quincena           char(2)          NOT NULL,

    totalPercepcion    money            NOT NULL,

    totalDeduccion     money            NOT NULL,

    pagoTotal          money            NOT NULL,

    año                numeric(4, 0)    NOT NULL,

    idEmpleado         int              NOT NULL,

    CONSTRAINT pk_recibo_pago PRIMARY KEY NONCLUSTERED (idRecibo), 

    CONSTRAINT RefEMPLEADO6 FOREIGN KEY (idEmpleado)

    REFERENCES EMPLEADO(idEmpleado)

)

go





/* 

 * TABLE: detalleRecibo 

 */



CREATE TABLE detalleRecibo(

    idRecibo      int        NOT NULL,

    idConcepto    tinyint    NOT NULL,

    CONSTRAINT pk_detalle_recibo PRIMARY KEY NONCLUSTERED (idRecibo, idConcepto), 

    CONSTRAINT RefreciboPago4 FOREIGN KEY (idRecibo)

    REFERENCES reciboPago(idRecibo),

    CONSTRAINT RefCONCEPTO5 FOREIGN KEY (idConcepto)

    REFERENCES CONCEPTO(idConcepto)

)

go






/* 

 * TABLE: DOMICILIO 

 */



CREATE TABLE DOMICILIO(

    idEmpleado    int            NOT NULL,

    calle         varchar(60)    NOT NULL,

    numero        varchar(40)    NULL,

    colonia       varchar(40)    NOT NULL,

    alcaldia      varchar(40)    NOT NULL,

    tipo          char(1)        NOT NULL,

    CP            char(5)        NOT NULL,

    CONSTRAINT pk_domicilio PRIMARY KEY NONCLUSTERED (idEmpleado), 

    CONSTRAINT RefEMPLEADO3 FOREIGN KEY (idEmpleado)

    REFERENCES EMPLEADO(idEmpleado)

)

go









IF OBJECT_ID('PROYECTO') IS NOT NULL

    PRINT '<<< CREATED TABLE PROYECTO >>>'

ELSE

    PRINT '<<< FAILED CREATING TABLE PROYECTO >>>'

go



/* 

 * TABLE: EMPLEADO_PROYECTO 

 */



CREATE TABLE EMPLEADO_PROYECTO(

    id_proyecto    smallint    NOT NULL,

    idEmpleado     int         NOT NULL,

    numHoras       smallint    NOT NULL,

    CONSTRAINT pk_empleado_proyecto PRIMARY KEY NONCLUSTERED (id_proyecto, idEmpleado), 

    CONSTRAINT RefPROYECTO1 FOREIGN KEY (id_proyecto)

    REFERENCES PROYECTO(id_proyecto),

    CONSTRAINT RefEMPLEADO2 FOREIGN KEY (idEmpleado)

    REFERENCES EMPLEADO(idEmpleado)

)

go







IF OBJECT_ID('EMPLEADO_PROYECTO') IS NOT NULL

    PRINT '<<< CREATED TABLE EMPLEADO_PROYECTO >>>'

ELSE

    PRINT '<<< FAILED CREATING TABLE EMPLEADO_PROYECTO >>>'

go



/* 

 * TABLE: historicopuesto 

 */



CREATE TABLE historicopuesto(

    idHistoricoPuesto    int        NOT NULL,

    idPuesto             tinyint    NOT NULL,

    idEmpleado           int        NOT NULL,

    fechInicio           date       NOT NULL,

    FechaFin             date       NOT NULL,

    CONSTRAINT pk_historicoPuesto PRIMARY KEY NONCLUSTERED (idHistoricoPuesto), 

    CONSTRAINT RefPUESTO11 FOREIGN KEY (idPuesto)

    REFERENCES PUESTO(idPuesto),

    CONSTRAINT RefEMPLEADO12 FOREIGN KEY (idEmpleado)

    REFERENCES EMPLEADO(idEmpleado)

)

go







IF OBJECT_ID('historicopuesto') IS NOT NULL

    PRINT '<<< CREATED TABLE historicopuesto >>>'

ELSE

    PRINT '<<< FAILED CREATING TABLE historicopuesto >>>'

go



/* 

 * TABLE: HONORARIOS 

 */



CREATE TABLE HONORARIOS(

    idEmpleado      int              NOT NULL,

    id_conyugue     int              NULL,

    tipoContrato    numeric(2, 0)    NOT NULL,

    titulo          varchar(60)      NOT NULL,

    CONSTRAINT pk_honorarios PRIMARY KEY NONCLUSTERED (idEmpleado), 

    CONSTRAINT RefEMPLEADO7 FOREIGN KEY (idEmpleado)

    REFERENCES EMPLEADO(idEmpleado),

    CONSTRAINT RefHONORARIOS19 FOREIGN KEY (id_conyugue)

    REFERENCES HONORARIOS(idEmpleado)

)

go







IF OBJECT_ID('HONORARIOS') IS NOT NULL

    PRINT '<<< CREATED TABLE HONORARIOS >>>'

ELSE

    PRINT '<<< FAILED CREATING TABLE HONORARIOS >>>'

go



/* 

 * TABLE: PAGOS 

 */



CREATE TABLE PAGOS(

    id_proyecto    smallint          NOT NULL,

    id_pago        smallint          NOT NULL,

    fecha          date              NOT NULL,

    monto          decimal(10, 3)    NOT NULL,

    CONSTRAINT pk_pagos PRIMARY KEY NONCLUSTERED (id_proyecto, id_pago), 

    CONSTRAINT fk_proyecto_pagos FOREIGN KEY (id_proyecto)

    REFERENCES PROYECTO(id_proyecto)

)

go







IF OBJECT_ID('PAGOS') IS NOT NULL

    PRINT '<<< CREATED TABLE PAGOS >>>'

ELSE

    PRINT '<<< FAILED CREATING TABLE PAGOS >>>'

go



/* 

 * TABLE: TARJETA 

 */



CREATE TABLE TARJETA(

    id_tarjeta    smallint       NOT NULL,

    numTrajeta    char(18)       NOT NULL,

    banco         varchar(50)    NOT NULL,

    idEmpleado    int            NOT NULL,

    CONSTRAINT pk_tarjeta PRIMARY KEY NONCLUSTERED (id_tarjeta), 

    CONSTRAINT RefHONORARIOS20 FOREIGN KEY (idEmpleado)

    REFERENCES HONORARIOS(idEmpleado)

)

go







IF OBJECT_ID('TARJETA') IS NOT NULL

    PRINT '<<< CREATED TABLE TARJETA >>>'

ELSE

    PRINT '<<< FAILED CREATING TABLE TARJETA >>>'

go
