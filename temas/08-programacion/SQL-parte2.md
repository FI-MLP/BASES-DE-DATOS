# Programación con SQL parte II

### Contenido
* PROCEDIMIENTOS ALMACENADOS (STORE PROCEDURE)
* FUNCIONES
    * Funciones escalares
    * Funciones de tabla en línea
    * Funciones de tabla de multisentencias
* TABLAS TEMPORALES
    * Tablas globales
    * Variables de tabla
* CURSORES
* CONTROL DE ERRORES
    * TRY...CATCH
    * Funciones
    * Variable de sistema @@ERROR

---

## PROCEDIMIENTOS ALMACENADOS (STORE PROCEDURE)

Un procedimiento almacenado de SQL Server es un grupo de una o varias instrucciones. Los procedimientos se asemejan a las construcciones de otros lenguajes de programación, porque pueden:

* Aceptar parámetros de entrada
* Contener llamadas a otros procedimientos.
* Realizar operaciones en la base de datos.
* Devolver un valor de estado.

**Ventajas de usar procedimientos almacenados**

* **Compilación:** La primera vez que se invoca un SP, el motor lo compila y a partir de ahí, se sigue usando la versión compilada del mismo, hasta que se modifique o se reinicie el servicio de SQL. Esto significa que se tendrá un mejor rendimiento que las consultas directas que usan cadenas con las instrucciones T-SQL, que se compilan cada vez que se invocan.
* **Automatización:** permite ejecutar un conjunto de instrucciones T-SQL, las cuales queremos ejecutar de manera ordenada.
* **Administración:** cuando realizamos aplicaciones con un gran número de líneas de código, y queremos hacer cambios, solo implica modificar un SP y no toda la aplicación, lo que significa solo cambiamos los SP en el servidor y no tenemos que actualizar la aplicación.
* **Programabilidad:** Los SP admiten el uso de variables y estructuras de control como IF, Bucles, Case, etc. además del manejo de transacción y permite controlar excepciones.
* **Tráfico de Red:** Pueden reducir el tráfico de la red, debido a que se trabaja sobre el motor (en el servidor), y si una operación incluye hacer un trabajo de lectura primero y en base a eso realizar algunas operaciones, esos datos que se obtienen no viajan por la red.
* **Seguridad:** Una parte importante es que, a los usuarios de nuestra aplicación, solo les proporcionamos los permisos para ejecutar los procedimientos almacenados y no el acceso a todos los objetos de la base. Es decir, si en nuestra aplicación encuentran una vulnerabilidad como SQL Injection no se podrá explotar ejecutando SQL directamente.

**Tipos**

* **Procedimientos almacenados definidos por el usuario (store procedure)** – Son procedimientos definidos por el usuario que se deben llamar explícitamente.
* **Triggers** – Son procedimientos definidos por el usuario que se ejecutan automáticamente cuando se modifica un dato en una tabla.
* **Procedimientos del sistema** – Procedimientos suministrados por el sistema.
* **Procedimientos extendidos** – Procedimientos que hacen llamadas al sistema operativo y ejecutan tareas a ese nivel.

**Sintaxis**
```
CREATE PROCEDURE <ProcedureName>
    -- PARÁMETROS
    <@Param1, sysname, @p1>  <Datatype_For_Param1,  ,  int>  =
    <Default_Value_For_Param1,  ,  0>,

    <@Param2, sysname, @p2>  <Datatype_For_Param2,  ,  int>  =
    <Default_Value_For_Param2,  ,  0>,
AS
BEGIN    -- INICIO DE LAS INSTRUCCIONES A EJECUTAR

  -- INSTRUCCIONES A EJECUTAR
    SELECT  <@Param1, sysname, @p1>,  <@Param2, sysname, @p2>
END    -- FIN DE LAS INSTRUCCIONES A EJECUTAR
  GO    -- EJECUTA LA CREACIÓN DEL PROCEDIMIENTO ALMACENADO
```  
**Parámetros**

➢ **Parámetros de entrada**

Un parámetro de entrada es una variable local del procedimiento almacenado que puede recibir un valor de una sentencia:

```sql
exec procedure lista_de_parámetros
```

➢ **Paso de parámetros**

Dos métodos para pasar valores a parámetros:
* Paso de parámetros por posición ---sin encabezado
* Paso de parámetros por nombre

**Paso de parámetros por posición**
* Sintaxis para paso por posición: `[exec | execute] procedure_name 45, 'lopez' [, value...]`
* Los parámetros se deben pasar en el mismo orden en que ellos aparecen en la sentencia `create procedure`
* Como este método es más propenso a errores, se aconseja el paso por nombre.

**Paso de parámetros por nombre**
* Sintaxis para paso por nombre: `[exec | execute] procedure_name @parameter_nam = value [, @parameter_name = value ]`
* Los nombres de los parámetros en la sentencia exec deben concordar con los nombres de los parámetros usados en la sentencia `create procedure`
* Los parámetros pueden pasar en cualquier orden.

➢ **Valores por default**

Se puede asignar un valor por default a un parámetro cuando él no se indica en la sentencia exec.

➢ **Retorno de valores**

Un parámetro output es una variable local en un procedimiento almacenado que se puede enviar a una Sentencia exec procedure.

**Crear parámetros que retornan valores**

Sintaxis:
```sql
create procedure procedureName
(@parameter_name datatype output[, @parameter_name datatype output...] )
as
statements
return
```

**Borrar**
```sql
drop nombredelprocedimiento
```

**Actualizar un procedimiento**
```sql
ALTER PROCEDURE [@param1 , ...]
```

**Para ejecutar el procedimiento**
```sql
EXEC nombreprocedimiento [@param1 , ...]
```

