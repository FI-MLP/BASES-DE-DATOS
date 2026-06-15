## Bases de Datos

# TEMA 8. LENGUAJE DE PROGRAMACIÓN TRANSACT-SQL (PARTE 1)

### Contenido
* 8.1 Lenguaje de programación Transact –SQL (PARTE 1)
* 8.2 Código limpio
* 8.3 Uso de Variables
* 8.4 Operadores
* 8.5 Control de flujo
    * 8.5.1 BEGIN...END
    * 8.5.2 GO
    * 8.5.3 IF
    * 8.5.4 While
    * 8.5.5 CASE
* 8.6 Triggers o Disparadores

---

## 8.1 Lenguaje de programación Transact –SQL (PARTE 1)

SQL es un lenguaje estándar tanto de ANSI como de ISO, organizaciones que se encargan de supervisar el desarrollo de estándares para productos, servicios, sistemas, etc. a fin de facilitar los procesos. Este lenguaje SQL estándar fue tomado por la mayoría de empresas desarrolladores de manejadores de bases de datos, tales como Microsoft, Oracle, MySQL, IBM, etc. Posteriormente, estas empresas decidieron ampliar este SQL estándar con características propias para sus bases de datos, Microsoft desarrolló el Transact-SQL, Oracle el PL-SQL y así cada una de éstas.

* El lenguaje TRANSACT-SQL está compuesto por comandos, cláusulas, operadores y funciones de agregación, estos elementos se combinan en las instrucciones para crear, actualizar y manipular las bases de datos.
* Se pueden crear subprogramas también llamados; función, procedimiento o disparador.
* Los operadores son los mismos que para SQL: aritméticos, lógicos, concatenación, y paréntesis.
* También se utilizan estructuras de control, éstas permiten elegir la forma en la que se van a ejecutar las diferentes instrucciones dentro del programa. Las más importantes son las estructuras condicionales y las estructuras de repetición también llamadas ciclos.

---

## 8.2 Código limpio

**_Documentar_**

```sql
-- =============================================
-- Autor:
-- Fecha de creación:
-- Descripción:
-- =============================================
```

**_Legibilidad_** Para hacer un código más legible:
* Utilizar comentarios
* Utilizar identación
* Usar espacios en blanco y dejar el código organizado en columnas
* Declarar e iniciar las variables en un bloque

---

## 8.3 Uso de Variables

En Transact-SQL podemos definir variables que serán de un tipo de datos determinado, como tipos de datos se pueden utilizar los propios de SQL-SERVER, pero también es posible utilizar tipos propios del lenguaje que no pueden ser utilizados en DDL (Lenguaje de Definición de Datos), el tipo Cursor y el tipo Table son dos de estos tipos.

Las variables nos permiten almacenar un valor y recuperarlo más adelante para emplearlos en otras sentencias.

Las variables de usuario son específicas de cada conexión y son liberadas automáticamente al abandonar la conexión.

Los procedimientos almacenados pueden crear y usar variables locales:
* Las variables sólo existen mientras exista el procedimiento.
* Las variables no las puede usar otro proceso.

Las variables de usuario comienzan con "@" (arroba) seguido del nombre (sin espacios), dicho nombre puede contener cualquier caracter.

Una variable debe ser declarada antes de usarse. Una variable local se declara colocando "declare" el nombre de la variable que comienza con el símbolo arroba (@) y el tipo de dato.

```sql
declare @NOMBREVARIABLE tipodeDato
```

Ejemplo:
```sql
declare @nombre varchar( 20 )
```

Puede declarar varias variables en una misma sentencia:
```sql
declare @nombre varchar( 20 ),
@edad int,
@sexo char( 1 )
```

**_Asignar valor a una variable_**

Una variable a la cual no se le ha asignado un valor contiene "null". Se le asigna un valor inicial con "set":

```sql
set @edad= 45
```

Como se puede observar para almacenar un valor en una variable se coloca el signo igual (=) entre la variable y el valor a asignar.

Si le asignamos un valor resultado de una consulta, la sintaxis es:

```sql
Declare @parentesco varchar( 40 )

select @parentesco = denominacion from catalogo.parentesco where idparentesco= 3 ;
```

Podemos ver el contenido de una variable con:

```sql
select @parentesco;
PRINT 'El parentesco con id=3 es: ' +@parentesco;
```

**_Consideraciones:_**

Una variable declarada existe únicamente dentro del entorno en que se define; debemos declarar y emplear la variable en el mismo lote de sentencias, porque si declaramos una variable y luego en otro bloque de sentencias pretendemos emplearla, dicha variable ya no existe.

Debemos escribir:

```sql
declare @variable varchar( 10 )
select @variable;
```

Colocamos punto y coma solo al final de la última instrucción del lote.

