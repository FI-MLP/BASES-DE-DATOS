# Ejercicios Tema 7.1: Álgebra Relacional y SQL

## Descripción

Este directorio contiene los ejercicios prácticos correspondientes al Tema 7.1 del curso. El objetivo de esta práctica es aplicar los conceptos matemáticos del álgebra relacional (unión, intersección, diferencia y producto cartesiano) directamente mediante sentencias SQL en la base de datos de la empresa.

## Requerimientos

Los ejercicios a resolver son los siguientes:

## EJERCICIOS
```
1. La empresa quiere dar un bono a los empleados que hayan nacido antes del 31 de diciembre de 1990, adicionalmente a los empleados que hayan
  ingresado entre el 1/01/2018 y el 31/08/2018. Genere el listado de los empleados que tendrán dicho bono (nombre completo, fecha de nacimiento,
fecha de ingreso). Utilice operaciones con conjuntos. No utilizar operadores and ni or.
2. Obtenga el nombre completo de los empleados de confianza, así como el nombre completo de los dependientes económicos que hayan nacido después
 del año 2000. Utilice operadores de conjuntos.
3. Se desea otorgar un bono del 30% de sueldo a todos los jefes. Sin embargo, el mes anterior, la empresa otorgó un bono del 20 % a todos los
 empleados que nacieron entre los años 1985 y 1995. Genere el álgebra relacional y la sentencia SQL que obtenga a todos los empleados que recibirán
 el bono (nombre completo, fecha de ingreso y puesto actual) considerando que, si el empleado ya recibió bono el mes pasado, ya no se le aplicará en
 esta ocasión. (diferencia)
4. Obtener el nombre completo, correo e identificador del jefe de los empleados testers que no sean empleados de honorarios (diferencia)
5. Obtener un reporte (nombre completo, fecha de ingreso) de todos los empleados que tengan fecha de ingreso en el 2018, así como los empleados cuyo
 puesto sea desarrollador (intersect)
6. Obtenga el producto cartesiano de los puestos y los proyectos.
7. Obtener el sueldo y el nombre de todos los empleados analistas.
8. Obtener los puestos que ya no están vigentes (descripción y sueldo), que se encuentren en la tabla históricos (intersect)
```

## Archivos de Trabajo

A continuación se lista el script SQL que conforma esta práctica:

* **[01-resolucion-ar.sql](./01-resolucion-ar.sql):** Archivo de trabajo principal. Contiene la resolución de los 8 ejercicios solicitados, aplicando estrictamente operadores de conjuntos y álgebra relacional.