**Un procedimiento almacenado puede:**
* Seleccionar y modificar datos
* Crear tablas temporales y permanentes
* Llamar otros procedimientos almacenados
* Referenciar objetos de bases de datos

**Un procedimiento almacenado no puede ejecutar:**
* use database
* create view
* create default
* create rule
* create procedure
* create trigger

**Para permitir que otros usen un procedimiento almacenado, el propietario debe dar los respectivos permisos.**

Sintaxis:
```sql
grant execute on nombreProcedimiento to usu1, usu2, ...
```

**Límite de anidamiento**

Los procedimientos almacenados pueden llamar otros procedimientos almacenados.
* El máximo nivel de anidamiento es 16.
* La variable `@@nestlevel` contiene el nivel de anidamiento actual.

Si se excede el nivel máximo:
* Se abortan los procedimientos pendientes.
* El servidor retorna un error.

**Ejemplo:** Creamos un procedimiento almacenado al cual le enviamos 2 números y retorna el promedio.

Declaramos una variable para guardar el valor devuelto por el procedimiento; ejecutamos el procedimiento enviándole 2 valores y mostramos el resultado.

```sql
CREATE PROCEDURE pa_promedio
-- Definimos los parámetros de entrada y salida
@n1 decimal ( 4 , 2 ),
@n2 decimal ( 4 , 2 ),
@resultado decimal ( 4 , 2 ) output
AS
BEGIN
    -- Colocamos las sentencias del procedimiento almacenado
    select @resultado=(@n1+@n2) / 2 ;
END
GO
```

La instrucción que realiza la llamada al procedimiento debe contener un nombre de variable para almacenar el valor retornado.

Ejecutamos el procedimiento enviándole 2 valores y mostramos el resultado:

```sql
declare @promedioSalida decimal( 4 , 2 )
execute pa_promedio 5 , 6 , @promedioSalida output
select @promedioSalida

print @promedioSalida;
```

---

### EJERCICIOS

```sql
-- Ejercicio 1.- Crear un procedimiento almacenado que muestre nombre completo (en un solo campo),
-- RFC y correo de los subordinados, pasando como parámetro de entrada el id del jefe además
-- retorne el número de los empleados que dirige y el total ganado por dichos empleados.

CREATE or ALTER PROCEDURE trabajador.procSubordinados -- esta sentencia permite crear o modificar un procedimiento almacenado
@jefe int
AS
BEGIN
    declare
    @totalSubordinados int,
    @totalGanado money

    select nombre + ' ' + paterno + ' ' + isNull(materno,'-') as nombreEmpleado, RFC, correo
    from trabajador.empleado
    where idEmpleado_jefe=@jefe

    select @totalSubordinados = count(idEmpleado)
    from trabajador.empleado
    where idEmpleado_jefe=@jefe
    select @totalSubordinados -- Aparece en pantalla el resultado

    select @totalGanado = sum(pagoTotalCalculado)
    from trabajador.empleado as e
    inner join nomina.reciboPago as r ON e.idEmpleado = r.idEmpleado
    where idEmpleado_jefe=@jefe
    select @totalGanado -- Aparece en pantalla el resultado
END
GO

-- Ejecutando el procedimiento
select * from trabajador.empleado
select * from nomina.reciboPago

exec trabajador.procSubordinados 1
go
```

```sql
-- Ejercicio 2.- Crear un procedimiento almacenado que obtenga los empleados que hayan
-- realizado el mayor numero de proyectos y calcule un abono para cada uno del 30% de su sueldo.
-- Muestre nombre completo, sueldo, el abono y el sueldo final

CREATE or ALTER PROCEDURE proyecto.procCalculaAbono
AS
BEGIN
    declare @numProyMax int

    -- obtenemos la cantidad máximo de proyectos en los que un empleado ha participado
    select @numProyMax = (select top 1 count(*) as numProy from
    proyecto.empleado_proyecto
    group by idEmpleado order by numProy desc);

    -- obtenemos los datos de los empleados que hay participado en la cantidad obtenida y almacenada en @numProyMax
    select e.idEmpleado, e.id_puestoActual, nombre, paterno, materno, sueldo,
    sueldo * 0.30 as abono, sueldo * 1.30 as sueldoFinal
    from trabajador.empleado as e
    inner join catalogo.puesto as p ON e.id_puestoActual = p.idPuesto
    where e.idEmpleado in (select idEmpleado from proyecto.empleado_proyecto
    group by idEmpleado having count(*)=@numProyMax)
END
GO

-- Verificando

select top 1 count(*) as numProy
from proyecto.empleado_proyecto
group by idEmpleado order by numProy desc -- esta consulta obtiene la cantidad máxima de proyectos que un empleado ha realizado, en mi caso

-- revisamos quien tiene 3 proyectos que para mi base en la cantidad máxima
select e.idEmpleado, e.id_puestoActual, nombre, paterno, materno, sueldo, sueldo * 0.30 as abono, sueldo * 1.30 as sueldoFinal
from trabajador.empleado as e
inner join catalogo.puesto as p ON e.id_puestoActual = p.idPuesto
where e.idEmpleado in (select idEmpleado from proyecto.empleado_proyecto
group by idEmpleado having count(*)= 3 )

-- hacer update para que al menos dos empleados sean los de que cumplan con 3 proyectos, hacer lo que corresponda a su base
update proyecto.empleado_proyecto
set idEmpleado= 5 where idEmpleado= 8 and id_proyecto= 3

-- ejecutamos el procedimientro almacenado
exec proyecto.procCalculaAbono
go
```

