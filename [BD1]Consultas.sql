------------Consulta 1------------
SELECT E.NOMBRE, E.APELLIDO, E.TELEFONO, count(EV.ID_PACIENTE) Cantidad_de_Pacientes
FROM EVALUACION EV
    inner join EMPLEADO E on E.ID_EMPLEADO = EV.ID_EMPLEADO
GROUP BY  E.NOMBRE, E.APELLIDO, E.TELEFONO
ORDER BY Cantidad_de_Pacientes DESC
;


------------Consulta 2------------
SELECT E1.NOMBRE, E1.APELLIDO, E1.DIRECCION, T.TITULO, count(*) Cantidad
FROM Empleado E1
    inner join TITULO T on E1.ID_TITULO = T.ID_TITULO
    inner join EVALUACION E on E1.ID_EMPLEADO = E.ID_EMPLEADO
WHERE E1.GENERO = 'M' 
    and extract(year FROM E.FECHA_EVALUACION) = '2016'
GROUP BY E1.NOMBRE, E1.APELLIDO, E1.DIRECCION, T.TITULO
having count(*) > 3
ORDER BY Cantidad DESC
;


------------Consulta 3------------
SELECT DISTINCT P.NOMBRE, P.APELLIDO
FROM PACIENTE P
    inner join PACIENTE_TRATAMIENTO PT on P.ID_PACIENTE = PT.ID_PACIENTE
    inner join TRATAMIENTO T on PT.ID_TRATAMIENTO = T.ID_TRATAMIENTO
    inner join EVALUACION E on P.ID_PACIENTE = E.ID_PACIENTE
    inner join PACIENTE_SINTOMA PS on PS.ID_PACIENTE = E.ID_PACIENTE
    inner join SINTOMA S on PS.ID_SINTOMA = S.ID_SINTOMA
WHERE T.NOMBRE_TRATAMIENTO = 'Tabaco en polvo' 
    and S.NOMBRE_SINTOMA = 'Dolor de cabeza'
;


------------Consulta 4------------
SELECT P.NOMBRE, P.APELLIDO, count(*) Cantidad
FROM PACIENTE P
    inner join PACIENTE_TRATAMIENTO PT on P.ID_PACIENTE = PT.ID_PACIENTE
    inner join TRATAMIENTO T on PT.ID_TRATAMIENTO = T.ID_TRATAMIENTO
WHERE T.NOMBRE_TRATAMIENTO = 'Antidepresivos'
GROUP BY P.NOMBRE, P.APELLIDO
ORDER BY Cantidad DESC
FETCH NEXT 5 ROWS ONLY;
;

------------Consulta 5------------
SELECT P1.NOMBRE, P1.APELLIDO, P1.DIRECCION, A2.CANTIDAD
FROM PACIENTE P1, (
    SELECT P2.ID_PACIENTE, P2.NOMBRE, P2.APELLIDO, P2.DIRECCION, count(*) CANTIDAD
    FROM PACIENTE P2
        inner join PACIENTE_TRATAMIENTO PT on P2.ID_PACIENTE = PT.ID_PACIENTE
        inner join TRATAMIENTO T on T.ID_TRATAMIENTO = PT.ID_TRATAMIENTO
    GROUP BY P2.ID_PACIENTE, P2.NOMBRE, P2.APELLIDO, P2.DIRECCION
) A2, EVALUACION E
WHERE P1.ID_PACIENTE = A2.ID_PACIENTE
    and 3 < A2.CANTIDAD
    and P1.ID_PACIENTE not in (
        SELECT id_paciente FROM Evaluacion
    )
GROUP BY P1.NOMBRE, P1.APELLIDO, P1.DIRECCION, A2.CANTIDAD
;


------------Consulta 6------------
SELECT D.NOMBRE_DIAGNOSTICO, count(*) Cantidad
FROM DIAGNOSTICO D
    inner join SINTOMA_DIAGNOSTICO SD on D.ID_DIAGNOSTICO = SD.ID_DIAGNOSTICO
    inner join SINTOMA S on S.ID_SINTOMA = SD.ID_SINTOMA
WHERE SD.RANGO = 9
GROUP BY D.NOMBRE_DIAGNOSTICO
ORDER BY Cantidad DESC
;


------------Consulta 7------------
SELECT DISTINCT P.NOMBRE, P.APELLIDO, P.DIRECCION
FROM PACIENTE P
    inner join EVALUACION E on P.ID_PACIENTE = E.ID_PACIENTE
    inner join PACIENTE_SINTOMA PS on E.ID_PACIENTE = PS.ID_PACIENTE
    inner join SINTOMA S on PS.ID_SINTOMA = S.ID_SINTOMA
    inner join SINTOMA_DIAGNOSTICO SD on S.ID_SINTOMA = SD.ID_SINTOMA
WHERE SD.RANGO > 5
ORDER BY P.NOMBRE, APELLIDO
;


------------Consulta 8------------
SELECT E.NOMBRE, E.APELLIDO, E.FECHA_NACIMIENTO, count(*) ATENDIDOS
FROM EMPLEADO E
    inner join EVALUACION E2 on E.ID_EMPLEADO = E2.ID_EMPLEADO
WHERE E.GENERO = 'F' 
    and E.DIRECCION = '1475 Dryden Crossing'
GROUP BY E.NOMBRE, E.APELLIDO, E.FECHA_NACIMIENTO
having count(*) >= 2
;


------------Consulta 9------------
SELECT E.NOMBRE, E.APELLIDO, round((100*(count(*)/(
    SELECT count(*)
    FROM EVALUACION E
))),2)||'%' ATENDIDOS
FROM EMPLEADO E
    inner join EVALUACION E2 on E.ID_EMPLEADO = E2.ID_EMPLEADO
WHERE extract(year FROM E2.FECHA_EVALUACION) >= '2017'
GROUP BY E.NOMBRE, E.APELLIDO
ORDER BY Atendidos DESC;


------------Consulta 10------------
SELECT DISTINCT T.TITULO, round((100*((
    SELECT COUNT(*)
    FROM EMPLEADO E
    WHERE E.ID_TITULO = T.ID_TITULO
    GROUP BY E.ID_TITULO
)
/
(
    SELECT count(*)
    FROM EMPLEADO
)
)),2)||'%' EMPLEADOS
FROM EMPLEADO E
inner join TITULO T on T.ID_TITULO = E.ID_TITULO
ORDER BY EMPLEADOS DESC
;


------------Consulta 11------------
(
SELECT P.NOMBRE, P.APELLIDO, count(*) TRATAMIENTOS
FROM PACIENTE P
    inner join PACIENTE_TRATAMIENTO PT on PT.ID_PACIENTE = P.ID_PACIENTE
GROUP BY P.NOMBRE, P.APELLIDO
ORDER BY count(*) DESC
fetch next 1 rows only
)
UNION
(
SELECT P.NOMBRE, P.APELLIDO, count(*) TRATAMIENTOS
FROM PACIENTE P
    inner join PACIENTE_TRATAMIENTO PT on PT.ID_PACIENTE = P.ID_PACIENTE
GROUP BY P.NOMBRE, P.APELLIDO
ORDER BY count(*) ASC
FETCH NEXT 1 ROWS only
)
;