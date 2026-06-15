# Syllabus Oficial - Bases de Datos (Clave 1644)

**Semestre:** 2026 - 2  
**Contacto:** M.I.A Martha López Pelcastre (martha.lopez@ingenieria.unam.edu)

---

## 1. Objetivo
El alumno analizará los conceptos y principios en los que se fundamenta la teoría de bases de datos, los cuales le permitirán analizar, diseñar, usar e implementar sistemas de bases de datos relacionales.

## 2. Mapa Curricular
Denominación de la asignatura: Base de Datos 1644, sexto semestre plan 2023.
<img width="800" height="1114" alt="computacion_2016" src="https://github.com/user-attachments/assets/825bff1d-cee0-4cfd-8d68-9cc9c9a0fac7" />


---

## 3. Temario del Curso

### 1 Introducción a las Bases de Datos
**Objetivo:** El alumno explicará y comprenderá los conceptos fundamentales que sustentan el diseño e implementación de las bases de datos, comprenderá la evolución de diversos modelos de datos y el uso de metodologías para su implementación.

**Contenido:**
* 1.1 Datos e Información
  * 1.1.1 Concepto de Dato
  * 1.1.2 Definición y características de la Información
* 1.2 Bases de Datos y Sistema Administrador de Bases de Datos
  * 1.2.1 Definición de Base de Datos
  * 1.2.2 Definición y características de un Sistema Administrador de Bases de Datos
  * 1.2.3 Arquitectura básica y general de una Base de Datos.
  * 1.2.4 Seguridad de la base de datos
    * 1.2.4.1 Roles y privilegios
  * 1.2.5 Tipos de Bases de Datos
* 1.3 Integridad, redundancia e Inconsistencia de datos.
  * 1.3.1 Redundancia de datos.
  * 1.3.2 Inconsistencia de datos
  * 1.3.3 Integridad de datos.
* 1.4 Sistemas de Bases de Datos
  * 1.4.1 Requerimientos para implementar un sistema de base de datos
    * 1.4.1.1 Hardware
    * 1.4.1.2 Software
    * 1.4.1.3 Roles del personal asociado con una Base de datos.
* 1.5 Modelos de Datos
  * 1.5.1 Sistemas de archivos
  * 1.5.2 Modelos Jerárquicos
  * 1.5.3 Modelos de Red
  * 1.5.4 Modelo relacional (RDBMS)
  * 1.5.5 Modelo Entidad – Relación
    * 1.5.5.1 Entidades
    * 1.5.5.2 Atributos
    * 1.5.5.3 Relaciones entre entidades
      * 1.5.5.3.1 Relación Uno a Uno
      * 1.5.5.3.2 Relación Uno a Muchos
      * 1.5.5.3.3 Relación Muchos a Muchos
    * 1.5.5.4 Reglas de negocio.
  * 1.5.6 Modelo Objeto/Relacional (ORDBMS)
* 1.6 Metodologías empleadas en el diseño de bases de datos.
  * 1.6.1 Análisis de requerimientos
  * 1.6.2 Modelo Conceptual
  * 1.6.3 Modelo lógico
  * 1.6.4 Modelo físico

### 2 Diseño Conceptual de una Base de Datos
**Objetivo:** El alumno comprenderá y aplicará conceptos y técnicas para construir modelos Entidad/Relación como parte del diseño conceptual de una Base de Datos. Comprenderá el uso de herramientas CASE empleadas en el modelado de bases de datos.

**Contenido:**
* 2.1 Definición de Modelo Entidad/Relación
  * 2.1.1 Notación propuesta por Peter P. Chen
* 2.2 Representación de Entidades
* 2.3 Representación de atributos
  * 2.3.1 Clave principal
  * 2.3.2 Claves candidatas
  * 2.3.3 Claves débiles
  * 2.3.4 Atributos obligatorios y opcionales
  * 2.3.5 Atributos Simples y Compuestos
  * 2.3.6 Atributos de valor simple y de valores múltiples (multivaluados)
  * 2.3.7 Atributos derivados.
* 2.4 Representación de relaciones
  * 2.4.1 Relación Uno a Uno
  * 2.4.2 Relación Uno a Muchos
  * 2.4.3 Relación Muchos a Muchos
  * 2.4.4 Relaciones Unarias o recursivas.
    * 2.4.4.1 Atributos de una relación Muchos a Muchos
