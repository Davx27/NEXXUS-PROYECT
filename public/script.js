// ==========================================================
// 1. LÓGICA PARA EL REGISTRO (register.html)
// ==========================================================
const registerForm = document.getElementById('register_form');

if (registerForm) {
    registerForm.addEventListener('submit', async (e) => {
        e.preventDefault();

        // Extraemos todos los datos nuevos y los mapeamos al inglés
        const formData = {
            first_name: document.getElementById('reg_nombre').value,
            last_name: document.getElementById('reg_apellido').value,
            document_type: document.getElementById('reg_tipo_doc').value, // Nuevo
            document_id: document.getElementById('reg_documento').value,
            email: document.getElementById('reg_correo').value,
            phone: document.getElementById('reg_telefono').value, // Nuevo
            password: document.getElementById('reg_password').value,
            confirm_password: document.getElementById('reg_confirm_password').value, // Nuevo
            accept_terms: document.getElementById('reg_terminos').checked // Nuevo (true/false)
        };

        try {
            const response = await fetch('/api/usuarios/registro', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData)
            });

            const result = await response.json();

            if (response.ok) {
                alert('¡Registro exitoso! Ya puedes iniciar sesión.');
                window.location.href = 'index.html'; // Te devuelve al login
            } else {
                alert('Error al registrar: ' + (result.error || 'Datos inválidos'));
            }
        } catch (error) {
            console.error('Error:', error);
            alert('No se pudo conectar con el servidor.');
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

        try {
            const response = await fetch('/api/usuarios/login', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                // Enviamos identifier como email, asumiendo que el backend valida por ahí
                body: JSON.stringify({ email: identifier, password: password }) 
            });

            const result = await response.json();

            if (response.ok) {
                alert('¡Inicio de sesión correcto!');
                // Aquí en el futuro lo rediriges a su panel (ej. window.location.href = 'panel.html')
            } else {
                alert('Error: ' + (result.error || 'Credenciales incorrectas'));
            }
        } catch (error) {
            console.error('Error:', error);
            alert('Fallo al conectar con el servidor.');
        }
    });
}

// ==========================================================
// 3. LÓGICA PARA RECUPERAR CONTRASEÑA (recover.html)
// ==========================================================
const recoverForm = document.getElementById('recover_form');

if (recoverForm) {
    recoverForm.addEventListener('submit', async (e) => {
        e.preventDefault();

        const email = document.getElementById('recover_email').value;

        try {
            const response = await fetch('/api/usuarios/recuperar-password', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ email: email })
            });

            const result = await response.json();

            if (response.ok) {
                // El backend responde con la propiedad "mensaje" si todo sale correcto
                alert(result.mensaje);
                window.location.href = 'index.html'; // Lo devolvemos al login
            } else {
                alert('Error: ' + (result.error || 'No se pudo procesar la solicitud.'));
            }
        } catch (error) {
            console.error('Error:', error);
            alert('Error al conectar con el servidor.');
        }
    });
}