#DROP SCHEMA `coopetico-dev`;

CREATE SCHEMA `coopetico-dev`;
USE `coopetico-dev`;

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
    apellido1			NVARCHAR(32)	NOT NULL,
    apellido2           NVARCHAR(32)    NOT NULL,
    telefono			VARCHAR(8)		NOT NULL,
    contrasena			CHAR(128)		NOT NULL,
    foto				VARCHAR(512)	NULL,
    id_grupo			VARCHAR(32)		NOT NULL,
    valid               BOOLEAN         NOT NULL DEFAULT FALSE, #esto se usa para el borrado lógico de taxista y cliente
    
    CONSTRAINT fk_usuario_grupo FOREIGN KEY (id_grupo) REFERENCES grupo (pk_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE operador (
	pk_correo_usuario	VARCHAR(64)		PRIMARY KEY,
    
    CONSTRAINT fk_operador_usuario FOREIGN KEY (pk_correo_usuario) REFERENCES usuario (pk_correo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE cliente ( 
	pk_correo_usuario	VARCHAR(64)		PRIMARY KEY,
    
    CONSTRAINT fk_cliente_usuario FOREIGN KEY (pk_correo_usuario) REFERENCES usuario (pk_correo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE taxista (
	pk_correo_usuario	VARCHAR(64)				PRIMARY KEY,
    faltas				ENUM('1','2','3','0')	NOT NULL,
    estado				BIT						NOT NULL,
    hoja_delincuencia	BIT						NOT NULL,
    estrellas			FLOAT                   NOT NULL,
    justificacion       NVARCHAR(1024)          NULL,
    vence_licencia		TIMESTAMP				NOT NULL,

    CONSTRAINT fk_taxista_usuario FOREIGN KEY (pk_correo_usuario) REFERENCES usuario (pk_correo) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE taxi (
	pk_placa			VARCHAR(8)				PRIMARY KEY,
    datafono			BIT						NULL,
    telefono			VARCHAR(8)		        NOT NULL,
    clase				ENUM('A','B','NA')		NOT NULL,
    tipo				ENUM('microbus','wagon','normal') NOT NULL,
    fecha_ven_rtv	    TIMESTAMP				NOT NULL,
    fecha_ven_marchamo	TIMESTAMP				NOT NULL,
    fecha_ven_seguro	TIMESTAMP				NOT NULL,
    valido              BOOLEAN                 NOT NULL DEFAULT TRUE,
    foto                VARCHAR(512)            NULL,
    correo_taxista      VARCHAR(64)             NOT NULL,
    estado				BIT						NOT NULL,
    justificacion       NVARCHAR(1024)          NULL,

    CONSTRAINT fk_taxi_taxista FOREIGN KEY (correo_taxista) REFERENCES taxista (pk_correo_usuario) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE conduce (
    pk_correo_taxista   VARCHAR(64)            NOT NULL,
    pk_placa_taxi       VARCHAR(8)             NOT NULL,

    CONSTRAINT pk_conduce PRIMARY KEY (pk_correo_taxista,pk_placa_taxi),
    CONSTRAINT fk_conduce_taxista FOREIGN KEY (pk_correo_taxista) REFERENCES taxista (pk_correo_usuario) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_conduce_taxi FOREIGN KEY (pk_placa_taxi) REFERENCES taxi (pk_placa) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE viaje (
    pk_placa_taxi		        VARCHAR(8)          NOT NULL,
    pk_fecha_inicio		        VARCHAR(19)         NOT NULL,
    fecha_fin			        VARCHAR(19)			NULL,
    costo				        VARCHAR(8)			NULL,
    estrellas			        INT 				NULL,
    origen	        	        VARCHAR(64)			NOT NULL,
    destino                     VARCHAR(64)			NULL,
    correo_taxista		        VARCHAR(64)			NOT NULL,
    agenda_telefono             VARCHAR(8)			NULL,
    agenda_nombre               VARCHAR(128)		NULL,
    fk_correo_cliente	        VARCHAR(64)			NULL,
    fk_agenda_correo_operador   VARCHAR(64)			NULL,

    CONSTRAINT fk_viaje_cliente FOREIGN KEY (fk_correo_cliente) REFERENCES cliente (pk_correo_usuario) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_viaje_taxi FOREIGN KEY (pk_placa_taxi) REFERENCES taxi (pk_placa) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_viaje_taxista FOREIGN KEY (correo_taxista) REFERENCES taxista (pk_correo_usuario) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_viaje_operador FOREIGN KEY (fk_agenda_correo_operador) REFERENCES operador (pk_correo_usuario) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT pk_viaje PRIMARY KEY (pk_placa_taxi,pk_fecha_inicio)
);

CREATE TABLE token_recuperacion_contrasena (
	fk_correo_usuario   VARCHAR(32)			PRIMARY KEY,
    token				VARCHAR(36),
    fecha_expiracion    TIMESTAMP,
    CONSTRAINT fk_token_usuario FOREIGN KEY (fk_correo_usuario) REFERENCES usuario (pk_correo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE EVENT tr_limpiar_faltas_t
    ON SCHEDULE EVERY 24 HOUR
    DO 
      UPDATE taxista 
      SET faltas = '0';

DELIMITER //
CREATE TRIGGER tr_rango_estrellas_e
BEFORE INSERT ON viaje
FOR EACH ROW
BEGIN
  IF (NEW.`estrellas` > 5 OR NEW.`estrellas` < 0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cantidad de estrellas no está entre 0 y 5';
  END IF;
END; //

CREATE TRIGGER tr_promedio_estrellas_e 
AFTER INSERT ON viaje
FOR EACH ROW BEGIN
		UPDATE taxista t
		SET t.estrellas = (
			SELECT AVG(estrellas) FROM viaje v
			WHERE v.correo_taxista = NEW.correo_taxista
		)
		WHERE t.pk_correo_usuario = NEW.correo_taxista;
END; //

CREATE TRIGGER tr_sumar_tiempo_expiracion_token_before_insert_e 
BEFORE INSERT ON token_recuperacion_contrasena
FOR EACH ROW 
BEGIN
		SET new.fecha_expiracion = TIMESTAMPADD(HOUR, 12, CURRENT_TIMESTAMP);
END; //

CREATE TRIGGER tr_sumar_tiempo_expiracion_token_before_update_e 
BEFORE UPDATE ON token_recuperacion_contrasena
FOR EACH ROW 
BEGIN
		SET new.fecha_expiracion = TIMESTAMPADD(HOUR, 12, CURRENT_TIMESTAMP);
		SET new.fecha_expiracion = TIMESTAMPADD(HOUR, 12, CURRENT_TIMESTAMP);
END; //
DELIMITER ;

CREATE EVENT tr_limpiar_tokens_expirados_t
    ON SCHEDULE EVERY 1 MINUTE
    DO 
      DELETE FROM token_recuperacion_contrasena WHERE TIMESTAMPDIFF(MINUTE, NOW(), fecha_expiracion) < 0;


CREATE EVENT tr_desactivar_taxista_licencia_vencida
    ON SCHEDULE EVERY 1 DAY
    STARTS '2019-05-01 00:01:00'
    DO
      UPDATE taxista 
	  SET estado = FALSE, justificacion =  CONCAT(justificacion , ' Licencia vencida.')
	  WHERE vence_licencia < now() AND estado = TRUE;

CREATE EVENT tr_desactivar_taxi_fecha_rtv_vencida
    ON SCHEDULE EVERY 1 DAY
    STARTS '2019-05-01 00:01:00'
    DO
      UPDATE taxi 
      SET estado = FALSE, justificacion =  CONCAT(justificacion , ' RTV vencido.')
      WHERE fecha_ven_rtv < now() AND estado = TRUE;

CREATE EVENT tr_desactivar_taxi_fecha_marchamo_vencida
    ON SCHEDULE EVERY 1 DAY
    STARTS '2019-05-01 00:01:00'
    DO
      UPDATE taxi 
      SET estado = FALSE, justificacion =  CONCAT(justificacion , ' Marchamo vencido.')
      WHERE fecha_ven_marchamo < now() AND estado = TRUE;

CREATE EVENT tr_desactivar_taxi_fecha_seguro_vencida
    ON SCHEDULE EVERY 1 DAY
    STARTS '2019-05-01 00:01:00'
    DO
    UPDATE taxi 
	SET estado = FALSE, justificacion =  CONCAT(justificacion , ' Seguro vencido.')
    WHERE fecha_ven_seguro < now() AND estado = TRUE;