* 2.5 Representación de relaciones de agregación.
* 2.6 Representación de cardinalidades en una relación
* 2.7 Dependencia e Independencia de existencia
* 2.8 Participación de una entidad en una relación
  * 2.8.1 Participación opcional
  * 2.8.2 Participación obligatoria.
* 2.9 Dependencia de Identificación
* 2.10 Diseño conceptual extendido de una base de datos.
  * 2.10.1 Jerarquías de tipos.
    * 2.10.1.1 Supertipo y Subtipo
    * 2.10.1.2 Generalización
    * 2.10.1.3 Especialización
    * 2.10.1.4 Relación de exclusión o de traslape
    * 2.10.1.5 Relación parcial o total
    * 2.10.1.6 Discriminate(s) de subtipo
* 2.11 Modelado conceptual de atributos con histórico
* 2.12 Relaciones exclusivas

### 3. Modelo Relacional
**Objetivo:** El alumno explicará y comprenderá las características y elementos que integran al Modelo Relacional aplicados al diseño lógico de bases de datos.

**Contenido:**
* 3.1 Características del modelo relacional
* 3.2 Elementos del modelo relacional
* 3.3 Estructura lógica de los datos
  * 3.3.1 Relación
  * 3.3.2 Tupla
  * 3.3.3 Atributo
  * 3.3.4 Cardinalidad
  * 3.3.5 Grado
  * 3.3.6 Dominio
* 3.4 Reglas de integridad o restricciones
  * 3.4.1 Restricción de Llave Primaria
    * 3.4.1.1 Tipos de Llaves primarias
      * 3.4.1.1.1 Llaves primarias naturales
      * 3.4.1.1.2 Llaves primarias candidatas
      * 3.4.1.1.3 Llaves primarias compuestas
      * 3.4.1.1.4 Llaves primarias artificiales o subrogadas.
    * 3.4.1.2 Determinación de la llave primaria
      * 3.4.1.2.1 Concepto de Dependencia funcional
      * 3.4.1.2.2 Requisitos funcionales.
      * 3.4.1.2.3 Requisitos no funcionales.
  * 3.4.2 Restricción de Referencia
    * 3.4.2.1 Concepto de Llave foránea
  * 3.4.3 Restricciones de Integridad
    * 3.4.3.1 Restricciones tipo UNIQUE
    * 3.4.3.2 Restricciones tipo CHECK
    * 3.4.3.3 Restricciones NULL, NOT NULL
    * 3.4.3.4 Validación a través del uso de un Trigger.
* 3.5 Reglas de Codd
* 3.6 Importancia de los índices en el diseño de una base de datos.
  * 3.6.1 Consideraciones de diseño para indexar atributos.
  * 3.6.2 Tipos de índices
    * 3.6.2.1 Índices Hash
    * 3.6.2.2 Índices B Tree.

### 4 Diseño Lógico de una Base de Datos.
**Objetivo:** El alumno realizará la construcción de Modelos Relacionales a partir de modelos Entidad/Relación, haciendo uso de conceptos, principios y buenas prácticas, para obtener el diseño lógico de la base de datos. Comprenderá el uso de herramientas CASE empleando diversas notaciones.

**Contenido:**
* 4.1 Formatos de representación
  * 4.1.1 Formato Crow’s foot
* 4.2 Transformación de Entidades y atributos al modelo relacional
  * 4.2.1 Transformación de claves principales a Llaves primarias
* 4.3 Transformación de relaciones.
  * 4.3.1 Transformación de relaciones Uno a Uno
  * 4.3.2 Transformación de relaciones Uno a Muchos
  * 4.3.3 Transformación de relaciones Muchos a Muchos.
  * 4.3.4 Transformación de relaciones Unarias.
* 4.4 Transformación de relaciones de agregación.
* 4.5 Representación de cardinalidades
* 4.6 Transformación de una dependencia de identificación
* 4.7 Transformación de Relaciones Supertipo – Subtipo
  * 4.7.1 Transformación de relaciones de exclusión o de traslape
  * 4.7.2 Transformación de relaciones parciales y totales.
  * 4.7.3 Transformación de discriminantes al modelo relacional.
