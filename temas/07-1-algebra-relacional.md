# Tema 7. Álgebra relacional y SQL

### Tabla de contenido

* 7.Álgebra relacional y SQL
* 7.1 Selección
    * 7.1.1 Selección en SQL
* 7.2 Proyección
    * 7.2.1 Proyección en SQL
* 7.3 Operadores Unarios
* 7.4 Operadores Binarios
    * 7.4.1 Unión
        * 7.4.1.1 SQL - UNION
    * 7.4.2 Diferencia
        * 7.4.2.1 SQL - DIFERENCIA (except en SQL Server)
    * 7.4.3 Producto cartesiano
        * 7.4.3.1 SQL - PRODUCTO CARTESIANO
* 7.5 OPERADORES COMPUESTOS O DERIVADOS
    * 7.5.1 INTERSECCIÓN
        * 7.5.1. SQL – INTERSECCIÓN
* 7.6 Representación en teoría de conjuntos
* 7.7 Combinación o JOIN
    * 7.7.1 Tipos de JOIN

---

## 7. Álgebra relacional y SQL

* El aspecto dinámico del modelo relacional en lo que al álgebra se refiere, lo constituye una colección de operadores que, aplicados a las relaciones, dan como resultado nuevas relaciones (propiedad de cierre).
* Los operandos del álgebra son las relaciones y los operadores se aplican a las relaciones a fin de formular consultas a la BD.
* Son cinco los operadores que podríamos llamar básicos: los tradicionales de teoría de conjuntos unión, diferencia y producto cartesiano, y los especialmente introducidos por Codd de restricción y proyección; además, existen otros operadores que se pueden considerar derivados, ya que se pueden deducir de los básicos.

## 7.1 Selección

La restricción también llamada selección de una relación mediante una expresión lógica, da como resultado una nueva relación formada por el subconjunto de tuplas que satisface una expresión lógica. Se denota mediante la letra **σ**.

**σ Condicion_de_seleccion (nombre_de_relacion)**

**_Ejemplo_**: Dada la tabla AUTOR:

**_AUTOR_**

| Nombre | Nacionalidad | Institución |
| :--- | :--- | :--- |
| Pepe | España | O.N.U. |
| John | EE.UU. | O.M.S. |
| Pérez | España | I.N.I. |
| Suárez | España | I.N.E. |
| Pierre | Francia | N.A.S.A. |

Enunciado: Selección de los autores de nacionalidad española:

**σ Nacionalidad=”España” (AUTOR)**

| Nombre | Nacionalidad | Institucion |
| :--- | :--- | :--- |
| Pepe | España | O.N.U. |
| Pérez | España | I.N.I. |
| Suárez | España | I.N.E. |

### 7.1.1 Selección en SQL

| Sintaxis | Para el ejemplo: |
| :--- | :--- |
| `select <columna>`<br>`from tabla`<br>`where <condición>;` | `Select * from autor`<br>`where nacionalidad='ESPAÑA'` |

---

## 7.2 Proyección

La proyección de una relación sobre un _subconjunto de sus atributos_ es una nueva relación definida sobre ellos, pero incluyendo sólo algunas de las columnas, eliminando las tuplas duplicadas que hubieran podido resultar. Se denota mediante la letra **Π**.

**Π lista_de_atributos (nombre_de_relacion)**

**_Ejemplo_**: Para la tabla AUTOR, la proyección de nacionalidad e institución:

**Π nombre, Institucion (AUTOR)**

| Nacionalidad | Institucion |
| :--- | :--- |
| España | O.N.U. |
| EE.UU. | O.M.S. |
| España | I.N.I. |
| España | I.N.E. |
| Francia | N.A.S.A. |

### 7.2.1 Proyección en SQL

Extrae los atributos especificados de una relación dada.

| Sintaxis | Para el ejemplo: |
| :--- | :--- |
| `select <columna1>, <columna2>,...`<br>`from tabla;` | `Select nacionalidad,`<br>`institución`<br>`from autor;` |

---

## 7.3 Operadores Unarios

La selección y proyección son conocidos como **operadores unarios**, porque tienen como operando una única relación.

Es posible que deseemos aplicar varias operaciones de álgebra relacional una tras otra. Para ello:
1. podemos escribir las operaciones en una sola expresión del álgebra relacional, anidándolas, o bien,
2. podemos aplicar las operaciones una a una y crear relaciones intermedias.

En el siguiente ejemplo tendremos que nombrar las relaciones que contienen los resultados intermedios.

**_Ejemplo_**: Obtener el nombre e institución de los autores españoles podemos escribir:

