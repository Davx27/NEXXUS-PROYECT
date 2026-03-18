# Analisis de la informacion


# Reglas de Negocio – Liga de Fútbol de Salón
## 1. Reglas de negocio sobre Usuarios y Roles

- RN1: Solo el Administrador General puede crear, editar o eliminar usuarios en el sistema.

- RN2: Cada usuario debe tener un rol asignado obligatoriamente.

- **RN3: Un jugador solo puede pertenecer a un equipo por torneo activo.**

- RN4: Los árbitros solo pueden registrar resultados de partidos en los que están asignados.

- RN5: El visitante solo puede acceder a información pública y no puede interactuar con módulos internos.

## 2. Reglas de negocio sobre Inscripciones

- RN6: Los equipos solo se consideran inscritos cuando todos los documentos han sido validados por el Auxiliar Administrativo.

- RN7: No se permite la inscripción de jugadores sin documento de identidad válido.

- RN8: Las inscripciones se cierran automáticamente en la fecha establecida por el Coordinador Deportivo.

- RN9: Todo equipo debe cumplir con el número mínimo y máximo de jugadores establecido por la liga.

## 3. Reglas sobre Torneos, Partidos y Programación

- RN10: La programación de partidos solo puede ser creada o modificada por el Coordinador Deportivo.

- RN11: No se puede programar un partido si alguno de los equipos no está inscrito o tiene sanciones que le impidan participar.

- RN12: Los árbitros deben confirmar su disponibilidad para poder ser asignados a un partido.

- RN13: Los cambios en la programación deben notificarse automáticamente a entrenadores, árbitros y jugadores involucrados.

## 4. Reglas sobre Resultados y Actas

- RN14: Un resultado solo es válido cuando el árbitro registra el acta del partido.

- RN15: Los resultados no pueden ser modificados después de ser aprobados por el Comité Disciplinario.

- RN16: Las estadísticas se actualizan automáticamente al validar el acta del partido.

## 5. Reglas sobre Sanciones y Comité Disciplinario

- RN17: Toda sanción debe basarse en un reporte arbitral oficial.

- RN18: Solo el Comité Disciplinario puede aprobar, rechazar o modificar sanciones.

- RN19: Las sanciones deben notificarse automáticamente al jugador, entrenador y delegado de equipo.

- RN20: Un jugador sancionado no podrá ser programado en partidos mientras la sanción siga activa.

## 6. Reglas sobre Pagos y Documentación

- RN21: Todo pago debe ser validado antes de considerar un equipo como inscrito.

- RN22: Los equipos con pagos pendientes quedan bloqueados en procesos críticos (inscripción, programación, registro de jugadores).

- RN23: Los documentos subidos por los usuarios deben ser verificados manualmente por el Auxiliar Administrativo.


#  Roles del Sistema – Liga de Fútbol de Salón

(Versión Oficial – Reorganizada y Profesional)

##  1. Administrador General

Descripción: Usuario con el nivel más alto de permisos dentro del sistema.
Responsabilidades:

- Gestionar usuarios y roles.

- Administrar torneos, categorías y reglamentos generales.

- Configurar parámetros globales del sistema.

- Supervisar los procesos administrativos y deportivos.

- Generar reportes institucionales.

##  2. Coordinador Deportivo

Descripción: Usuario operativo encargado de ejecutar la logística deportiva del torneo.
Responsabilidades:

- Programar partidos según las decisiones del Comité Deportivo.

- Organizar calendarios, escenarios y horarios.

- Asignar árbitros disponibles.

- Realizar ajustes menores en la programación.

- Supervisar el cumplimiento de las jornadas.

##  3. Comité Deportivo

Descripción: órgano colegiado encargado de decisiones deportivas estratégicas.
Responsabilidades:

- Aprobar o rechazar solicitudes de modificación significativa en la programación.

- Autorizar aplazamientos, reprogramaciones o partidos excepcionales.

- Validar inscripciones tardías o casos especiales.

- Definir lineamientos deportivos del torneo (formato, categorías, reglas).

- Resolver inconformidades deportivas no disciplinarias.

##  4. Comité Disciplinario

Descripción: órgano encargado de evaluar y sancionar comportamientos antideportivos.
Responsabilidades:

- Revisar reportes arbitrales oficiales.

