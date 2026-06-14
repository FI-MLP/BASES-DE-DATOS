# TEMA 6: INTRODUCCIÓN A SQL

**Bases de Datos**

**Grupo:** 04

---

## 6.1 S.Q.L. Lenguaje estructurado de consulta (Structured Query Language)

Es un lenguaje estándar de cuarta generación que se utiliza para **definir, gestionar y manipular** la información contenida en una Base de Datos Relacional. Es un lenguaje normalizado que nos permite trabajar con cualquier manejador de bases de datos.

Lenguaje definido por el estándar ISO/ANSI SQL (International Organization of Standardization / American National Standards Institute Structured Query Language) que utilizan los principales fabricantes de Sistemas de Gestión de Bases de Datos Relacionales.

En los lenguajes procedimentales de tercera generación se deben especificar todos los pasos que hay que dar para conseguir el resultado. Sin embargo, en SQL tan solo deberemos indicar al SGDB qué es lo que queremos obtener, y el sistema decidirá cómo obtenerlo.

SQL es un lenguaje sencillo y potente que se emplea para la gestión de la base de datos a distintos niveles de utilización: usuarios, programadores y administradores de la base de datos.

### ¿Qué podemos hacer con SQL?

Los principales SGBD incorporan un motor SQL en el Servidor de Base Datos, así como herramientas de cliente que permiten enviar comandos SQL para que sean procesadas por el motor del servidor. 

De esta forma, todas las tareas de gestión de la Base de Datos (BD) pueden realizarse utilizando sentencias SQL. Mediante estas sentencias podemos:

* Crear, modificar y borrar objetos de la Base de Datos.
* Insertar, modificar y borrar datos.
* Consultar datos de la Base de Datos.
* Controlar el acceso a la información.
* Garantizar la consistencia de los datos.

---

## 6.2 Categorías del SQL

El lenguaje SQL está dividido en varias categorías clasificadas de acuerdo a su uso:

* **DDL (Data Definition Language):** Lenguaje de definición de datos. Es el lenguaje encargado de la creación, modificación y eliminación de la estructura de los objetos de la base de datos (tablas, índices, vistas, etc.). Incluye instrucciones como `CREATE`, `DROP`, `ALTER` y `TRUNCATE`.
* **DML (Data Manipulation Language):** Lenguaje de manipulación de datos. Es el lenguaje que permite realizar las tareas de modificación y eliminación de los datos almacenados en una base de datos. Incluye instrucciones como `INSERT`, `UPDATE` y `DELETE`.
* **DCL (Data Control Language):** Lenguaje de control de datos. Es el lenguaje encargado de configurar y establecer el control de acceso a la base de datos. Incluye instrucciones para definir accesos y privilegios a los distintos objetos de la base de datos, como `GRANT` y `REVOKE`.
* **DQL (Data Query Languaje):** Lenguaje de consulta de datos. Es el lenguaje que permite realizar consultas de los datos de la BD. Incluye la instrucción `SELECT`. Cuando se dispara un SELECT en una tabla o tablas, el resultado se compila en una tabla temporal adicional, que se muestra o quizás recibe el programa, es decir, un front-end.
* **TCL (Transaction Control Languaje):** Lenguaje de control de transacciones. Es el lenguaje empleado para crear y administrar transacciones aplicadas a un conjunto de sentencias DML principalmente. Incluye instrucciones como `COMMIT`, `SAVEPOINT` y `ROLLBACK`.

<img width="851" height="579" alt="Screenshot_3" src="https://github.com/user-attachments/assets/8f16f163-167f-434f-ba88-e8ab1e3771ac" />


### Definiciones por SGBD

Cada SMDB define lo siguiente:

* Un **Lenguaje de Definición de Datos (DDL)** para especificar el Esquema Conceptual y los Esquemas Externos (vistas) de las BD.
* Un **Lenguaje de Manipulación de Datos (DML)** para que los usuarios de una BD puedan crear, modificar e interrogar (consultar información) la BD. El lenguaje de interrogación es, por lo tanto, parte del DML.
* SQL (Structured Query Language) no es simplemente un lenguaje de interrogación, sino que incluye tanto un DDL como un DML.
* Está estandarizado, sin embargo, cada SGBD (Oracle, PostgreSQL, SQLite, MySQL) añade sus propias extensiones.

---

## 6.3 Transact SQL

Cuando se desea realizar una aplicación completa para el manejo de una base de datos relacional, resulta necesario utilizar alguna herramienta que soporte la capacidad de consulta del SQL y la versatilidad de los lenguajes de programación tradicionales. 