**Π Nombre, Institucion ( σ Nacionalidad=”España” (AUTOR) )**

_O bien mostrar explícitamente la secuencia de operaciones dando un nombre a cada una de ellas._

**AUTOR_ESP** ← **σ Nacionalidad=”España” (AUTOR)**
**RESULTADO** ← **Π Nombre, Institucion (AUTOR_ESP)**

Autor = {idautor (pk), nombre, nacionalidad, institucion}
Resultado = {nombre, institucion, idautor int}

#### SQL

```sql
Select nombre, institución
from autor
where nacionalidad='ESPAÑA'
```
| Nombre | Nacionalidad | Institución |
| :--- | :--- | :--- |
| Pepe | España | O.N.U. |
| Pérez | España | I.N.I. |
| Suárez | España | I.N.E. |
---

## 7.4 Operadores Binarios

Los operadores binarios se aplican a **_dos relaciones_**, y algunos de ellos (unión, diferencia e intersección) exigen que las dos relaciones involucradas sean **_compatibles en sus esquemas_**, es decir, deben estar definidas sobre el mismo dominio, lo que no quiere decir que los nombres de los atributos sean los mismos.

### 7.4.1 Unión

La unión de dos relaciones _compatibles en su esquema_ es otra relación definida sobre el mismo esquema de relación cuya extensión estará constituida por las tuplas que pertenezcan a una de las dos relaciones o a ambas (se eliminarán las tuplas duplicadas puesto que se trata de una relación). Se denota mediante el símbolo **∪**

**Relacion1 ∪ Relacion2**

**_Ejemplo:_** Obtener el nombre, nacionalidad e institución de los autores y editores.

**Autor**
| Nombre | Nacionalidad | Institucion |
| :--- | :--- | :--- |
| John | EEUU | I1 |
| Juan | España | I2 |
| Pedro | España | I3 |
| Luigi | Italia | I4 |

**Editor**
| Nombre | Nacionalidad | Institucion |
| :--- | :--- | :--- |
| Juan | España | I2 |
| Chen | EEUU | I5 |
| Smith | EEUU | I6 |
| Pedro | España | I3 |

Autor = {nombre, nacionalidad, institución}
Editor = {nombre, nacionalidad, institución}

**Autor ∪ Editor**
| Nombre | Nacionalidad | Institucion |
| :--- | :--- | :--- |
| John | EEUU | I1 |
| Juan | España | I2 |
| Pedro | España | I3 |
| Luigi | Italia | I4 |
| Chen | EEUU | I5 |
| Smith | EEUU | I6 |

#### 7.4.1.1 SQL - UNION

Construye una relación formada por todas las tuplas que aparecen en las dos relaciones especificadas. Para realizar la unión, las columnas de ambas tablas deben ser compatibles en cuanto a número de columnas y mismo tipo de dato. Generalmente son conjuntos de la misma tabla, pero con condiciones diferentes.

| Sintaxis | Para el ejemplo: |
| :--- | :--- |
| `select <columna1, columna2>`<br>`from tabla1`<br>`union`<br>`select <columna1, columna2>`<br>`from tabla2;` | `Select nombre, nacionalidad, institucion`<br>`from autor`<br>`union`<br>`Select nombre, nacionalidad, institucion`<br>`from editores;` |

---

### 7.4.2 Diferencia

La diferencia de dos relaciones **_compatibles en su esquema_** es otra relación definida sobre el mismo esquema de la relación, cuya extensión estará constituida por el conjunto de tuplas que pertenezcan a la _primera relación_, pero _no a la segunda_. Se denota mediante el símbolo: **-**

**Relacion1 - Relacion2**

**_Ejemplo:_** la diferencia de dos relaciones

**Autor - Editor**
| Nombre | Nacionalidad | Institucion |
| :--- | :--- | :--- |
| John | EEUU | I1 |
| Luigi | Italia | I4 |

#### 7.4.2.1 SQL - DIFERENCIA (except en SQL Server)

Construye una relación formada por todas las tuplas de la 1ª relación que no aparezcan en la 2ª de las dos relaciones especificadas.

| Sintaxis | Para el ejemplo: |
| :--- | :--- |
| `select <columna>`<br>`from tabla1`<br>`minus / except`<br>`select <columna>`<br>`from tabla2;` | `Select nombre, nacionalidad, institucion`<br>`from autor`<br>`except`<br>`select nombre, nacionalidad, institucion`<br>`from editor;` |

---

### 7.4.3 Producto cartesiano

El producto cartesiano formado por A × B de 2 conjuntos A y B, es un nuevo conjunto integrado por parejas de elementos {x,y}, donde x es un elemento de A, y y es un elemento de B.

