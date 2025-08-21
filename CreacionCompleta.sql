CREATE DATABASE Coleccion_Publicaciones

USE Coleccion_publicaciones


CREATE TABLE serie(
	serie_id INT IDENTITY(1,1) PRIMARY KEY CLUSTERED,
	nombre VARCHAR(100) NOT NULL
);

CREATE TABLE volumen(
	volumen_id INT IDENTITY(1,1) PRIMARY KEY,
	numero_volumen INT NOT NULL,
	serie_id INT NOT NULL,
	CONSTRAINT fk_Volumen_Serie FOREIGN KEY (serie_id) REFERENCES serie(serie_id)
);

CREATE TABLE tipo_publicacion(
	tipo_publicacion_id INT IDENTITY(1,1) PRIMARY KEY,
	tipo VARCHAR(20) NOT NULL
);

CREATE TABLE tipo_autor(
	tipo_autor_id INT IDENTITY(1,1) PRIMARY KEY,
	tipo VARCHAR(50) NOT NULL
);


CREATE TABLE pais(
	pais_id INT IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL
);

CREATE TABLE autor(
	autor_id INT IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL,
	pais_id INT NOT NULL,
	tipo_autor_id INT NOT NULL,
	CONSTRAINT fk_autor_pais FOREIGN KEY (pais_id) REFERENCES pais(pais_id),
	CONSTRAINT fk_autor_tipo FOREIGN KEY (tipo_autor_id) REFERENCES tipo_autor(tipo_autor_id)
);


CREATE TABLE editorial(
	editorial_id INT IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL,
	pais_id INT NOT NULL,
	CONSTRAINT fk_editorial_pais FOREIGN KEY (pais_id) REFERENCES pais(pais_id)
);


CREATE TABLE tema(
	tema_id INT IDENTITY(1,1) PRIMARY KEY,
	tema VARCHAR(200) NOT NULL,
);

CREATE TABLE publicacion(
    publicacion_id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    numero_paginas INT NOT NULL,
    fecha_publicacion DATE NOT NULL,
    isbn VARCHAR(20),
    tipo_publicacion_id INT,
    volumen_id INT,
    
    CONSTRAINT fk_publicacion_tipo FOREIGN KEY (tipo_publicacion_id) REFERENCES tipo_publicacion(tipo_publicacion_id),
    CONSTRAINT fk_publicacion_volumen FOREIGN KEY (volumen_id) REFERENCES volumen(volumen_id)
);


CREATE TABLE publicacion_autor(
    publicacion_id INT,
    autor_id INT,
    
    PRIMARY KEY (publicacion_id, autor_id),
    CONSTRAINT fk_pub_autor_publicacion FOREIGN KEY (publicacion_id) REFERENCES publicacion(publicacion_id),
    CONSTRAINT fk_pub_autor_autor FOREIGN KEY (autor_id) REFERENCES autor(autor_id)
);


CREATE TABLE publicacion_editorial(
    publicacion_id INT,
    editorial_id INT,
    
    PRIMARY KEY (publicacion_id, editorial_id),
    CONSTRAINT fk_pub_editorial_publicacion FOREIGN KEY (publicacion_id) REFERENCES publicacion(publicacion_id),
    CONSTRAINT fk_pub_editorial_editorial FOREIGN KEY (editorial_id) REFERENCES editorial(editorial_id)
);


CREATE TABLE publicacion_tema(
    publicacion_id INT,
    tema_id INT,
    
    PRIMARY KEY CLUSTERED (publicacion_id, tema_id),
    CONSTRAINT fk_pub_tema_publicacion FOREIGN KEY (publicacion_id) REFERENCES publicacion(publicacion_id),
    CONSTRAINT fk_pub_tema_tema FOREIGN KEY (tema_id) REFERENCES tema(tema_id)
);

CREATE TABLE descriptor(
    descriptor_id INT IDENTITY(1,1) PRIMARY KEY,
    termino VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    categoria VARCHAR(50), 
    CONSTRAINT uk_descriptor_termino UNIQUE(termino)
);


CREATE TABLE publicacion_descriptor(
    publicacion_descriptor_id INT IDENTITY(1,1) PRIMARY KEY,
    publicacion_id INT NOT NULL,
    descriptor_id INT NOT NULL,
    CONSTRAINT fk_pub_desc_publicacion FOREIGN KEY (publicacion_id) REFERENCES publicacion(publicacion_id) ON DELETE CASCADE,
    CONSTRAINT fk_pub_desc_descriptor FOREIGN KEY (descriptor_id) REFERENCES descriptor(descriptor_id),
    CONSTRAINT uk_publicacion_descriptor UNIQUE(publicacion_id, descriptor_id),
);


CREATE INDEX idx_publicacion_descriptor_pub ON publicacion_descriptor(publicacion_id);
CREATE INDEX idx_publicacion_descriptor_desc ON publicacion_descriptor(descriptor_id);
CREATE INDEX idx_descriptor_categoria ON descriptor(categoria);
CREATE INDEX idx_descriptor_termino ON descriptor(termino);