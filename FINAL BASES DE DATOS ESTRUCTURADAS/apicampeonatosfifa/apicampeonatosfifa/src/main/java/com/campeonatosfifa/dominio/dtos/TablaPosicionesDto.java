package com.campeonatosfifa.dominio.dtos;

public class TablaPosicionesDto {
    private Integer id;
    private String pais;
    private Integer pj;
    private Integer pg;
    private Integer pe;
    private Integer pp;
    private Integer gf;
    private Integer gc;
    private Integer puntos;

    public TablaPosicionesDto() {}

    public TablaPosicionesDto(Integer id, String pais, Integer pj, Integer pg, 
                             Integer pe, Integer pp, Integer gf, Integer gc, Integer puntos) {
        this.id = id;
        this.pais = pais;
        this.pj = pj;
        this.pg = pg;
        this.pe = pe;
        this.pp = pp;
        this.gf = gf;
        this.gc = gc;
        this.puntos = puntos;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getPais() { return pais; }
    public void setPais(String pais) { this.pais = pais; }
    public Integer getPj() { return pj; }
    public void setPj(Integer pj) { this.pj = pj; }
    public Integer getPg() { return pg; }
    public void setPg(Integer pg) { this.pg = pg; }
    public Integer getPe() { return pe; }
    public void setPe(Integer pe) { this.pe = pe; }
    public Integer getPp() { return pp; }
    public void setPp(Integer pp) { this.pp = pp; }
    public Integer getGf() { return gf; }
    public void setGf(Integer gf) { this.gf = gf; }
    public Integer getGc() { return gc; }
    public void setGc(Integer gc) { this.gc = gc; }
    public Integer getPuntos() { return puntos; }
    public void setPuntos(Integer puntos) { this.puntos = puntos; }
}