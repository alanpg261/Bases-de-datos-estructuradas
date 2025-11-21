package com.conversionmoneda.moneda.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "moneda")
public class Moneda {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(name = "Moneda")
    private String moneda;
    
    @Column(name = "Sigla")
    private String sigla;
    
    @Column(name = "Simbolo")
    private String simbolo;
    
    @Column(name = "Emisor")
    private String emisor;
    
    @Lob
    @Column(name = "Imagen")
    private byte[] imagen;
    
    @OneToMany(mappedBy = "moneda", cascade = CascadeType.ALL)
    private List<CambioMoneda> cambios;
    
    @OneToMany(mappedBy = "moneda", cascade = CascadeType.ALL)
    private List<Pais> paises;

    // Constructor vacío
    public Moneda() {}

    // Constructor con parámetros
    public Moneda(String moneda, String sigla, String simbolo, String emisor) {
        this.moneda = moneda;
        this.sigla = sigla;
        this.simbolo = simbolo;
        this.emisor = emisor;
    }

    // GETTERS Y SETTERS
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMoneda() {
        return moneda;
    }

    public void setMoneda(String moneda) {
        this.moneda = moneda;
    }

    public String getSigla() {
        return sigla;
    }

    public void setSigla(String sigla) {
        this.sigla = sigla;
    }

    public String getSimbolo() {
        return simbolo;
    }

    public void setSimbolo(String simbolo) {
        this.simbolo = simbolo;
    }

    public String getEmisor() {
        return emisor;
    }

    public void setEmisor(String emisor) {
        this.emisor = emisor;
    }

    public byte[] getImagen() {
        return imagen;
    }

    public void setImagen(byte[] imagen) {
        this.imagen = imagen;
    }

    public List<CambioMoneda> getCambios() {
        return cambios;
    }

    public void setCambios(List<CambioMoneda> cambios) {
        this.cambios = cambios;
    }

    public List<Pais> getPaises() {
        return paises;
    }

    public void setPaises(List<Pais> paises) {
        this.paises = paises;
    }
}