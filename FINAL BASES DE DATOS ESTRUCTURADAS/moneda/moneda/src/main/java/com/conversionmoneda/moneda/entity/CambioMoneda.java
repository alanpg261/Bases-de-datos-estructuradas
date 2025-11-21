package com.conversionmoneda.moneda.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "cambiomoneda")
public class CambioMoneda {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name = "IdMoneda")
    private Moneda moneda;
    
    @Column(name = "Fecha")
    private LocalDateTime fecha;
    
    @Column(name = "Cambio")
    private Float cambio;

    // Constructor vacío
    public CambioMoneda() {}

    // Constructor con parámetros
    public CambioMoneda(Moneda moneda, LocalDateTime fecha, Float cambio) {
        this.moneda = moneda;
        this.fecha = fecha;
        this.cambio = cambio;
    }

    // GETTERS Y SETTERS
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Moneda getMoneda() {
        return moneda;
    }

    public void setMoneda(Moneda moneda) {
        this.moneda = moneda;
    }

    public LocalDateTime getFecha() {
        return fecha;
    }

    public void setFecha(LocalDateTime fecha) {
        this.fecha = fecha;
    }

    public Float getCambio() {
        return cambio;
    }

    public void setCambio(Float cambio) {
        this.cambio = cambio;
    }
}