- Aprobar, rechazar o modificar sanciones disciplinarias.

- Gestionar procesos de apelación.

- Publicar decisiones disciplinarias.

- Llevar historial disciplinario por torneo.

##  5. Auxiliar Administrativo

Descripción: Usuario encargado de la verificación documental y procesos administrativos.
Responsabilidades:

- Validar documentos de inscripciones.

- Revisar comprobantes de pago.

- Mantener actualizada la información administrativa.

- Apoyar los procesos de registro de equipos y jugadores.

## 6. Entrenador / Técnico

Descripción: Responsable deportivo de un equipo.
Responsabilidades:

- Gestionar la plantilla de jugadores.

- Consultar horarios, resultados y sanciones.

- Recibir notificaciones deportivas.

- Reportar novedades o solicitudes al Coordinador Deportivo.

## 7. Delegado de Equipo

Descripción: Representante oficial del club ante la liga.
Responsabilidades:

- Inscribir equipos y jugadores.

- Gestionar y subir documentación obligatoria.

- Recibir comunicaciones institucionales.

- Representar al club en procesos deportivos y disciplinarios.

##  8. Jugador

Descripción: Usuario participante del torneo.
Responsabilidades:

- Consultar su perfil deportivo.

- Ver sanciones, estadísticas y programación.

- Recibir notificaciones de la liga y de su equipo.

##  9. Árbitro

Descripción: Usuario encargado de registrar lo sucedido en el partido.
Responsabilidades:

- Registrar resultados oficiales.

- Subir actas arbitrales.

- Reportar sanciones y eventos relevantes.

- Confirmar asistencia a los partidos asignados.

##  10. Visitante (Usuario sin registro)

Descripción: Usuario público con acceso limitado al sistema.
Acciones permitidas:

- Consultar programación de partidos.

- Ver tablas de posiciones y resultados.

- Acceder a noticias y boletines informativos.

- Leer reglamentos y documentos públicos.

- Navegar módulos informativos del portal.



#  Infraestructura Tecnológica Actual
##  1. Recursos Humanos Disponibles

La Liga cuenta con un equipo reducido que opera la mayoría de procesos de manera manual:

- Administrador General: responsable institucional.

- Coordinador Deportivo: organiza torneos y programación.

- Auxiliar Administrativo: maneja inscripciones y documentos.

- Comité Disciplinario: revisa sanciones y reportes.

- Árbitros externos: reportan resultados y actas.

- Entrenadores / Delegados: representantes de los equipos.

**Limitaciones identificadas:**

- Falta de personal especializado en TI.

- Sobrecarga laboral en pocas personas.

- Dependencia de comunicación informal (WhatsApp).

- Decisiones dependen de disponibilidad física.

##  2. Equipamiento y Recursos Físicos

La infraestructura física es básica y orientada a tareas de oficina:

- 1–2 computadores de escritorio de gama baja/media.

- 4–8 GB de RAM y almacenamiento HDD tradicional.

- Sistemas operativos y software no siempre actualizados.

- Impresora multifuncional compartida.

- Archivos físicos para documentos de inscripción y actas.

- Espacio de oficina limitado para archivar papelería.

- Equipos lentos afectan el procesamiento de datos.

- Falta de SSD y hardware moderno.

- Riesgo de pérdida de documentos físicos (humedad, extravío, deterioro).

- No se cuenta con UPS para fallos eléctricos.

- Capacidad de archivo físico insuficiente.

##  3. Recursos Tecnológicos Actuales

El sistema actual se basa en herramientas ofimáticas y comunicación dispersa:

- Uso de Excel para programación, jugadores, sanciones y resultados.

- Word para formularios e inscripciones.

- WhatsApp para enviar documentos, fotos y horarios.

- Gmail para comunicación formal.

- Redes sociales para publicar tablas, sanciones y anuncios.

- Excel no tiene control de versiones → alta probabilidad de errores.

- No existe un sistema unificado para torneos, actas, sanciones o estadísticas.

- No hay una base de datos centralizada.

- Información dispersa en múltiples formatos y plataformas.

- Dependencia de capturas de pantalla o fotos como “evidencia”.

- Dificultad para consultar información histórica.

##  4. Infraestructura de Red y Conectividad

