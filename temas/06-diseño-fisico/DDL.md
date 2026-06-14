# TEMA 6: DDL

**Facultad de Ingeniería**  |  **Bases de Datos**

**Grupo: 04**

### Contenido
* 6.5 DDL - lenguaje de definición de datos.
* 6.5.1 Crear base de datos.
* 6.5.2 Crear tablas.
    * 6.5.2.1 Renombrando tablas.
    * 6.5.2.2 Eliminar una tabla.
    * 6.5.2.3 Modificar una tabla.
    * 6.5.2.4 Ver la estructura de una tabla.
    * 6.5.2.5 Columnas calculadas.
* 6.5.3 Restricciones de integridad.
    * 6.5.3.1 Restricciones a nivel columna y a nivel tabla.
    * 6.5.3.2 Restricción not null.
    * 6.5.3.3 PRIMARY KEY.
    * 6.5.3.4 UNIQUE.
    * 6.5.3.5 FOREIGN KEY.
    * 6.5.3.6 CHECK.
    * 6.5.3.7 DEFAULT.
* 6.5.4 Generación de llave primaria.
* 6.5.5 Esquemas.
* 6.5.6 Índices.
    * 6.5.6.1 Índice clustered & uno non-clustered.

---

## 6.5 DDL - Lenguaje de Definición de Datos

Permite realizar las tareas de creación, eliminación, modificación de un objeto de base de datos (tablas, vistas, usuarios, índices, etc.). La primera fase de cualquier base de datos siempre comienza con órdenes DDL, para diseñar los objetos de la base de datos.

**Comandos DDL**

| Comando | Descripción |
| :--- | :--- |
| **CREATE** | Utilizado para crear nuevas tablas, campos e índices. |
| **DROP** | Empleado para eliminar tablas e índices. |
| **ALTER** | Utilizado para modificar las tablas agregando campos o cambiando la definición de los campos. |

### 6.5.1 Crear base de datos

Una vez que tenemos un modelo de base de datos listo para su implementación y el manejador de base de datos elegido configurado y listo, podemos crear la base de datos, los objetos de la base de datos y así como la asignación de privilegios. Como primer paso crearemos la base de datos, el comando en su forma más simple es:

```sql
CREATE DATABASE <nombre base de datos>;
```
### 6.5.2 Crear tablas

Como se había dicho la definición de objetos varia entre manejador y manejador, sin embargo, es posible hacer uso de la definición empleando SQL estándar:

```sql
CREATE TABLE <nombre tabla>
(  <nombre columna> <tipo de dato>

  [NOT NULL] [UNIQUE | CONSTRAINT <nombre restricción>] [PRIMARY KEY] [DEFAULT] [CHECK]

  | [PRIMARY KEY (<lista columnas>)]

  | [FOREIGN KEY (<lista columnas>) REFERENCES <nombretabla>] [UNIQUE (<lista columnas>)] [CONSTRAINT <nombre restricción>], [,...])
| [CHECK (condición de búsqueda) ];

```
**Nomenclatura en la sintaxis:**

`< >` Los corchetes triangulares deben ser reemplazados por el nombre del objeto correspondiente.

`( )` Los paréntesis son elementos propios de la sintaxis.

`[ ]` Los corchetes cuadrados indican argumentos opcionales.

`|` La barra vertical separa distintas alternativas.

`...` Los puntos suspensivos indican repetición del elemento sintáctico precedente.

Para desplegar la información de las tablas existentes:

```sql
SELECT nombre_columna_a_seleccionar [[AS] col_renombrada]
[,nombre_columna_a_seleccionar [[AS] col_renombrada]...]
FROM tabla_a_consultar [[AS] tabla_renombrada];
```
### 6.5.2.1 Renombrando tablas

```sql
RENAME <nombre tabla existente> TO <nuevo nombre tabla>
RENAME emp TO empleado;
__________________________________________________________________________________________________________________
USE nombreBase;
GO
EXEC sp_rename 'nomOrigen', 'nomDespues';
```
### 6.5.2.2 Eliminar una tabla

