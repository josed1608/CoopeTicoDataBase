#USE `coopetico-dev`;
DELETE FROM conduce;
DELETE FROM viaje;
DELETE FROM taxi;
DELETE FROM taxista;
DELETE FROM cliente;
DELETE FROM operador;
DELETE FROM usuario;
DELETE FROM permisos_grupo;
DELETE FROM grupo;
DELETE FROM permiso;
DELETE FROM token_recuperacion_contrasena;

INSERT INTO permiso VALUES
 (100, 'Pedir viaje'),
 (101, 'Ver taxis cerca'),
 (102, 'Editar perfil'),
 (103, 'Calificar viaje'),
 (104, 'Ingresar monto'),
 (200, 'Tomar vijae'),
 (300, 'Agregar taxi'),
 (301, 'Agregar taxista'),
 (302, 'Borrar taxi'),
 (303, 'Borrar taxista'),
 (304, 'Editar taxi'),
 (305, 'Editar taxista'),
 (306, 'Asignar taxista a taxi'),
 (307, 'Borrar usuario cliente'),
 (308, 'Asignar rol a usuario'),
 (309, 'Ver historial de viajes de un taxista'),
 (310, 'Consultar taxis'),
 (311, 'Consultar taxista'),
 (400, 'Agregar administrativo'),
 (401, 'Borrar administrativo'),
 (402, 'Editar permiso'),
 (403, 'Agregar grupo de permisos'),
 (404, 'Consultar permisos'),
 (405, 'Asignar permisos'),
 (500, 'Consultar viajes');

INSERT INTO grupo VALUES
('Cliente'),
('Taxista'),
('Administrativo'),
('Telefonista'),
('Gerente');

INSERT INTO permisos_grupo VALUES
(100, 'Cliente'),
(101, 'Cliente'),
(102, 'Cliente'),
(103, 'Cliente'),
(104, 'Cliente'),
(200, 'Taxista'),
(300, 'Administrativo'),
(301, 'Administrativo'),
(302, 'Administrativo'),
(303, 'Administrativo'),
(304, 'Administrativo'),
(305, 'Administrativo'),
(306, 'Administrativo'),
(307, 'Administrativo'),
(308, 'Administrativo'),
(309, 'Administrativo'),
(311, 'Administrativo'),
(400, 'Administrativo'),
(500, 'Administrativo'),
(300, 'Gerente'),
(301, 'Gerente'),
(302, 'Gerente'),
(303, 'Gerente'),
(304, 'Gerente'),
(305, 'Gerente'),
(306, 'Gerente'),
(307, 'Gerente'),
(308, 'Gerente'),
(309, 'Gerente'),
(310, 'Gerente'),
(311, 'Gerente'),
(400, 'Gerente'),
(401, 'Gerente'),
(402, 'Gerente'),
(403, 'Gerente'),
(404, 'Gerente'),
(405, 'Gerente'),
(500, 'Gerente');

-- La contraseña es contrasenna para todos
INSERT INTO usuario VALUES
('cliente@cliente.com', 'Cliente', 'apellido','apellido', '11111111', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Cliente',TRUE),
('coopeticotaxi@gmail.com', 'Cliente', 'apellido','apellido', '11111111', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Cliente',TRUE),
('taxista1@taxista.com', 'Taxista', 'apellido','apellido', '11111111', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Taxista',TRUE),
('taxista2@taxista.com', 'Taxista', 'apellido','apellido', '11111111', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Taxista',TRUE),
('taxistaNoSuspendido@taxista.com', 'Taxista', 'apellido','apellido', '11111111', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Taxista',TRUE),
('taxistaSuspendido@taxista.com', 'Taxista', 'apellido','apellido', '11111111', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Taxista',TRUE),
('administrativo@administrativo.com', 'Administrativo', 'apellido','apellido', '11111111', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Administrativo',TRUE),
('gerente@gerente.com', 'Gerente', 'apellido','apellido', '11111111', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Gerente',TRUE);

INSERT INTO taxista VALUES
('taxista1@taxista.com', '0', 1, 1, 5, 'justificación', '2019-05-01', null),
('taxista2@taxista.com', '0', 1, 1, 5, 'justificación', '2019-05-01', null),
('taxistaNoSuspendido@taxista.com', '0', 1, 1, 5, '', '2019-05-01', null),
('taxistaSuspendido@taxista.com', '0', 0, 1, 5, 'Cobro de más a un cliente', '2019-05-01', null);

INSERT INTO taxi VALUES
('AAA111', 1, '11111111', 'A', 'normal', now(), now(), now(),TRUE,NULL,'taxista1@taxista.com',TRUE,'justificación'),
('BBB111', 1, '11111111', 'A', 'normal', now(), now(), now(),TRUE,NULL,'taxista1@taxista.com',TRUE,'justificación'),
('CCC111', 1, '11111111', 'A', 'normal', '2019-05-01', '2020-05-01', '2020-05-01',TRUE,NULL,'taxista1@taxista.com',TRUE,''),
('DDD111', 1, '11111111', 'A', 'normal', '2020-05-01', '2019-05-01', '2020-05-01',TRUE,NULL,'taxista1@taxista.com',TRUE,''),
('EEE111', 1, '11111111', 'A', 'normal', '2020-05-01', '2020-05-01', '2019-05-01',TRUE,NULL,'taxista1@taxista.com',TRUE,'');

Insert INTO conduce VALUES
('taxista1@taxista.com', 'AAA111'),
('taxista2@taxista.com', 'AAA111');

INSERT INTO cliente VALUES
('cliente@cliente.com'),
('coopeticotaxi@gmail.com');

INSERT INTO operador VALUES
('administrativo@administrativo.com'),
('gerente@gerente.com');

INSERT INTO viaje VALUES
('AAA111', '2019-05-29 15:48:00', '2019-05-29 16:26:00', '5000', 0, '', '', 'taxista1@taxista.com', '', '', 'cliente@cliente.com', 'administrativo@administrativo.com');
        
INSERT INTO token_recuperacion_contrasena VALUES ('cliente@cliente.com', 'tokenGenerado2', '2019-07-07');
INSERT INTO token_recuperacion_contrasena VALUES ('gerente@gerente.com', 'tokenGenerado', '2019-04-04');