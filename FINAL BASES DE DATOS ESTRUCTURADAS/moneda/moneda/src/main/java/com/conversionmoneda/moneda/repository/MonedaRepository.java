package com.conversionmoneda.moneda.repository;

import com.conversionmoneda.moneda.entity.Moneda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface MonedaRepository extends JpaRepository<Moneda, Integer> {
    Optional<Moneda> findBySigla(String sigla);
}