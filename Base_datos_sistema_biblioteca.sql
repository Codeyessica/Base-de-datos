-- PARTE A - Diseno fisico de bases de datos
DROP DATABASE IF EXISTS sistema_bilioteca;

CREATE DATABASE sistema_biblioteca
CHARACTER SET utf8mb4
COLLATE utf8mb4_spanish_ci;

USE sistema_biblioteca;
-- Tabla socios
CREATE TABLE socios (
id_socio INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR (50) NOT NULL,
dni CHAR (9) NOT NULL,
fecha_alta DATE NOT NULL,
tipo_socio ENUM ('Infantil','Adulto','Senior') NOT NULL,
CONSTRAINT uq_socio_dni UNIQUE (dni)
);
-- Tabla libros
CREATE TABLE libros(
id_libro INT PRIMARY KEY AUTO_INCREMENT,
titulo VARCHAR (150) NOT NULL,
autor VARCHAR (50) NOT NULL, 
isbn CHAR(13) ,
fecha_publicacion YEAR, 
estado ENUM ('Disponible','Prestado','Extraviado') NOT NULL,
CONSTRAINT uq_libro_isbn UNIQUE (isbn)
);
-- Tabla prestamos
CREATE TABLE prestamos(
id_prestamo INT PRIMARY KEY AUTO_INCREMENT ,
id_socio INT ,
id_libro INT,
fecha_prestamo DATE NOT NULL, 
fecha_devolucion DATE ,
CONSTRAINT fk_prestamos_socios
FOREIGN KEY (id_socio)
REFERENCES socios(id_socio), 
CONSTRAINT fk_prestamos_libro
FOREIGN KEY (id_libro)
REFERENCES libros(id_libro),
CONSTRAINT uq_socios_libros
UNIQUE (id_socio, id_libro)
);

-- Parte B - Gestión de usuarios y roles 
-- Crear usuario 
CREATE USER 'biblioteca_app'@'localhost'
IDENTIFIED BY 'LibPass$2026'; 

-- Crear rol llamado rol_consulta
CREATE ROLE rol_consulta;
GRANT select 
ON sistema_biblioteca. *
TO rol_consulta ;

-- Crear rol llamado rol_gestion 
CREATE ROLE rol_gestion;
GRANT INSERT, UPDATE
ON sistema_biblioteca. *
TO rol_gestion;

-- Asignar ambos roles al usuario biblioteca_app
 GRANT rol_consulta, rol_gestion
 TO 'biblioteca_app'@'localhost';
 SET DEFAULT ROLE rol_consulta
 TO 'biblioteca_app'@'localhost';
 
 -- Elimina la cuenta del usuario biblioteca_app
 DROP USER 'biblioteca_app'@'localhost';
 DROP ROLE rol_consulta;
 DROP ROLE rol_gestion; 

