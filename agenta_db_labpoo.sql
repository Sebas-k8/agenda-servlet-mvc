DROP DATABASE IF EXISTS agenda_db;
CREATE DATABASE agenda_db CHARACTER SET utf8mb4;

USE agenda_db;

CREATE TABLE contactos (
  id        INT AUTO_INCREMENT PRIMARY KEY,
  nombre    VARCHAR(100) NOT NULL,
  telefono  VARCHAR(20),
  email     VARCHAR(100)
);
select * From contactos;