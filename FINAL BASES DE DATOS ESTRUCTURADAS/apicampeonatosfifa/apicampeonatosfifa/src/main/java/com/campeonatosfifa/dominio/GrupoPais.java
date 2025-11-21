package com.campeonatosfifa.dominio;

import jakarta.persistence.*;

@Entity
@IdClass(GrupoPaisId.class)
@Table(name = "grupo_pais")
public class GrupoPais {
    @Id
    @ManyToOne
    @JoinColumn(name = "id_grupo")
    private Grupo grupo;

    @Id
    @ManyToOne
    @JoinColumn(name = "id_pais")
    private Pais pais;

    public GrupoPais() {}

    public GrupoPais(Grupo grupo, Pais pais) {
        this.grupo = grupo;
        this.pais = pais;
    }

    public Grupo getGrupo() { return grupo; }
    public void setGrupo(Grupo grupo) { this.grupo = grupo; }
    public Pais getPais() { return pais; }
    public void setPais(Pais pais) { this.pais = pais; }
}