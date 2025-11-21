package com.campeonatosfifa.dominio;

import java.io.Serializable;
import java.util.Objects;

public class GrupoPaisId implements Serializable {
    private Integer grupo;
    private Integer pais;

    public GrupoPaisId() {}

    public GrupoPaisId(Integer grupo, Integer pais) {
        this.grupo = grupo;
        this.pais = pais;
    }

    public Integer getGrupo() { return grupo; }
    public void setGrupo(Integer grupo) { this.grupo = grupo; }
    public Integer getPais() { return pais; }
    public void setPais(Integer pais) { this.pais = pais; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        GrupoPaisId that = (GrupoPaisId) o;
        return Objects.equals(grupo, that.grupo) && Objects.equals(pais, that.pais);
    }

    @Override
    public int hashCode() {
        return Objects.hash(grupo, pais);
    }
}