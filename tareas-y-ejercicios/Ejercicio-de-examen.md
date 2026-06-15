<img width="655" height="367" alt="Screenshot_37" src="https://github.com/user-attachments/assets/80b63fa5-4039-47ee-a591-8632606846d7" />

---
Considere el siguiente modelo relacional que describe el registro de las calificaciones de los alumnos de una universidad.
Se requiere crear un procedimiento almacenado que reciba como parámetros, el número de cuenta, el semestre y unparámetro 
de salida en el que se almacenará el promedio de calificaciones para el semestre y estudiante especificados.
Además de calcular el promedio, el procedimiento deberá generar una cadena (columnas separadas por comas) que contenga el 
número de cuenta y la lista de los nombres de las asignaturas cursadas, su calificación y su promedio. 
Por ejemplo, suponer que el alumno con número de cuenta 114000526 curso Álgebra con 9, y Cálculo con 10. La cadena
generada será 114000526, ALGEBRA,9, CALCULO,10,9.5. La última columna corresponde con el promedio del estudiante.
Esta cadena se deberá almacenar en la tabla reporte cuyo esquema es: REPORTE={id_reporte numeric 5 (pk), cadena,
fecha_registro date. Emplear la fecha actual del sistema y una secuencia llamada sec_reporte para realizar la inserción.
Finalmente, invocar a procedimiento empleando como valores: número de cuenta 110369548, semestre 2026-1.
