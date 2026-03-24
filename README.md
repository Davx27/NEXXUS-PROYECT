NEXXUS PROYECT
 
## Descripcion
 
## Objetivos

## Estructura(Para guiarnos)
'''
NEXXUS-PROYECT/
├── docs/                 # Documentación (diagramas, requerimientos, manuales)
├── database/             # Scripts de MySQL (ej. esquema_inventario.sql)
├── src/                  # Código fuente de la aplicación
│   ├── config/           # Configuración de conexión a la base de datos
│   ├── controllers/      # Lógica del negocio (lo que hace cada módulo)
│   ├── models/           # Modelos de datos (consultas a la base de datos)
│   ├── routes/           # Rutas de la API o navegación
│   └── index.js          # Archivo principal que arranca el sistema
├── .env                  # Variables de entorno (contraseñas, puertos) - NUNCA SE SUBE
├── .gitignore            # Archivos ignorados (ya tienes node_modules/, debes agregar .env)
├── package.json          # Dependencias del proyecto (se genera con npm init)
└── README.md             # Descripción general
