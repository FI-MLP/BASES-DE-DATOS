-- ==========================================================================================
-- Archivo: 02-resolucion-dql.sql
-- Descripción: Resolución de los 16 ejercicios prácticos de DQL (Tema 7.2).
-- ==========================================================================================

USE [262_EMPRESA_89000546];
GO

-- 1. Se requiere un informe de la platilla del personal de confianza de la empresa, los datos a obtener son: Nombre completo, rfc, fecha ingreso, correo, tipo de empleado, su puesto actual, y numero de plaza.


-- 2. Le piden un informe de los cónyuges de los empleados de honorarios: nombre completo, puesto y tipo de contrato de ambos.


-- 3. Se dará un premio a los empleados por honorarios, por lo que le piden un listado de ellos con los siguientes datos: nombre completo, fecha de ingreso, número de horas trabajadas y número de proyectos.


-- 4. Por razones contables le solicitan un listado de los datos de los proyectos, costo, el total pagado (suma de sus pagos de la tabla pagos) y adeudo. Todo lo debe calcular en la consulta.


-- 5. La empresa dará una fiesta y un obsequio a los empleados y sus familiares, para ello le piden un listado de todo el personal con los siguientes datos: nombre completo, fecha de ingreso, años en la institución, su tipo de empleado, nombre y parentesco de sus dependientes económicos y edad.


-- 6. Obtenga un listado de proyectos con un adeudo entre 120,000 y 200, 000, incluir el nombre del empleado que dirige cada proyecto. Solo proyectos sin concluir.


-- 7. Listado de los empleados que han dirigido proyectos, identificador y nombre del empleado, suma del costo de los proyectos, cantidad de proyectos, ordene de mayo a menor (costo).


-- 8. Obtenga nombre de los proyectos y suma de sus pagos, considerando solo los proyectos cuyo total pagado sea mayor a $100,000 ordene de mayor a menor total pagado (calcule con la tabla pagos).


-- 9. Obtenga a través de operadores de conjuntos de álgebra relacional y después con sentencia SQL, el nombre de los proyectos en los que se haya trabajado más de 100 horas y con una duración de mas de 15 meses sin considerar aquellos proyectos que estén desfasados.


-- 10. En base al puesto actual, obtener la cantidad de dinero que la empresa paga por puesto (nombre del puesto y cantidad que se paga a los empleados que tienen cada puesto) ordenado de mayor a menor.


-- 11. Obtenga todos los empleados que no tengan un proyecto asignado y asígneles el proyecto 'REGISTRO DE VIATICOS', con 90 horas para cada uno, utilice transacciones.


-- 12. Obtenga la información de todos los empleados, todos los proyectos y los proyectos en los que ha sido asignado cada empleado (full outer).


-- 13. Obtenga el PROMEDIO de empleados que ha participado en cada proyecto, incluya nombre del proyecto.


-- 14. Obtener el identificador y nombre de los proyectos que han tenido más de 10 empleados trabajando, donde el promedio de sus pagos sea mayor a $150000 y, además uno de sus pagos sea mayor a $25,000.


-- 15. Escribe una consulta SQL que devuelva los proyectos (id, nombre, total de pagos, suma de sus pagos y la cantidad de su mayor pago) que han realizado más de 2 pagos y que su pago máximo individual sea mayor a $80,000. Obtenga todo mediante la tabla pagos.


-- 16. Por medio de álgebra relacional genere uno de los empleados que tienen un puesto de nivel directivo y que han sido superiores de proyectos con un costo de más de $800,000 empleando operadores de conjuntos y sin usar operadores lógicos AND y OR. Posteriormente, genere las sentencias SQL.