Sean dos conjuntos A = {1, 2, 3} y B = {7, 8}
A × B = {(1,7), (1,8), (2,7), (2,8), (3,7), (3,8)}

Producto cartesiano de dos relaciones de _cardinalidades m y n_ es una relación cuyo esquema estará definido sobre la unión de los atributos de ambas relaciones, y cuya extensión estará constituida por las m × n tuplas formadas concatenando cada tupla de la primera relación con cada una de las tuplas de la segunda. Se denota por la letra **×**.

**_Ejemplo_**: Socio × Libro

**Socio**
| Codigo | Nombre | Direccion |
| :--- | :--- | :--- |
| 1 | Elena | Madrid |
| 2 | Manuel | Bilbao |

**Libro**
| Libro | Autor | Editorial |
| :--- | :--- | :--- |
| BD | Gardarin | McGraw |
| INFORMIX | Zeroual | Ra-Ma |

**Socio × Libro**
| Código | Nombre | Direccion | Libro | Autor | Editorial |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | Elena | Madrid | BD | Gardarin | McGraw |
| 1 | Elena | Madrid | INFORMIX | Zeroual | Ra-Ma |
| 2 | Manuel | Bilbao | BD | Gardarin | McGraw |
| 2 | Manuel | Bilbao | INFORMIX | Zeroual | Ra-Ma |

#### 7.4.3.1 SQL - PRODUCTO CARTESIANO

En bases de datos el producto cartesiano de 2 relaciones A y B es una nueva relación formada por una combinación de todas las tuplas de A con cada una de las tuplas de B y sus atributos corresponden a los de A seguidos por los de B.

| Sintaxis | Para el ejemplo: |
| :--- | :--- |
| `select <columnaA>, <columnaB>,.. \| *`<br>`from <tabla1>, <tabla2>;`<br><br>`--CROSS JOIN`<br>`select {<column_name1>, <column_name2>,.. \| *}`<br>`from <table_name1> cross join <table_name2>...` | `Select * from socio, libro`<br><br>`Select * from socio cross join libro` |

---

## 7.5 OPERADORES COMPUESTOS O DERIVADOS

Los operadores derivados o compuestos son aquellos que se pueden expresar en función de operadores primitivos, pero su introducción tiene la simplificación de las consultas.

### 7.5.1 INTERSECCIÓN

La intersección de dos relaciones compatibles en su esquema, es otra relación definida sobre el mismo esquema de relación, cuya extensión estará constituida por las tuplas que pertenezcan a ambas relaciones. Se denota por la letra **∩**. Es el conjunto de elementos que aparecen en ambas relaciones.

**_Ejemplo:_**

**RelacionA ∩ RelacionB = RelacionA – (RelacionA – RelacionB)**

<img width="283" height="195" alt="Screenshot_22" src="https://github.com/user-attachments/assets/ff025136-ca98-4c5d-ab94-6ab492a43a27" />

**Autor**
| Nombre | Nacionalidad | Institucion |
| :--- | :--- | :--- |
| A1 | N1 | I1 |
| A2 | N2 | I2 |
| A3 | N3 | I3 |
| A4 | N4 | I4 |

**Editor**
| Nombre | Nacionalidad | Institucion |
| :--- | :--- | :--- |
| A2 | N2 | I2 |
| A5 | N1 | I5 |
| A6 | N1 | I6 |
| A3 | N2 | I3 |

**Autor ∩ Editor**
| Nombre | Nacionalidad | Institucion |
| :--- | :--- | :--- |
| A2 | N2 | I2 |
| A3 | N2 | I3 |

#### 7.5.1. SQL – INTERSECCIÓN

La intersección de dos relaciones específicas obtiene las tuplas que coinciden en ambas. A nivel de base de datos se obtienen los registros que aparecen en ambas tablas con valores idénticos. Usualmente son conjuntos de la misma tabla, pero con condiciones diferentes.

| Sintaxis | Para el ejemplo: |
| :--- | :--- |
| `select <columna>`<br>`from tabla1`<br>`Intersect`<br>`select <columna>`<br>`from tabla2;` | `Select nombre, nacionalidad, institucion`<br>`from autor`<br>`Intersect`<br>`Select nombre, nacionalidad, institucion`<br>`from editor` |

---

## 7.6 Representación en teoría de conjuntos

* **UNION:** Retorna todos los valores (eliminando duplicados).
* **UNION ALL:** Retorna todos los valores (incluyendo duplicados).
* **INTERSECT:** Retorna solo los valores que coinciden en ambos conjuntos.
* **MINUS (EXCEPT):** Retorna los valores del primer conjunto excluyendo los que existen en el segundo.