La sentencia DROP suprime todas las restricciones de integridad referencial que hagan referencia a llaves de la tabla eliminada.
```sql
DROP TABLE <nombre tabla> [CASCADE CONSTRAINTS]
```
### 6.5.2.3 Modificar una tabla 
```sql
ALTER TABLE <nombre tabla>
ADD <nombre columna nueva> <tipo de dato> [NOT NULL]
MODIFY <nombre columna> [DEFAULT | DROP DEFAULT] valor
DROP (<nombre columna>) [CASCADE CONSTRAINTS]
ADD [PRIMARY KEY (nombre columna) |
FOREIGN KEY (nombre columna) REFERENCES <nombre tabla> | UNIQUE (nombre columna) | CHECK (condición)]
DROP CONSTRAINT nombre restricción [CASCADE]
```
### 6.5.2.4 Ver la estructura de una tabla

Para mostrar la estructura de la tabla:
```sql
DESCRIBE <nombre tabla>;
__________________________________________________________________________________________________________________
EXEC sp_help 'nombre tabla'
```
### 6.5.2.5 Columnas calculadas
▪ Una columna calculada es una columna virtual que no está almacenada físicamente en la tabla,
a menos que la columna esté marcada con PERSISTED.

▪ Las expresiones de columnas calculadas pueden utilizar datos de otras columnas al calcular un
valor.

▪ Cuando una fórmula combina dos expresiones de tipos de datos distintos, las reglas de prioridad
de tipo de datos especifican que el tipo de datos con la prioridad menor se convierta al tipo de
datos con la prioridad mayor.

_Crear una tabla con una columna calculada_

Ejemplo crear una tabla con una columna calculada (total) que multiplica el valor de la columna
precio tantas veces como indique el valor de la columna cantidad
```sql
CREATE TABLE dbo.venta
(
    idventa int IDENTITY (1,1) NOT NULL,
    cantidad smallint,
    precio money,
    total AS cantidad * precio
);
```
Agregar una nueva columna calculada a una tabla existente
```sql
ALTER TABLE dbo.venta ADD totalmasIva AS (cantidad * precio * 1.5)
```
Agregar el argumento PERSISTED para almacenar físicamente los valores calculados en la tabla:
```sql
ALTER TABLE dbo.venta ADD total AS (cantidad * precio) PERSISTED
```
Para cambiar una columna existente a una columna calculada, primero se borra la columna y después se crea.

### 6.5.3 Restricciones de integridad

Las restricciones o constraints son empleados para cuidar la integridad de los datos. Los
socntraints son objetos en la base de datos.

<img width="731" height="466" alt="Screenshot_2" src="https://github.com/user-attachments/assets/766110fe-7b5b-4637-8e0f-2ade61266e27" />

La sintaxis para crear un constraints es similar entre los distintos manejadores:

```sql
constraint [(nombre_constraint)]<tipo_constraint><expresion>
```
Los constraint están formados por:

▪ Un nombre
▪ El tipo de contraint
▪ Una expresión que depende del tipo de constraint
Si no se especifica un nombre el manejador le asigna un nombre único en toda la base de datos

#### 6.5.3.1 Restricciones a nivel columna y a nivel tabla

Los constraints pueden definirse en 2 lugares dentro de la definición de una tabla:

a) A nivel columna (campo), se definen como parte de la definición del atributo. Se llaman
constraint de columna
b) A nivel tabla, se definen después de la definición de todos los campos de la tabla.

#### 6.5.3.2 Restricción not null

Para este tipo de constraint generalmente no se especifica un nombre, solo se indica después de la
definición del campo

```sql
CREATE TABLE nombre_tabla(
id_tabla     numeric( 3 , 0 )     NOT NULL );
```
#### 6.5.3.3 PRIMARY KEY

Para generar una llave primaria desde la creación de una tabla:
<img width="560" height="121" alt="Screenshot_4" src="https://github.com/user-attachments/assets/0dc6b1cf-13ef-471c-a22f-1205d5d9c219" />

Modificando una tabla:

<img width="553" height="36" alt="Screenshot_5" src="https://github.com/user-attachments/assets/e46e72f1-7e62-4d7d-8b7c-942ea4b67033" />

Para verificar las llaves primarias contenidas en nuestra base de datos podemos utilizar el siguiente
código:

<img width="530" height="61" alt="Screenshot_6" src="https://github.com/user-attachments/assets/6942ccd1-5f67-46c8-8366-484b5677d696" />