Una variable puede tener comodines:

```sql
declare @patron varchar( 30 )

set @patron='%gmail.com'
select @patron
select correo from trabajador.investigador where correo like @patron;
```

La utilidad de las variables consiste en que almacenan valores para utilizarlos en otras consultas. Por ejemplo, queremos saber todos los datos de los investigadores con el nivel cuyo sueldo es el más alto.

```sql
--Para ello podemos emplear una variable para almacenar el id del sueldo más alto

declare @idmayorsueldo INT ---los tipos de datos deben ser compatibles con el campo de donde recibe el dato

select @idmayorsueldo=id_nivel
from catalogo.NIVEL
where sueldo=(select MAX(sueldo) from catalogo.NIVEL)

select 'Id del investigador con mayor sueldo', @idmayorsueldo as 'id del puesto'

--y luego mostrar todos los datos de los empleados empleando la variable anterior:

select * from trabajador.INVESTIGADOR e
where id_nivel_actual=@idmayorsueldo

select 'Empleado con el nivel con el suelto más alto: ', p.*
from trabajador.PERSONAL p
join trabajador.INVESTIGADOR i on p.id_personal=i.id_personal
where id_nivel_actual=@idmayorsueldo
```

Una variable puede ser definida con cualquier tipo de dato, excepto text e image; incluso de un tipo de dato definido por el usuario.

---

## 8.4 Operadores

Los operadores que se emplean son los operadores clásicos que se encuentran en la mayoría de los lenguajes: operadores aritméticos, operadores lógicos, etc. Existen algunas diferencias particulares que se muestran a continuación:

* El operador `=` se emplea para hacer comparaciones (no se emplea el operador `==`)
* El operador de negación puede ser cualquiera de los siguientes: `!=`, `<>`
* El operador para concatenar cadenas es `+`

---

## 8.5 Control de flujo

Existen palabras especiales que pertenecen al lenguaje de control de flujo que controlan la ejecución de las sentencias, los bloques de sentencias y procedimientos almacenados.

Tales palabras son: "begin... end", "if... else", "while", "break" y "continue", "return" y "waitfor".

### 8.5.1 BEGIN...END

Encierra un conjunto de instrucciones Transact-SQL de forma que estas instrucciones formen un bloque de instrucciones.

### 8.5.2 GO

No es una instrucción Transact-SQL, sino un comando reconocido por las utilidades sqlcmd y osql, así como por el Editor de código de SQL Server Management Studio.

Las utilidades de SQL Server interpretan GO como una señal de que deben enviar el lote actual de instrucciones Transact-SQL a una instancia de SQL Server. El lote actual de instrucciones está formado por todas las instrucciones especificadas desde el último comando GO o desde el comienzo de la sesión o script si se trata del primer comando GO.

### 8.5.3 IF

La estructura condicional IF permite evaluar una expresión booleana (resultado SI - NO), y ejecutar las operaciones contenidas en el bloque formado por BEGIN END.

Sintaxis:
```sql
If (CONDICION) then
begin
    -- SENTENCIAS si la condición se cumple
end
```

O bien, sentencia IF-THEN-ELSE:
```sql
If (CONDICION) then
begin
    -- SENTENCIAS si la condición se cumple
end
else
begin
    -- SENTENCIAS si la condición resulta falsa
end
```

**EXISTS**, evalúa una consulta y si la consulta regresa resultados devuelve un true, de lo contrario un false:

```sql
if exists (select ... from where..) -- si regresa al menos un registro, entonces hay un true
begin
    print 'si existe información'
end
else
    print 'no existe información'
```

**IF ELSE IF** La estructura IF admite el uso de subconsultas:

```sql
IF <(EXPRESION>)
BEGIN
    ---
END
ELSE IF <(EXPRESION>)
BEGIN
    ---
END
ELSE
BEGIN
    ---
END
```

### 8.5.4 While

La estructura WHILE ejecuta en forma repetitiva un conjunto o bloque de instrucciones SQL siempre que la condición especificada sea verdadera.

Se puede controlar la ejecución de instrucciones en el bucle WHILE con las palabras clave BREAK y CONTINUE.

Es el único tipo de bucle del que dispone **Transact SQL**:

```sql
While <expresión>
Begin
    ...
End
```

**_Ejemplo._** _Creamos un ciclo que nos muestre los números del 1 al 100 y nos indique si es par o impar_

```sql
DECLARE @contador integer
SET @contador = 0
WHILE (@contador < 100 )
BEGIN
    SET @contador = @contador + 1
    IF (@contador % 2 = 0 )
        PRINT cast(@contador AS varchar) +' es un Número Par'
    ELSE
        PRINT cast(@contador AS varchar) + ' es un Número Impar'
end
```

