const express = require('express');
const bcrypt = require('bcrypt'); // Seguridad para encriptar contraseñas
const pool = require('./src/config/db'); // Conexión a tu MySQL

const app = express();

// CONFIGURACIÓN DE MIDDLEWARES
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public')); // Sirve los archivos de la carpeta public


// RUTAS DE LA API - SISTEMA NEXXUS


/**
 * 1. REGISTRO DE USUARIOS (RF01)
 * Parámetros solicitados: TyC, Encriptación, Confirmación y Verificación.
 */
app.post('/api/usuarios/registro', async (req, res) => {
    const { 
        first_name, 
        last_name, 
        document_type, 
        document_id, 
        email, 
        phone, 
        password, 
        confirm_password, // Confirmación de contraseña
        accept_terms      // Requerimiento: Acepto TyC
    } = req.body;

    // VALIDACIÓN TyC: Bloqueo desde el servidor
    if (!accept_terms) {
        return res.status(400).json({ error: 'Debes aceptar los términos y condiciones.' });
    }

    // VALIDACIÓN CONFIRMACIÓN: Contraseña y Confirmación deben ser iguales
    if (password !== confirm_password) {
        return res.status(400).json({ error: 'Las contraseñas no coinciden.' });
    }

    if (!first_name || !email || !password || !document_id) {
        return res.status(400).json({ error: 'Faltan campos obligatorios.' });
    }

    try {
        // ENCRIPTACIÓN: Hash de la contraseña antes de guardar
        const hashedPassword = await bcrypt.hash(password, 10);

        // VERIFICACIÓN: Generamos token para confirmar correo
        const verificationToken = Math.random().toString(36).substring(2, 15);

        // No enviamos user_id porque el TRIGGER lo genera automáticamente.
        const sql = `INSERT INTO users 
            (first_name, last_name, document_type, document_id, email, phone, password, verification_token) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)`;

        await pool.query(sql, [
            first_name, 
            last_name, 
            document_type, 
            document_id, 
            email, 
            phone, 
            hashedPassword, 
            verificationToken
        ]);

        res.status(201).json({ 
            mensaje: 'Usuario creado. Revisa tu correo para confirmar tu cuenta.',
            nota: 'En producción, el token se envía por email.' 
        });

    } catch (err) {
        if (err.code === 'ER_DUP_ENTRY') {
            res.status(409).json({ error: 'El documento o correo ya existen.' });
        } else {
            console.error(err);
            res.status(500).json({ error: 'Error interno en el registro.' });
        }
    }
});

/**
 * 2. DOBLE AUTENTICACIÓN (2FA) - Confirmación por código
 */
app.post('/api/usuarios/confirmar-2fa', async (req, res) => {
    const { email, code } = req.body;
    
    try {
        const [rows] = await pool.query('SELECT two_factor_code FROM users WHERE email = ?', [email]);
        
        if (rows.length > 0 && rows[0].two_factor_code === code) {
            res.json({ mensaje: 'Doble autenticación exitosa. Acceso concedido.' });
        } else {
            res.status(401).json({ error: 'Código 2FA incorrecto o expirado.' });
        }
    } catch (err) {
        res.status(500).json({ error: 'Error al verificar 2FA.' });
    }
});

/**
 * 3. RESTABLECER CONTRASEÑA (Solicitud)
 */
app.post('/api/usuarios/recuperar-password', async (req, res) => {
    const { email } = req.body;
    const resetToken = Math.random().toString(36).substring(2, 15);

    try {
        await pool.query('UPDATE users SET reset_token = ? WHERE email = ?', [resetToken, email]);
        res.json({ mensaje: 'Si el correo existe, se enviará un enlace de recuperación.' });
    } catch (err) {
        res.status(500).json({ error: 'Error al procesar recuperación.' });
    }
});

/**
 * 4. LISTAR USUARIOS (Optimizado con BIN_TO_UUID)
 */
app.get('/api/usuarios', async (req, res) => {
    try {
        // Importante: BIN_TO_UUID para que el frontend reciba el ID como texto
        const sql = `SELECT 
            BIN_TO_UUID(user_id, 1) AS id, 
            first_name, last_name, email, document_type, is_verified 
            FROM users`;
        const [rows] = await pool.query(sql);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// ==========================================================
// INICIO DEL SERVIDOR
// ==========================================================
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`
  
    NEXXUS SERVER
    URL: http://localhost:${PORT}
    DB: nexxus_db (UUID & Triggers Ready)
    Security: BCrypt & TyC Protection Active
  
    `);
});