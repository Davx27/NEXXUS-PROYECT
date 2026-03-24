DROP DATABASE IF EXISTS nexxus_db;
CREATE DATABASE nexxus_db;
USE nexxus_db;

-- MÓDULO 1: IDENTIDAD Y ACCESO (Gestión de Usuarios)

-- Tabla de Roles: Define quién es Administrador, Árbitro, Jugador o Delegado.
CREATE TABLE roles (
    -- role_id: Usamos BINARY(16) para UUIDs no usamos DEFAULT por error 1901
    role_id BINARY(16) PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE, -- Nombre del rol (ej. 'Administrador')
    role_description TEXT, -- Explicación de los permisos del rol
    role_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Fecha de creación automática
    -- role_updated_at: Se actualiza solo cada vez que se modifique el registro.
    role_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla de Usuarios: La base de todo el sistema.
CREATE TABLE users (
    user_id BINARY(16) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    -- document_type: ENUM para asegurar que solo se ingresen tipos de documento válidos.
    document_type ENUM('Cédula de Ciudadanía', 'Tarjeta de Identidad', 'Pasaporte', 'Cédula de Extranjería') NOT NULL DEFAULT 'Cédula de Ciudadanía',
    document_id VARCHAR(20) UNIQUE NOT NULL, -- El número de identificación debe ser único.
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20),
    password TEXT NOT NULL, -- Guardaremos el hash de la contraseña por seguridad (bcrypt).
    photo_url TEXT, -- Link a la foto de perfil en la nube.
    
    -- NUEVOS PARÁMETROS SOLICITADOS (Integrados para index.js)
    is_verified BOOLEAN DEFAULT FALSE,       -- Para saber si ya confirmó el correo
    verification_token VARCHAR(100),         -- El código que se envía al correo
    reset_token VARCHAR(100),                -- Para el cambio de contraseña
    two_factor_code VARCHAR(6),              -- Para la doble autenticación
    
    user_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    -- INDEX: Optimiza la velocidad cuando busquemos a alguien por su número de documento.
    INDEX idx_user_document (document_type, document_id)
);

DELIMITER //

-- Trigger para la tabla ROLES (Solución Error 1901)
CREATE TRIGGER before_roles_insert BEFORE INSERT ON roles FOR EACH ROW
BEGIN
    -- Si el ID viene vacío, generamos uno nuevo y lo convertimos a binario ordenado (flag 1).
    IF NEW.role_id IS NULL THEN SET NEW.role_id = UUID_TO_BIN(UUID(), 1); END IF;
END //

-- Trigger para la tabla USUARIOS (Solución Error 1901)
CREATE TRIGGER before_users_insert BEFORE INSERT ON users FOR EACH ROW
BEGIN
    IF NEW.user_id IS NULL THEN SET NEW.user_id = UUID_TO_BIN(UUID(), 1); END IF;
END //

DELIMITER ;

