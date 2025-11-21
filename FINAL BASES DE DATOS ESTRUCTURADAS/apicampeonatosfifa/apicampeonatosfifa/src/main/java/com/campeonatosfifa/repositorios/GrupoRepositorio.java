package com.campeonatosfifa.repositorios;

import com.campeonatosfifa.dominio.Grupo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface GrupoRepositorio extends JpaRepository<Grupo, Integer> {
    
    @Query("SELECT g FROM Grupo g WHERE g.campeonato.id = :idCampeonato ORDER BY g.nombre")
    List<Grupo> findByCampeonatoId(@Param("idCampeonato") Integer idCampeonato);
}