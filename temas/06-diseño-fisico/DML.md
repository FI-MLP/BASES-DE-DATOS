# 6.6 LENGUAJE DE MANIPULACIÓN DE DATOS DML 

### Contenido
* 6.6.1 Comando INSERT
* 6.6.2 Comando UPDATE
* 6.6.3 Comando DELETED
* 6.6.4 Control de transacciones
    * 6.6.4.1 Propiedades ACID
* 6.6.5 Niveles de aislamiento
    * 6.6.5.1 Terminología
    * 6.6.5.2 Lectura no confirmada
    * 6.6.5.3 Lectura confirmada
    * 6.6.5.4 Lectura repetible
    * 6.6.5.5 Nivel de aislamiento en serie
    * 6.6.5.6 Nivel de aislamiento instantáneo
* 6.6.6 Select

---

## 6.6 LENGUAJE DE MANIPULACIÓN DE DATOS DML
Nos permite acceder, agregar, modificar o eliminar los datos de un esquema de base de datos. Los comandos utilizados son:

* Insert - insertar,
* Update - actualizar,
* Delete - borrar y
* Select - consultar los datos de la base de datos.

### 6.6.1 Comando INSERT

Se emplea para agregar datos a una tabla en la base de datos, la sintaxis SQL estándar es:

```sql
INSERT INTO <nombreTabla> [(campo1 [, campo2, ...])]
VALUES (valor1, valor2 | <expresion> | null | default, ......) |
<select-statement>;
```

O bien:

```sql
INSERT INTO <nombreTabla>
VALUES (valor1, valor2, ...);
```

También se puede realizar un INSERT obteniendo los datos a almacenar en la base de datos con el resultado de una consulta (SELECT):

```sql
INSERT INTO <nombreTabla> [(campo1 [,campo2, ...])]
SELECT <columna1, columna2, ...>
FROM <nombreTabla>
```

* Los valores de tipo fecha o caracteres se deben encerrar entre comillas simples ('').
* Los valores insertados deben ser de un tipo compatible con el de las columnas de la tabla.

**Ejemplo**: De acuerdo al siguiente modelo, genere la instrucción para almacenar un registro en la tabla empleado.

<img width="656" height="259" alt="Screenshot_19" src="https://github.com/user-attachments/assets/699bd162-e8e8-44f8-8608-076742047413" />

**Sin encabezados**

```sql
insert into empleado
values( 1 , null, 'GOMEZ', 'FLORES', 'ERNESTO', 'JUIO740823HYTER65Y', '28/06/1974', 2 );
```

* En este caso debemos tener cuidado de colocar los valores según el orden correspondiente en la tabla, es decir, el orden en que se definieron los campos al crear la tabla. Esto debido a que decimos realizar la instrucción insert sin encabezados.
* Adicionalmente, se deben especificar todos los valores de los campos, si son opcionales, es decir NUL, se tiene que escribir la palabra “null” para indicarle al manejador la ausencia de dicho valor.

**Con encabezados (forma recomendada)**

```sql
insert into empleado (id_empleado, paterno, materno, nombre, fechanacimiento, id_puesto, curp)
values( 1 , 'GOMEZ', 'FLORES', 'ERNESTO', '28/06/1974', 2 , 'JUIO740823HYTER65Y');
```

* Para este caso es necesario solamente especificar el valor de las columnas definidas como not NULL.
* Para el caso de los campos NULL simplemente se omite le nombre del campo en la lista.

**Insert con select**

Si quisiéramos insertar información de otra tabla, por ejemplo, a un histórico, podríamos hacer lo siguiente:

```sql
insert into empleado_historico
select * from empleado where id_empleado= 230
```

---

### 6.6.2 Comando UPDATE

Se emplea para modificar los datos existentes en una tabla de uno o más campos asociados a uno o más registros, su sintaxis SQL estándar es la siguiente:

```sql
UPDATE <nombre tabla> SET
{<columna> = <literal> | <expresión> | <single-row-select-statement> [, ...]
| {(<lista-de columnas>) | *} = (<lista de expresiones>) }
[WHERE <condición>]
```

* De acuerdo a la sintaxis, el valor del campo a actualizar puede ser un valor fijo (literal).
* El valor también puede ser determinado a través de una expresión aritmética, booleana, a partir del resultado de la invocación de una función, o el resultado de un subquery (single row select statement). Subquery es subconsulta SELECT entre paréntesis, cuyo resultado es un único dato de una sola columna (un único valor simple).
* La lista de columnas está formada por aquellas columnas a las cuales se les modificará su valor.
* Si se omite la cláusula WHERE entonces se actualizan **_todos los datos_** de la tabla.

**Ejemplo:** Actualice el sueldo del empleado con id_empelado 450 a $35,000.