Podemos pasar a la siguiente iteración del bucle utilizando **CONTINUE**

```sql
DECLARE @contador integer
SET @contador = 0
WHILE (@contador < 100 )
BEGIN
    SET @contador = @contador + 1
    IF (@contador % 2 = 0 )
        continue
    PRINT 'Iteración del bucle '+cast(@contador AS varchar)
end
```

El bucle se dejará de repetir con la instrucción **BREAK**.

```sql
DECLARE @contador integer
SET @contador = 0
WHILE (@contador <= 100 )
BEGIN
    SET @contador = @contador + 1
    IF (@contador % 50 = 0 )
        break
    PRINT 'Iteración del bucle '+cast(@contador AS varchar)
end
```

También podemos utilizar el bucle WHILE conjuntamente con subconsultas.

1. Ponga la fecha de término a cada proyecto que aún no la tenga, ponga la fecha del sistema

```sql
--También podemos utilizar el bucle WHILE conjuntamente con subconsultas.

declare @v_id_proyecto int

while exists(select * from proyecto.proyecto
where fechafin is null) -- ojo, la subconsulta se ejecuta una vez por cada iteración del bucle
begin
    set @v_id_proyecto = (select top 1 id_proyecto from proyecto.proyecto
    where fechafin is null)

    select @v_id_proyecto

    update proyecto.proyecto
    set fechafin=getdate()
    where id_proyecto=@v_id_proyecto

    select * from proyecto.proyecto
end

select * from proyecto.proyecto
```

### 8.5.5 CASE

La estructura CASE evalúa una lista de condiciones y devuelve una de las varias expresiones de resultado posibles. La expresión CASE tiene dos formatos:

* La expresión CASE sencilla, compara una expresión con un conjunto de expresiones sencillas para determinar el resultado.
* La expresión CASE buscada, evalúa un conjunto de expresiones booleanas para determinar el resultado.

Ambos formatos admiten un argumento ELSE opcional.

Sintaxis:
```sql
CASE <expresion>
    when <valor_expresion> then <valor devuelto>
    when <valor_expresion1> then <valor_devuelto1>
    .
    .
    .
    else <valor_devuelto2> --VALOR POR DEFECTO
```

**Ejemplo:** Declarar una variable donde se le asigne el número del mes, evalúe el valor de la variable y retorne el mes en letras.

```sql
declare @mes int, @mes varchar( 20 )
set @mes= 4
set @mes = ( case @mes
    when 1 then 'ENERO'
    when 2 then 'FEBRERO'
    when 3 then 'MARZO'
    when 4 then 'ABRIL'
    when 5 then 'MAYO'
    when 6 then 'JUNIO'
    when 7 then 'JULIO'
    when 8 then 'AGOSTO'
    when 9 then 'SEPTIEMBRE'
    when 10 then 'OCTUBRE'
    when 11 then 'NOVIEMBRE'
    when 12 then 'DICIEMBRE'
    else 'No es un mes valido'
end)
select @mes
```

La estructura CASE se puede utilizar en cualquier instrucción o cláusula que permite una expresión válida. Por ejemplo, puede utilizar CASE en instrucciones como SELECT, UPDATE, DELETE y SET, y en cláusulas como IN, WHERE, ORDER BY y HAVING.

La función CASE es una expresión especial de Transact SQL que permite que se muestre un valor alternativo dependiendo de una columna. Este cambio es temporal, no hay cambios permanentes en los datos.

En una instrucción SELECT, la expresión CASE de búsqueda permite sustituir valores en el conjunto de resultados basándose en los valores de comparación.

En el ejemplo siguiente, listamos los datos de los productos y definimos una columna llamada ESTADO, el cual evaluará stock de cada producto imprimiendo un valor: Stockeado (existencia), Limite, Haga una solicitud.

---

## 8.6 Triggers o Dispáradores

Un "trigger" (disparador o desencadenador) es un tipo de procedimiento almacenado que se ejecuta cuando se intenta modificar los datos de una tabla (o vista) por lo tanto, se definen para una tabla (o vista) específica en cualquier sentencia **DML**; insert, update, delete.

Generalmente se crean para conservar la integridad referencial y la coherencia entre los datos entre distintas tablas. Si se intenta modificar (agregar, actualizar o eliminar) datos de una tabla en la que se definió un disparador para alguna de estas acciones (inserción, actualización y eliminación), el disparador se ejecuta (se dispara) en forma **automática**.

**No reciben y retornan parámetros**. A diferencia de las restricciones "check", pueden hacer referencia a **campos de otras tablas**. Por ejemplo, puede crearse un trigger de inserción en la tabla "ventas" que compruebe el campo "stock" de un artículo en la tabla "artículos"; el disparador controlaría que, cuando el valor de "stock" sea menor a la cantidad que se intenta vender, la inserción del nuevo registro en "ventas" no se realice.

