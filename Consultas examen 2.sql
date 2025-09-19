
--Canciones que ha compuesto JUANES
SELECT 
    COUNT(*) AS CantidadCancionesJuanes
FROM CancionCompositor cc
INNER JOIN Compositor comp ON cc.IdCompositor = comp.Id
WHERE CHARINDEX('JUANES', comp.Nombre) > 0;

--Interpretaciones de la canción "Lluvia" y ritmos
SELECT 
    i.Id AS IdInterpretacion,
    can.Titulo AS Cancion,
    inter.Nombre AS Interprete,
    r.Ritmo,
    i.Duracion
FROM Interpretacion i
INNER JOIN Cancion can ON i.IdCancion = can.Id
INNER JOIN Interprete inter ON i.IdInterprete = inter.Id
INNER JOIN Ritmo r ON i.IdRitmo = r.Id
WHERE can.Titulo = 'Lluvia';

--Canciones con el mismo interprete y compositor en baladas 
SELECT 
    can.Id AS IdCancion,
    can.Titulo AS Cancion,
    inter.Nombre AS Interprete,
    comp.Nombre AS Compositor,
    r.Ritmo
FROM Cancion can
INNER JOIN CancionCompositor cc ON can.Id = cc.IdCancion  
INNER JOIN Compositor comp ON cc.IdCompositor = comp.Id   
INNER JOIN Interpretacion i ON can.Id = i.IdCancion
INNER JOIN Interprete inter ON i.IdInterprete = inter.Id
INNER JOIN Ritmo r ON i.IdRitmo = r.Id
INNER JOIN Tipo tipo ON inter.IdTipo = tipo.Id  
WHERE r.Ritmo = 'Balada'
AND tipo.Tipo = 'Solista'
AND (comp.Nombre LIKE '%' + inter.Nombre + '%' OR inter.Nombre LIKE '%' + comp.Nombre + '%');

--Paises con grupos de salsa
SELECT DISTINCT
    p.Id AS IdPais,
    p.Pais AS Pais
FROM Pais p
INNER JOIN Interprete inter ON p.Id = inter.IdPais
INNER JOIN Interpretacion i ON inter.Id = i.IdInterprete
INNER JOIN Ritmo r ON i.IdRitmo = r.Id
INNER JOIN Tipo tipo ON inter.IdTipo = tipo.Id
WHERE r.Ritmo = 'Salsa'
AND tipo.Tipo = 'Grupo'
ORDER BY p.Pais;

--Interpretes de las canciones “Candilejas” y “Malaguena”
SELECT 
    can.Titulo AS Cancion,
    inter.Nombre AS Interprete
FROM Cancion can
INNER JOIN Interpretacion i ON can.Id = i.IdCancion
INNER JOIN Interprete inter ON i.IdInterprete = inter.Id
WHERE can.Titulo IN ('Candilejas', 'Malaguena')
ORDER BY can.Titulo, inter.Nombre;


--Artistas que son compositores e interpretes a la vez y cantidad de canciones interpretadas y compuestas
SELECT 
    inter.Nombre AS Artista,
    COUNT(DISTINCT cc.IdCancion) AS Canciones_Compuestas,
    COUNT(DISTINCT i2.IdCancion) AS Canciones_Interpretadas
FROM Interprete inter
INNER JOIN Compositor comp ON inter.Nombre LIKE '%' + comp.Nombre + '%' 
    OR comp.Nombre LIKE '%' + inter.Nombre + '%'
INNER JOIN CancionCompositor cc ON comp.Id = cc.IdCompositor
INNER JOIN Interpretacion i2 ON inter.Id = i2.IdInterprete
GROUP BY inter.Nombre
HAVING COUNT(DISTINCT cc.IdCancion) > 0
    AND COUNT(DISTINCT i2.IdCancion) > 0
ORDER BY Artista;