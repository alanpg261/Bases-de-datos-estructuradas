package com.conversionmoneda.moneda.controller;

import com.conversionmoneda.moneda.entity.CambioMoneda;
import com.conversionmoneda.moneda.service.CambioMonedaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@RestController
@RequestMapping("/api/cambios")
@CrossOrigin(origins = "*")
public class CambioMonedaController {
    
    @Autowired
    private CambioMonedaService cambioMonedaService;
    
    @GetMapping("/listarporperiodo")
    public ResponseEntity<List<CambioMoneda>> listarPorPeriodo(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta,
            @RequestParam String sigla) {
        
        LocalDateTime fechaDesde = desde.atStartOfDay();
        LocalDateTime fechaHasta = hasta.atTime(LocalTime.MAX);
        
        List<CambioMoneda> cambios = cambioMonedaService.findByMonedaSiglaAndFechaBetween(sigla, fechaDesde, fechaHasta);
        return ResponseEntity.ok(cambios);
    }
    
    @GetMapping
    public List<CambioMoneda> listarTodos() {
        return cambioMonedaService.findAll();
    }
    
    @PostMapping
    public CambioMoneda crearCambio(@RequestBody CambioMoneda cambioMoneda) {
        return cambioMonedaService.save(cambioMoneda);
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<?> eliminarCambio(@PathVariable Integer id) {
        if (cambioMonedaService.findById(id).isPresent()) {
            cambioMonedaService.deleteById(id);
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.notFound().build();
    }
}