<img width="792" height="300" alt="Screenshot_20" src="https://github.com/user-attachments/assets/061b3727-e0f2-47ee-9df3-950842ce988f" />

```sql
update empleado
set sueldo= 35000
where id_empleado= 450 ;
```

**Ejemplo**: Actualizar el puesto del empleado Luis Solano Huerta de jefe de departamento a director general.

```sql
update empleado
set id_puesto = (select id_puesto from puesto where descripcion='DIRECTOR GENERAL' )
where nombre='LUIS' and apellido_paterno='SOLANO' and apellido_materno='HUERTA';
```

**Ejemplo**: El empleado cuyo RFC=JUBM801103 es ahora jefe, se requiere reflejar los cambios en la base de datos. Adicionalmente se requiere corregir su fecha de nacimiento al 11-01-1980.

```sql
update empleado
set idempleado_jefe =null, fecha_nacimiento = '1980- 11 - 02'
where curp='JUBM801103';
```

---

### 6.6.3 Comando DELETED

Permite eliminar los registros de una tabla. Su sintaxis SQL server es la siguiente:

```sql
delete from <nombre tabla>
[where <condición>]
```

* Delete borra únicamente los registros de una sola tabla a la vez a excepción de que exista la cláusula on delete cascade en la definición de las tablas involucradas.
* Si no se pone condición, se borran todos los datos de la tabla.

**Ejemplo: Eliminar todos los dependientes del empleado Juan Martínez Flores**

<img width="620" height="342" alt="Screenshot_21" src="https://github.com/user-attachments/assets/6235563d-55b6-42fe-82bc-f1b5b8fc5ca9" />


```sql
delete from dependiente
where id_empleado= (select id_empleado from empleado
where nombre='JUAN' and paterno='MARTINEZ' and materno='FLORES' );
```

---

### 6.6.4 Control de transacciones

Una transacción se define como un conjunto de operaciones sobre la base de datos. Unidad básica de procesamiento de datos que puede ejecutarse de forma confiable y consistente.

Las transacciones proporcionan mayor flexibilidad y control cuando los datos cambian y ello asegura la consistencia de los datos en el caso de un fallo en el proceso del usuario o del sistema.

**Consistencia de una Base de datos.**

Una base de datos se encuentra en un estado consistente si todas las restricciones y reglas de integridad definidas en ella se cumplen.

El estado de una base de datos cambia al realizar operaciones de insert, update, delete.

Para garantizar integridad, la base de datos no debería encontrarse en estado inconsistente.

Sin embargo, la base de datos adquiere un estado de inconsistencia durante la ejecución de una Transacción, pero al terminarla debe recuperar el estado consistente.

#### 6.6.4.1 Propiedades ACID

Conjunto de características necesarias para que una serie de instrucciones puedan ser consideradas como una transacción.

* Atomicidad. Se ejecutan todas sus operaciones o ninguna.
* Consistencia. La base de datos debe pasar de un estado consistente a otro estado consistente (se cumplen todas las restricciones de integridad).
* Aislamiento. Una transacción no debe hacer visibles sus cambios a otras transacciones hasta que sea confirmada.
* Durabilidad. Cuando una transacción es confirmada sus cambios deben ser grabados en la base de datos y no deben perderse debido a fallos de otras transacciones o del sistema.

Una transacción comienza cuando se encuentra la primera sentencia DML y termina cuando ocurre alguno de los siguientes eventos:

* Se emite una sentencia de control de transacciones (COMMIT o ROLLBACK)
* Se emite una sentencia DDL, como CREATE
* Se emite una sentencia DCL
* El usuario sale de SQL

**_COMMIT_**

* Este comando da por concluida la transacción actual y hace definitivos los cambios realizados.
* Sólo después de que se ejecute COMMIT tendremos acceso a los datos modificados.

**_AUTOCOMMIT_**

* El comando AUTOCOMMIT puede ser habilitado o deshabilitado.
* Si se habilita, cada sentencia DML individual es cometida e inmediatamente es ejecutada.
* No se pueden deshacer estos cambios.
* Si se deshabilita la sentencia, COMMIT debe ser usada explícitamente.

**_ROLLBACK_**

* Este comando da por concluida la transacción actual y deshace los cambios que se pudiesen haber producido en la misma.
* Se utiliza especialmente cuando no se puede concluir una transacción porque se han levantado excepciones.

**_ROLLBACK implícito,_** este comando se ejecuta cuando:

* Un programa almacenado (procedimiento o función) falla y no se controla la excepción que produjo el fallo. Si en el programa tenemos un COMMIT estos cambios no serán deshechos.
* Terminación anormal de Transac SQL
* Fallo del sistema

##### SAVEPOINT