El entorno de red es básico y no está pensado para un sistema centralizado:

- Internet de 10–30 Mbps.

- Router doméstico sin configuraciones avanzadas.

- No existen redes segmentadas ni configuraciones de seguridad.

- No hay hosting propio.

- No hay servidores físicos ni virtuales.

- Velocidad de internet limitada afecta carga/descarga de documentos.

- No existe control de seguridad en la red.

- No hay respaldo automático en la nube.

- Conexión inestable en horas de alta demanda.


- No se dispone de estructura para alojar un sistema multiusuario.

##  5. Seguridad Informática

La seguridad informática es mínima, casi inexistente:

- No hay políticas de contraseñas ni de acceso.

- Contraseñas compartidas entre personal.

- No se realizan copias de seguridad periódicas.

- No hay antivirus corporativo ni monitoreo.

- No existe cifrado de información.

- Documentos sensibles se envían por WhatsApp.

- Riesgo alto de pérdida de información.

- Información sensible expuesta (documentos de identidad de jugadores).

- No existe trazabilidad ni historial de cambios.

- Posibles accesos no autorizados.

- Riesgo de virus o daño por malware.

##  6. Infraestructura de Procesos Actuales (Cómo operan hoy)

Los procesos actuales son manuales y propensos a error:

**Inscripciones:**

- Envío de documentos por WhatsApp/correo → validación manual → impresión → archivo físico.

**Programación:** 

- Hecha en Excel → enviada como captura de pantalla → múltiples versiones circulando.

**Resultados y actas:**

- Acta física o foto → enviada por WhatsApp → transcripción manual en Excel.

**Sanciones:**

- Comité recibe actas en foto → interpreta → publica sanción en imagen en redes.

- Alto nivel de errores humanos.

- Procesos lentos y repetitivos.

- Información duplicada o desactualizada.

- No hay registro oficial centralizado.

- Dificultad para validar autenticidad de actas.

- Cambios constantes obligan a reenviar documentos manualmente.

##  7. Limitaciones Globales de la Infraestructura

Sumando todas las áreas, la liga presenta estas limitaciones críticas:

- Ausencia total de un sistema digital centralizado.

- Alta dependencia de archivos dispersos y mensajería instantánea.

- Bajo nivel de seguridad y protección de datos.

- Falta de trazabilidad, auditoría y control de versiones.

- Procesos manuales que generan demoras y errores.

- Falta de equipo TI, servidores y políticas formales.

- Imposibilidad de generar estadísticas confiables.

- Riesgo permanente de pérdida o modificación de información.

# Primer listado de requisitos 

### RF01 — Gestión de usuarios

CUANDO un Administrador requiera registrar o gestionar un usuario,
EL SISTEMA DEBE permitir crear, actualizar, consultar o eliminar usuarios,
PARA asegurar el control de acceso según roles definidos,
CON validaciones de unicidad de correo/documento, verificación de datos obligatorios y registro de auditoría.

### RF02 — Autenticación por roles

CUANDO un usuario ingrese sus credenciales en el inicio de sesión,
EL SISTEMA DEBE validar la identidad y asignar permisos según el rol,
PARA garantizar acceso seguro y restringido,
CON bloqueo tras intentos fallidos, expiración de sesión y cifrado de credenciales.

### RF03 — Recuperación de contraseña

CUANDO un usuario declare haber olvidado su contraseña,
EL SISTEMA DEBE generar un enlace temporal o código para restablecerla,
PARA permitir la recuperación segura del acceso,
CON tokens de un solo uso y expiración en un tiempo definido.

### RF04 — Registro de equipos

CUANDO un Delegado solicite inscribir un equipo en un torneo,
EL SISTEMA DEBE permitir registrar nombre, categoría, documentos y responsables,
PARA formalizar la participación del equipo,
CON validaciones de documentos completos, formatos permitidos y estado inicial como “pendiente por validar”.

### RF05 — Registro y validación de jugadores

CUANDO un Delegado registre un jugador vinculado a un equipo,
EL SISTEMA DEBE almacenar datos personales, foto y documentos,
PARA habilitar su participación reglamentaria,
CON verificación de edad, duplicidad y consistencia con la categoría correspondiente.

### RF06 — Configuración de torneos

