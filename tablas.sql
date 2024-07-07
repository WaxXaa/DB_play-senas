mariadb -u root -p
show DATABASES;

CREATE OR REPlACE DATABASE `juegos_senas`;
USE `juegos_senas`
SHOW TABLES;
DROP TABLE IF EXISTS Etapas;
CREATE TABLE IF NOT EXISTS Etapas (
    id_etapa INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(500) NOT NULL,
    CONSTRAINT Etapas_IdEtapa_PK PRIMARY KEY (id_etapa)
);

SHOW TABLES;
DROP TABLE IF EXISTS Niveles;
CREATE TABLE IF NOT EXISTS Niveles (
    id_nivel INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(500) NOT NULL,
    etapa INT NOT NULL,
    CONSTRAINT Niveles_IdNivel_PK PRIMARY KEY (id_nivel),
    CONSTRAINT Niveles_EtapasId_FK FOREIGN KEY (etapa) REFERENCES Etapas(id_etapa)
);

SHOW TABLES;
DROP TABLE IF EXISTS Lecciones;
CREATE TABLE IF NOT EXISTS Lecciones (
    id_leccion INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(500) NOT NULL,
    imagen_url VARCHAR(500) NOT NULL,
    CONSTRAINT Lecciones_IdLeccion_PK PRIMARY KEY (id_leccion)
);
SHOW TABLES;
DROP TABLE IF EXISTS Niveles_Lecciones;
CREATE TABLE IF NOT EXISTS Niveles_Lecciones (
    id_nivele_leccion INT AUTO_INCREMENT,
    nivel INT,
    leccion INT,
    CONSTRAINT Niveles_Lecciones_Id_PK PRIMARY KEY (id_nivele_leccion),
    CONSTRAINT Niveles_Lecciones_NivelId_FK FOREIGN KEY (nivel) REFERENCES Niveles(id_nivel),
    CONSTRAINT Niveles_Lecciones_LeccionId_FK FOREIGN KEY (leccion) REFERENCES Lecciones(id_leccion)
);

SHOW TABLES;
DROP TABLE IF EXISTS Tipo_Preguntas;
CREATE TABLE IF NOT EXISTS Tipo_Preguntas (
  id_tipo INT PRIMARY KEY AUTO_INCREMENT,
  tipo VARCHAR(50) NOT NULL
);
SHOW TABLES;
DROP TABLE IF EXISTS Preguntas;
CREATE TABLE IF NOT EXISTS Preguntas (
    id_pregunta INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(500) NOT NULL,
    imagen_url VARCHAR(500) NOT NULL,
    nivel INT NOT NULL,
    tipo INT NOT NULL,
    CONSTRAINT Preguntas_Tipo_FK FOREIGN KEY (tipo) REFERENCES Tipo_Preguntas(id_tipo),
    CONSTRAINT Preguntas_nivel_FK FOREIGN KEY (nivel) REFERENCES Niveles(id_nivel),
    CONSTRAINT Preguntas_IdPregunta_PK PRIMARY KEY (id_pregunta)
);

SHOW TABLES;
DROP TABLE IF EXISTS Respuestas;
CREATE TABLE IF NOT EXISTS Respuestas (
    id_respuesta INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    imagenURL VARCHAR(255) NOT NULL,
    tipo BOOLEAN NOT NULL,
    CONSTRAINT Opciones_IdRespuesta_PK PRIMARY KEY (id_respuesta)
);
SHOW TABLES;
DROP TABLE IF EXISTS Preguntas_Respuestas;
CREATE TABLE IF NOT EXISTS Preguntas_Respuestas (
  id_pregunta_respuesta INT AUTO_INCREMENT,
  pregunta INT NOT NULL,
  respuesta INT NOT NULL,
  CONSTRAINT Preguntas_Respuestas_IdPreguntaRespuesta_PK PRIMARY KEY (id_pregunta_respuesta),
  CONSTRAINT Preguntas_Respuestas_PreguntasId_FK FOREIGN KEY (pregunta) REFERENCES Preguntas(id_pregunta),
  CONSTRAINT Preguntas_Respuestas_RespuestasId_FK FOREIGN KEY (respuesta) REFERENCES Respuestas(id_respuesta)
);
SHOW TABLES;
DROP TABLE IF EXISTS Orden_Respuestas;
CREATE TABLE IF NOT EXISTS Orden_Respuestas (
  id_orden INT AUTO_INCREMENT,
  pregunta INT NOT NULL,
  imagenURL VARCHAR(255) NOT NULL,
  orden INT NOT NULL,
  CONSTRAINT Orden_Respuestas_IdOrden_PK PRIMARY KEY (id_orden),
  CONSTRAINT Orden_Respuestas_PreguntasId_FK FOREIGN KEY (pregunta) REFERENCES Preguntas(id_pregunta)
);
SHOW TABLES;
DROP TABLE IF EXISTS Progreso;
CREATE TABLE IF NOT EXISTS Progreso (
    id_progreso INT AUTO_INCREMENT,
    etapa INT NOT NULL,
    nivel INT NOT NULL,
    completado BOOLEAN NOT NULL DEFAULT 0,
    experiencia INT DEFAULT 0,
    CONSTRAINT Progreso_Id_PK PRIMARY KEY (id_progreso),
    CONSTRAINT Progreso_EtapasId_FK FOREIGN KEY (etapa) REFERENCES Etapas(id_etapa),
    CONSTRAINT Progreso_NivelesId_FK FOREIGN KEY (nivel) REFERENCES Niveles(id_nivel)
);

SHOW TABLES;

DROP TABLE IF EXISTS Tipo_Usuario;
CREATE TABLE IF NOT EXISTS Tipo_Usuario (
    id_tipo INT,
    tipo VARCHAR(50) NOT NULL,
    CONSTRAINT Tipo_Usuario_IdTipo_PK PRIMARY KEY (id_tipo)
);

SHOW TABLES;
CREATE TABLE IF NOT EXISTS Usuarios (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  contra VARCHAR(50) NOT NULL, -- password
  foto_perfil VARCHAR(400) NOT NULL,
  tipo INT NOT NULL,
  progreso INT NOT NULL,
  CONSTRAINT `PK_Usuarios_id` PRIMARY KEY (id_usuario),
  CONSTRAINT Usuarios_TipoUsuarioId_FK FOREIGN KEY (tipo) REFERENCES Tipo_Usuario(id_tipo),
  CONSTRAINT Usuarios_ProgresoId_FK FOREIGN KEY (progreso) REFERENCES Progreso(id_progreso)
);
SHOW TABLES;























-- borrar todo para levantar nuevamente
-- Desactivar las verificaciones de claves foráneas
SET FOREIGN_KEY_CHECKS = 0;

-- Eliminar las tablas
DROP TABLE IF EXISTS Usuarios;
DROP TABLE IF EXISTS Tipo_Usuario;
DROP TABLE IF EXISTS Progreso;
DROP TABLE IF EXISTS Orden_Respuestas;
DROP TABLE IF EXISTS Preguntas_Respuestas;
DROP TABLE IF EXISTS Respuestas;
DROP TABLE IF EXISTS Preguntas;
DROP TABLE IF EXISTS Tipo_Preguntas;
DROP TABLE IF EXISTS Niveles_Lecciones;
DROP TABLE IF EXISTS Lecciones;
DROP TABLE IF EXISTS Niveles;
DROP TABLE IF EXISTS Etapas;

-- Volver a activar las verificaciones de claves foráneas
SET FOREIGN_KEY_CHECKS = 1;
