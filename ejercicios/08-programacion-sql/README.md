# Ejercicios Tema 8: Programación en SQL Server (T-SQL)

## Descripción

Este directorio contiene los scripts y resoluciones de los ejercicios prácticos correspondientes al Tema 8. El objetivo es aplicar elementos de programación directamente en el motor de base de datos utilizando Transact-SQL (T-SQL), abarcando la declaración de variables, estructuras de control de flujo, ciclos y el procesamiento fila por fila.

## Archivos de Trabajo

A continuación se listan los scripts SQL que conforman esta práctica, categorizados por la estructura de programación evaluada:

* **[01-uso-variables.sql](./01-uso-variables.sql):** Ejercicios demostrativos sobre la declaración, asignación y uso de variables locales y globales, incluyendo su implementación paramétrica en subconsultas.
* **[02-control-flujo-if.sql](./02-control-flujo-if.sql):** Implementación de la estructura condicional `IF...ELSE` y el uso de `EXISTS` para validación lógica de datos (ej. verificación de sueldos y auditoría de proyectos asignados).
* **[03-ciclos-while.sql](./03-ciclos-while.sql):** Uso de la estructura iterativa `WHILE` junto con las instrucciones `BREAK` y `CONTINUE` para automatizar actualizaciones masivas y registros condicionales.
* **[04-condicionales-case.sql](./04-condicionales-case.sql):** Ejercicios empleando la función `CASE` simple y buscada dentro de consultas `SELECT`, ordenamientos `ORDER BY`, actualizaciones condicionales `UPDATE` y filtros `HAVING`.
* **[05-cursores.sql](./05-cursores.sql):** Declaración, apertura, lectura y cierre de cursores. Incluye ejemplos de cursores dinámicos, cursores con operaciones `JOIN` y cursores anidados para la generación de reportes detallados.