Cada vez que generamos una llave primaria, esta crea un índice tipo de clustered automáticamente.

#### 6.5.3.4 UNIQUE

Este tipo de restricción es muy parecida a PRIMARY KEY, las diferencias son las siguientes:

o También genera un índice automáticamente, pero es de tipo de NON CLUSTERED.

o La tabla puede tener más de una restricción de tipo UNIQUE.

o Si puede aceptar NULL, pero solo una fila puede contenerlo ya que como su nombre lo
indica, es de tipo UNIQUE o único.

<img width="745" height="176" alt="Screenshot_7" src="https://github.com/user-attachments/assets/0057dc49-7398-495d-a640-52528e85ede8" />

Para consultar las restricciones UNIQUE se puede utilizar:

<img width="728" height="66" alt="Screenshot_8" src="https://github.com/user-attachments/assets/9134f066-31ae-41a7-aab0-0fbd3100f407" />

#### 6.5.3.5 FOREIGN KEY

Las columnas involucradas en la llave foránea deben tener el mismo tipo de datos que la llave
primaria de la segunda tabla. Una llave foránea no crea un índice automáticamente, por lo que se
recomienda generar uno para incrementar el rendimiento de la consulta.

<img width="714" height="153" alt="Screenshot_9" src="https://github.com/user-attachments/assets/6f29e41a-0100-4d38-9beb-3146278d06ee" />

Modificando una tabla:

<img width="727" height="60" alt="Screenshot_10" src="https://github.com/user-attachments/assets/54fece07-001b-489e-8ef0-f425aa06c8c0" />

Algunos requerimientos para la restricción FOREIGN KEY:

o Los valores ingresados en la o las columnas de la llave foránea, deben existir en la tabla a la
que se hace referencia en la o las columnas de la llave primaria.
o Solo se pueden hacer referencia a llaves primaria de tablas que se encuentren dentro de la
misma base de datos.
o Puede hacer referencia a otras columnas de la misma tabla.
o Solo puede hacer referencia a columnas de restricciones PRIMARY KEY o UNIQUE.
o No se puede utilizar en tablas temporales.

Para consultar las llaves foráneas:

<img width="660" height="61" alt="Screenshot_11" src="https://github.com/user-attachments/assets/6973a65f-6bb5-42a1-a048-32e5bef56529" />

**Restricciones de la integridad referencial**

Especifican una acción a ejecutar para los registros de una tabla que tengan relación referencial. Las
acciones que se pueden ejecutar a los registros referenciados son: eliminarlos o modificar el valor
de la FK

La sintaxis es:

```sql
FOREIGN KEY
( column [ ,...n ] )
REFERENCES referenced_table_name [ ( ref_column [ ,...n ] ) ]
[ ON DELETE { NO ACTION | CASCADE | SET NULL | SET DEFAULT } ]
[ ON UPDATE { NO ACTION | CASCADE | SET NULL | SET DEFAULT } ]
```
**no action** : Es la opción por default, el manejador genera un error si se trata de eliminar el registro
o actualizar el valor de la PK la cual está siendo referenciada por otras tablas. Al error que se genera
se le llama “Violación de restricción de integridad”.

**cascade** : Propaga las operaciones de delete o update aplicadas en la tabla padre a las tablas hijas.
Si se elimina el registro en la tabla padre, se eliminan los registros en las tablas hijas. Si se actualiza
la PK, se actualizan las FKs.

**set default:** Les asigna el valor configurado en la definición de la tabla.

**set null:** Al aplicar una operación de update o delete se actualiza el valor de la PK a NULL

#### 6.5.3.6 CHECK

Con este tipo de restricción, se especifica que los valores ingresados en la columna deben cumplir
la regla o condición especificada. Por ejemplo:

<img width="683" height="257" alt="Screenshot_12" src="https://github.com/user-attachments/assets/54f602e4-0fd8-4be0-ad04-89fced95bcfa" />

Modificando una tabla:

<img width="700" height="250" alt="Screenshot_13" src="https://github.com/user-attachments/assets/f816ac8d-6107-4083-a75c-20344ecb5004" />

Algunos requerimientos son:

- Una columna puede tener cualquier número de restricciones CHECK.
- La condición de búsqueda debe evaluarse como una expresión booleana y no puede hacer
    referencia a otra tabla.
