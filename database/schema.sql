CREATE DATABASE IF NOT EXISTS proyecto_aws CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE proyecto_aws;
CREATE TABLE IF NOT EXISTS roles(id INT AUTO_INCREMENT PRIMARY KEY,nombre VARCHAR(40) NOT NULL UNIQUE);
CREATE TABLE IF NOT EXISTS permisos(id INT AUTO_INCREMENT PRIMARY KEY,clave VARCHAR(80) NOT NULL UNIQUE,descripcion VARCHAR(150));
CREATE TABLE IF NOT EXISTS rol_permisos(rol_id INT NOT NULL,permiso_id INT NOT NULL,PRIMARY KEY(rol_id,permiso_id),FOREIGN KEY(rol_id) REFERENCES roles(id),FOREIGN KEY(permiso_id) REFERENCES permisos(id));
CREATE TABLE IF NOT EXISTS usuarios(id INT AUTO_INCREMENT PRIMARY KEY,nombre VARCHAR(120) NOT NULL,usuario VARCHAR(60) NOT NULL UNIQUE,correo VARCHAR(150) NOT NULL UNIQUE,password_hash VARCHAR(255) NOT NULL,activo TINYINT(1) NOT NULL DEFAULT 1,rol_id INT NOT NULL,creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(rol_id) REFERENCES roles(id));
INSERT IGNORE INTO roles(nombre) VALUES ('admin'),('viewer');
INSERT IGNORE INTO permisos(clave,descripcion) VALUES ('dashboard:read','Consultar dashboard');
INSERT IGNORE INTO rol_permisos(rol_id,permiso_id) SELECT r.id,p.id FROM roles r CROSS JOIN permisos p WHERE r.nombre IN ('admin','viewer') AND p.clave='dashboard:read';