```sql
/*
Ejericicio 3. Realice un procedimiento almacenado para actualizar un proyecto, tome en cuenta
que solo: ADEUDO Y FECHA_FIN pueden ser nulos. Valide que el costo no sea menor a $250,000,
recibe como parámetro el id del proyecto. El nombre del proyecto es pro_updateProyecto
*/
GO

CREATE OR ALTER PROCEDURE proyecto.pro_updateProyecto
@p_nombre varchar( 30 ),
@p_fechaInicio date,
@p_costo decimal ( 9 , 3 ),
@p_duracion tinyint,
@p_total decimal ( 9 , 3 ),
@p_totalPagado decimal ( 12 , 3 ),
@p_idempleado smallint,
@id_proyecto smallint
AS
BEGIN
    IF (@p_nombre IS NOT NULL AND
        @p_fechaInicio IS NOT NULL AND
        @p_costo IS NOT NULL AND
        @p_duracion IS NOT NULL AND
        @p_total IS NOT NULL AND
        @p_totalPagado IS NOT NULL AND
        @p_idempleado IS NOT NULL AND
        @p_costo >= 250000 ) -- SE PUEDE ACTUALIZAR
    BEGIN
        UPDATE proyecto.proyectos
        SET NOMBRE=@p_nombre ,
        FECHAINICIO=@p_fechaInicio ,
        COSTO=@p_costo ,
        DURACION=@p_duracion ,
        idempleado=@p_idempleado
        WHERE id_proyecto=@id_proyecto
    END
    ELSE IF (@p_costo < 250000 )
        SELECT 'El costo nuevo no puede ser menor a 250,000' AS 'INFORMACION DEL ERROR'
    ELSE
        SELECT 'Falta algun dato obligatorio' AS 'INFORMACION DEL ERROR'
END
GO

-- COMPROBACION, COSTO MENOR DE 250,000
SELECT * FROM proyecto.proyectos

BEGIN TRANSACTION

EXECUTE proyecto.pro_updateProyecto @p_nombre='REGISTRO DE ASISTENCIAS',
@p_costo= 222000 ,
@p_duracion= 13 , @p_fechaInicio='2024-01-16',
@p_total= 80000 ,
@p_idempleado= 2 , @id_proyecto= 13 ,
@p_totalPagado= 50000

SELECT * FROM proyecto.proyectos
where id_proyecto= 4 -- este es el id del proyecto Registro de asistencias
ROLLBACK TRANSACTION
GO

-- COMPROBACION, COSTO MAYOR DE 250,000
BEGIN TRANSACTION
SELECT * FROM proyecto.proyectos

EXECUTE proyecto.pro_updateProyecto @p_nombre='REGISTRO DE ASISTENCIAS',
@p_costo= 252000 ,
@p_duracion= 13 , @p_fechaInicio='2024-01-16',
@p_total= 80000 ,
@p_idempleado= 2 , @id_proyecto= 13 ,
@p_totalPagado= 50000

SELECT * FROM proyecto.proyectos
where id_proyecto= 4
ROLLBACK TRANSACTION
GO
```

---

## FUNCIONES

Las funciones son rutinas que permiten encapsular sentencias TRANSACT-SQL que se ejecutan frecuentemente.

Las funciones definidas por el usuario, acepta parámetros, realiza una acción, como un cálculo complejo y devuelve el resultado de esa acción como un valor. El valor de retorno puede ser un escalar (único) valor o una tabla.

Las funciones de usuario son definidas para crear una rutina reutilizable que se pueden utilizar en:
* En TRANSACT-SQL como SELECT
* En las aplicaciones de llamar a la función
* En la definición de otra función definida por el usuario
* Para parametrizar una vista o mejorar la funcionalidad de una vista indizada
* Para definir una columna en una tabla
* Para definir una restricción CHECK en una columna
* Para reemplazar a un procedimiento almacenado

Las funciones de usuario, según el tipo de retorno se clasifican en:
1. Funciones Escalares
2. Funciones con valores de tabla de varias instrucciones
3. Funciones con valores de tabla en línea

### Funciones escalares

Son aquellas funciones donde retornan un valor único: tipo de datos como int, Money, varchar, real, etc. Pueden ser utilizadas en cualquier lugar, incluso, incorporada dentro de las sentencias SQL.

```sql
CREATE FUNCTION [propietario.] nombre_funcion
([{ @parameter tipo de dato [ = default]}, [, ... n]])
RETURNS VALOR_ESCALAR
[AS]
BEGIN
    RETURN expresion_escalar
END
```

**Ejemplo:** Crear una función que retorne el sueldo promedio de los puestos.

```sql
CREATE FUNCTION catalogo.sueldoPromedio() RETURNS DECIMAL
AS
BEGIN
    DECLARE @promedio DECIMAL
    SELECT @promedio=AVG(sueldo)
    FROM catalogo.puesto
    RETURN @promedio
END
GO

-- LLAMAR A LA FUNCIÓN Y MOSTRAR EL RESULTADO
PRINT catalogo.sueldoPromedio()
go
```

**Ejemplo 2:** cree una función que convierta una fecha en cadena

```sql
create function persona.fechaCadena
(@fecha varchar( 30 ))
returns varchar( 30 )
as
begin
    declare @nombre varchar( 30 )
    set @nombre='Fecha inválida'
    if (isdate(@fecha)= 1 )
    begin
        set @fecha=cast(@fecha as datetime)
        set @nombre=case datename(month,@fecha)
            when 'January' then 'Enero'
            when 'February' then 'Febrero'
            when 'March' then 'Marzo'
            when 'April' then 'Abril'
            when 'May' then 'Mayo'
            when 'June' then 'Junio'
            when 'July' then 'Julio'
            when 'August' then 'Agosto'
            when 'September' then 'Setiembre'
            when 'October' then 'Octubre'
            when 'November' then 'Noviembre'
            when 'December' then 'Diciembre'
        end--case
        set @nombre=rtrim(cast(datepart(day,@fecha) as char( 2 )))+' de '+@nombre
        set @nombre=@nombre+' de '+ rtrim(cast(datepart(year,@fecha)as char( 4 )))
    end--si es una fecha válida
    return @nombre
end;
go

-- Mostremos los datos de los "empleados", mostrando el nombre, puesto actual y la fecha de
-- nacimiento empleando la función creada anteriormente:

select paterno, materno, nombre, idpuestoactual,descripcion,
persona.fechaCadena(fechaNacimiento) as 'Fecha de nacimiento'
from persona.empleado e inner join catalogo.puesto p
on e.idpuestoactual=p.idPuesto

-- Empleamos la función en otro contexto:
select persona.fechaCadena(getdate());
```

