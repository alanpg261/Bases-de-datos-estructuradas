package com.campeonatosfifa.controladores;

import com.campeonatosfifa.dominio.Grupo;
import com.campeonatosfifa.dominio.dtos.TablaPosicionesDto;
import com.campeonatosfifa.repositorios.GrupoRepositorio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import jakarta.persistence.EntityManager;
import java.util.List;

@RestController
@RequestMapping("/api/grupos")
@CrossOrigin(origins = "*")
public class GrupoControlador {

    @Autowired
    private GrupoRepositorio repositorio;

    @Autowired
    private EntityManager em;

    @GetMapping("/listar-campeonato/{idCampeonato}")
    public List<Grupo> listarGruposPorCampeonato(@PathVariable Integer idCampeonato) {
        return repositorio.findByCampeonatoId(idCampeonato);
    }

    @GetMapping("/posiciones/{idGrupo}")
    public List<TablaPosicionesDto> obtenerTablaPosiciones(@PathVariable Integer idGrupo) {
        String sql = "SELECT * FROM f_obtenertablaposiciones(:idGrupo) ORDER BY puntos DESC, (gf - gc) DESC";
        
        return em.createNativeQuery(sql, TablaPosicionesDto.class)
                 .setParameter("idGrupo", idGrupo)
                 .getResultList();
    }
}