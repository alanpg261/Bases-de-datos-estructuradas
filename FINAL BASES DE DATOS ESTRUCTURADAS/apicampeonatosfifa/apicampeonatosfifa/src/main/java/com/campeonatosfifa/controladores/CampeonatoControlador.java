package com.campeonatosfifa.controladores;

import com.campeonatosfifa.dominio.Campeonato;
import com.campeonatosfifa.repositorios.CampeonatoRepositorio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/campeonatos")
@CrossOrigin(origins = "*")
public class CampeonatoControlador {

    @Autowired
    private CampeonatoRepositorio repositorio;

    @GetMapping("/listar")
    public List<Campeonato> listarCampeonatos() {
        return repositorio.findAll();
    }
}