const express = require('express');
const mysql = require('mysql2');
const { v4: uuidv4 } = require('uuid'); // Generador de IDs únicos
const app = express();

app.use(express.urlencoded({ extended: false }));

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '', // Tu contraseña
    database: 'proyecto'
});

// RUTA DEL FORMULARIO
app.get('/', (req, res) => {
    res.send(`
        <body style="font-family:sans-serif; background:#f4f7f6; display:flex; justify-content:center; padding:20px;">
            <div style="background:white; padding:30px; border-radius:10px; box-shadow:0 4px 10px rgba(0,0,0,0.1); width:400px;">
                <h2 style="text-align:center; color:#1a73e8;">Registro Nexxus PRO</h2>
                <form action="/agregar" method="POST">
                    <label>Nombre:</label>
                    <input type="text" name="nombre" required style="width:100%; margin-bottom:15px; padding:10px;">
                    
                    <label>Apellido:</label>
                    <input type="text" name="apellido" required style="width:100%; margin-bottom:15px; padding:10px;">
                    
                    <label>Tipo de Documento:</label>
                    <select name="tipo_doc" style="width:100%; margin-bottom:15px; padding:10px;">
                        <option value="CC">Cédula de Ciudadanía</option>
                        <option value="TI">Tarjeta de Identidad</option>
                        <option value="PAS">Pasaporte</option>
                    </select>

                    <label>Número Documento:</label>
                    <input type="text" name="num_doc" required style="width:100%; margin-bottom:15px; padding:10px;">

                    <label>Teléfono:</label>
                    <input type="text" name="telefono" required style="width:100%; margin-bottom:15px; padding:10px;">

                    <label>Correo:</label>
                    <input type="email" name="correo" required style="width:100%; margin-bottom:15px; padding:10px;">

                    <button type="submit" style="width:100%; background:#1a73e8; color:white; border:none; padding:12px; border-radius:5px; cursor:pointer;">REGISTRAR USUARIO</button>
                </form>
            </div>
        </body>
    `);
});

// PROCESO DE AGREGAR CON UUID
app.post('/agregar', (req, res) => {
    const { nombre, apellido, tipo_doc, num_doc, telefono, correo } = req.body;
    
    const nuevoId = uuidv4(); // Genera un ID como: '6c84fb90-12c4-11e1-840d-7b25c5ee775a'
    const documentoFinal = `${tipo_doc}: ${num_doc}`;

    const sql = `INSERT INTO usuarios (id, nombre, apellido, documento, correo, telefono, password) 
                 VALUES (?, ?, ?, ?, ?, ?, 'encriptado_provisorio')`;

    db.query(sql, [nuevoId, nombre, apellido, documentoFinal, correo, telefono], (err) => {
        if (err) {
            console.error(err);
            return res.send("❌ Error: " + err.message);
        }
        res.send('<h1>✅ Registrado con UUID: ' + nuevoId + '</h1><a href="/">Volver</a>');
    });
});

app.listen(3000, () => console.log('🚀 Servidor en http://localhost:3000'));