Las funciones definidas por el usuario se eliminan con la instrucción "drop function":

Sintaxis:
```sql
drop function NOMBREPPROPIETARIO.NOMBREFUNCION;
```

Las funciones definidas por el usuario pueden modificarse con la instrucción "alter function".

Sintaxis general:
```sql
alter function PROPIETARIO.NOMBREFUNCION
NUEVADEFINICION;
```

### Funciones de tabla en línea

Las funciones de tabla en línea son las funciones que devuelven la salida de una simple declaración SELECT. La salida se puede utilizar dentro de JOINS o querys como si fuera una tabla. La sintaxis para una función de tabla en línea es como sigue:

```sql
CREATE FUNCTION [propietario.] nombre_funcion
([{ @parameter tipo de dato [ = default]}, [, ... n]])
RETURNS TABLE
[AS]
RETURN [(] SENTENCIA SQL [)]
```

**Ejemplo:** Defina una función que obtenga el nombre completo, fecha de nacimiento y edad de los dependientes de los empleados de confianza.

```sql
create or alter function trabajador.datos_dependiente()
RETURNS TABLE
as
return (
    select d.paterno + ' '+isnull (d.materno, '--')+ d.nombre as nombre, d.fechanacimiento, d.edad
    from trabajador.empleado e
    inner join trabajador.dependiente d on e.idempleado=d.idempleado
    where tipoempleado='c'
)
go

--Ejecutando la función.
select * from trabajador.datos_dependiente()
where year(fechanacimiento)= 1989
go
```

**Ejemplo:** Cree una función que obtenga los proyectos y los empleados que trabajan en ellos

```sql
CREATE or alter FUNCTION proyecto.proyectos_empleados()
RETURNS TABLE
AS
RETURN (
    SELECT e.idEmpleado, paterno, materno, e.nombre, y.nombre as nombreproyecto, y.costo
    from trabajador.empleado e
    join proyecto.proyectos ep on e.idempleado=ep.idempleado
    join proyecto.proyectos y on ep.id_proyecto=y.id_proyecto
)
GO

-- EJECUTANDO LA FUNCION
SELECT * FROM proyecto.proyectos_empleados()
WHERE idempleado= 2
GO
```

**Borrando una función**
```sql
drop function proyecto.proyectos_empleados
go
```

### Funciones de tabla de multisentencias

Son similares a los procedimientos almacenados excepto que vuelven una tabla. Este tipo de función se usa en situaciones donde se requiere más lógica y proceso. Sintaxis:

```sql
CREATE FUNCTION [propietario.] nombre_funcion
([{ @parameter tipo de dato [ = default]}, [, ... n]])
RETURNS TABLE
[AS]
RETURN [(] SENTENCIA SQL [)]
```

**Ejemplo:** Realice una función que obtenga a los empleados que nacieron en el mes de mayo y su sueldo es menor que 46,000 envíe un mensaje para que se le otorgue un aumento. El resultado debe mostrar: el nombre del empleado, puesto actual, total de percepciones mensual, si la percepción es menos de 30,000 indique que debe recibir un aumento.

```sql
create or alter function trabajador.empleadoAumento(@vmes varchar( 20 ))
returns @tNomina table(
    idEmpleado int,
    nombreCompleto varchar( 60 ),
    puestoActual varchar( 90 ),
    percepciones money,
    mensaje varchar( 40 ),
    fechaNacimiento date
)
as
begin
    declare @vnumeromes tinyint = 0
    set @vnumeromes=case ltrim(rtrim(upper(@vmes)))
        when 'ENERO' then 1
        when 'FEBRERO' then 2
        when 'MARZO' then 3
        when 'ABRIL' then 4
        when 'MAYO' then 5
        when 'JUNIO' then 6
        when 'JULIO' then 7
        when 'AGOSTO' then 8
        when 'SEPTIEMBRE' then 9
        when 'OCTUBRE' then 10
        when 'NOVIEMBRE' then 11
        when 'DICIEMBRE' then 12
    end--case

    insert into @tNomina (idempleado, nombreCompleto, puestoActual, percepciones, fechaNacimiento)
    select e.idempleado, CONCAT(e.nombre,' ',e.paterno,' ',ISNULL(e.materno,'-')) nombre,
    p.descripcion, sueldo, fechaNacimiento
    from trabajador.empleado as e
    left join catalogo.puesto p on e.id_puestoActual = p.idPuesto
    where month(fechaNacimiento)=@vnumeromes

    update @tNomina
    set mensaje = (case
        when ( percepciones < 46000 ) then 'Recibirá aumento'
        else 'No recibe aumento'
    end )
    return
end
go

--ejecucion
SELECT * FROM trabajador.empleadoAumento('MAYO')
go
```

---

## TABLAS TEMPORALES

SQL Server admite algunos tipos de tablas temporales de SQL Server que pueden ser muy útiles.

### Tablas temporales de SQL locales

