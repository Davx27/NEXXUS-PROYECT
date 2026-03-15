DROP DATABASE IF EXISTS proyecto;
CREATE DATABASE proyecto;
USE proyecto;


CREATE TABLE roles (
    -- Usamos VARCHAR(36) para compatibilidad con UUIDs (Identificadores Únicos Universales)
    id VARCHAR(36) PRIMARY KEY, 
    nombre VARCHAR(60) NOT NULL UNIQUE, -- Nombre del rol (ej: 'Administrador') --
    descripcion TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE usuarios (
    id VARCHAR(36) PRIMARY KEY, -- Identificador único generado por Node.js (UUID) --
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    documento VARCHAR(100) UNIQUE NOT NULL, 
    correo VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    password TEXT NOT NULL, 
    foto_url TEXT, -- Ruta o enlace a la foto de perfil (.jpg, .png) --
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE usuario_roles (
    usuario_id VARCHAR(36),
    rol_id VARCHAR(36),
    PRIMARY KEY (usuario_id, rol_id),
    CONSTRAINT fk_usuario_rol FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    CONSTRAINT fk_rol_usuario FOREIGN KEY (rol_id) REFERENCES roles(id) ON DELETE CASCADE
);


CREATE TABLE torneos (
    id VARCHAR(36) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    categoria VARCHAR(50),
    anio INT,
    estado ENUM('pendiente', 'activo', 'finalizado') DEFAULT 'pendiente',
    fecha_inicio DATE,
    fecha_fin DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE equipos (
    id VARCHAR(36) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    logo_url TEXT,
    delegado_id VARCHAR(36),
    estado BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_delegado FOREIGN KEY (delegado_id) REFERENCES usuarios(id)
);


CREATE TABLE jugadores (
    id VARCHAR(36) PRIMARY KEY,
    usuario_id VARCHAR(36) UNIQUE,
    fecha_nacimiento DATE NOT NULL,
    posicion_principal ENUM('Portero', 'Poste', 'Ala', 'Pivot'),
    pierna_habil ENUM('Izquierda', 'Derecha', 'Ambidiestro'),
    altura DECIMAL(5,2),
    peso DECIMAL(5,2),
    video_highlights_url TEXT,
    busca_equipo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_usuario_jugador FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);


CREATE TABLE partidos (
    id VARCHAR(36) PRIMARY KEY,
    torneo_id VARCHAR(36),
    equipo_local_id VARCHAR(36),
    equipo_visitante_id VARCHAR(36),
    arbitro_id VARCHAR(36),
    fecha_hora DATETIME NOT NULL,
    escenario VARCHAR(150) NOT NULL,
    estado ENUM('programado', 'en_juego', 'finalizado', 'aplazado', 'cancelado') DEFAULT 'programado',
    url_acta_digital TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_torneo_partido FOREIGN KEY (torneo_id) REFERENCES torneos(id) ON DELETE CASCADE,
    CONSTRAINT fk_local FOREIGN KEY (equipo_local_id) REFERENCES equipos(id),
    CONSTRAINT fk_visitante FOREIGN KEY (equipo_visitante_id) REFERENCES equipos(id),
    CONSTRAINT fk_arbitro FOREIGN KEY (arbitro_id) REFERENCES usuarios(id)
);

select * from usuarios;