* 4.8 Transformación de atributos con histórico
* 4.9 Transformación de relaciones de exclusividad.
* 4.10 Importancia de los tipos de datos estándar en el diseño lógico de una base de datos.
* 4.11 Diseño lógico de indexado de una base de datos.

### 5 Normalización
**Objetivo:** El alumno comprenderá y aplicará los conceptos del proceso de Normalización de Bases de Datos con la finalidad de implementar mejores diseños, estableciendo un equilibrio entre los niveles de redundancia y desempeño establecidos en los requerimientos no funcionales de casos de estudio.

**Contenido:**
* 5.1 Proceso de Normalización
* 5.2 Ventajas y desventajas del proceso de Normalización
  * 5.2.1 Redundancia contra Desempeño
* 5.3 Aplicación de la Primera Forma Normal (1FN)
  * 5.3.1 Identificación de grupos de repetición
  * 5.3.2 Identificación de la llave primaria
  * 5.3.3 Identificación de relaciones parciales
  * 5.3.4 Identificación de relaciones transitivas
  * 5.3.5 Notaciones empleadas en el proceso de Normalización
    * 5.3.5.1 Diagramas de Dependencias
    * 5.3.5.2 Notación de dependencia funcional.
* 5.4 Aplicación de la Segunda Forma Normal (2FN)
* 5.5 Aplicación de la Tercera Forma Normal (3FN)
* 5.6 Aplicación de formas normales de orden superior
  * 5.6.1 Forma Normal Boyce-Cood
  * 5.6.2 Aplicación de la Cuarta Forma Normal 4FN)
  * 5.6.3 Aplicación de la Quinta Forma Normal (5FN)
* 5.7 Construcción de Modelos Relacionales a partir de un proceso de normalización.
* 5.8 Proceso de denormalización.
  * 5.8.1 Ventajas y desventajas.

### 6 Diseño Físico de una Base de Datos
**Objetivo:** El alumno comprenderá y aplicará los elementos necesarios para la implementación física del diseño lógico de la base de datos a través del lenguaje SQL, así como la manipulación y uso de transacciones a través de sentencias.

**Contenido:**
* 6.1 Introducción al lenguaje SQL
* 6.2 Breve historia del lenguaje SQL
* 6.3 Características principales del lenguaje SQL
* 6.4 Categorías del lenguaje SQL
* 6.5 Lenguaje De Definición De Datos (DDL)
  * 6.5.1 Creación de tablas y atributos
  * 6.5.2 Clasificación de tablas
    * 6.5.2.1 Tablas permanentes
    * 6.5.2.2 Tablas temporales
    * 6.5.2.3 Tablas externas
  * 6.5.3 Valores por default
  * 6.5.4 Creación de Restricciones
    * 6.5.4.1 Restricciones a nivel columna
    * 6.5.4.2 Restricciones a nivel tabla.
    * 6.5.4.3 Restricciones de borrado.
  * 6.5.5 Generación de valores secuenciales
  * 6.5.6 Índices
    * 6.5.6.1 Índices tipo non unique
    * 6.5.6.2 Índices tipo Unique
    * 6.5.6.3 Índices compuestos.
    * 6.5.6.4 Índices basados en funciones.
  * 6.5.7 Sinónimos
    * 6.5.7.1 Sinónimos públicos
    * 6.5.7.2 Sinónimos privados
  * 6.5.8 Creación de Vistas simples
  * 6.5.9 Modificación de la estructura de una base de datos
    * 6.5.9.1 Instrucción ALTER
    * 6.5.9.2 Instrucción DROP
* 6.6 Lenguaje De Manipulación De Datos (DML)
  * 6.6.1 Instrucción INSERT
  * 6.6.2 Instrucción UPDATE
  * 6.6.3 Instrucción DELETE
  * 6.6.4 Instrucción MERGE
  * 6.6.5 Introducción al Manejo transaccional con operaciones DML y DDL
    * 6.6.5.1 Definición de una transacción
    * 6.6.5.2 Control transaccional
      * 6.6.5.2.1 Instrucción COMMIT
      * 6.6.5.2.2 Instrucción ROLLBACK
      * 6.6.5.2.3 Instrucción SAVEPOINT
    * 6.6.5.3 Propiedades ACID de las transacciones
      * 6.6.5.3.1 Atomicidad
      * 6.6.5.3.2 Consistencia
      * 6.6.5.3.3 Aislamiento
      * 6.6.5.3.4 Durabilidad
    * 6.6.5.4 Niveles de Aislamiento
      * 6.6.5.4.1 Lecturas confirmadas
      * 6.6.5.4.2 Lecturas repetibles
      * 6.6.5.4.3 Lecturas serializables
    * 6.6.5.5 Control de concurrencia
      * 6.6.5.5.1 Control de concurrencia pesimista
      * 6.6.5.5.2 Control de concurrencia optimista.