CUANDO el Administrador o Coordinador cree un torneo,
EL SISTEMA DEBE permitir definir categorías, fechas, fases y reglas,
PARA establecer las condiciones operativas del campeonato,
CON validación de fechas, cupos y coherencia de reglas.

### RF07 — Gestión de categorías

CUANDO se requiera crear o modificar categorías de competición,
EL SISTEMA DEBE permitir administrar sus parámetros (edades, reglas),
PARA garantizar que los torneos cumplan lineamientos,
CON restricciones para evitar cambios una vez iniciado el torneo.

### RF08 — Programación de partidos

CUANDO el Coordinador programe encuentros,
EL SISTEMA DEBE generar horarios con escenarios disponibles,
PARA construir el calendario oficial del torneo,
CON validaciones para evitar cruces de horarios, uso doble de escenarios y partidos simultáneos para un mismo equipo.

### RF09 — Asignación de árbitros

CUANDO un partido sea programado,
EL SISTEMA DEBE permitir asignar uno o más árbitros,
PARA garantizar la disponibilidad del oficial de juego,
CON validación de horarios, confirmación del árbitro y notificación automática.

### RF10 — Registro de resultados

CUANDO finalice un partido,
EL SISTEMA DEBE permitir al árbitro registrar marcador, goles y tarjetas,
PARA actualizar oficialmente la información del torneo,
CON bloqueo posterior que impida modificaciones no autorizadas.

### RF11 — Carga y validación de actas arbitrales

CUANDO un árbitro suba un acta en PDF o imagen,
EL SISTEMA DEBE asociarla al partido correspondiente,
PARA garantizar respaldo documental,
CON verificación del formato, tamaño y registro de fecha/hora.

### RF12 — Gestión disciplinaria

CUANDO el Comité revise un acta que contenga eventos disciplinarios,
EL SISTEMA DEBE permitir registrar sanciones con duración y tipo,
PARA mantener el control reglamentario del torneo,
CON validaciones automáticas según el reglamento vigente.

### RF13 — Control automático de tarjetas

CUANDO el sistema reciba tarjetas amarillas o rojas,
EL SISTEMA DEBE sumar automáticamente los valores al jugador,
PARA aplicar suspensiones cuando corresponda,
CON notificación a delegados y bloqueo del jugador suspendido.

### RF14 — Tabla de posiciones

CUANDO se registren nuevos resultados,
EL SISTEMA DEBE recalcular puntos, diferencia de goles y posiciones,
PARA mantener actualizada la clasificación del torneo,
CON criterios configurables según reglas especiales.

### RF15 — Estadísticas avanzadas

CUANDO un usuario consulte estadísticas,
EL SISTEMA DEBE mostrar goles, tarjetas, rendimiento individual y colectivo,
PARA apoyar análisis deportivo,
CON filtros por torneo, equipo, jugador y fase.

### RF16 — Notificaciones automáticas

CUANDO se realice una acción relevante (reprogramación, sanción, resultado),
EL SISTEMA DEBE enviar notificaciones a los usuarios interesados,
PARA mantener comunicación oportuna,
CON preferencia de canal (email, SMS, app) configurable.

### RF17 — Búsquedas y filtros

CUANDO un usuario requiera encontrar información,
EL SISTEMA DEBE ofrecer filtros por torneo, fecha, equipo, jugador y estado,
PARA facilitar consultas rápidas y organizadas,
CON paginación y ordenamiento configurable.

### RF18 — Generación de reportes
 
CUANDO se solicite un reporte,
EL SISTEMA DEBE generar documentos PDF o Excel con datos seleccionados,
PARA apoyar gestión administrativa y deportiva,
CON personalización de columnas y rangos.

### RF19 — Auditoría de eventos

CUANDO se realice cualquier cambio crítico,
EL SISTEMA DEBE registrar usuario, acción, fecha, hora y módulo,
PARA garantizar trazabilidad interna,
CON almacenamiento seguro y consulta por parte del Administrador.

### RF20 — Portal público para visitantes

CUANDO un visitante acceda al sitio web sin iniciar sesión,
EL SISTEMA DEBE mostrar programación, resultados, tablas y sanciones públicas,
PARA facilitar la consulta ciudadana del torneo,
CON información actualizada y sin comprometer datos internos o privados.