Las tablas temporales locales de SQL Server se van a crear utilizando el símbolo numeral o “hashtag” seguido del nombre de la tabla. Por ejemplo: `#Table_name`. Las tablas temporales de SQL se crean en la base de datos de la base de datos tempdb. Una tabla temporal local de SQL Server solo es visible para la sesión actual. No puede ser vista y tampoco utilizada por procesos o consultas fuera de la sesión en la que esta se declara.

Obtenga nombre completo de los empleados y guárdelos en una tabla temporal llamada `#tblEpleados`

```sql
-- se crea la tabla temporal
select ROWNUM = ROW_NUMBER() OVER (ORDER BY idempleado), paterno, materno, nombre
INTO #tblEpleados
from TRABAJADOR.empleado

-- revisamos lo que tiene la tabla temporal
select * from #tblEpleados

-- insertamos un registro
insert into #tblEpleados values ( 27 , 'paterno', 'materno', 'nombre')

-- consultamos nuevamente
select * from #tblEpleados

-- revisamos que en la tabla de la base de datos no existe este registro, solo en la tabla temporal
select * from TRABAJADOR.empleado

-- borramos la tabla temporal
DROP TABLE #tblEpleados
```

Otra definición:

```sql
select ROWNUM = ROW_NUMBER() OVER (ORDER BY id_empleado),
paterno+' '+isnull(materno,'-')+' '+ nombre as nombreCompleto
from TRABAJADOR.empleado

CREATE TABLE #tablaTemporal2( id INT , nombre varchar( 90 ) )

insert into #tablaTemporal
select ROWNUM = ROW_NUMBER() OVER (ORDER BY id_empleado),
paterno+' '+isnull(materno,'-')+' '+ nombre as nombreCompleto
from TRABAJADOR.empleado

select * from #tablaTemporal

drop table #tablaTemporal
```

### Tablas globales

También existen tablas temporales globales, estas se usan cuando se desea que el conjunto de resultados sea visible para todas las demás sesiones. No se requiere configurar permisos. Cualquiera puede insertar valores, modificar o recuperar registros de la tabla y cualquiera puede eliminar la tabla. Al igual que las tablas temporales locales, se eliminan una vez que la sesión se desconecta y ya no hay más referencias a la tabla. Se puede usar el comando “DROP” para borrarla manualmente.

Para crear una tabla temporal global de SQL, simplemente ponemos dos símbolos numeral delante del nombre de la tabla. Ejemplo: `##tablaGLobal`.

Los escenarios más comunes para usar tablas temporales de SQL Server están dentro de un ciclo. Otro motivo es que se requiere realizar un procesamiento en la instrucción sql.

### Variables de tabla

Las variables de tabla se crean como cualquier otra variable, utilizando la instrucción DECLARE. Las variables de tabla residen en la base de datos tempdb de forma muy similar a las tablas temporales de SQL Server locales. Como las tablas temporales de SQL locales, las variables de tabla solo son accesibles dentro de la sesión que las creó. No obstante, a diferencia de las tablas temporales de SQL, solo se puede tratar de acceder a la variable de tabla dentro del lote actual.

En lo que respecta al rendimiento, las variables de tabla son útiles con pequeñas cantidades de datos (como solo unas pocas filas). De lo contrario, una tabla temporal de SQL Server es útil al examinar grandes cantidades de datos.

```sql
-- Ejemplo: obtenga el total pagado para cada PROYECTO y almacene en una variable de tabla

SELECT P.id_proyecto, P.nombre, P.costo, isnull(SUM(monto), 0 ) as total_PAGADO
FROM proyecto.PROYECTOS P
LEFT JOIN proyecto.PAGOS PA ON P.id_proyecto=PA.id_proyecto
GROUP BY P.id_proyecto, P.nombre, P.costo

DECLARE @TotalPagos AS TABLE
(id_proyecto INT NOT NULL PRIMARY KEY,
Nombre varchar( 90 ) NOT NULL,
costo money,
TotalPagado money not null)

INSERT INTO @TotalPagos (id_proyecto, nombre, costo, totalpagado )
SELECT P.id_proyecto, P.nombre, P.costo, isnull(SUM(monto), 0 ) as total_PAGADO
FROM proyecto.PROYECTOS P
LEFT JOIN proyecto.PAGOS PA ON P.id_proyecto=PA.id_proyecto
GROUP BY P.id_proyecto, P.nombre, P.costo

select 'Haciendo select a la tabla'
select * from @TotalPagos
```

Una vez que se llena la variable de la tabla, se puede unir como una tabla a otra tabla y obtener la información que necesite. Hay mucha flexibilidad y permite al desarrollador ser bastante creativo.

---

## CURSORES

Un cursor es una variable que nos permite recorrer con un conjunto de resultados obtenidos a través de una sentencia SELECT fila por fila.

El uso de los cursores es una técnica que permite tratar fila por fila el resultado de una consulta, contrariamente al SELECT SQL que trata a un conjunto de fila.

Existen dos tipos:
* Implícitos
* Explícitos

Si deseamos obtener más de un valor utilizamos un cursor explícito para extraer individualmente cada fila.

Pasos a seguir:
a) Declarar el cursor, utilizando DECLARE
b) Abrir el cursor, utilizando OPEN
c) Leer los datos del cursor, utilizando FETCH ... INTO
d) Cerrar el cursor, utilizando CLOSE
e) Liberar el cursor, utilizando DEALLOCATE

**a) Declarar el cursor, utilizando DECLARE. Sintaxis**

```sql
-- DECLARACIÓN DEL CURSOR
DECLARE <NOMBRE_CURSOR> [INSENSITIVE][SCROLL] CURSOR
FOR <SENTENCIA_SQL>
FOR [READ ONLY | UPDATE[ OF LISTA DE COLUMNAS]]
```

