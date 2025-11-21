package com.conversionmoneda.moneda.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "pais")
public class Pais {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(name = "Pais")
    private String pais;
    
    @Column(name = "CodigoAlfa2")
    private String codigoAlfa2;
    
    @Column(name = "CodigoAlfa3")
    private String codigoAlfa3;
    
    @ManyToOne
    @JoinColumn(name = "IdMoneda")
    private Moneda moneda;
    
    @Lob
    @Column(name = "Mapa")
    private byte[] mapa;
    
    @Lob
    @Column(name = "Bandera")
    private byte[] bandera;

    // Constructor vacío
    public Pais() {}

    // Constructor con parámetros
    public Pais(String pais, String codigoAlfa2, String codigoAlfa3, Moneda moneda) {
        this.pais = pais;
        this.codigoAlfa2 = codigoAlfa2;
        this.codigoAlfa3 = codigoAlfa3;
        this.moneda = moneda;
    }

    // GETTERS Y SETTERS
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getCodigoAlfa2() {
        return codigoAlfa2;
    }

    public void setCodigoAlfa2(String codigoAlfa2) {
        this.codigoAlfa2 = codigoAlfa2;
    }

    public String getCodigoAlfa3() {
        return codigoAlfa3;
    }

    public void setCodigoAlfa3(String codigoAlfa3) {
        this.codigoAlfa3 = codigoAlfa3;
    }

    public Moneda getMoneda() {
        return moneda;
    }

    public void setMoneda(Moneda moneda) {
        this.moneda = moneda;
    }

    public byte[] getMapa() {
        return mapa;
    }

    public void setMapa(byte[] mapa) {
        this.mapa = mapa;
    }

    public byte[] getBandera() {
        return bandera;
    }

    public void setBandera(byte[] bandera) {
        this.bandera = bandera;
    }
}