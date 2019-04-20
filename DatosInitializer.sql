USE `coopetico-dev`;
DELETE FROM taxista;
DELETE FROM taxi;
DELETE FROM cliente;
DELETE FROM coopetico;
DELETE FROM usuario;
DELETE FROM permisos_grupo;
DELETE FROM grupo;
DELETE FROM permiso;
DELETE FROM viaje;
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
 (400, 'Agregar administrativo'),
 (401, 'Borrar administrativo'),
 (402, 'Editar permiso'),
 (403, 'Agregar grupo de permisos');

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
(400, 'Gerente'),
(401, 'Gerente'),
(402, 'Gerente'),
(403, 'Gerente');

-- La contraseña es contrasenna para todos
INSERT INTO usuario VALUES
('cliente@cliente.com', 'Cliente', 'apellido', '11111111', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Cliente'),
('coopeticotaxi@gmail.com', 'Cliente', 'apellido', '11111111', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Cliente'),
('taxista@taxista.com', 'Taxista', 'apellido', '11111111', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Taxista'),
('administrativo@administrativo.com', 'Administrativo', 'apellido', '11111111', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Administrativo'),
('gerente@gerente.com', 'Gerente', 'apellido', '11111111', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Gerente');

INSERT INTO taxi VALUES
('AAA111', 1, '11111111', 'A', 'normal', now(), now(), now());

INSERT INTO cliente VALUES
('cliente@cliente.com'),
('coopeticotaxi@gmail.com');

INSERT INTO taxista VALUES
('taxista@taxista.com', '0', 1, 1, 5, 'AAA111', null);

INSERT INTO coopetico VALUES
('administrativo@administrativo.com'),
('gerente@gerente.com');

INSERT INTO token_recuperacion_contrasena VALUES ('gerente@gerente.com', 'tokenGenerado', '2019-04-04');
INSERT INTO token_recuperacion_contrasena VALUES ('cliente@cliente.com', 'tokenGenerado2', '2019-07-07');
