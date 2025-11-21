package com.conversionmoneda.moneda.controller;

import com.conversionmoneda.moneda.entity.Pais;
import com.conversionmoneda.moneda.service.PaisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/paises")
@CrossOrigin(origins = "*")
public class PaisController {
    
    @Autowired
    private PaisService paisService;
    
    @GetMapping
    public List<Pais> listarTodos() {
        return paisService.findAll();
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<Pais> obtenerPorId(@PathVariable Integer id) {
        Optional<Pais> pais = paisService.findById(id);
        return pais.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }
    
    @PostMapping
    public Pais crearPais(@RequestBody Pais pais) {
        return paisService.save(pais);
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<Pais> actualizarPais(@PathVariable Integer id, @RequestBody Pais paisDetalles) {
        Optional<Pais> paisOptional = paisService.findById(id);
        
        if (paisOptional.isPresent()) {
            Pais pais = paisOptional.get();
            pais.setPais(paisDetalles.getPais());
            pais.setCodigoAlfa2(paisDetalles.getCodigoAlfa2());
            pais.setCodigoAlfa3(paisDetalles.getCodigoAlfa3());
            pais.setMoneda(paisDetalles.getMoneda());
            
            Pais paisActualizado = paisService.save(pais);
            return ResponseEntity.ok(paisActualizado);
        }
        
        return ResponseEntity.notFound().build();
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<?> eliminarPais(@PathVariable Integer id) {
        if (paisService.findById(id).isPresent()) {
            paisService.deleteById(id);
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.notFound().build();
    }
}