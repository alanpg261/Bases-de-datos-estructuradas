package com.campeonatosfifa.repositorios;

import com.campeonatosfifa.dominio.Campeonato;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CampeonatoRepositorio extends JpaRepository<Campeonato, Integer> {
}