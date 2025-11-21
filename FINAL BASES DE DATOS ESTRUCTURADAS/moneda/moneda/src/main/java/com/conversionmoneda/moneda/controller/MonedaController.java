package com.conversionmoneda.moneda.controller;

import com.conversionmoneda.moneda.entity.Moneda;
import com.conversionmoneda.moneda.service.MonedaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/monedas")
@CrossOrigin(origins = "*")
public class MonedaController {
    
    @Autowired
    private MonedaService monedaService;
    
    @GetMapping
    public List<Moneda> listarTodas() {
        return monedaService.findAll();
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<Moneda> obtenerPorId(@PathVariable Integer id) {
        Optional<Moneda> moneda = monedaService.findById(id);
        return moneda.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }
    
    @PostMapping("/agregar")
    public Moneda agregarMoneda(@RequestBody Moneda moneda) {
        return monedaService.save(moneda);
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<Moneda> actualizarMoneda(@PathVariable Integer id, @RequestBody Moneda monedaDetalles) {
        Optional<Moneda> monedaOptional = monedaService.findById(id);
        
        if (monedaOptional.isPresent()) {
            Moneda moneda = monedaOptional.get();
            moneda.setMoneda(monedaDetalles.getMoneda());
            moneda.setSigla(monedaDetalles.getSigla());
            moneda.setSimbolo(monedaDetalles.getSimbolo());
            moneda.setEmisor(monedaDetalles.getEmisor());
            
            Moneda monedaActualizada = monedaService.save(moneda);
            return ResponseEntity.ok(monedaActualizada);
        }
        
        return ResponseEntity.notFound().build();
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<?> eliminarMoneda(@PathVariable Integer id) {
        if (monedaService.findById(id).isPresent()) {
            monedaService.deleteById(id);
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.notFound().build();
    }
}