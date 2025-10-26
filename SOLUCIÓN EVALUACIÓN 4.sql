CREATE OR ALTER PROCEDURE GenerarEncuentrosOctavos
    @p_IdCampeonato INT,
    @p_IdFaseGrupos INT,
    @p_IdFaseOctavos INT,
    @p_IdEstadio INT
AS
BEGIN
    -- Eliminar encuentros existentes de octavos para evitar duplicados
    DELETE FROM Encuentro 
    WHERE IdFase = @p_IdFaseOctavos 
      AND IdCampeonato = @p_IdCampeonato;
    
    -- Tabla temporal para calcular posiciones
    CREATE TABLE #PosicionesGrupo (
        IdGrupo INT,
        IdPais INT,
        Puntos INT,
        DiferenciaGoles INT,
        GolesFavor INT,
        Posicion INT
    );
    
    -- Calcular posiciones para todos los grupos
    INSERT INTO #PosicionesGrupo (IdGrupo, IdPais, Puntos, DiferenciaGoles, GolesFavor)
    SELECT 
        gp.IdGrupo,
        gp.IdPais,
        -- Cálculo de PUNTOS
        SUM(CASE 
            WHEN e.IdPais1 = gp.IdPais AND e.Goles1 > e.Goles2 THEN 3
            WHEN e.IdPais2 = gp.IdPais AND e.Goles2 > e.Goles1 THEN 3
            WHEN (e.IdPais1 = gp.IdPais OR e.IdPais2 = gp.IdPais) AND e.Goles1 = e.Goles2 THEN 1
            ELSE 0
        END) AS Puntos,
        -- Cálculo de DIFERENCIA de GOLES
        SUM(CASE 
            WHEN e.IdPais1 = gp.IdPais THEN e.Goles1 - e.Goles2
            WHEN e.IdPais2 = gp.IdPais THEN e.Goles2 - e.Goles1
            ELSE 0
        END) AS DiferenciaGoles,
        -- Cálculo de GOLES A FAVOR
        SUM(CASE 
            WHEN e.IdPais1 = gp.IdPais THEN e.Goles1
            WHEN e.IdPais2 = gp.IdPais THEN e.Goles2
            ELSE 0
        END) AS GolesFavor
    FROM GrupoPais gp
    INNER JOIN Encuentro e ON (e.IdPais1 = gp.IdPais OR e.IdPais2 = gp.IdPais)
    WHERE e.IdFase = @p_IdFaseGrupos
      AND e.IdCampeonato = @p_IdCampeonato
    GROUP BY gp.IdGrupo, gp.IdPais;
    
    -- Asignar posiciones dentro de cada grupo
    ;WITH Ranking AS (
        SELECT 
            IdGrupo,
            IdPais,
            Puntos,
            DiferenciaGoles,
            GolesFavor,
            ROW_NUMBER() OVER (
                PARTITION BY IdGrupo 
                ORDER BY Puntos DESC, DiferenciaGoles DESC, GolesFavor DESC
            ) AS NuevaPosicion
        FROM #PosicionesGrupo
    )
    UPDATE pg
    SET Posicion = r.NuevaPosicion
    FROM #PosicionesGrupo pg
    INNER JOIN Ranking r ON pg.IdGrupo = r.IdGrupo AND pg.IdPais = r.IdPais;
    
    -- Generar emparejamientos
    DECLARE @Grupos TABLE (IdGrupo INT, Orden INT);
    
    INSERT INTO @Grupos (IdGrupo, Orden)
    SELECT DISTINCT IdGrupo, ROW_NUMBER() OVER (ORDER BY IdGrupo) 
    FROM #PosicionesGrupo
    WHERE Posicion <= 2;
    
    DECLARE @v_Contador INT = 1;
    DECLARE @v_TotalGrupos INT;
    DECLARE @v_MaxIteraciones INT;
    
    SELECT @v_TotalGrupos = COUNT(*) FROM @Grupos;
    SET @v_MaxIteraciones = @v_TotalGrupos / 2;
    
    WHILE @v_Contador <= @v_MaxIteraciones
    BEGIN
        DECLARE @v_IdGrupo1 INT, @v_IdGrupo2 INT;
        DECLARE @v_Primero1 INT, @v_Segundo1 INT, @v_Primero2 INT, @v_Segundo2 INT;
        
        SELECT @v_IdGrupo1 = IdGrupo FROM @Grupos WHERE Orden = (@v_Contador * 2 - 1);
        SELECT @v_IdGrupo2 = IdGrupo FROM @Grupos WHERE Orden = (@v_Contador * 2);
        
        -- Obtener posiciones del Grupo 1
        SELECT @v_Primero1 = IdPais FROM #PosicionesGrupo WHERE IdGrupo = @v_IdGrupo1 AND Posicion = 1;
        SELECT @v_Segundo1 = IdPais FROM #PosicionesGrupo WHERE IdGrupo = @v_IdGrupo1 AND Posicion = 2;
        
        -- Obtener posiciones del Grupo 2
        SELECT @v_Primero2 = IdPais FROM #PosicionesGrupo WHERE IdGrupo = @v_IdGrupo2 AND Posicion = 1;
        SELECT @v_Segundo2 = IdPais FROM #PosicionesGrupo WHERE IdGrupo = @v_IdGrupo2 AND Posicion = 2;
        
        -- Validar que tenemos los 4 equipos
        IF @v_Primero1 IS NOT NULL AND @v_Segundo1 IS NOT NULL AND 
           @v_Primero2 IS NOT NULL AND @v_Segundo2 IS NOT NULL
        BEGIN
            -- Insertar encuentro 1: 1° Grupo 1 vs 2° Grupo 2
            INSERT INTO Encuentro (IdPais1, IdPais2, IdEstadio, IdFase, IdCampeonato, Fecha, Goles1, Goles2)
            VALUES (@v_Primero1, @v_Segundo2, @p_IdEstadio, @p_IdFaseOctavos, @p_IdCampeonato, NULL, NULL, NULL);
            
            -- Insertar encuentro 2: 2° Grupo 1 vs 1° Grupo 2
            INSERT INTO Encuentro (IdPais1, IdPais2, IdEstadio, IdFase, IdCampeonato, Fecha, Goles1, Goles2)
            VALUES (@v_Segundo1, @v_Primero2, @p_IdEstadio, @p_IdFaseOctavos, @p_IdCampeonato, NULL, NULL, NULL);
        END
        
        SET @v_Contador = @v_Contador + 1;
    END
    
    DROP TABLE #PosicionesGrupo;
    SELECT 'Encuentros de octavos generados exitosamente' AS Mensaje;
END
GO