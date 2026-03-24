// ==========================================================
// 1. LÓGICA PARA EL REGISTRO (register.html)
// ==========================================================
const registerForm = document.getElementById('register_form');

if (registerForm) {
    registerForm.addEventListener('submit', async (e) => {
        e.preventDefault(); // Evita que la página se recargue

        // Capturamos los datos de los inputs
        const formData = {
            nombre: document.getElementById('reg_nombre').value,
            apellido: document.getElementById('reg_apellido').value,
            documento: document.getElementById('reg_documento').value,
            correo: document.getElementById('reg_correo').value,
            password: document.getElementById('reg_password').value
        };

        try {
            // Enviamos los datos a la API que ya tienes en index.js
            const response = await fetch('/api/usuarios', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData)
            });

            const result = await response.json();

            if (response.ok) {
                alert('¡Registro exitoso! Ahora puedes iniciar sesión.');
                window.location.href = 'index.html'; // Lo mandamos al login
            } else {
                alert('Error: ' + result.error);
            }
        } catch (error) {
            console.error('Error en el registro:', error);
            alert('Hubo un problema al conectar con el servidor.');
        }
    });
}

// ==========================================================
// 2. LÓGICA PARA EL LOGIN (index.html)
// ==========================================================
const loginForm = document.getElementById('login_form');

if (loginForm) {
    loginForm.addEventListener('submit', async (e) => {
        e.preventDefault();

        const identifier = document.getElementById('user_identifier').value;
        const password = document.getElementById('user_password').value;

        console.log('Intentando entrar con:', identifier);
        
        // Aquí es donde luego programaremos la validación contra la DB
        alert('Próximamente: Validación de login para ' + identifier);
    });
}