* **INSENSITIVE** solo se permiten las operaciones sobre la fila siguiente.
* **SCROLL** los desplazamientos en las filas del cursor podrán hacerse en todos los sentidos.
* **UPDATE** especifica que las actualizaciones se harán sobre la tabla de origen del cursor. Un cursor INSENSITIVE con una cláusula ORDER BY no puede actualizarse. Un cursor con ORDER BY, UNION, DISTINCT o HAVING es INSENSITIVE y READ ONLY.

**b) Abrir el cursor, utilizando OPEN**

Esta instrucción permite hacer operativo el cursor y crear eventualmente las tablas temporales asociadas. La variable `@@CURSOR_ROWS` se asigna después de OPEN.

Teniendo en cuenta el espacio en disco y la memoria utilizada, y el bloqueo eventual de los datos en la apertura del cursor, esta operación debe ser ejecutada lo más cerca posible del tratamiento de los datos extraídos del cursor.

**c) Leer los datos del cursor, utilizando FETCH ... INTO**

Es la instrucción que permite extraer una fila del cursor y asignar valores a variables con su contenido. Tras FETCH, la variable `@@FETCH_STATUS` está a 0 si FETCH no retorna errores.

Sintaxis:
```sql
FETCH [NEXT | PRIOR | LAST | ABSOLUTE n | RELATIVE n ]
[FROM] [GLOBAL ] <nombre del cursor>
```

* `NEXT` lee la fila siguiente (única opción posible para los INSENSITIVE CURSOR).
* `PRIOR` lee la fila anterior.
* `FIRST` lee la primera fila.
* `LAST` lee la última fila.
* `ABSOLUTE n` lee la enésima fila del conjunto.
* `RELATIVE n` lee la enésima fila a partir de la fila actual.

Cuando trabajamos con cursores, la función `@@FETCH_STATUS` nos indica el estado de la última instrucción FETCH emitida. Los valores posibles son los siguientes:

| Valor devuelto | Descripción |
| :--- | :--- |
| **0** | La instrucción FETCH se ejecutó correctamente |
| **-1** | La instrucción FETCH no se ejecutó correctamente o la fila estaba más allá del conjunto de resultados. |
| **-2** | Falta la fila recuperada. |

**d) Cerrar el cursor, utilizando CLOSE**

Cierra el cursor y libera la memoria. Esta operación debe interponerse lo antes posible con el fin de liberar los recursos cuanto antes.

Después de cerrado el cursor, ya no es posible capturarlo o actualizarlo/eliminarlo. Al cerrar el cursor se elimina su conjunto de claves dejando la definición del cursor intacta, es decir, un cursor cerrado puede volver a abrirse sin tener que volver a declararlo.

```sql
CLOSE <nombre_cursor>
```

**e) Liberar el cursor, utilizando DEALLOCATE**

```sql
DEALLOCATE <nombre_cursor>
```

La sintaxis general para trabajar con un cursor es la siguiente:

```sql
-- 1 DECLARACIÓN DEL CURSOR
DECLARE <NOMBRE_CURSOR> CURSOR
FOR <SENTENCIA_SQL>

-- 2 APERTURA DEL CURSOR
OPEN <NOMBRE_CURSOR>

-- 3 LECTURA DE LA PRIMERA FILA DEL CURSOR
FETCH <NOMBRE_CURSOR> INTO <LISTA_VARIABLES>

WHILE (@@FETCH_STATUS = 0 )
BEGIN
    -- LECTURA DE LA SIGUIENTE FILA DE UN CURSOR
    FETCH <NOMBRE_CURSOR> INTO <LISTA_VARIABLES>
    ...
END -- FIN DEL BUCLE WHILE

-- 4 CIERRA EL CURSOR
CLOSE <NOMBRE_CURSOR>

-- 5 LIBERA LOS RECURSOS DEL CURSOR
DEALLOCATE <NOMBRE_CURSOR>
```

**EJEMPLOS**

```sql
-- 1.- Defina un cursor dinámico que permita visualizar: el primer registro, el registro en la
-- posición 6 y el último registro de la tabla empleados

select * from TRABAJADOR.empleado

DECLARE EmpleadoDin SCROLL CURSOR -- SCROLL permite avanzar en cualquier dirección.
FOR
SELECT idempleado, nombre, paterno, materno, correo, fechaNacimiento, tipoempleado
FROM TRABAJADOR.empleado

OPEN EmpleadoDin; -- Apertura del cursor

FETCH FIRST FROM EmpleadoDin -- Se despliega la primer fila
FETCH ABSOLUTE 6 FROM EmpleadoDin -- Se despliega la sexta fila
FETCH LAST FROM EmpleadoDin -- Se despliega la última fila

CLOSE EmpleadoDin -- Cierre del cursor
DEALLOCATE EmpleadoDin -- Liberar los recursos
go
```

```sql
-- 2.- Muestre el nombre, alcaldia y fecha de nacimiento, para cada empleado que viva en COYOACAN

DECLARE
@idEmpleado int,
@nombre varchar( 40 ),
@paterno varchar( 40 ),
@materno varchar( 40 ),
@fechaNacimiento datetime,
@alcaldia varchar( 40 )

DECLARE curEmpleado CURSOR
FOR
SELECT DISTINCT e.idempleado, e.nombre, e.paterno, e.materno, e.fechaNacimiento, d.alcaldia
FROM TRABAJADOR.EMPLEADO e
LEFT JOIN TRABAJADOR.DOMICILIO d ON e.idempleado=d.idEmpleado
WHERE d.alcaldia='coyoacan'

OPEN curEmpleado

FETCH curEmpleado INTO @idEmpleado, @nombre, @paterno, @materno, @fechaNacimiento, @alcaldia

WHILE(@@FETCH_STATUS= 0 )
BEGIN
    SELECT @idEmpleado AS idEmpleado, CONCAT(@nombre, ' ', @paterno, ' ',
    ISNULL(@materno, ' ')) AS nombre,
    @fechaNacimiento AS fechaNacimiento, @alcaldia AS estado
    
    FETCH curEmpleado INTO @idEmpleado, @nombre, @paterno, @materno, @fechaNacimiento, @alcaldia
END

CLOSE curEmpleado
DEALLOCATE curEmpleado
go
```