-- Tabla intermedia para asignar ROLES a los USUARIOS.
CREATE TABLE user_roles (
    mapped_user_id BINARY(16),
    mapped_role_id BINARY(16),
    PRIMARY KEY (mapped_user_id, mapped_role_id),
    -- Si borras un usuario, sus roles asignados se borran automáticamente (CASCADE).
    CONSTRAINT fk_mapping_user FOREIGN KEY (mapped_user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_mapping_role FOREIGN KEY (mapped_role_id) REFERENCES roles(role_id) ON DELETE CASCADE
);


-- MÓDULO 2: COMPETENCIA Y EQUIPOS (Nexxus Sports)

-- Tabla de Torneos: Organiza las temporadas y categorías en el Meta.
CREATE TABLE tournaments (
    tournament_id BINARY(16) PRIMARY KEY,
    tournament_name VARCHAR(150) NOT NULL,
    category VARCHAR(50), -- Ej: 'Masculino Libre', 'Femenino Juvenil'
    season_year INT, -- Año de la competencia
    -- status: Estados en español para que la interfaz los muestre directamente.
    tournament_status ENUM('Borrador', 'Inscripciones Abiertas', 'En Curso', 'Pausado', 'Finalizado', 'Cancelado') DEFAULT 'Borrador',
    start_date DATE,
    end_date DATE,
    tournament_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tournament_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla de Equipos: Clubes inscritos en el sistema.
CREATE TABLE teams (
    team_id BINARY(16) PRIMARY KEY,
    team_name VARCHAR(150) NOT NULL,
    logo_url TEXT,
    delegate_user_id BINARY(16), -- Relación con el usuario que es el "dueño" o representante.
    is_active BOOLEAN DEFAULT TRUE,
    team_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    team_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_team_delegate FOREIGN KEY (delegate_user_id) REFERENCES users(user_id)
);

-- TRIGGERS PARA TORNEOS Y EQUIPOS
DELIMITER //
CREATE TRIGGER before_tournaments_insert BEFORE INSERT ON tournaments FOR EACH ROW
BEGIN IF NEW.tournament_id IS NULL THEN SET NEW.tournament_id = UUID_TO_BIN(UUID(), 1); END IF; END //

CREATE TRIGGER before_teams_insert BEFORE INSERT ON teams FOR EACH ROW
BEGIN IF NEW.team_id IS NULL THEN SET NEW.team_id = UUID_TO_BIN(UUID(), 1); END IF; END //
DELIMITER ;

-- Tabla de Estadísticas por Torneo (Tabla de Posiciones).
CREATE TABLE tournament_registrations (
    reg_tournament_id BINARY(16),
    reg_team_id BINARY(16),
    -- Datos numéricos para calcular el rendimiento del equipo.
    points_total INT DEFAULT 0,
    played_matches INT DEFAULT 0,
    won_matches INT DEFAULT 0,
    drawn_matches INT DEFAULT 0,
    lost_matches INT DEFAULT 0,
    goals_scored INT DEFAULT 0,   -- Goles a favor
    goals_conceded INT DEFAULT 0, -- Goles en contra
    registration_status ENUM('Pendiente', 'Aprobado', 'Rechazado', 'Retirado') DEFAULT 'Pendiente',
    PRIMARY KEY (reg_tournament_id, reg_team_id),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    registration_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_reg_tournament_ref FOREIGN KEY (reg_tournament_id) REFERENCES tournaments(tournament_id) ON DELETE CASCADE,
    CONSTRAINT fk_reg_team_ref FOREIGN KEY (reg_team_id) REFERENCES teams(team_id) ON DELETE CASCADE
);


-- MÓDULO 3: JUGADORES (Hojas de Vida Deportiva)

-- Tabla de Jugadores: Información técnica adicional.
CREATE TABLE players (
    player_id BINARY(16) PRIMARY KEY,
    player_user_id BINARY(16) UNIQUE, -- Un usuario solo puede tener un perfil de jugador.
    current_team_id BINARY(16) NULL, -- Si es NULL, el jugador es "Agente Libre".
    birth_date DATE NOT NULL,
    -- court_position: Posiciones reales de Fútbol de Salón.
    court_position ENUM('Portero', 'Poste', 'Ala', 'Pivot', 'Universal') DEFAULT 'Universal',
    preferred_foot ENUM('Izquierda', 'Derecha', 'Ambidiestro') DEFAULT 'Derecha',
    height_cm DECIMAL(4,2), 
    weight_kg DECIMAL(5,2), 
    is_free_agent BOOLEAN DEFAULT TRUE, -- Indica si está disponible para ser contratado.
    player_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    player_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_player_to_user FOREIGN KEY (player_user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_player_to_team FOREIGN KEY (current_team_id) REFERENCES teams(team_id) ON DELETE SET NULL
);

-- TRIGGER PARA JUGADORES
DELIMITER //
CREATE TRIGGER before_players_insert BEFORE INSERT ON players FOR EACH ROW
BEGIN IF NEW.player_id IS NULL THEN SET NEW.player_id = UUID_TO_BIN(UUID(), 1); END IF; END //
DELIMITER ;


-- MÓDULO 4: PARTIDOS Y ESTADÍSTICAS (Actas de Juego)

-- Tabla de Partidos: Programación y resultados finales.
CREATE TABLE matches (
    match_id BINARY(16) PRIMARY KEY,
    parent_tournament_id BINARY(16),
    home_team_id BINARY(16), -- Equipo Local
    away_team_id BINARY(16), -- Equipo Visitante
    assigned_referee_id BINARY(16), -- Árbitro (debe estar en la tabla users).
    match_start_time DATETIME NOT NULL,
    match_venue VARCHAR(150) NOT NULL, -- Lugar del encuentro (Coliseo).
    competition_stage VARCHAR(50) DEFAULT 'Temporada Regular',
    -- match_status: Vital para la transmisión en vivo de la App.
    match_status ENUM('Programado', 'Calentamiento', 'En Juego', 'Entretiempo', 'Finalizado', 'Aplazado', 'Cancelado') DEFAULT 'Programado',
    home_score INT DEFAULT 0,
    away_score INT DEFAULT 0,
    digital_report_url TEXT, -- Link al acta oficial firmada.
    match_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    match_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_match_tournament FOREIGN KEY (parent_tournament_id) REFERENCES tournaments(tournament_id),
    CONSTRAINT fk_match_home FOREIGN KEY (home_team_id) REFERENCES teams(team_id),
    CONSTRAINT fk_match_away FOREIGN KEY (away_team_id) REFERENCES teams(team_id),
    CONSTRAINT fk_match_referee FOREIGN KEY (assigned_referee_id) REFERENCES users(user_id)
);

-- TRIGGER PARA PARTIDOS
DELIMITER //
CREATE TRIGGER before_matches_insert BEFORE INSERT ON matches FOR EACH ROW
BEGIN IF NEW.match_id IS NULL THEN SET NEW.match_id = UUID_TO_BIN(UUID(), 1); END IF; END //
DELIMITER ;

-- Tabla de Eventos: Goles y tarjetas ocurridas en cada minuto.
CREATE TABLE match_events (
    -- event_id: Usamos INT AUTO_INCREMENT porque los eventos son miles y no se comparten externamente.
    event_id INT AUTO_INCREMENT PRIMARY KEY, 
    parent_match_id BINARY(16),
    actor_player_id BINARY(16),
    -- event_type: Incluye la Tarjeta Azul (regla única del fútbol de salón).
    event_type ENUM('Gol', 'Tarjeta Amarilla', 'Tarjeta Roja', 'Tarjeta Azul', 'Autogol', 'Gol de Penalti') NOT NULL,
    event_minute INT, 
    event_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_event_to_match FOREIGN KEY (parent_match_id) REFERENCES matches(match_id) ON DELETE CASCADE,
    CONSTRAINT fk_event_to_player FOREIGN KEY (actor_player_id) REFERENCES players(player_id)
);