Un disparador es un objeto de la base de datos. Cuando se crea un disparador, se especifica la tabla y los comandos de modificación de datos (sentencia DML) que deben “disparar” o activar el disparador. Luego, se indica la acción o acciones que debe llevar a cabo.

**Sintaxis**

```sql
CREATE [ OR ALTER ] TRIGGER [ Esquema. ]NombreTrigger
ON { tabla | vista }
{ FOR | AFTER | INSTEAD OF }
{ [ INSERT ] [ , ] [ UPDATE ] [ , ] [ DELETE ] }
AS
Begin
    -- Instrucciones T-SQL
End
```

Consideraciones generales:
* "create trigger" debe ser la primera sentencia de un bloque y sólo se puede aplicar a una tabla.
* Un disparador se crea solamente en la base de datos actual, pero puede hacer referencia a objetos de otra base de datos.
* Las siguientes instrucciones no están permitidas en un disparador: create database, alter database, drop database, load database, restore database, load log, reconfigure, restore log, disk init, disk resize.

**Ejemplos:**

```sql
CREATE TRIGGER catalogo.trpuesto
ON catalogo.puesto
FOR INSERT, UPDATE, DELETE
AS
PRINT 'Actualización de los registros de Puestos'
```

Para modificar el TRIGGER, se utiliza la siguiente sintaxis:

```sql
ALTER TRIGGER catalogo.trpuesto
ON catalogo.puesto
FOR INSERT, UPDATE, DELETE
AS
PRINT 'Modificación del trigger TRPUESTO'
```

Para borrar un _TRIGGER_, se utiliza la siguiente sintaxis:

```sql
DROP TRIGGER catalogo.trpuesto
```

Cuando se inserta una nueva fila en una tabla, SQL Server inserta los nuevos valores en la tabla **INSERTED** la cual es una tabla del sistema. Está tabla toma la misma estructura del cual se originó el **TRIGGER**, de tal manera que se pueda verificar los datos y ante un error podría revertirse los cambios.

Cuando se elimina una fila de una tabla, SQL Server inserta los valores que fueron eliminados en la tabla **DELETED** el cual es una tabla del sistema. Está tabla toma la misma estructura del cual se originó el **TRIGGER**, de tal manera que se pueda verificar los datos y ante un error podría revertirse los cambios. En este caso, la reversión de los cambios significará restaurar los datos eliminados.

Cuando se actualiza una fila de una tabla, SQL Server inserta los valores antiguos en la tabla **DELETED** y los nuevos valores los inserta en la tabla **INSERTED**. Usando estas dos tablas se podrá verificar los datos y ante un error podrían revertirse los cambios:
* **Deleted** – tabla que contiene la información almacenada en la base de datos, antes de la actualización.
* **Inserted** – tabla que contiene la información que deseo insertar.

**INSTEAD OF**

Los desencadenadores **INSTEAD OF** se inician en lugar de la instrucción SQL desencadenante, pasan por alto las acciones estándar de la instrucción de desencadenamiento: INSERT, UPDATE o DELETE.

Se puede definir un desencadenador INSTEAD OF para realizar comprobación de errores o valores en una o más columnas y, a continuación, realizar acciones adicionales antes de insertar el registro.

Como máximo, puede definir un desencadenador INSTEAD OF por instrucción INSERT, UPDATE o DELETE en una tabla o vista.

**FOR/AFTER**

Especifica que el trigger se dispara solo cuando todas las operaciones especificadas en la instrucción SQL desencadenante se han **_iniciado_** correctamente. Todas las acciones de referencia en cascada y las comprobaciones de restricciones también deben tener éxito antes de que se active este disparador.

**Restricciones de los triggers**
* Cada disparador puede aplicarse a una sola tabla. Sin embargo, un mismo disparador se puede aplicar a las tres acciones del usuario: UPDATE, INSERT y DELETE.
* No se puede crear un disparador en una vista ni en una tabla temporal, aunque los disparadores pueden hacer referencia a las vistas o tablas temporales.

**Deshabilitar o habilitar**

* Se puede deshabilitar o habilitar un disparador específico de una tabla o vista, o todos los disparadores que tenga definidos.
* Si se deshabilita un disparador, éste sigue existiendo, pero al ejecutar una instrucción "insert", "update" o "delete" en la tabla, no se activa.
* Sintaxis para deshabilitar o habilitar un disparador:

```sql
--Deshabilitar un trigger:
DISABLE TRIGGER catalogo.trpuesto on catalogo.puesto;
GO

--Habilitar un trigger:
ENABLE TRIGGER catalogo.trpuesto on catalogo.puesto;
```
