package com.conversionmoneda.moneda.repository;

import com.conversionmoneda.moneda.entity.CambioMoneda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface CambioMonedaRepository extends JpaRepository<CambioMoneda, Integer> {
    
    @Query("SELECT cm FROM CambioMoneda cm WHERE cm.moneda.sigla = :sigla AND cm.fecha BETWEEN :desde AND :hasta ORDER BY cm.fecha")
    List<CambioMoneda> findByMonedaSiglaAndFechaBetween(
        @Param("sigla") String sigla,
        @Param("desde") LocalDateTime desde,
        @Param("hasta") LocalDateTime hasta
    );
}