package com.conversionmoneda.moneda.service;

import com.conversionmoneda.moneda.entity.Pais;
import com.conversionmoneda.moneda.repository.PaisRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class PaisService {
    
    @Autowired
    private PaisRepository paisRepository;
    
    public List<Pais> findAll() {
        return paisRepository.findAll();
    }
    
    public Optional<Pais> findById(Integer id) {
        return paisRepository.findById(id);
    }
    
    public Pais save(Pais pais) {
        return paisRepository.save(pais);
    }
    
    public void deleteById(Integer id) {
        paisRepository.deleteById(id);
    }
}