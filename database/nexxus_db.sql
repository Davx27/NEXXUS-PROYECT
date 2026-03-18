*/ PROYECTO: NEXXUS - SISTEMA PROFESIONAL DE GESTIÓN DEPORTIVA
   OPTIMIZACIÓN: Estructura normalizada, índices y gestión de eventos en tiempo real.
*/

DROP DATABASE IF EXISTS proyecto;
CREATE DATABASE proyecto;
USE proyecto;

-- ==========================================================
-- 1. IDENTIDAD Y ACCESO
-- ==========================================================

CREATE TABLE roles (
    id VARCHAR(36) PRIMARY KEY, 
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE usuarios (
    id VARCHAR(36) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    -- Optimizado a VARCHAR(20) para mejorar el rendimiento de búsqueda
    documento VARCHAR(20) UNIQUE NOT NULL, 
    correo VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    password TEXT NOT NULL,
    foto_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE usuario_roles (
    usuario_id VARCHAR(36),
    rol_id VARCHAR(36),
    PRIMARY KEY (usuario_id, rol_id),
    CONSTRAINT fk_user_rol FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    CONSTRAINT fk_rol_user FOREIGN KEY (rol_id) REFERENCES roles(id) ON DELETE CASCADE
);

-- ==========================================================
-- 2. ESTRUCTURA DE COMPETICIÓN
-- ==========================================================

CREATE TABLE torneos (
    id VARCHAR(36) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    categoria VARCHAR(50),
    anio INT,
    estado ENUM('pendiente', 'activo', 'finalizado') DEFAULT 'pendiente',
    fecha_inicio DATE,
    fecha_fin DATE
);

CREATE TABLE equipos (
    id VARCHAR(36) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    logo_url TEXT,
    delegado_id VARCHAR(36),
    estado BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_equipo_delegado FOREIGN KEY (delegado_id) REFERENCES usuarios(id),
    -- Índice para búsquedas rápidas por nombre de equipo
    INDEX (nombre)
);

-- RELACIÓN CRÍTICA: Inscripción de equipos en torneos
CREATE TABLE torneo_equipos (
    torneo_id VARCHAR(36),
    equipo_id VARCHAR(36),
    PRIMARY KEY (torneo_id, equipo_id),
    CONSTRAINT fk_te_torneo FOREIGN KEY (torneo_id) REFERENCES torneos(id) ON DELETE CASCADE,
    CONSTRAINT fk_te_equipo FOREIGN KEY (equipo_id) REFERENCES equipos(id) ON DELETE CASCADE
);

-- ==========================================================
-- 3. GESTIÓN TÉCNICA DE JUGADORES
-- ==========================================================

CREATE TABLE jugadores (
    id VARCHAR(36) PRIMARY KEY,
    usuario_id VARCHAR(36) UNIQUE,
    -- Vinculación directa con equipo (un jugador pertenece a un equipo actual)
    equipo_id VARCHAR(36), 
    fecha_nacimiento DATE NOT NULL,
    posicion ENUM('Portero', 'Poste', 'Ala', 'Pivot'),
    pierna_habil ENUM('Izquierda', 'Derecha', 'Ambidiestro'),
    altura DECIMAL(4,2),
    peso DECIMAL(5,2),
    busca_equipo BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_j_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    CONSTRAINT fk_j_equipo FOREIGN KEY (equipo_id) REFERENCES equipos(id) ON SET NULL
);

-- ==========================================================
-- 4. PARTIDOS Y ESTADÍSTICAS EN VIVO
-- ==========================================================

CREATE TABLE partidos (
    id VARCHAR(36) PRIMARY KEY,
    torneo_id VARCHAR(36),
    equipo_local_id VARCHAR(36),
    equipo_visitante_id VARCHAR(36),
    arbitro_id VARCHAR(36),
    fecha_hora DATETIME NOT NULL,
    escenario VARCHAR(150) NOT NULL,
    fase VARCHAR(50) DEFAULT 'Regular', -- Grupos, Semifinal, Final
    estado ENUM('programado', 'en_juego', 'finalizado', 'aplazado') DEFAULT 'programado',
    -- Marcadores añadidos para registro final
    goles_local INT DEFAULT 0,
    goles_visitante INT DEFAULT 0,
    url_acta_digital TEXT,
    CONSTRAINT fk_p_torneo FOREIGN KEY (torneo_id) REFERENCES torneos(id),
    CONSTRAINT fk_p_local FOREIGN KEY (equipo_local_id) REFERENCES equipos(id),
    CONSTRAINT fk_p_visitante FOREIGN KEY (equipo_visitante_id) REFERENCES equipos(id),
    CONSTRAINT fk_p_arbitro FOREIGN KEY (arbitro_id) REFERENCES usuarios(id)
);

-- ESTADÍSTICAS PRO: Registro detallado de eventos por jugador
CREATE TABLE eventos_partido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    partido_id VARCHAR(36),
    jugador_id VARCHAR(36),
    tipo_evento ENUM('Gol', 'Tarjeta Amarilla', 'Tarjeta Roja', 'Autogol'),
    minuto_juego INT,
    CONSTRAINT fk_ev_partido FOREIGN KEY (partido_id) REFERENCES partidos(id) ON DELETE CASCADE,
    CONSTRAINT fk_ev_jugador FOREIGN KEY (jugador_id) REFERENCES jugadores(id)
);