### 7 Lenguaje de Consulta de Datos (DQL)
**Objetivo:** El alumno comprenderá los conceptos teóricos y prácticos que le permitirán realizar el acceso y consulta de datos a través del uso de sentencias del lenguaje SQL, así como las diferentes estrategias de acceso a datos.

**Contenido:**
* 7.1 Instrucción SELECT
  * 7.1.1 Instrucción DISTINCT
  * 7.1.2 Instrucción ORDER BY
* 7.2 Literales, expresiones y alias en columnas.
* 7.3 Tablas de apoyo
* 7.4 Álgebra Relacional
  * 7.4.1 Introducción al álgebra relacional
  * 7.4.2 Principales operaciones y operadores del Álgebra Relacional
    * 7.4.2.1 Selección
    * 7.4.2.2 Proyección
    * 7.4.2.3 Unión
    * 7.4.2.4 Intersección
    * 7.4.2.5 Diferencia
    * 7.4.2.6 Producto
    * 7.4.2.7 Join
  * 7.4.3 Transformación de expresiones de Álgebra Relacional a SQL y viceversa.
* 7.5 Joins
  * 7.5.1 Inner Join
  * 7.5.2 Outer Join
  * 7.5.3 Cross Join
  * 7.5.4 Sintaxis estándar para Joins
  * 7.5.5 Sintaxis anterior para Joins.
* 7.6 Operadores SQL
  * 7.6.1 Aritméticos
  * 7.6.2 Lógicos
    * 7.6.2.1 all, any, some,
    * 7.6.2.2 and, or, not
    * 7.6.2.3 between, exists, like
* 7.7 Funciones de agregación
  * 7.7.1 Instrucción group by
  * 7.7.2 Instrucción Having
* 7.8 Subconsultas
  * 7.8.1 Definición de subconsultas
  * 7.8.2 Tipos de subconsultas
    * 7.8.2.1 Subconsultas en la cláusula SELECT
    * 7.8.2.2 Subconsultas en la cláusula FROM
    * 7.8.2.3 Subconsultas en la cláusula JOIN
    * 7.8.2.4 Subconsultas en la cláusula WHERE
    * 7.8.2.5 Subconsultas en la cláusula HAVING
    * 7.8.2.6 Subconsultas correlacionales.

### 8 Introducción a la programación en Base de Datos
**Objetivo:** El alumno explicará el uso de las extensiones de la base de datos y aplicará los elementos necesarios para la creación de programas en lenguaje procedural para procesar y gestionar la información contenida en la base de datos.

**Contenido:**
* 8.1 Características de los lenguajes de programación en la base de datos
  * 8.1.1 Extensiones SQL en el manejador de bases de datos
  * 8.1.2 Posibilidad de uso de otros lenguajes dentro de la base de datos
* 8.2 Elementos básicos de programación
  * 8.2.1 Declaración e inicialización de variables
  * 8.2.2 Estructuras de control
  * 8.2.3 Cursores
* 8.3 Manejo de errores
* 8.4 Funciones
* 8.5 Procedimientos Almacenados
* 8.6 Triggers
  * 8.6.1 Triggers DML simples
  * 8.6.2 Triggers DML compuestos
  * 8.6.3 Triggers tipo Instead Of

---

## 4. Software a utilizar
* Manejador de base de datos: SQL Server 2022
* Herramienta CASE: ER/Studio o Erwin
* Diagramador: DIA

## 5. Reglas
* Leer el material proporcionado previamente a la clase
* Humildad, respeto y honestidad
* Requerido 80% de asistencia a clase (de no ser así deberá presentar examen final). Si el día que se pase lista el alumno no está pierde el 80 % de asistencia. Al menos que justifique con antelación su inasistencia.
* Participación
  * Crítica de calidad, que aporte
  * Trabajo en equipo
