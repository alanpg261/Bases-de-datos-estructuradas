package com.conversionmoneda.moneda.service;

import com.conversionmoneda.moneda.entity.Moneda;
import com.conversionmoneda.moneda.repository.MonedaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class MonedaService {
    
    @Autowired
    private MonedaRepository monedaRepository;
    
    public List<Moneda> findAll() {
        return monedaRepository.findAll();
    }
    
    public Optional<Moneda> findById(Integer id) {
        return monedaRepository.findById(id);
    }
    
    public Optional<Moneda> findBySigla(String sigla) {
        return monedaRepository.findBySigla(sigla);
    }
    
    public Moneda save(Moneda moneda) {
        return monedaRepository.save(moneda);
    }
    
    public void deleteById(Integer id) {
        monedaRepository.deleteById(id);
    }
}