```sql
-- 3.- Liste todos los empleados(nombre y escolaridad), incluya puesto y sueldo, si el sueldo es menor que
-- 38000 solo envié el siguiente mensaje ‘Incrementar sueldo’ + ‘Nombre del empleado’+'Sueldo:‘

declare @nombre varchar( 122 ),
@escolaridad varchar( 40 ),
@puesto varchar( 90 ),
@sueldo money

declare cEmpleados cursor
for
select nombre+' '+paterno+isnull(' '+materno,'') NombreCompleto, descripcion, sueldo
from TRABAJADOR.EMPLEADO E
inner join catalogo.PUESTO p on e.id_puestoActual=p.idPUESTO

open cEmpleados
fetch cEmpleados into @nombre, @puesto, @sueldo

while @@FETCH_STATUS= 0
begin
    select @nombre as NombreCompleto, @puesto as 'puesto actual', @sueldo sueldo

    if (@sueldo< 38000 )
    begin
        select 'Pago bajo para el empleado: '+@nombre+' '+cast(@sueldo as varchar) Mensaje
    end
    else
        select 'Sin cambios en el sueldo' Mensaje
        
    fetch cEmpleados into @nombre, @puesto, @sueldo
end

close cEmpleados
deallocate cEmpleados
go
```

```sql
-- 4.- Para cada empleado muestre lo siguiente, nombre completo, alcaldia de donde vive , nombre
-- de los proyectos en los que ha participado (utilice cursores anidados)

DECLARE
@idEmpleado int,
@nombre varchar( 40 ),
@materno varchar( 40 ),
@paterno varchar( 40 )

DECLARE cursorEmpleado CURSOR
FOR
select e.idempleado, e.nombre, materno, paterno
from TRABAJADOR.empleado as e

OPEN cursorEmpleado
FETCH cursorEmpleado INTO @idEmpleado, @nombre, @materno, @paterno

WHILE ( @@FETCH_STATUS = 0 )
BEGIN
    if (exists(select * from proyecto.EMPLEADO_PROYECTO where idempleado=@idEmpleado))
    begin
        DECLARE
        @idProyecto int,
        @nombreProy varchar( 40 )
        
        DECLARE cursorProyecto CURSOR
        FOR
        select p.id_proyecto, p.nombre from proyecto.proyectos as p
        
        OPEN cursorProyecto
        FETCH cursorProyecto INTO @idProyecto, @nombreProy
        
        WHILE ( @@FETCH_STATUS = 0 )
        BEGIN
            if (exists(select * from proyecto.EMPLEADO_PROYECTO
            where id_proyecto=@idProyecto AND idempleado=@idEmpleado))
            print 'Empleado: '+@nombre+' '+@paterno+' '+@materno+', Proyecto: '+@nombreProy

            FETCH cursorProyecto INTO @idProyecto, @nombreProy
        END
        
        CLOSE cursorProyecto
        DEALLOCATE cursorProyecto
    end
    
    FETCH cursorEmpleado INTO @idEmpleado, @nombre, @materno, @paterno
END

CLOSE cursorEmpleado
DEALLOCATE cursorEmpleado
GO
```

---

## CONTROL DE ERRORES

### TRY...CATCH

SQL Server proporciona el control de errores a través de las instrucciones TRY y CATCH. La sintaxis de TRY CATCH es la siguiente:

```
BEGIN TRY
    EXPRESION_SQL
END TRY
BEGIN CATCH
    EXPRESION_SQL
END CATCH
```

**Ejemplo:** Realice un programa que evalúe la división de dos números enteros. Si la división ha sido exitosa, imprima un mensaje: NO HAY ERROR. Caso contrario imprimir un mensaje: SE HA PRODUCIDO UN ERROR

```sql
BEGIN TRY
    DECLARE @DIVISOR INT, @DIVIDENDO INT, @RESULTADO INT
    SET @DIVIDENDO = 100
    SET @DIVISOR = 5
    -- ESTA LINEA PROVOCA UN ERROR DE DIVISION POR 0
    SET @RESULTADO = @DIVIDENDO/@DIVISOR
    PRINT 'NO HAY ERROR'
    PRINT @RESULTADO
END TRY
BEGIN CATCH
    PRINT 'SE HA PRODUCIDO UN ERROR'
END CATCH;
```

### Funciones

Las funciones especiales de error, están disponibles únicamente en el bloque CATCH para la obtención de información detallada del error. Funciones que se utilizan en el control de errores:

| Error | Descripción |
| :--- | :--- |
| `ERROR_NUMBER()` | Devuelve el numero de error |
| `ERROR_SEVERITY()` | Devuelve la severidad del error |
| `ERROR_STATE()` | Devuelve el estado del error |
| `ERROR_PROCEDURE()`| Devuelve el nombre del procedimiento almacenado que ha provocado el error |
| `ERROR_LINE()` | Devuelve el número de línea en la que se ha producido el error. |
| `ERROR_MESSAGE()` | Devuelve el mensaje de error |

**Ejemplo:** Realice un programa que evalúe la división de dos números enteros. Si la división ha sido exitosa, imprima un mensaje: NO HAY ERROR. Caso contrario imprimir el mensaje de error y el número del error.