* Horario: Martes, jueves y viernes 7:00 – 9:00

## 6. Tareas, trabajos y ejercicios
Tanto las tareas, como trabajos y ejercicios deberán contener una portada con la siguiente información:
* Materia
* Nombre del profesor
* Grupo
* Fecha de Entrega
* Número de lista, número de cuenta y nombre del alumno empezando por apellido
* Tema (ejemplo: Tema 2. Modelo conceptual)
* ¿Qué es? (Tarea o ejercicio) y número de éste (ejemplo: Tarea 1. Mapa conceptual)
* Enunciado de lo que trata el entregable (indicaciones de la tarea)

Todo se entrega en formato pdf, además de los archivos solicitados por la profesora. Si no se entregan los archivos la tarea se califica con 0.

## 7. Sistema de Evaluación
* Examen Parciales 40 %
* Laboratorio 20%
* Tareas y Ejercicios 15 %
* Proyecto Final 15%
* Exposición 10 %

**Exentos**
* Aprobar todos los exámenes parciales
* Entregar proyecto final
* Realizar exposición
* Mínimo 80 % de asistencias

**Primer examen final**

Para poder presentar primer examen final deberá haber entregado el proyecto final.
La calificación final se formará de la siguiente forma; 70% calificación del examen final, 30% promedio del semestre.

**Segundo examen final**

Tener como mínimo 40 % de promedio final

**NOTAS:**
* Todos los alumnos deberán participar activamente en el grupo, y así obtener puntos extras sobre el porcentaje de la calificación del semestre.
* En la calificación final se consideran las participaciones de clase para contar las décimas, es decir, si el promedio del semestre es 8.6 para subir a 9 se requiere de más de 8 participaciones, 8 o menos participaciones la calificación se queda en 8.
* Ejemplo:

| PROMEDIO DE SEMESTRE | PARTICIPACIONES | CALIFICACIÓN FINAL |
| :---: | :---: | :---: |
| 7.6 | 6 | 7 |
| 7.5 | 7 | 7 |
| 7.6 | 9 | 8 |
| 7.5 | 8 | 7 |
| 7.5 | 9 | 8 |

* Se pasará lista aleatoriamente
* NP
 
De acuerdo al Reglamento General de Exámenes en su artículo tercero dice que la calificación de NP se obtiene; “En el caso que el alumno no se presente al examen de la materia, se anotará NP, que significa: no presentado”, en específico para nuestro curso, un alumno puede obtener NP, si no realizó ningún examen parcial de la materia durante el semestre.

## 8. Contacto
martha.lopez@ingenieria.unam.edu

## 9. Actividades a realizar

