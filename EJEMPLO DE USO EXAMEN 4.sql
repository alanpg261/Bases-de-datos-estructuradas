-- Ejemplo de uso
DECLARE @IdCampeonato INT = 4;  
DECLARE @IdFaseGrupos INT = 1;  
DECLARE @IdFaseOctavos INT = 2; 
DECLARE @IdEstadio INT = 1;     

EXEC GenerarEncuentrosOctavos 
    @p_IdCampeonato = @IdCampeonato,
    @p_IdFaseGrupos = @IdFaseGrupos,
    @p_IdFaseOctavos = @IdFaseOctavos,
    @p_IdEstadio = @IdEstadio;