**Transact SQL** es el lenguaje de programación que proporciona SQL Server para extender el SQL estándar con otro tipo de instrucciones. Amplía SQL con los elementos característicos de los lenguajes de programación: variables, sentencias de control de flujo, bucles, etc.

### 6.3.1 Características de SQL Server

* Soporte de transacciones.
* Escalabilidad, estabilidad y seguridad.
* Soporta procedimientos almacenados.
* Incluye también un potente entorno gráfico de administración, que permite el uso de comandos DDL y DML gráficamente.
* Permite trabajar en modo cliente-servidor, donde la información y datos se alojan en el servidor y las terminales o clientes de la red sólo acceden a la información.
* Además, permite administrar información de otros servidores de datos.

---

## 6.4 Tipos de datos

Determinar los tipos de datos a emplear en el diseño lógico es primordial. A continuación, revisaremos los diferentes tipos de datos SQL que pueden ser empleados durante el proceso del modelado de una base de datos. 

La definición del tipo de dato y del dominio de los atributos debe reflejar de forma correcta la naturaleza de los datos que estamos modelando: cadenas de caracteres, cantidades, valores monetarios, fechas, etc.

### 6.4.1 Tipos de datos de SQL estándar

* **Cadenas:** Cadenas de caracteres (de longitud fija o de longitud variable) y cadenas binarias.
* **Numéricos:** Exactos y aproximados.
* **Tiempo y fechas.**
* **Otros:** boolean (Estándar, MySQL, PostgreSQL), ROWID (Oracle), UROWID (Oracle), BFILE (Oracle), Cursor (SQLServer), Uniqueidentifier (SQLServer) y XML.

### 6.4.2 Tipos de datos en SQL Server

#### 6.4.2.1 Tipos de datos numéricos

SQL Server dispone de varios tipos de datos numéricos. Cuanto mayor sea el número que puedan almacenar, mayor será el espacio utilizado para almacenarlo. Como regla general se recomienda usar el tipo de dato mínimo posible. Todos los datos numéricos admiten el valor NULL.

* **Bit:** Puede almacenar el rango de valores de 1 a 0.
* **Tinyint:** Puede almacenar el rango de valores de 0 a 255.
* **SmallInt:** Puede almacenar el rango de valores de -32,768 a 32,767.
* **Int:** Puede almacenar el rango de valores de -2^31 a (2^31) - 1.
* **BigInt:** Puede almacenar el rango de valores de -2^63 a (2^63) - 1.
* **Decimal(p,s):** Almacena datos numéricos decimales sin redondear. Donde `p` es la precisión (número total de dígitos) y `s` la escala (número de valores decimales).
* **Float:** Almacena el rango de valores de -1.79E+308 a 1.79E+308 (si se define con el valor máximo de precisión). La precisión puede variar entre 1 y 53.
* **Real:** Sinónimo de `float(24)`. Puede almacenar el rango de valores de -3.4E+38 a 3.4E+38.
* **Money:** Almacena valores numéricos monetarios de -2^63 a (2^63) - 1, con una precisión de hasta diez milésimas de la unidad monetaria.
* **SmallMoney:** Almacena valores numéricos monetarios de -214,748.3647 a 214,748.3647, con una precisión de hasta diez milésimas de la unidad monetaria.

> **Nota importante:** Todos los tipos de datos enteros pueden marcarse con la propiedad `identity` para hacerlos autonuméricos (generalmente se utiliza para implementar llaves primarias).

#### 6.4.2.2 Tipos de datos de carácter

* **Char(n):** Almacena `n` caracteres en formato ASCII (un byte por cada letra). Siempre se utilizan los `n` caracteres indicados, incluso si la entrada de datos es inferior. Por ejemplo, si en un `char(5)` guardamos el valor 'A', se almacena 'A    ', ocupando los cinco bytes.
* **Varchar(n):** Almacena `n` caracteres en formato ASCII. Únicamente se utilizan los caracteres necesarios. Si en un `varchar(255)` guardamos 'A', se almacena 'A', ocupando solo un byte.
* **Varchar(max):** Igual que varchar, pero puede almacenar hasta (2^31) - 1 bytes.
* **Nchar(n):** Almacena `n` caracteres en formato UNICODE (dos bytes por cada letra). Recomendable cuando los valores a almacenar puedan pertenecer a diferentes idiomas.
* **Nvarchar(n):** Almacena `n` caracteres en formato UNICODE (dos bytes por cada letra). Ideal para texto multilingüe de longitud variable.
* **Nvarchar(max):** Igual que nvarchar, pero puede almacenar hasta (2^31) - 1 bytes.