- No se pueden definir restricciones CHECK en columnas de tipo text, ntext o image.

Ventajas:

- Las expresiones utilizadas son similares a las que se usan en la cláusula WHERE.
- Pueden llegar a ser una mejor alternativa que los TRIGGERS o disparadores.
Tener siempre en mente:
- Al momento de crear nuestra expresión, tomar en cuenta si la columna acepta valores NULL,
por ejemplo, si definimos nuestra restricción que acepte solo valores positivos
(nombreColumna1>=0), NULL es un valor desconocido por lo tanto se insertará en la
columna.
- No es posible obtener el valor previo después de realizar un UPDATE, si esto es necesario se
recomienda usar un TRIGGER.

Para consultar las restricciones CHECK se puede utilizar

<img width="718" height="62" alt="Screenshot_14" src="https://github.com/user-attachments/assets/83306cfe-8898-49e3-b2c4-2c3b326fff6a" />

#### 6.5.3.7 DEFAULT

Se puede decir que no es una restricción, ya que solo se ingresa un valor en caso de que ninguno
otro sea especificado. Si una columna permite NULL y el valor a insertar no se especifica, se puede
sustituir con un valor predeterminado.

<img width="745" height="119" alt="Screenshot_15" src="https://github.com/user-attachments/assets/3b6ac08d-c634-48a3-ac65-2ce73ddf3ee7" />

Para obtener una lista de las restricciones DEFAULT:

<img width="824" height="73" alt="Screenshot_16" src="https://github.com/user-attachments/assets/604d5b90-2c68-44c6-9f44-03192f32245f" />

### 6.5.4 Generación de llave primaria

Empleados para la obtener valores únicos y consecutivos en las llaves primarias, en SQLServer hay
dos formas:

o Clausula Identity
o Secuencias

**Clausula Identity**

El manejador genera un nuevo valor único cada vez que se realice una inserción en la tabla. La
sintaxis es:

```sql
IDENTITY [ (seed , increment) ]
```
Ejemplo:
```sql
CREATE TABLE nombre_tabla(
id_tabla     numeric( 3 , 0 )     NOT NULL identity (1,1));
```
**Secuencia**

Una secuencia es similar a una columna de tipo identity, la diferencia es que la secuencia es
totalmente independiente a la definición de la tabla que la utiliza. La secuencia de valores numéricos
se genera en orden ascendente o descendente en un intervalo definido y se puede configurar para
reiniciarse (en un ciclo) cuando se agota. Las secuencias, a diferencia de las columnas de identidad,
no se asocian a tablas concretas. Las aplicaciones hacen referencia a un objeto de secuencia para
recuperar su valor siguiente. La aplicación controla la relación entre las secuencias y tablas. Sintaxis

```sql
CREATE SEQUENCE [schema_name. ] sequence_name
[ AS [ built_in_integer_type | user-defined_integer_type ] ]
[ START WITH <constant> ]
[ INCREMENT BY <constant> ]
[ { MINVALUE [ <constant> ] } | { NO MINVALUE } ]
[ { MAXVALUE [ <constant> ] } | { NO MAXVALUE } ]
[ CYCLE | { NO CYCLE } ]
[ { CACHE [ <constant> ] } | { NO CACHE } ]
[ ; ]
```

### 6.5.5 Esquemas

Trabajar con esquemas permite disponer de más flexibilidad en la administración de los permisos
de objeto de base de datos. Un esquema es un contenedor con nombre para objetos de base de
datos, que permite agrupar objetos en espacios de nombres independientes.

**Esquemas por defecto**

SQL Server incluye diez esquemas predefinidos que usan el mismo nombre que los usuarios y los
roles de base de datos integrados. Estos esquemas se han creado principalmente por compatibilidad
con versiones anteriores. No puede quitar los esquemas con el mismo nombre que las funciones
fijas de base de datos, aunque no los necesite. No puede quitar los siguientes esquemas:

1 – dbo

2 – guest

3 – sys

4 – INFORMATION_SCHEMA

**Debemos saber que los objetos que se crean en sql server sin especificar esquema se crean bajo
el esquema dbo**