| SEM | TEMA | NUM. PRAC | NOMBRE PRÁCTICA | FECHAS |
| :---: | :--- | :---: | :--- | :--- |
| 1 | Presentación 1. Introducción a las bases de datos | 1 | Presentación del curso. Acceso al servidor, instalación del sistema operativo | 3/2/2026 - 7/2/2026 |
| 2 | 2. Diseño conceptual de una base de datos | 2 | Entorno de trabajo | 9/2/2026 - 14/2/2026 |
| 3 | 2. Diseño conceptual de una base de datos / 3. Modelo relacional | 3 | Introducción al lenguaje de control de acceso a Datos (DCL) | 16/2/2026 - 21/2/2026 |
| 4 | 4. Diseño lógico de una base de datos | 4 | Diseño de modelos básicos E/R con notación Chen utilizando una herramieta CASE | 23/2/2026 - 28/2/2026 |
| 5 | 4. Diseño lógico de una base de datos / 1er EXAMEN PARCIAL | 5 | Diseño básico de modelos relacionales | 2/3/2026 - 7/3/2026 |
| 6 | 5. Normalización | 6 | Diseño de modelos avanzados E/R con notación Chen | 9/3/2026 - 14/3/2026 |
| 7 | 6. Diseño físico de una base de datos. Lenguaje de definición de datos (DDL) | 7 | Diseño avanzado de modelos relacionales | 16/3/2026 - 21/3/2026 |
| 8 | 6. Lenguaje de definición de datos (DDL). Lenguaje de manipulación de datos (DML) y transacciones | 8 | Normalización | 23/3/2026 - 28/3/2026 |
| - | **VACACIONES SEMANA SANTA** | - | - | 30/3/2026 - 4/4/2026 |
| 9 | 6. Lenguaje de manipulación de datos (DML) y transacciones | 9 y 10 | Leguaje de definición de datos (DDL) / Lenguaje de manipulación de datos (DML) y transacciones | 6/4/2026 - 11/4/2026 |
| 10 | 7. Lenguaje de consulta de datos (DQL) y álgebra relacional: álgebra, joins, consultas básicas, funciones de agregación, subconsultas y vistas / **2do EXAMEN PARCIAL** | 11 | Álgebra relacional y uso de join básico | 13/4/2026 - 18/4/2026 |
| 11 | 7. Lenguaje de consulta de datos (DQL) y álgebra relacional: álgebra, joins, consultas básicas, funciones de agregación, subconsultas y vistas | 12 | Consultas básicas en SQL y funciones de agregación | 20/4/2026 - 25/4/2026 |
| 12 | 7. Lenguaje de consulta de datos (DQL) /8. Introducción a la programación de SQL y sus extensiones | 13 | Utilización de distintos tipos de JOIN, subconsultas y vistas | 27/4/2026 - 2/5/2026 |
| 13 | 8. Introducción a la programación de SQL y sus extensiones | 14 | Programación básica con SQL. | 4/5/2026 - 9/5/2026 |
| 14 | 8. Introducción a la programación de SQL y sus extensiones | - | Realización del examén | 11/5/2026 - 16/5/2026 |
| 15 | Revisión de proyecto / **3er EXAMEN PARCIAL** | - | Entrega de calificaciones | 18/5/2026 - 23/5/2026 |
| 16 | Revisión de proyecto /entrega de calificaciones | - | - | 25/5/2026 - 30/5/2026 |
| 17 | 1er Examen Final | - | - | 1/6/2026 - 6/6/2026 |
| 18 | 2do Examen Final | - | - | 8/6/2026 - 13/6/2026 |

## 10. Bibliografía

### 1. Fundamentos y Conceptos Generales (Teoría Base)
* **Database System Concepts (7ª Edición, 2019)**
  * Autores: A. Silberschatz, H. Korth, S. Sudarshan.
  * Uso: Es el estándar para los Temas 1 (Introducción), 3 (Modelo Relacional) y la base del Tema 9. Cubre la arquitectura de los DBMS y conceptos de seguridad.
* **Databases: A Beginner’s Guide (6ª Edición, 2023)**
  * Autores: Andy Oppel, Robert Sheldon.
  * Uso: Ideal para los alumnos que inician. Muy fuerte en el Tema 1 (Conceptos de datos) y el Tema 2 (Diseño conceptual).

### 2. Diseño, Modelado y Normalización
* **Database Systems: Design, Implementation, & Management (14ª Edición, 2023)**
  * Autores: Carlos Coronel, Steven Morris.
  * Uso: Fundamental para los Temas 2, 4 y 5 (Diseño conceptual, lógico y Normalización).
* **Diseño de Bases de Datos (Problemas Resueltos) (Ed. 2001)**
  * Autores: Adoración de Miguel, Elena Castro, Mario Piattini.
  * Uso: Referencia práctica para ejercicios de Normalización (Tema 5) y transformación de modelos (Tema 4).

### 3. Lenguaje SQL y Programación
* **A Guide to SQL (10ª Edición, 2021)**
  * Autores: Philip J. Pratt, Mary Z. Last.
  * Uso: Tema 7 (DQL) y Tema 8 (Programación). Se enfoca en la sintaxis estándar y ejemplos reales de consultas.
* **SQL Bible (3ª Edición)**
  * Autores: Alex Kriegel, Boris M. Trukhnov.
  * Uso: Funciona como manual de referencia avanzada para el Tema 6 (Diseño físico/DDL) y el manejo de transacciones.

### 4. Nuevas Tecnologías (Temas Complementarios)
* **Next Generation Databases: NoSQL and Big Data (1ª Edición, 2015)**
  * Autor: Guy Harrison.
  * Uso: Específico para el Tema 9. Explica los modelos clave/valor, documentos y grafos, así como las arquitecturas de Big Data (Volumen, Velocidad, Variedad).
