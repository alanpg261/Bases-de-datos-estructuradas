package com.campeonatosfifa.dominio;

import jakarta.persistence.*;

@Entity
@Table(name = "campeonato")
public class Campeonato {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "nombre", length = 100, unique = true)
    private String nombre;

    @Column(name = "anio")
    private Integer anio;

    @ManyToOne
    @JoinColumn(name = "id_pais")
    private Pais pais;

    public Campeonato() {}

    public Campeonato(Integer id, String nombre, Integer anio, Pais pais) {
        this.id = id;
        this.nombre = nombre;
        this.anio = anio;
        this.pais = pais;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public Integer getAnio() { return anio; }
    public void setAnio(Integer anio) { this.anio = anio; }
    public Pais getPais() { return pais; }
    public void setPais(Pais pais) { this.pais = pais; }
}