Para crear un esquema:
```sql
CREATE SCHEMA <Nombre> AUTHORIZATION DBO
```
AUTHORIZATION DBO: Si se crea un objeto sin especificar esquema, ese objeto le
pertenece a DBO, por tal razón, hay que pedirle autorización para poder mover
ese objeto a tu nuevo esquema.

Para mover un objeto de un esquema a otro:
```sql
ALTER SCHEMA <Nuevo esquema> TRANSFER Esquema.Tabla
```

### 6.5.6 Índices

Los índices son objetos de la base de datos, cuya función es optimizar el acceso a datos. A medida
que las tablas se van haciendo más grandes y se desea hacer consultar sobre estas tablas, los índices
son indispensables.

Internamente un índice normal es una estructura de árbol, que cuenta con una página principal y
luego esta con paginas hijas, que a su vez tiene más paginas hijas hasta llegar a la página final del
índice (leaf level).

La clave del índice está repartida en las páginas del índice, de modo tal que la búsqueda se haga
leyendo la menor cantidad posible de datos.

#### Estructura de un índice

<img width="565" height="182" alt="Screenshot_17" src="https://github.com/user-attachments/assets/67ad65ee-6fea-4b6a-8ed4-b2c6bd946250" />

Son similares a índices de libros de texto. En los libros de texto, si necesitamos ir a un capítulo en
particular, vamos al índice, encontramos el número de página del capítulo y vamos directamente a
esa página.

Lo mismo aplica a los índices en bases de datos. Sin índices, un DBMS tiene que recorrer todos los
registros en la tabla para recuperar los resultados deseados. Este proceso es llamado escaneo de
tablas, y es extremadamente lento. Por otra parte, si se crean índices, la base de datos va a ese
índice primero y luego recupera los correspondientes registros de tabla directamente.

#### 6.5.6. 1 Índice clustered & uno non-clustered

La diferencia está en la leaf level (la última página) del índice. **En un índice non-clustered, la clave
por la que buscamos tiene un puntero a la página de datos donde se encuentra el registro.
Mientras que en índice clustered, la leaf level es la página de datos. Con lo cual, el SQL Server, se
ahorra hacer un salto para leer los datos del registro (Bookmark lookup).** La diferencia es
importante, ya que el uso de este tipo de índices al evitar tener que hacer lecturas adicionales para
traer el registro, son más rápidos.

<img width="672" height="241" alt="Screenshot_18" src="https://github.com/user-attachments/assets/0169cb9e-d230-45b6-b430-b2ab9115d391" />

¿Entonces porque no siempre usar índices clustered? Bueno, en primer lugar, lamentablemente
solo puede haber 1 solo índice clustered por tabla. La razón es muy sencilla y lógica: Los registros de
la tabla físicamente son las paginas leaf-level del índice clustered. Los datos de la tabla esta
ordenados según el índice. Y obviamente una tabla no puede simultáneamente estar físicamente
ordenada de 2 maneras diferentes. Por lo tanto, en tablas grandes y muy consultadas, tenemos que
ser cuidadosos y analizar a que campos vamos a seleccionar para ser llaves del índice clustered.
¡Tenemos 1 solo índice de este tipo por tabla, no hay que desperdiciarlo!!!

Este último punto es importante para saber en qué situaciones y para que campos se debe utilizar
un clustered index o un non-clustered.

Guía general de uso de índices:

➢ Campos autoincreméntales (Identitys, newsequentialid, etc), deben convenientemente ser
del tipo clustered index. La razón es reducir el page split (fragmentación) de la tabla.

➢ Los clustered index son convenientes si se va seleccionar un rango de valores, ordenar
(ORDER BY) o agrupar (GROUP BY).

➢ La PK es un buen candidato para un clustered index. Pero no siempre. Por ejemplo, si
tenemos una tabla de ventas, cuya PK es un identity en donde se efectúan muchas consultas
por rangos de fecha, el campo Fecha seria un mejor candidato para el clustered que la PK.

➢ Para búsquedas de valores específicos, conviene utilizar un non-clustered index.

➢ Para índices compuestos, mejor utilizar non-clustered index (generalmente).

**Sintaxis**

```sql
CREATE UNIQUE CLUSTERED INDEX nombreIndice
ON tabla(columna);
```
```sql
CREATE UNIQUE NONCLUSTERED INDEX nombreIndice
ON tabla(columna);
```
