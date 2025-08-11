
CREATE DATABASE clinica;

USE clinica;

CREATE TABLE pacientes(
    id_paciente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR (100) NOT NULL,
    email VARCHAR (100) UNIQUE NOT NULL
);

CREATE TABLE medicos (
    id_medico INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR (100) NOT NULL,
    especialidad VARCHAR (100)
);

CREATE TABLE citas (
    id_cita INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT,
    id_medico INT,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    motivo VARCHAR (100) NOT NULL,
    descripcion VARCHAR (200) ,
    ubicacion ENUM ('Sede Norte','Sede Centro','Sede Sur'),
    metodo_pago ENUM ('Efectivo','Transferencia','Tarjeta Crédito','Tarjeta Débito'),
    estatus ENUM ('Cancelada','Confirmada','Reprogramada','Pendiente'),
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente) ON DELETE SET NULL,
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medico) ON DELETE SET NULL
);

CREATE TABLE usuarios(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    usuario VARCHAR (25) UNIQUE NOT NULL,
    contrasenia VARCHAR (25) NOT NULL
);

SELECT * FROM usuarios;
/*
SET SQL_SAFE_UPDATES = 0;
DELETE FROM citas;
DELETE FROM pacientes;
DELETE FROM medicos;
TRUNCATE TABLE citas;
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE pacientes;
TRUNCATE TABLE medicos;
SET FOREIGN_KEY_CHECKS = 1;
SET SQL_SAFE_UPDATES = 1;
*/

SELECT m.nombre as Medico, m.especialidad, c.*
FROM citas  c
JOIN medicos m ON c.id_medico = m.id_medico
WHERE c.id_medico = 2 AND c.fecha BETWEEN '2025-02-14' AND '2025-05-08'
ORDER BY c.fecha;




-- Inserta 5 citas (usa IDs que existan en pacientes y medicos)
INSERT INTO citas
(id_paciente, id_medico, fecha, hora, motivo, descripcion, ubicacion, metodo_pago, estatus)
VALUES
(3, 11, '2025-02-14', '09:00:00', 'Control general', 'Chequeo anual',      'Sede Norte',  'Efectivo',          'Confirmada'),
(3, 11, '2025-02-15', '10:30:00', 'Odontología',     'Limpieza dental',    'Sede Centro', 'Tarjeta Crédito',   'Confirmada'),
(3, 6, '2025-03-01', '08:45:00', 'Chequeo',         NULL,                  'Sede Norte',  'Efectivo',          'Pendiente'),
(4, 6, '2025-03-10', '11:15:00', 'Dermatología',    'Primera vez',         'Sede Sur',    'Transferencia',     'Confirmada'),
(4, 11, '2025-04-05', '16:00:00', 'Resultados',      'Revisar estudios',    'Sede Centro', 'Tarjeta Débito',    'Cancelada');


SELECT p.*, 
	COUNT(c.id_cita) AS Total_citas
FROM pacientes p
JOIN citas c ON c.id_paciente = p.id_paciente
GROUP BY p.id_paciente	
HAVING COUNT(*) >= 3;

SELECT * FROM citas;

SELECT 
       m.*,
       COUNT(c.id_cita) AS Total_citas
     FROM medicos m
     JOIN citas c ON c.id_medico = m.id_medico
     WHERE c.fecha BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND CURDATE()
     GROUP BY m.id_medico;
     
INSERT INTO citas
(id_paciente, id_medico, fecha, hora, motivo, descripcion, ubicacion, metodo_pago, estatus)
VALUES
(3, 11, '2025-07-12', '09:00:00', 'Control general', 'Chequeo anual',      'Sede Norte',  'Efectivo',        'Confirmada'),
(3, 11, '2025-07-15', '10:30:00', 'Odontología',     'Limpieza dental',    'Sede Centro', 'Tarjeta Crédito', 'Confirmada'),
(3, 6,  '2025-07-20', '08:45:00', 'Chequeo',         NULL,                 'Sede Norte',  'Efectivo',        'Pendiente'),
(4, 6,  '2025-07-25', '11:15:00', 'Dermatología',    'Primera vez',        'Sede Sur',    'Transferencia',   'Confirmada'),
(4, 11, '2025-08-02', '16:00:00', 'Resultados',      'Revisar estudios',   'Sede Centro', 'Tarjeta Débito',  'Cancelada');


SELECT 
	c.metodo_pago, COUNT(id_cita) AS Total_citas
FROM citas c
WHERE c.fecha BETWEEN '2025-02-14' AND '2025-05-08'
GROUP BY c.metodo_pago;

/*DROP DATABASE clinica;*/

SELECT * FROM pacientes;
