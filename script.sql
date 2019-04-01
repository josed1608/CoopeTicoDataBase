/**DROP SCHEMA coopetico;**/

CREATE SCHEMA coopetico;

USE coopetico;

CREATE TABLE grupo (
	pk_id				VARCHAR(32)			PRIMARY KEY
);

CREATE TABLE permiso (
	pk_id				INT					PRIMARY KEY,
    descripcion			VARCHAR(64)			NOT NULL
);

CREATE TABLE permisos_grupo (
	pk_id_permisos		INT					NOT NULL,
    pk_id_grupo			VARCHAR(32) 		NOT NULL,
    
    CONSTRAINT fk_permiso FOREIGN KEY (pk_id_permisos) REFERENCES permiso (pk_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_grupo FOREIGN KEY (pk_id_grupo) REFERENCES grupo (pk_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT pk_permisos_grupo PRIMARY KEY (pk_id_permisos,pk_id_grupo)
);

CREATE TABLE usuario (
	pk_correo			VARCHAR(64)		PRIMARY KEY,
    nombre				NVARCHAR(32)	NOT NULL,
    apellidos			NVARCHAR(64)	NOT NULL,
    telefono			VARCHAR(8)		NOT NULL,
    contrasena			CHAR(128)		NOT NULL,
    foto				VARCHAR(512)	NULL,
    id_grupo			VARCHAR(32)		NOT NULL,
    salt				CHAR(128)		NOT NULL,
    
    CONSTRAINT fk_usuario_grupo FOREIGN KEY (id_grupo) REFERENCES grupo (pk_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE coopetico (
	pk_correo_usuario	VARCHAR(64)		PRIMARY KEY,
    
    CONSTRAINT fk_coopetico_usuario FOREIGN KEY (pk_correo_usuario) REFERENCES usuario (pk_correo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE taxista (
	pk_correo_usuario	VARCHAR(64)				PRIMARY KEY,
    faltas				ENUM('1','2','3','0')	NOT NULL,
    estado				BIT						NOT NULL,
    hoja_delincuencia	BIT						NOT NULL,
    estrellas			INT	 					NOT NULL,
    
    CONSTRAINT fk_taxista_usuario FOREIGN KEY (pk_correo_usuario) REFERENCES usuario (pk_correo)
);

CREATE TABLE cliente ( 
	pk_correo_usuario	VARCHAR(64)		PRIMARY KEY,
    
    CONSTRAINT fk_cliente_usuario FOREIGN KEY (pk_correo_usuario) REFERENCES usuario (pk_correo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE taxi (
	pk_placa			VARCHAR(8)				PRIMARY KEY,
    datafono			BIT						NULL,
    telefono			VARCHAR(8)		NOT NULL,
    clase				ENUM('A','B','NA')		NOT NULL,
    tipo				ENUM('microbus','wagon','normal') NOT NULL,
    fecha_ven_taxista	TIMESTAMP				NOT NULL,
    fecha_ven_marchamo	TIMESTAMP				NOT NULL,
    fecha_ven_seguro	TIMESTAMP				NOT NULL
);

CREATE TABLE autentica (
	pk_correo_taxista	VARCHAR(64),
    pk_placa_taxi		VARCHAR(8),
    pk_fecha_inicio		TIMESTAMP 			NOT NULL,
    fecha_fin			TIMESTAMP			NOT NULL,
    
    CONSTRAINT fk_autoriza_a_taxista FOREIGN KEY (pk_correo_taxista) REFERENCES taxista (pk_correo_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_autoriza_a_taxi FOREIGN KEY (pk_placa_taxi) REFERENCES taxi (pk_placa) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT pk_autorizado_a PRIMARY KEY (pk_correo_taxista,pk_placa_taxi,pk_fecha_inicio)
);

CREATE TABLE viaje (
    pk_placa_taxi		VARCHAR(8),
    pk_correo_cliente	VARCHAR(64),
    pk_fecha_inicio		TIMESTAMP			NOT NULL,
    fecha_fin			TIMESTAMP			NOT NULL,
    costo				VARCHAR(8)			NOT NULL,
    estrellas			INT					NULL,
    origen_destino		VARCHAR(64)			NOT NULL,
    
    CONSTRAINT fk_viaje_cliente FOREIGN KEY (pk_correo_cliente) REFERENCES cliente (pk_correo_usuario) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_viaje_taxi FOREIGN KEY (pk_placa_taxi) REFERENCES taxi (pk_placa) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT pk_viaje PRIMARY KEY (pk_correo_cliente,pk_placa_taxi,pk_fecha_inicio)
);