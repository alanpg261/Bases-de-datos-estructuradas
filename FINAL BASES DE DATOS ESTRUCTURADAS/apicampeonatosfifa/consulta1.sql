-- Tablas básicas
CREATE TABLE IF NOT EXISTS pais (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    entidad VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS campeonato (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    anio INTEGER NOT NULL,
    id_pais INTEGER REFERENCES pais(id)
);

CREATE TABLE IF NOT EXISTS grupo (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(1) NOT NULL,
    id_campeonato INTEGER REFERENCES campeonato(id)
);

CREATE TABLE IF NOT EXISTS grupo_pais (
    id_grupo INTEGER REFERENCES grupo(id),
    id_pais INTEGER REFERENCES pais(id),
    PRIMARY KEY (id_grupo, id_pais)
);

CREATE TABLE IF NOT EXISTS partido (
    id SERIAL PRIMARY KEY,
    id_grupo INTEGER REFERENCES grupo(id),
    pais_local INTEGER REFERENCES pais(id),
    pais_visitante INTEGER REFERENCES pais(id),
    goles_local INTEGER,
    goles_visitante INTEGER,
    fecha DATE
);

-- Datos de ejemplo
INSERT INTO pais (nombre, entidad) VALUES 
('Colombia', 'Federación Colombiana de Fútbol'),
('Brasil', 'Confederación Brasileña de Fútbol'),
('Argentina', 'Asociación del Fútbol Argentino'),
('Alemania', 'Federación Alemana de Fútbol'),
('Francia', 'Federación Francesa de Fútbol');

INSERT INTO campeonato (nombre, anio, id_pais) VALUES 
('Copa América 2024', 2024, 1),
('Mundial 2022', 2022, 4);

INSERT INTO grupo (nombre, id_campeonato) VALUES 
('A', 1), ('B', 1), ('C', 1),
('A', 2), ('B', 2), ('C', 2), ('D', 2);

INSERT INTO grupo_pais (id_grupo, id_pais) VALUES 
(1, 1), (1, 2), (1, 3),
(4, 1), (4, 2), (4, 3), (4, 4), (4, 5);

INSERT INTO partido (id_grupo, pais_local, pais_visitante, goles_local, goles_visitante, fecha) VALUES 
(1, 1, 2, 2, 1, '2024-06-10'),
(1, 3, 1, 0, 2, '2024-06-15'),
(1, 2, 3, 1, 1, '2024-06-20');

-- Función para tabla de posiciones
CREATE OR REPLACE FUNCTION f_obtenertablaposiciones(id_grupo INTEGER)
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
        p.id,
        p.nombre as pais,
        COUNT(m.id) as pj,
        SUM(CASE WHEN (m.pais_local = p.id AND m.goles_local > m.goles_visitante) 
                  OR (m.pais_visitante = p.id AND m.goles_visitante > m.goles_local) THEN 1 ELSE 0 END) as pg,
        SUM(CASE WHEN m.goles_local = m.goles_visitante THEN 1 ELSE 0 END) as pe,
        SUM(CASE WHEN (m.pais_local = p.id AND m.goles_local < m.goles_visitante) 
                  OR (m.pais_visitante = p.id AND m.goles_visitante < m.goles_local) THEN 1 ELSE 0 END) as pp,
        SUM(CASE WHEN m.pais_local = p.id THEN m.goles_local ELSE m.goles_visitante END) as gf,
        SUM(CASE WHEN m.pais_local = p.id THEN m.goles_visitante ELSE m.goles_local END) as gc,
        SUM(CASE 
            WHEN (m.pais_local = p.id AND m.goles_local > m.goles_visitante) 
              OR (m.pais_visitante = p.id AND m.goles_visitante > m.goles_local) THEN 3
            WHEN m.goles_local = m.goles_visitante THEN 1
            ELSE 0 
        END) as puntos
    FROM pais p
    JOIN grupo_pais gp ON p.id = gp.id_pais
    LEFT JOIN partido m ON (gp.id_grupo = m.id_grupo AND (m.pais_local = p.id OR m.pais_visitante = p.id))
    WHERE gp.id_grupo = id_grupo
    GROUP BY p.id, p.nombre
    ORDER BY puntos DESC, (gf - gc) DESC;
END;
$$ LANGUAGE plpgsql;