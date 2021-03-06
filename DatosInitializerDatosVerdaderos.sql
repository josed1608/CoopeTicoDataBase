USE `coopetico-prod`;
SET SQL_MODE='ALLOW_INVALID_DATES';
DELETE FROM taxista;
DELETE FROM taxi;
DELETE FROM cliente;
DELETE FROM operador;
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
 (200, 'Tomar viaje'),
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
 (500, 'Consultar viajes'),
 (600, 'Pedir viajeoperadora');

INSERT INTO grupo VALUES
('Cliente'),
('Taxista'),
('Administrativo'),
('Telefonista'),
('Gerente'),
('Operador');

INSERT INTO permisos_grupo VALUES
(100, 'Cliente'),
(101, 'Cliente'),
(102, 'Cliente'),
(103, 'Cliente'),
(104, 'Cliente'),
(200, 'Taxista'),
(100, 'Administrativo'),
(101, 'Administrativo'),
(102, 'Administrativo'),
(103, 'Administrativo'),
(104, 'Administrativo'),
(200, 'Administrativo'),
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
(310, 'Administrativo'),
(311, 'Administrativo'),
(400, 'Administrativo'),
(401, 'Administrativo'),
(500, 'Administrativo'),
(600, 'Administrativo'),
(100, 'Gerente'),
(101, 'Gerente'),
(102, 'Gerente'),
(103, 'Gerente'),
(104, 'Gerente'),
(200, 'Gerente'),
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
(500, 'Gerente'),
(600, 'Gerente'),
(100, 'Operador'),
(101, 'Operador'),
(200, 'Operador'),
(600, 'Operador'),
(500, 'Operador');

-- La contraseña es contrasenna para todos
INSERT INTO usuario VALUES
('carlos.vargas12312@gmail.com', 'Carlos', 'Vargas','Artavia', '89904578', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Cliente',TRUE),
('juanmanuel1233@gmail.com', 'Manuel', 'Sanchez','Perez', '89082334', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Cliente',TRUE),
('kevinjimmej@gmail.com', 'Kevin', 'Jimenez','Mejia', '73456327', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Taxista',TRUE),
('carlamerzar@gmail.com', 'Carla', 'Merina','Zaravia', '62028743', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Taxista',TRUE),
('danieloduber@gmail.com', 'Daniel', 'Uber','Carillo', '84831321', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Taxista',TRUE),
('federicocastro@gmail.com', 'Federico', 'Castro','Madriz', '64009097', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Taxista',TRUE),
('alejandro1605@gmail.com', 'Alejandro', 'Fernandez','Gaga', '87343212', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Administrativo',TRUE),
('mariasancho@gmail.com', 'Maria', 'Sanchez','Pereira', '87879034', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Gerente',TRUE),
('fernandozarate@gmail.com', 'Fernando', 'Zarate','Mora', '87859685', '$2a$10$gJ0hUnsEvTp5zyBVo19IHe.GoYKkL3Wy268wGJxG5.k.tUFhSUify', 'foto', 'Operador',TRUE);

INSERT INTO taxista VALUES
('kevinjimmej@gmail.com', '0', 1, 1, 5, 'justificación', '2019-05-01', null),
('carlamerzar@gmail.com', '0', 1, 1, 5, 'justificación', '2019-05-01', null),
('danieloduber@gmail.com', '0', 1, 1, 5, 'prueba', '2019-05-01', null),
('federicocastro@gmail.com', '0', 0, 1, 5, 'Cobro de más a un cliente', '2019-05-01', null);

INSERT INTO taxi VALUES
('123654', 1, '84303254', 'A', 'normal', now(), now(), now(),TRUE,NULL,'kevinjimmej@gmail.com',TRUE,'justificación'),
('420323', 1, '87342434', 'A', 'normal', now(), now(), now(),TRUE,NULL,'carlamerzar@gmail.com',TRUE,'justificación'),
('1000342', 1, '88907843', 'A', 'normal', '2019-05-01', '2020-05-01', '2020-05-01',TRUE,NULL,'kevinjimmej@gmail.com',TRUE,''),
('122783', 1, '67329384', 'A', 'normal', '2020-05-01', '2019-05-01', '2020-05-01',TRUE,NULL,'kevinjimmej@gmail.com',TRUE,''),
('432682', 1, '32014354', 'A', 'normal', '2020-05-01', '2020-05-01', '2019-05-01',TRUE,NULL,'kevinjimmej@gmail.com',TRUE,'');


Insert INTO conduce VALUES
('kevinjimmej@gmail.com', '420323'),
('carlamerzar@gmail.com', '123654');

INSERT INTO cliente VALUES
('carlos.vargas12312@gmail.com'),
('juanmanuel1233@gmail.com');

INSERT INTO operador VALUES
('alejandro1605@gmail.com'),
('fernandozarate@gmail.com'),
('mariasancho@gmail.com');

INSERT INTO viaje VALUES
('123654', '2019-07-29 15:48:00', '2019-07-29 16:26:00', '5000', 0, '', '', 'danieloduber@gmail.com', '', '', 'carlos.vargas12312@gmail.com', 'alejandro1605@gmail.com'),
('420323', '2019-08-29 15:48:00', '2019-08-29 16:26:00', '5000', 0, '', '', 'kevinjimmej@gmail.com', '', '', 'carlos.vargas12312@gmail.com', 'alejandro1605@gmail.com'),
('1000342', '2019-08-29 15:48:00', '2019-08-29 16:26:00', '5000', 0, '', '', 'danieloduber@gmail.com', '', '', 'carlos.vargas12312@gmail.com', 'alejandro1605@gmail.com'),
('122783', '2019-09-29 15:48:00', '2019-09-29 16:26:00', '5000', 0, '', '', 'danieloduber@gmail.com', '', '', 'carlos.vargas12312@gmail.com', 'alejandro1605@gmail.com'),
('432682', '2019-09-29 15:48:00', '2019-09-29 16:26:00', '5000', 0, '', '', 'carlamerzar@gmail.com', '', '', 'carlos.vargas12312@gmail.com', 'alejandro1605@gmail.com'),
('123654', '2019-010-29 15:48:00', '2019-010-29 16:26:00', '5000', 0, '', '', 'danieloduber@gmail.com', '', '', 'carlos.vargas12312@gmail.com', 'alejandro1605@gmail.com'),
('420323', '2019-011-29 15:48:00', '2019-011-29 16:26:00', '5000', 0, '', '', 'federicocastro@gmail.com', '', '', 'carlos.vargas12312@gmail.com', 'alejandro1605@gmail.com');        

INSERT INTO token_recuperacion_contrasena VALUES ('carlos.vargas12312@gmail.com', 'tokenGenerado2', '2019-07-07');
INSERT INTO token_recuperacion_contrasena VALUES ('mariasancho@gmail.com', 'tokenGenerado', '2019-04-04');