```sql
BEGIN TRY
    DECLARE @DIVISOR INT, @DIVIDENDO INT, @RESULTADO INT
    SET @DIVIDENDO = 100
    SET @DIVISOR = 0
    -- ESTA LINEA PROVOCA UN ERROR DE DIVISION POR 0
    SET @RESULTADO = @DIVIDENDO/@DIVISOR
    PRINT 'NO HAY ERROR'
END TRY
BEGIN CATCH
    SELECT
    ERROR_NUMBER() AS numero,
    ERROR_SEVERITY() AS severidad,
    ERROR_STATE() AS estatus,
    ERROR_LINE() AS linea,
    ERROR_MESSAGE() AS mensaje;
END CATCH;
```

### Variable de sistema @@ERROR

Devuelve el número de error de la última instrucción TRANSACT-SQL ejecutada; si la variable devuelve 0, la instrucción TRANSACT-SQL anterior no encontró errores.

**Ejemplo:** Implemente un bloque de instrucciones que permita eliminar un registro de EMPLEADO por su RFC. Si hay un error en el proceso, visualice un mensaje de error

```sql
begin tran
    DELETE FROM TRABAJADOR.empleado WHERE RFC='ISDF850423NHR'
    IF @@ERROR = 547
    begin
        select 'NO SE PUEDE ELIMINAR'
    end
    else
        select 'NO HAY ERROR Y ENTONCES SE PUEDE ELIMINAR'
rollback tran
```

Otra forma de implementar este proceso, es controlándolo a través del bloque TRY CATCH.

```sql
BEGIN TRY
    DELETE FROM TRABAJADOR.empleado WHERE RFC='ISDF850423NHR'
END TRY
BEGIN CATCH
    IF @@ERROR= 547
        PRINT 'NO SE PUEDE ELIMINAR ESTE EMPLEADO'
END CATCH
```

**Niveles de severidad**

La siguiente tabla enumera y describe los niveles de gravedad de los errores generados por el Motor de base de datos de SQL Server.

| Nivel de severidad | Descripción |
| :--- | :--- |
| `0-9` | Mensajes informativos que devuelven información de estado o informan errores que no son graves. El motor de base de datos no genera errores del sistema con una gravedad de 0 a 9. |
| `10` | Mensajes informativos que devuelven información de estado o informan errores que no son graves. Por motivos de compatibilidad, el motor de base de datos convierte la gravedad 10 en la gravedad 0 antes de devolver la información del error a la aplicación. |
| `16` | Indicar errores que puede corregir el usuario. |
| `11` | Indica que el objeto o entidad dados no existe. |
| `12` | Una gravedad especial para las consultas que no utilizan el bloqueo debido a sugerencias de consulta especiales. En algunos casos, las operaciones de lectura realizadas por estas declaraciones pueden resultar en datos inconsistentes, ya que no se |
| `13` | Indica errores de interbloqueo de transacciones. |
| `14` | Indica errores relacionados con la seguridad, como permiso denegado. |
| `15` | Indica errores de sintaxis en el comando Transact-SQL. |
| `dieciséis` | Indica errores generales que puede corregir el usuario. |
| `17-19` | Indica errores de software que el usuario no puede corregir. Informe al administrador del sistema del problema. |
| `17` | Indica que la declaración provocó que SQL Server se quedara sin recursos (como memoria, bloqueos o espacio en disco para la base de datos) o que superara algún límite establecido por el administrador del sistema. |
| `18` | Indica un problema en el software Motor de base de datos, pero la instrucción completa la ejecución y se mantiene la conexión a la instancia del Motor de base de datos. Se debe informar al administrador del sistema cada vez que se produzca un mensaje con un nivel |
| `19` | Indica que se ha superado un límite de motor de base de datos no configurable y que se ha terminado el proceso por lotes actual. Los mensajes de error con un nivel de gravedad de 19 o superior detienen la ejecución del lote actual. Los errores de nivel de gravedad |
| `20-24` | Indican problemas del sistema y son errores fatales, lo que significa que la tarea del Motor de base de datos que esta ejecutando una instrucción o un lote ya no se está ejecutando. La tarea registra información sobre lo ocurrido y luego finaliza. En la mayoría. Los mensajes de error en este rango pueden afectar a todos los procesos que acceden a los datos en la misma base de datos y pueden indicar que una base de datos u objeto está dañado. Los mensajes de error con un nivel de gravedad de 19 a 24 se escriben en el |
| `20` | Indica que una declaración ha encontrado un problema. Debido a que el problema ha afectado solo a la tarea actual, es poco probable que la base de datos se haya dañado. |
| `21` | Indica que se ha encontrado un problema que afecta a todas las tareas de la base de datos actual, pero es poco probable que la propia base de datos se haya dañado. |
| `22` | Indica que la tabla o el índice especificado en el mensaje ha sido dañado por un problema de software o hardware. Los errores de nivel de gravedad 22 ocurren raramente. Si ocurre uno, ejecute DBCC CHECKDB para determinar si otros objetos de la base de datos también están dañados. El problema puede estar solo en la memoria caché del búfer y no en el disco en. Si reiniciar la instancia del Motor de base de datos no corrige el problema, entonces el problema está en el disco. A veces, destruir el objeto especificado en el mensaje de error puede resolver el problema. Por ejemplo, si el mensaje informa que la instancia del |
| `23` | Indica que la integridad de toda la base de datos está en duda debido a un problema de hardware o software. Los errores de nivel de gravedad 23 ocurren raramente. Si ocurre uno, ejecute DBCC CHECKDB para determinar el alcance del daño. El problema puede estar solo en la caché y no en el disco en sí. Si es así, reiniciar la instancia de Motor de base de datos corrige el |
| `24` | Indica una falla en el medio. Es posible que el administrador del sistema deba restaurar la base de datos. También puede que tenga que llamar a su proveedor de hardware. |
