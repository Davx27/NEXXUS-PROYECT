const mysql = require('mysql2');
require('dotenv').config(); // Esto lee tu archivo .env mágicamente

// Creamos el pool de conexiones usando las variables de entorno
const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    port: 3306,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
}).promise(); // Usamos .promise() para poder usar async/await

// Verificación automática al iniciar
pool.getConnection()
    .then(connection => {
        console.log(' Base de datos conectada exitosamente.');
        connection.release();
    })
    .catch(err => {
        console.error(' Error al conectarse a la base de datos:', err.message);
    });

module.exports = pool;


