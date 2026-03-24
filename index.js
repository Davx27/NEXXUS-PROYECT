const express = require('express');
const { v4: uuidv4 } = require('uuid');
const pool = require('./src/config/db'); // Importación de DB

const app = express();

// Configuración de Middlewares
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// ESTA ES LA CLAVE: Servir archivos desde la carpeta public
app.use(express.static('public'));

// ==========================================================
// RUTAS DE LA API (Mantener para funcionalidad de datos)
// ==========================================================

// 1. Crear un usuario (RF01 - Gestión de usuarios)
app.post('/api/usuarios', async (req, res) => {
    const { nombre, apellido, documento, correo, telefono, password } = req.body;

    if (!nombre || !correo || !documento || !password) {
        return res.status(400).json({ error: 'Faltan campos obligatorios.' });
    }

    const nuevoId = uuidv4();
    const sql = `INSERT INTO usuarios (id, nombre, apellido, documento, correo, telefono, password) 
                 VALUES (?, ?, ?, ?, ?, ?, ?)`;

    try {
        await pool.query(sql, [nuevoId, nombre, apellido, documento, correo, telefono, password]);
        res.status(201).json({ mensaje: 'Usuario creado exitosamente', id: nuevoId });
    } catch (err) {
        if (err.code === 'ER_DUP_ENTRY') {
            res.status(409).json({ error: 'El documento o correo ya están registrados.' });
        } else {
            console.error(err);
            res.status(500).json({ error: 'Error interno del servidor.' });
        }
    }
});

// 2. Listar usuarios (Para reportes o administración)
app.get('/api/usuarios', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT id, nombre, apellido, documento, correo FROM usuarios');
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// NOTA: Se eliminó la ruta app.get('/') manual para que use index.html de /public

// ==========================================================
// INICIO DEL SERVIDOR
// ==========================================================
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`-- Servidor Nexxus corriendo en http://localhost:${PORT}`);
});