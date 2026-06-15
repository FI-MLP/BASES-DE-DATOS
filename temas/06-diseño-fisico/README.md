# Tema 6: Introducción a SQL, DDL y DML

## Descripción

Este directorio contiene la documentación teórica y los ejemplos prácticos correspondientes al Tema 6 del curso. Para facilitar su consulta, estructuración y lectura, el contenido se ha dividido en tres archivos principales basados en la categorización del propio lenguaje.

En esta sección se abordan los fundamentos de SQL, la creación y alteración de estructuras en la base de datos mediante el Lenguaje de Definición de Datos (DDL), y las operaciones de inserción, actualización, borrado y control de transacciones mediante el Lenguaje de Manipulación de Datos (DML).

A continuación, se presenta el índice detallado. Al hacer clic en los enlaces, serás dirigido directamente al archivo y al apartado específico correspondiente.

---

## Índice de Contenidos

### [Parte I: Introducción a SQL](./IntroSQL.md)
* [6.1 S.Q.L. Lenguaje estructurado de consulta (Structured Query Language)](./IntroSQL.md#61-sql-lenguaje-estructurado-de-consulta-structured-query-language)
* [6.2 Categorías del SQL](./IntroSQL.md#62-categorías-del-sql)
* [6.3 Transact SQL](./IntroSQL.md#63-transact-sql)
  * [6.3.1 Características de SQL Server](./IntroSQL.md#631-características-de-sql-server)
* [6.4 Tipos de datos](./IntroSQL.md#64-tipos-de-datos)
  * [6.4.1 Tipos de datos de SQL estándar](./IntroSQL.md#641-tipos-de-datos-de-sql-estándar)
  * [6.4.2 Tipos de datos en SQL Server](./IntroSQL.md#642-tipos-de-datos-en-sql-server)
  * [6.4.3 Prioridad de los tipos de datos](./IntroSQL.md#643-prioridad-de-los-tipos-de-datos)
  * [6.4.4 Sentencias SQL](./IntroSQL.md#644-sentencias-sql)

### [Parte II: Lenguaje de Definición de Datos - DDL](./DDL.md)
* [6.5 DDL - Lenguaje de Definición de Datos](./DDL.md#65-ddl---lenguaje-de-definición-de-datos)
  * [6.5.1 Crear base de datos](./DDL.md#651-crear-base-de-datos)
  * [6.5.2 Crear tablas](./DDL.md#652-crear-tablas)
    * [6.5.2.1 Renombrando tablas](./DDL.md#6521-renombrando-tablas)
    * [6.5.2.2 Eliminar una tabla](./DDL.md#6522-eliminar-una-tabla)
    * [6.5.2.3 Modificar una tabla](./DDL.md#6523-modificar-una-tabla)
    * [6.5.2.4 Ver la estructura de una tabla](./DDL.md#6524-ver-la-estructura-de-una-tabla)
    * [6.5.2.5 Columnas calculadas](./DDL.md#6525-columnas-calculadas)
  * [6.5.3 Restricciones de integridad](./DDL.md#653-restricciones-de-integridad)
    * [6.5.3.1 Restricciones a nivel columna y a nivel tabla](./DDL.md#6531-restricciones-a-nivel-columna-y-a-nivel-tabla)
    * [6.5.3.2 Restricción not null](./DDL.md#6532-restricción-not-null)
    * [6.5.3.3 PRIMARY KEY](./DDL.md#6533-primary-key)
    * [6.5.3.4 UNIQUE](./DDL.md#6534-unique)
    * [6.5.3.5 FOREIGN KEY](./DDL.md#6535-foreign-key)
    * [6.5.3.6 CHECK](./DDL.md#6536-check)
    * [6.5.3.7 DEFAULT](./DDL.md#6537-default)
  * [6.5.4 Generación de llave primaria](./DDL.md#654-generación-de-llave-primaria)
  * [6.5.5 Esquemas](./DDL.md#655-esquemas)
  * [6.5.6 Índices](./DDL.md#656-índices)
    * [6.5.6.1 Índice clustered & uno non-clustered](./DDL.md#6561-índice-clustered--uno-non-clustered)

### [Parte III: Lenguaje de Manipulación de Datos - DML](./DML.md)
* [6.6 Lenguaje de Manipulación de Datos DML](./DML.md#66-lenguaje-de-manipulación-de-datos-dml)
  * [6.6.1 Comando INSERT](./DML.md#661-comando-insert)
  * [6.6.2 Comando UPDATE](./DML.md#662-comando-update)
  * [6.6.3 Comando DELETED](./DML.md#663-comando-deleted)
  * [6.6.4 Control de transacciones](./DML.md#664-control-de-transacciones)
    * [6.6.4.1 Propiedades ACID](./DML.md#6641-propiedades-acid)
  * [6.6.5 Niveles de aislamiento](./DML.md#665-niveles-de-aislamiento)
    * [6.6.5.1 Terminología](./DML.md#6651-terminología)
    * [6.6.5.2 Lectura no confirmada](./DML.md#6652-lectura-no-confirmada)
    * [6.6.5.3 Lectura confirmada](./DML.md#6653-lectura-confirmada)
    * [6.6.5.4 Lectura repetible](./DML.md#6654-lectura-repetible)
    * [6.6.5.5 Nivel de aislamiento en serie](./DML.md#6655-nivel-de-aislamiento-en-serie)
    * [6.6.5.6 Nivel de aislamiento instantáneo](./DML.md#6656-nivel-de-aislamiento-instantáneo)
  * [6.6.6 Select](./DML.md#666-select)