* Es una marca que divide una transacción en secciones más pequeñas.
* Se utiliza junto con ROLLBACK permitiendo deshacer cambios hasta los SAVEPOINT.
* El número de SAVEPOINT está limitado a 5 por sesión pero lo podemos modificar con la siguiente sentencia:

```sql
SAVEPOINT <número>;
```

Al ejecutar **COMMIT**

* Los cambios de datos son escritos en la base de datos
* El estado previo de los datos se pierde permanentemente
* Todos los usuarios pueden ver los resultados de la transacción
* Los bloqueos en las filas afectadas son liberados; las filas están ahora disponibles para que otros usuarios realicen nuevos cambios a los datos
* Todos los SAVEPOINT son borrados

##### ROLLBACK TRAN / TO

* Deshace el trabajo realizado después del punto indicado. Pero no se confirma el trabajo hecho hasta el SAVEPOINT.
* La transacción no finaliza hasta que se ejecuta un comando de control de transacciones o hasta que finaliza la sesión.
* Antes de usar las sentencias COMMIT o ROLLBACK
* El estado previo de los datos se puede recuperar.
* El usuario actual puede revisar los resultados de las operaciones DML.
* Otros usuarios no pueden ver los resultados de las operaciones DML hechas por el usuario actual.
* Las filas afectadas son bloqueadas; otros usuarios no pueden cambiar los datos de las filas afectadas.

##### ROLLBACK TRANSACTION

* SQL Server implementa SAVEPOINT implícitos
* Si una simple sentencia DML falla durante su ejecución, sólo a esta sentencia se le realiza un ROLLBACK. Todos los otros cambios no son desechos
* El usuario puede terminar sus transacciones explícitamente ejecutando COMMIT o ROLLBACK

**Ventajas del uso de transacciones**

* Asegurar la consistencia de datos
* Ver previamente los cambios de los datos antes de hacerlos permanentes
* Agrupar operaciones lógicamente relacionadas

---

### 6.6.5 Niveles de aislamiento

El comportamiento de aislamiento de una transacción puede optimizarse para las necesidades de la aplicación, al establecer el nivel de aislamiento de una transacción, los niveles de aislamiento determinan la manera en que se comportan las transacciones concurrentes.

```sql
SET TRANSACTION ISOLATION LEVEL
  { READ UNCOMMITTED
  | READ COMMITTED
  | REPEATABLE READ
  | SNAPSHOT
  | SERIALIZABLE
  }
```

SQL server soporta 5 niveles de aislamiento:

* Lectura no confirmada
* Lectura confirmada
* Lectura repetible
* Instantáneas
* En serie

El nivel de aislamiento predeterminado es "Lectura confirmada". Sin embargo, se puede modificar desde la ventana de consulta y desde las herramientas de Management Studio.

#### 6.6.5.1 Terminología

**Lectura sucia:** lectura de datos que aún no se ha confirmado, esto ocurre cuando la transacción A bloquea a la B, pero se ha optimizado el comportamiento de aislamiento, por lo que la transacción B termina leyendo los cambios de la transacción A, aunque no se hayan confirmado.

**Lectura no repetible:** condición en que la transacción B modifica los datos con los que está trabajando la transacción A durante el tiempo de vida de ésta. Como resultado, la transacción lee datos modificados, y no puede repetirse la lectura original.

**Lectura fantasma:** igual que una lectura no repetible, excepto por el número de cambios en filas entre dos lecturas dentro de la misma transacción. Las filas diferentes entre las dos lecturas se consideran filas fantasma.

#### 6.6.5.2 Lectura no confirmada

Las transacciones que se ejecutan en este nivel no emiten bloqueos compartidos para impedir que otras transacciones modifiquen los datos leídos por la transacción actual. Además, las transacciones no se bloquean con bloqueos exclusivos al modificar los datos, lo que permite que otras transacciones lean los datos modificados que aún no se han confirmado.

Se indica a la base de datos que viole todos los bloqueos al estado inmediato actual de los datos. Al hacerlo así tal vez terminemos con una lectura sucia (leyendo datos que no se han confirmado).
Ejemplo:

1. Abra dos instancias de SQL Server
2. En ambas use su base de datos
3. En la instancia 1 ejecute la siguiente instrucción:

```sql
Begin tran

  UPDATE catalogo.concepto
  SET descripcion='CONCEPTO MODIFICADO'
  WHERE ID_CONCEPTO= 6
```

4. En la segunda instancia ejecute la siguiente consulta:

```sql
SELECT * FROM catalogo.concepto WHERE id_concepto= 6
```

¿Qué sucede?

Al menos que se emita un COMMIT o un ROLLBACK en la instancia 1 la consulta de la instancia 2 estará bloqueada

