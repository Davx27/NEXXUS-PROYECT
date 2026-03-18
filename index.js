const express = require('express');
const mysql = require('mysql2');
const { v4: uuidv4 } = require('uuid');
const path = require('path');

const app = express();

// Configuración para recibir datos de formularios y JSON
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// CONFIGURACIÓN DE LA CONEXIÓN (Abstracción para facilitar cambios)
const dbConfig = {
    host: '127.0.0.1',
    user: 'root',
    password: '', // Tu contraseña de MySQL
    database: 'proyecto',
    port: 3306
};

// Crear pool de conexiones (Más eficiente que una conexión única para muchos usuarios)
const pool = mysql.createPool(dbConfig).promise();

// VERIFICACIÓN DE CONEXIÓN
async function checkConnection() {
    try {
        const connection = await pool.getConnection();
        console.log('Conexión a MySQL establecida (Pool activo).');
        connection.release();
    } catch (err) {
        console.error('Error crítico de conexión:', err.message);
    }
}
checkConnection();

// ==========================================================
// RUTAS DE LA API (Preparadas para independencia del Front-end)
// ==========================================================

// 1. Ruta para registrar usuarios (POST)
app.post('/api/usuarios', async (req, res) => {
    const { nombre, apellido, documento, correo, telefono, password } = req.body;

    // Validación básica de datos
    if (!nombre || !correo || !documento) {
        return res.status(400).json({ error: 'Faltan campos obligatorios.' });
    }

    const nuevoId = uuidv4();
    
    const sql = `INSERT INTO usuarios (id, nombre, apellido, documento, correo, telefono, password) 
                 VALUES (?, ?, ?, ?, ?, ?, ?)`;

    try {
        await pool.query(sql, [nuevoId, nombre, apellido, documento, correo, telefono, password || '12345']);
        
        // En lugar de enviar HTML, enviamos JSON (estándar de API profesional)
        res.status(201).json({
            mensaje: 'Usuario creado exitosamente',
            id: nuevoId
        });
    } catch (err) {
        console.error(err);
        if (err.code === 'ER_DUP_ENTRY') {
            res.status(409).json({ error: 'El documento o correo ya están registrados.' });
        } else {
            res.status(500).json({ error: 'Error interno del servidor.' });
        }
    }
});

// 2. Ruta para listar usuarios (GET)
app.get('/api/usuarios', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT id, nombre, apellido, documento, correo FROM usuarios');
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// ==========================================================
// RUTA TEMPORAL PARA EL FORMULARIO (Frontend básico)
// ==========================================================
app.get('/', (req, res) => {
    res.send(`
        <body style="font-family:sans-serif; background:#eef2f7; display:flex; justify-content:center; padding:50px;">
            <div style="background:white; padding:30px; border-radius:15px; box-shadow:0 10px 25px rgba(0,0,0,0.1); width:400px;">
                <h2 style="color:#1a73e8; text-align:center;">Nexxus Pro - Registro</h2>
                <form action="/api/usuarios" method="POST">
                    <input type="text" name="nombre" placeholder="Nombre" required style="width:100%; margin-bottom:15px; padding:12px; border:1px solid #ddd; border-radius:8px;">
                    <input type="text" name="apellido" placeholder="Apellido" required style="width:100%; margin-bottom:15px; padding:12px; border:1px solid #ddd; border-radius:8px;">
                    <input type="text" name="documento" placeholder="Documento (DNI/CC)" required style="width:100%; margin-bottom:15px; padding:12px; border:1px solid #ddd; border-radius:8px;">
                    <input type="email" name="correo" placeholder="Correo electrónico" required style="width:100%; margin-bottom:15px; padding:12px; border:1px solid #ddd; border-radius:8px;">
                    <input type="text" name="telefono" placeholder="Teléfono" style="width:100%; margin-bottom:15px; padding:12px; border:1px solid #ddd; border-radius:8px;">
                    <button type="submit" style="width:100%; background:#1a73e8; color:white; border:none; padding:15px; border-radius:8px; cursor:pointer; font-weight:bold;">CREAR CUENTA</button>
                </form>
            </div>
        </body>
    `);
});

// INICIO DEL SERVIDOR
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log (` Servidor Nexxus corriendo en http://localhost:\${PORT}`)
});