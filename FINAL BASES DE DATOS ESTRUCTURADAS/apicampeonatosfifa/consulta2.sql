-- Eliminar la función existente primero
DROP FUNCTION IF EXISTS f_obtenertablaposiciones(integer);

-- Crear la función CORREGIDA con casting de tipos
CREATE OR REPLACE FUNCTION f_obtenertablaposiciones(grupo_id INTEGER)
RETURNS TABLE(
    id INTEGER,
    pais VARCHAR,
    pj INTEGER,
    pg INTEGER,
    pe INTEGER,
    pp INTEGER,
    gf INTEGER,
    gc INTEGER,
    puntos INTEGER
) AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        p.id::INTEGER,
        p.nombre::VARCHAR as pais,
        COUNT(m.id)::INTEGER as pj,
        COALESCE(SUM(CASE 
            WHEN (m.pais_local = p.id AND m.goles_local > m.goles_visitante) OR 
                 (m.pais_visitante = p.id AND m.goles_visitante > m.goles_local) THEN 1 
            ELSE 0 
        END)::INTEGER, 0) as pg,
        COALESCE(SUM(CASE WHEN m.goles_local = m.goles_visitante THEN 1 ELSE 0 END)::INTEGER, 0) as pe,
        COALESCE(SUM(CASE 
            WHEN (m.pais_local = p.id AND m.goles_local < m.goles_visitante) OR 
                 (m.pais_visitante = p.id AND m.goles_visitante < m.goles_local) THEN 1 
            ELSE 0 
        END)::INTEGER, 0) as pp,
        COALESCE(SUM(CASE WHEN m.pais_local = p.id THEN m.goles_local ELSE m.goles_visitante END)::INTEGER, 0) as gf,
        COALESCE(SUM(CASE WHEN m.pais_local = p.id THEN m.goles_visitante ELSE m.goles_local END)::INTEGER, 0) as gc,
        COALESCE(SUM(CASE 
            WHEN (m.pais_local = p.id AND m.goles_local > m.goles_visitante) OR 
                 (m.pais_visitante = p.id AND m.goles_visitante > m.goles_local) THEN 3
            WHEN m.goles_local = m.goles_visitante THEN 1
            ELSE 0 
        END)::INTEGER, 0) as puntos
    FROM pais p
    INNER JOIN grupo_pais gp ON p.id = gp.id_pais
    LEFT JOIN partido m ON m.id_grupo = gp.id_grupo AND (m.pais_local = p.id OR m.pais_visitante = p.id)
    WHERE gp.id_grupo = grupo_id
    GROUP BY p.id, p.nombre
    ORDER BY puntos DESC, (gf - gc) DESC;
END;
$$ LANGUAGE plpgsql;