<img width="399" height="269" alt="Screenshot_23" src="https://github.com/user-attachments/assets/26c0a919-7265-445e-ac13-39d4849c1386" />

---

## 7.7 Combinación o JOIN

La combinación de dos relaciones respecto de sus columnas d y k es otra relación constituida por todos los pares de tuplas concatenadas, tales que, en cada par, las columnas d y k de las correspondientes tuplas satisfacen la condición especificada. Si la condición es de igualdad se denomina combinación por igualdad (_también se denomina equijoin o join_). Un join hace un producto cartesiano de sus dos argumentos y realiza una selección forzando la igualdad de atributos que aparecen en ambas relaciones. Elimina repetidos (como toda operación de conjuntos).

El operador Join realiza una unión de 2 relaciones aplicando un predicado _p_ para asociar las tuplas de A con las tuplas de B.

Este operador es fundamental en bases de datos para realizar consultas que actúan sobre un conjunto de tablas relacionadas entre sí. Existen varios tipos de Joins, mismos que se revisarán más adelante.

La llamada combinación natural (o join natural) es una combinación por igualdad donde se ha eliminado en la relación resultante uno de los atributos idénticos. Es el caso más utilizado de combinación para relaciones que tienen un atributo común (se suele hablar de join para referirse a esta posibilidad por ser el caso más usual).

<img width="380" height="57" alt="Screenshot_24" src="https://github.com/user-attachments/assets/4c89daed-f6bf-45b0-8e60-0fbb94a279e3" />

Combina la proyección, selección y producto cartesiano en una sola operación, donde la condición **θ** es la igualdad Clave Primaria = Clave Externa (o Foránea), y la proyección elimina la columna duplicada (clave externa).

Expresada en las operaciones básicas, queda:

**R ⋈ S = Π A1,A2...An ( σ θ (R × S) )**

Una reunión theta (θ-Join) de dos relaciones es equivalente a:
**R ⋈θ S = σ θ (R × S)**

donde la condición **θ** es libre. 

Si la condición **θ** es una igualdad se denomina EquiJoin.

**Ejemplo:** Obtener el nombre, nacionalidad, institución y libros escritos por los autores.

**Libro**
| Libro | Autor | Editorial |
| :--- | :--- | :--- |
| L1 | A1 | E1 |
| L2 | A4 | E2 |
| L3 | A1 | E1 |
| L4 | A2 | E3 |

**Π Nombre, Nacionalidad, Institucion, Libro, Editorial ( σ AUTOR.Nombre = LIBRO.Autor (AUTOR × LIBRO) )**

**Resultado JOIN**
| Nombre | Nacionalidad | Institucion | Libro | Editorial |
| :--- | :--- | :--- | :--- | :--- |
| A1 | N1 | I1 | L1 | E1 |
| A1 | N1 | I1 | L3 | E1 |
| A2 | N2 | I2 | L4 | E3 |
| A4 | N4 | I4 | L2 | E2 |

| Sintaxis estándar | Para el ejemplo: |
| :--- | :--- |
| `select ...`<br>`from <table-1> [inner \| natural \| cross]`<br>`join <table-2> [on <condition> \| using <column-name>,...],...` | `Select nombre, nacionalidad, institución, autor, editorial`<br>`from libro`<br>`JOIN autor on libro.autor=autor.nombre`<br><br>`Select nombre, nacionalidad, institución, autor, editorial`<br>`from libro`<br>`INNER JOIN autor on libro.autor=autor.nombre` |

---

### 7.7.1 Tipos de JOIN

Los datos se combinan relacionando valores comunes, regularmente de primary key y foreign key. Por lo tanto, se usan para combinar filas de dos o más tablas basándose en un campo común entre ellas, devolviendo así datos de diferentes tablas.

Existen más tipos de joins en SQL que los que aquí se explican, como CROSS JOIN, o SELF JOIN, pero no todos ellos están soportados por todos los sistemas de bases de datos. Los más importantes son los siguientes:

* **_INNER JOIN:_** Devuelve todas las filas cuando hay al menos una coincidencia en ambas tablas.
* **_LEFT JOIN:_** Devuelve todas las filas de la tabla de la izquierda, y las filas coincidentes de la tabla de la derecha.
* **_RIGHT JOIN:_** Devuelve todas las filas de la tabla de la derecha, y las filas coincidentes de la tabla de la izquierda.
* **_OUTER JOIN:_** Devuelve todas las filas de las dos tablas, la izquierda y la derecha. También se llama FULL OUTER JOIN.
