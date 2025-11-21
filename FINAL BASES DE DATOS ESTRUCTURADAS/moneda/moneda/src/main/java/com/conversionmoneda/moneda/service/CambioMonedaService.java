package com.conversionmoneda.moneda.service;

import com.conversionmoneda.moneda.entity.CambioMoneda;
import com.conversionmoneda.moneda.repository.CambioMonedaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;
import java.time.LocalDateTime;

@Service
public class CambioMonedaService {
    
    @Autowired
    private CambioMonedaRepository cambioMonedaRepository;
    
    public List<CambioMoneda> findAll() {
        return cambioMonedaRepository.findAll();
    }
    
    public Optional<CambioMoneda> findById(Integer id) {
        return cambioMonedaRepository.findById(id);
    }
    
    public CambioMoneda save(CambioMoneda cambioMoneda) {
        return cambioMonedaRepository.save(cambioMoneda);
    }
    
    public void deleteById(Integer id) {
        cambioMonedaRepository.deleteById(id);
    }
    
    public List<CambioMoneda> findByMonedaSiglaAndFechaBetween(String sigla, LocalDateTime desde, LocalDateTime hasta) {
        return cambioMonedaRepository.findByMonedaSiglaAndFechaBetween(sigla, desde, hasta);
    }
}