#### 6.4.2.3 Tipos de datos de fecha

* **Datetime:** Almacena fechas con una precisión de milisegundo. Debe usarse para fechas muy específicas.
* **SmallDatetime:** Almacena fechas con una precisión de minuto, por lo que ocupa la mitad de espacio que el tipo `datetime`. Para tablas con muchos datos, es un factor a tener muy en cuenta.
* **Date:** Almacena fechas en formato `yyyy-MM-dd`. Intervalo de 0001-01-01 a 9999-12-31. Precisión de 1 día.
* **Time:** Almacena hora con formato de hasta 100 nanosegundos.

<img width="1112" height="302" alt="Screenshot_1" src="https://github.com/user-attachments/assets/19deab20-70b1-493d-a547-bc5fb80962c0" />


#### 6.4.2.4 Tipos de datos binarios

* **Binary:** Almacena datos binarios de longitud fija, con una longitud máxima de 8000 bytes.
* **Varbinary:** Almacena datos binarios de longitud variable, con una longitud máxima de 8000 bytes. Similar a `binary`, salvo que utiliza menos espacio en disco.
* **Varbinary(max):** Igual que varbinary, pero puede almacenar (2^31) - 1 bytes.
* **Image:** Datos binarios de longitud variable desde 0 hasta (2^31) - 1 bytes.

#### 6.4.2.5 Tipo de datos XML

* **XML:** Este tipo de datos se utiliza para almacenar datos muy estructurados como tablas.

#### 6.4.2.6 Otros tipos de datos

* **UniqueIdentifier:** Se utiliza para identificadores únicos. Para generarlos, se debe utilizar la función `NEWID()`.
* **Sql_Variant:** Permite almacenar valores de diferentes tipos de datos. No puede almacenar `varchar(max)`, `xml`, `timestamp` ni tipos de datos definidos por el usuario.
* **CURSOR:** Para recorrer registros y resultados de una consulta. 
* **ROWVERSION:** Para exponer números binarios generados automáticamente, utilizado usualmente para indicar la versión de las filas de una tabla.
* **HIERARCHYID:** Para representar la posición en una jerarquía de árbol.
* **TABLE:** Para almacenar temporalmente un conjunto de filas y devolver el resultado con valores de tabla.
* **GEOMETRÍA ESPACIAL:** Para almacenar datos espaciales planares en un sistema de coordenadas euclídeo.
* **GEOGRAFÍA ESPACIAL:** Para almacenar datos espaciales elipsoidales como coordenadas de latitud y longitud GPS.

---

### 6.4.3 Prioridad de los tipos de datos

SQL Server utiliza el siguiente orden de prioridad para los tipos de datos (del más alto al más bajo):

1. Tipos de datos definidos por el usuario (el más alto)
2. sql_variant
3. xml
4. datetimeoffset
5. datetime2
6. datetime
7. smalldatetime
8. date
9. time
10. float
11. real
12. decimal
13. money
14. smallmoney
15. bigint
16. int
17. smallint
18. tinyint
19. bit
20. ntext
21. text
22. image
23. timestamp
24. uniqueidentifier
25. nvarchar (incluido nvarchar(max))
26. nchar
27. varchar (incluido varchar(max))
28. char
29. varbinary (incluido varbinary(max))
30. binary (el más bajo)

---

### 6.4.4 Sentencias SQL

El SQL se compone de sentencias, cada una con una utilidad diferente. Algunos ejemplos son:

* Creación de una base de datos (`CREATE DATABASE`)
* Creación de una tabla (`CREATE TABLE`)
* Creación de una vista (`CREATE VIEW`)
* Creación de un índice de una tabla (`CREATE INDEX`)
* Creación de procedimientos almacenados (`CREATE PROCEDURE`)
* Creación de disparadores (`CREATE TRIGGER`)
* Consultar los datos almacenados en una tabla (`SELECT`)
* Insertar datos en una tabla (`INSERT`)
* Modificar datos ya existentes en una tabla (`UPDATE`)
* Borrar datos almacenados en una tabla (`DELETE`)
* Dar permiso de acceso a los datos de una tabla (`GRANT`)
* Eliminar permisos de acceso a datos de una tabla (`REVOKE`)
* Finalizar la transacción de una sentencia SQL (`COMMIT`)
* Retroceder la transacción de una sentencia SQL (`ROLLBACK`)