5. En la segunda instancia, cancele la consulta con Alt+Esc. Ejecute el siguiente comando para establecer el nivel de aislamiento de la consulta para lectura no confirmada en la conexión mantenida en la instancia 2.

```sql
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
```

6. Ejecute de nuevo la consulta (en la instancia 2):

```sql
SELECT * FROM catalogo.concepto WHERE id_concepto= 6
```

7. Regrese a la instancia 1 y emita ROLLBACK
8. Vaya de nuevo a la instancia 2, ejecute de nuevo la consulta SELECT y vea el resultado

#### 6.6.5.3 Lectura confirmada

Es el nivel predeterminado de SQL Server, porque representa la mejor relación entre integridad de datos y desempeño, respeta los bloqueos y evita las lecturas sucias. En el ejemplo hasta que solicitamos explícitamente que el nivel cambiara a lectura no confirmada. Por lo tanto nuestra segunda transacción la que se solicitó en modo auto confirmación en la consulta SELECT fue bloqueado por la transacción que ejecutó la transacción UPDATE.

#### 6.6.5.4 Lectura repetible

Especifica que las instrucciones no pueden leer datos que han sido modificados, pero aún no confirmados por otras transacciones y que ninguna otra transacción puede modificar los datos leídos por la transacción actual hasta que ésta finalice. Debido a que los bloqueos compartidos se mantienen hasta el final de la transacción en lugar de liberarse al final de cada instrucción, la simultaneidad es inferior que en el nivel de aislamiento predeterminado READ COMMITTED. Utilice esta opción solamente cuando sea necesario.

#### 6.6.5.5 Nivel de aislamiento en serie

No permite lecturas sucias, fantasmas ni no repetibles, coloca los bloqueos más restrictivos en los datos que se leen o modifican, manteniendo sus datos perfectamente limpios, las transacciones bloquearan otras transacciones en ejecución, afectando el desempeño concurrente o aun la creación de puntos muertos por lo que afecta el rendimiento del sistema.

#### 6.6.5.6 Nivel de aislamiento instantáneo

En todos los niveles de aislamiento descritos anteriormente parece que estamos cambiando el rendimiento concurrente por la santidad lógica de los datos, debido a que una transacción bloque los dato con los que se está trabajando, se bloquen otras transacciones que tratan de trabajar con los mismos datos, hasta que la primera transacción se confirma o se revierte, ninguna de estas permite leer datos lógicamente consistentes, mientras ofrece comportamiento concurrente de no bloqueo.

No crea bloqueos compartidos en las filas que se están leyendo. Especifica que los datos leídos por cualquier instrucción de una transacción serán la versión coherente, desde el punto de vista transaccional, de los datos existentes al inicio de la transacción. La transacción únicamente puede reconocer las modificaciones de datos confirmadas antes del comienzo de la misma. Las instrucciones que se ejecuten en la transacción actual no verán las modificaciones de datos efectuadas por otras transacciones después del inicio de la transacción actual. Esto suena lo mejor de ambos mundos: la capacidad de respuesta de la lectura no confirmada con la consistencia de la lectura repetible. Esto se configura en la base de datos tempdb, el problema es el aumento de la sobrecarga en la base de datos tempdb.

---

### 6.6.6 Select

Para recuperar la información guardada en una base de datos utilizamos el comando SELECT.

```sql
SELECT [ALL | DISTINCT | UNIQUE ] [<tabla|aliasTabla>.] <columna1> [AS
<nombreColumna>]
[, [<tabla|aliasTabla>.]< columna2> [AS <nombreColumna>]...., |*]
FROM [<nombreBasedeDatos>] Tabla [<aliasTabla>]
[WHERE <condición>]
```

Las columnas ambiguas (iguales) se preceden del nombre de la tabla: `<tabla>.<columna>` o de un sobrenombre corto para la tabla `<aliasTabla>.<columna>`

* **AS** Se usa para cambiar el nombre de una columna del conjunto de resultados o para asignarle un nombre a una columna derivada.
* El `*` hace referencia a todas las columnas de la tabla.
* Cláusula **FROM** permite indicar las tablas que contienen los datos.

```sql
FROM {<nombre de tabla> [alias de tabla] } [,...]
```

```sql
<alias de tabla>: Es un sinónimo activo sólo en el ámbito de la sentencia SELECT.
```

* Cláusula **WHERE** sirve para indicar la condición que deben cumplir las filas resultantes.

```sql
WHERE <condición>
```

Una condición está formada por una o varias expresiones condicionales conectadas por los operadores lógicos AND, OR y NOT. Una expresión condicional tiene la forma siguiente:

Expresión de comparación:

```sql
<expresión1> <operador relacional> <expresión2>
```

Verifica si las dos expresiones satisfacen la comparación.
