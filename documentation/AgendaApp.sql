DROP DATABASE IF EXISTS AgendaApp;
CREATE DATABASE AgendaApp;
USE AgendaApp ;

-- -----------------------------------------------------
-- Table Usuario
-- -----------------------------------------------------
CREATE TABLE Usuario (
  username VARCHAR(45) NOT NULL,
  password VARCHAR(45) NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  fechaNacimiento DATE NOT NULL,
  nacionalidad VARCHAR(45) NULL,
  ocupacion VARCHAR(45) NULL,
  descripcion VARCHAR(150) NULL,
  PRIMARY KEY (username))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Contacto
-- -----------------------------------------------------
CREATE TABLE Contacto (
  id INT NOT NULL AUTO_INCREMENT,
  idUsuario VARCHAR(45) NOT NULL,
  item VARCHAR(45) NOT NULL,
  valor VARCHAR(60) NOT NULL,
  PRIMARY KEY (id),
  INDEX FK_CONTACTO_TO_USER_idx (idUsuario ASC) ,
  CONSTRAINT FK_CONTACTO_TO_USER
    FOREIGN KEY (idUsuario)
    REFERENCES Usuario (username)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Rol
-- -----------------------------------------------------
CREATE TABLE Rol (
  id INT NOT NULL AUTO_INCREMENT,
  tipo ENUM('ADMINISTRADOR', 'USUARIO', 'EDITOR') NOT NULL,
  idUsuario VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  INDEX FK_ASIGNAR_ROL_TO_USER_idx (idUsuario ASC) ,
  CONSTRAINT FK_ASIGNAR_ROL_TO_USER
    FOREIGN KEY (idUsuario)
    REFERENCES Usuario (username)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Proyecto
-- -----------------------------------------------------
CREATE TABLE Proyecto (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  descripcion TEXT NOT NULL,
  fechaInicio TIMESTAMP NOT NULL,
  fechaPrevistaFin TIMESTAMP NOT NULL,
  ubicacion VARCHAR(250) NOT NULL,
  visibilidad TINYINT NOT NULL DEFAULT 1,
  idUsuario VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_Proyecto_Usuario1_idx (idUsuario ASC) ,
  CONSTRAINT fk_Proyecto_Usuario1
    FOREIGN KEY (idUsuario)
    REFERENCES Usuario (username)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Categoria
-- -----------------------------------------------------
CREATE TABLE Categoria (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  idUsuario VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_Categoria_Usuario1_idx (idUsuario ASC) ,
  CONSTRAINT fk_Categoria_Usuario1
    FOREIGN KEY (idUsuario)
    REFERENCES Usuario (username)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Actividad
-- -----------------------------------------------------
CREATE TABLE Actividad (
  id INT NOT NULL AUTO_INCREMENT,
  idProyecto INT NULL,
  fechaInicio TIMESTAMP NOT NULL,
  fechaFin TIMESTAMP NOT NULL,
  titulo VARCHAR(45) NOT NULL,
  descripcion TEXT NULL,
  estado TINYINT NOT NULL,
  idCategoria INT NOT NULL,
  idUsuario VARCHAR(45) NOT NULL,
  INDEX fk_RegistroActividad_Proyecto1_idx (idProyecto ASC) ,
  PRIMARY KEY (id),
  INDEX fk_Actividad_Categoria1_idx (idCategoria ASC) ,
  INDEX fk_Actividad_Usuario1_idx (idUsuario ASC) ,
  CONSTRAINT fk_RegistroActividad_Proyecto1
    FOREIGN KEY (idProyecto)
    REFERENCES Proyecto (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT fk_Actividad_Categoria1
    FOREIGN KEY (idCategoria)
    REFERENCES Categoria (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT fk_Actividad_Usuario1
    FOREIGN KEY (idUsuario)
    REFERENCES Usuario (username)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Recordatorio
-- -----------------------------------------------------
CREATE TABLE Recordatorio (
  id INT NOT NULL AUTO_INCREMENT,
  titulo VARCHAR(45) NOT NULL,
  descripcion VARCHAR(200) NOT NULL,
  estado TINYINT NOT NULL,
  fecha TIMESTAMP NULL,
  idUsuario VARCHAR(45),
  PRIMARY KEY (id),
  INDEX fk_Recordatorio_Usuario_idx (idUsuario ASC) ,
  CONSTRAINT fk_Recordatorio_Usuario
    FOREIGN KEY (idUsuario)
    REFERENCES Usuario (username)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Plugin
-- -----------------------------------------------------
CREATE TABLE Plugin (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  descripcion TEXT NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Post
-- -----------------------------------------------------
CREATE TABLE Post (
  id INT NOT NULL AUTO_INCREMENT,
  idPlugin INT NOT NULL,
  titulo VARCHAR(100) NULL,
  contenido LONGBLOB NOT NULL,
  fecha TIMESTAMP NOT NULL,
  idEditor VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_Post_Plugin2_idx (idPlugin ASC) ,
  INDEX fk_Post_Usuario1_idx (idEditor ASC) ,
  CONSTRAINT fk_Post_Plugin2
    FOREIGN KEY (idPlugin)
    REFERENCES Plugin (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT fk_Post_Usuario1
    FOREIGN KEY (idEditor)
    REFERENCES Usuario (username)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table PluginsUsuario
-- -----------------------------------------------------
CREATE TABLE PluginsUsuario (
  id INT NOT NULL AUTO_INCREMENT,
  idUsuario VARCHAR(45) NOT NULL,
  idPlugin INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_PluginsUsuario_Usuario1_idx (idUsuario ASC) ,
  INDEX fk_PluginsUsuario_Plugin1_idx (idPlugin ASC) ,
  CONSTRAINT fk_PluginsUsuario_Usuario1
    FOREIGN KEY (idUsuario)
    REFERENCES Usuario (username)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT fk_PluginsUsuario_Plugin1
    FOREIGN KEY (idPlugin)
    REFERENCES Plugin (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Publicacion
-- -----------------------------------------------------
CREATE TABLE Publicacion (
  id INT NOT NULL AUTO_INCREMENT,
  idUsuario VARCHAR(45) NOT NULL,
  titulo VARCHAR(45) NOT NULL,
  contenido LONGBLOB NOT NULL,
  fechaPublicacion TIMESTAMP NOT NULL,
  puntuacion INT NULL DEFAULT 0,
  PRIMARY KEY (id),
  INDEX fk_Publicacion_Usuario1_idx (idUsuario ASC) ,
  CONSTRAINT fk_Publicacion_Usuario1
    FOREIGN KEY (idUsuario)
    REFERENCES Usuario (username)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Seguidores
-- -----------------------------------------------------
CREATE TABLE Seguidores (
  id INT NOT NULL AUTO_INCREMENT,
  idUsuario VARCHAR(45) NOT NULL,
  idSeguidor VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_Seguidores_Usuario1_idx (idUsuario ASC) ,
  INDEX fk_Seguidores_Usuario2_idx (idSeguidor ASC) ,
  CONSTRAINT fk_Seguidores_Usuario1
    FOREIGN KEY (idUsuario)
    REFERENCES Usuario (username)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT fk_Seguidores_Usuario2
    FOREIGN KEY (idSeguidor)
    REFERENCES Usuario (username)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Comentario
-- -----------------------------------------------------
CREATE TABLE Comentario (
  id INT NOT NULL AUTO_INCREMENT,
  idPublicacion INT NOT NULL,
  idUsuario VARCHAR(45) NOT NULL,
  fecha TIMESTAMP NOT NULL,
  contenido VARCHAR(250) NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_Comentario_Publicacion1_idx (idPublicacion ASC) ,
  INDEX fk_Comentario_Usuario1_idx (idUsuario ASC) ,
  CONSTRAINT fk_Comentario_Publicacion1
    FOREIGN KEY (idPublicacion)
    REFERENCES Publicacion (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT fk_Comentario_Usuario1
    FOREIGN KEY (idUsuario)
    REFERENCES Usuario (username)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table SolicitudRolEditor
-- -----------------------------------------------------
CREATE TABLE SolicitudRolEditor (
  id INT NOT NULL AUTO_INCREMENT,
  idUsuario VARCHAR(45) NOT NULL,
  contenido TEXT NOT NULL,
  fecha TIMESTAMP NOT NULL,
  estado TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  INDEX fk_SolicitudRolEditor_Usuario1_idx (idUsuario ASC) ,
  CONSTRAINT fk_SolicitudRolEditor_Usuario1
    FOREIGN KEY (idUsuario)
    REFERENCES Usuario (username)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Puntuacion
-- -----------------------------------------------------

CREATE TABLE  Puntuacion (
  id INT(11) NOT NULL AUTO_INCREMENT,
  punto INT(1) NOT NULL DEFAULT 1,
  idPublicacion INT(11) NOT NULL,
  idUsuario VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_Puntuacion_Usuario1_idx (idUsuario ASC) ,
  INDEX fk_Puntuacion_Publicacion1_idx (idPublicacion ASC),
  CONSTRAINT fk_Puntuacion_Usuario1
    FOREIGN KEY (idUsuario)
    REFERENCES Usuario (username)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT fk_Puntuacion_Publicacion1
    FOREIGN KEY (idPublicacion)
    REFERENCES Publicacion (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Notificacion
-- -----------------------------------------------------

CREATE TABLE Notificacion (
  id INT NOT NULL AUTO_INCREMENT,
  titulo VARCHAR(45) NOT NULL,
  descripcion VARCHAR(200) NOT NULL,
  fechaHora TIMESTAMP NULL,
  idUsuario VARCHAR(45),
  PRIMARY KEY (id),
  INDEX fk_Notificacion_Usuario_idx (idUsuario ASC) ,
  CONSTRAINT fk_Notificacion_Usuario
    FOREIGN KEY (idUsuario)
    REFERENCES Usuario (username)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

INSERT INTO Usuario VALUES ('admin','123','Admin','1998-09-04','GT','Student',NULL);
INSERT INTO Usuario VALUES ('user','123','Admin','1998-09-04','GT','Student',NULL);
INSERT INTO Usuario VALUES ('editor','123','Admin','1998-09-04','GT','Student',NULL);

INSERT INTO Rol VALUES (1,'ADMINISTRADOR','admin');
INSERT INTO Rol VALUES (2,'USUARIO','user');
INSERT INTO Rol VALUES (3,'EDITOR','editor');

INSERT INTO Proyecto(nombre, descripcion, fechaInicio, fechaPrevistaFin, ubicacion, visibilidad, idUsuario) VALUES('Sin Proyecto', '', '2021-02-02', '2021-02-02', '', 0, 'user');
INSERT INTO Categoria(nombre, idUsuario) VALUES('Sin Categoria', 'user');

