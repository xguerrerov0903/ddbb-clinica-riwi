# Clínica RIWI — CRUD + Consultas (Node.js, MySQL, Vite)

## 🇪🇸 Español

Aplicación full‑stack para gestionar una clínica: **citas**, **pacientes**, **médicos** y **usuarios**, con consultas agregadas para reporting.  
Backend en **Node.js + Express + MySQL** y frontend **SPA** con **Vite** (HTML + JS).

### 🧭 Estructura
```
ddbb-clinica-riwi-main/
├─ backend/              # API REST (Express)
│  ├─ app.js             # Rutas y servidor
│  ├─ db.js              # Conexión MySQL (dotenv)
│  ├─ crud/              # Controladores CRUD
│  ├─ readcsv.js         # Carga de datos desde CSV (opcional)
│  └─ data_crudclinic.csv# Dataset de ejemplo (citas)
└─ frontend/             # SPA con Vite (HTML + JS vanilla)
   ├─ index.html         # Layout y navbar
   ├─ index.js           # Router simple (SPA)
   ├─ public/            # Vistas (citas, pacientes, etc.)
   └─ js/                # Lógica de vistas/CRUD
```

### ✅ Requisitos
- **Node.js 18+**
- **MySQL 8+**
- **npm**

### ⚙️ Variables de entorno (backend)
Crea `backend/.env` con:
```env
DB_HOST=localhost
DB_USER=root
DB_PASS=tu_password
DB_NAME=clinica
```
> ⚠️ El archivo `readcsv.js` tiene credenciales hardcodeadas (solo para demo). Ajústalas si deseas usar el cargador CSV.

### 🗄️ Esquema de base de datos (SQL de ejemplo)
> El código espera estas tablas/columnas. Si ya tienes un esquema propio, adáptalo.
```sql
CREATE DATABASE IF NOT EXISTS clinica;
USE clinica;

CREATE TABLE usuarios (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  usuario VARCHAR(50) NOT NULL UNIQUE,
  contrasenia VARCHAR(255) NOT NULL
);

CREATE TABLE pacientes (
  id_paciente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE medicos (
  id_medico INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  especialidad VARCHAR(120) NOT NULL
);

CREATE TABLE citas (
  id_cita INT AUTO_INCREMENT PRIMARY KEY,
  id_paciente INT NOT NULL,
  id_medico INT NOT NULL,
  fecha DATE NOT NULL,
  hora TIME NOT NULL,
  motivo VARCHAR(255) NOT NULL,
  descripcion TEXT NULL,
  ubicacion VARCHAR(120) NOT NULL,
  metodo_pago VARCHAR(60) NOT NULL,
  estatus VARCHAR(40) NOT NULL,
  CONSTRAINT fk_cita_paciente FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
  CONSTRAINT fk_cita_medico FOREIGN KEY (id_medico) REFERENCES medicos(id_medico)
);
```

### 🚀 Puesta en marcha
**1) Backend**
```bash
cd backend
npm install
# crea backend/.env (ver arriba)
node app.js
# API en http://localhost:3000  (CORS ya permite http://localhost:5173)
```
**2) Frontend**
```bash
cd frontend
npm install
npm run dev
# Vite en http://localhost:5173
```

### 🧪 Carga de datos demo (opcional)
```bash
cd backend
node readcsv.js  # Inserta citas desde data_crudclinic.csv
```
> Revisa y ajusta credenciales dentro de `readcsv.js` antes de ejecutar.

### 🔌 Endpoints principales (REST)
CRUD estándar para cada recurso (usa `application/json`):

- **Citas**: `GET /citas`, `GET /citas/:id`, `POST /citas`, `PATCH /citas/:id`, `DELETE /citas/:id`
- **Pacientes**: `GET /pacientes`, `GET /pacientes/:id`, `POST /pacientes`, `PATCH /pacientes/:id`, `DELETE /pacientes/:id`
- **Médicos**: `GET /medicos`, `GET /medicos/:id`, `POST /medicos`, `PATCH /medicos/:id`, `DELETE /medicos/:id`
- **Usuarios**: `GET /usuarios`, `GET /usuarios/:id`, `POST /usuarios`, `PATCH /usuarios/:id`, `DELETE /usuarios/:id`

Consultas avanzadas (reportes):
- `GET /consultas/citas-por-medico/:id_medico/:fecha_inicio/:fecha_fin`
- `GET /consultas/pacientes-frecuentes` *(pacientes con varias citas)*
- `GET /consultas/medicos-citas-mes` *(conteo agrupado por mes)*
- `GET /consultas/pagos-por-metodo/:fecha_inicio/:fecha_fin` *(totales por método de pago)*

### 🧾 Ejemplos de petición (JSON)
```jsonc
// POST /pacientes
{ "nombre": "Ana Pérez", "email": "ana@example.com" }

// POST /medicos
{ "nombre": "Dr. Ruiz", "especialidad": "Dermatología" }

// POST /usuarios
{ "usuario": "admin", "contrasenia": "1234" }

// POST /citas
{
  "id_paciente": 1,
  "id_medico": 1,
  "fecha": "2025-08-20",
  "hora": "09:00:00",
  "motivo": "Chequeo",
  "descripcion": "N/A",
  "ubicacion": "Sede Norte",
  "metodo_pago": "Efectivo",
  "estatus": "Confirmada"
}
```

### 🔐 Autenticación (nota)
El **login** del frontend valida contra `/usuarios`, pero **no** hay hashing de contraseñas ni JWT en el backend (uso educativo). No utilizar en producción sin endurecer seguridad.

### 🛠️ Tecnologías
- **Backend:** Node.js, Express 5, mysql2, dotenv, CORS
- **Frontend:** Vite, HTML/JS vanilla (SPA con routing básico)
- **Utilidades:** csv-parser / csv-parse para carga desde CSV

### 🧩 Problemas comunes
- **CORS**: el backend permite `http://localhost:5173` por defecto; si cambias el puerto del frontend, ajusta `app.use(cors({ origin: ... }))` en `backend/app.js`.
- **Tiempo/fecha**: usa formatos `YYYY-MM-DD` (fecha) y `HH:MM:SS` (hora).
- **Esquema**: si los nombres de columnas difieren, adapta los controladores en `backend/crud/*`.

### 📄 Licencia
No se especifica licencia en el repositorio original. Agrega una si corresponde.

---

## 🇬🇧 English

Full‑stack app to manage a clinic: **appointments**, **patients**, **doctors**, and **users**, plus reporting queries.  
Backend: **Node.js + Express + MySQL**. Frontend: **Vite SPA** (HTML + JS).

### 🧭 Project structure
```
ddbb-clinica-riwi-main/
├─ backend/              # REST API (Express)
│  ├─ app.js             # Routes & server
│  ├─ db.js              # MySQL connection (dotenv)
│  ├─ crud/              # CRUD controllers
│  ├─ readcsv.js         # CSV data loader (optional)
│  └─ data_crudclinic.csv# Sample dataset (appointments)
└─ frontend/             # SPA with Vite (HTML + vanilla JS)
   ├─ index.html         # Layout & navbar
   ├─ index.js           # Simple SPA router
   ├─ public/            # Views (appointments, patients, …)
   └─ js/                # View/CRUD logic
```

### ✅ Requirements
- **Node.js 18+**
- **MySQL 8+**
- **npm**

### ⚙️ Environment variables (backend)
Create `backend/.env`:
```env
DB_HOST=localhost
DB_USER=root
DB_PASS=your_password
DB_NAME=clinica
```
> ⚠️ `readcsv.js` contains hardcoded credentials (demo only). Adjust if you plan to use the CSV loader.

### 🗄️ Database schema (sample SQL)
> The code expects the following tables/columns. If you already have a schema, adapt accordingly.
```sql
CREATE DATABASE IF NOT EXISTS clinica;
USE clinica;

CREATE TABLE usuarios (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  usuario VARCHAR(50) NOT NULL UNIQUE,
  contrasenia VARCHAR(255) NOT NULL
);

CREATE TABLE pacientes (
  id_paciente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE medicos (
  id_medico INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  especialidad VARCHAR(120) NOT NULL
);

CREATE TABLE citas (
  id_cita INT AUTO_INCREMENT PRIMARY KEY,
  id_paciente INT NOT NULL,
  id_medico INT NOT NULL,
  fecha DATE NOT NULL,
  hora TIME NOT NULL,
  motivo VARCHAR(255) NOT NULL,
  descripcion TEXT NULL,
  ubicacion VARCHAR(120) NOT NULL,
  metodo_pago VARCHAR(60) NOT NULL,
  estatus VARCHAR(40) NOT NULL,
  CONSTRAINT fk_cita_paciente FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
  CONSTRAINT fk_cita_medico FOREIGN KEY (id_medico) REFERENCES medicos(id_medico)
);
```

### 🚀 Getting started
**1) Backend**
```bash
cd backend
npm install
# create backend/.env (see above)
node app.js
# API at http://localhost:3000  (CORS allows http://localhost:5173 by default)
```
**2) Frontend**
```bash
cd frontend
npm install
npm run dev
# Vite at http://localhost:5173
```

### 🧪 Seed demo data (optional)
```bash
cd backend
node readcsv.js  # Inserts appointments from data_crudclinic.csv
```
> Check and update credentials in `readcsv.js` before running.

### 🔌 Main endpoints (REST)
Standard CRUD for each resource (`application/json`):

- **Appointments**: `GET /citas`, `GET /citas/:id`, `POST /citas`, `PATCH /citas/:id`, `DELETE /citas/:id`
- **Patients**: `GET /pacientes`, `GET /pacientes/:id`, `POST /pacientes`, `PATCH /pacientes/:id`, `DELETE /pacientes/:id`
- **Doctors**: `GET /medicos`, `GET /medicos/:id`, `POST /medicos`, `PATCH /medicos/:id`, `DELETE /medicos/:id`
- **Users**: `GET /usuarios`, `GET /usuarios/:id`, `POST /usuarios`, `PATCH /usuarios/:id`, `DELETE /usuarios/:id`

Reporting/advanced queries:
- `GET /consultas/citas-por-medico/:id_medico/:fecha_inicio/:fecha_fin`
- `GET /consultas/pacientes-frecuentes` *(frequent patients)*
- `GET /consultas/medicos-citas-mes` *(count grouped by month)*
- `GET /consultas/pagos-por-metodo/:fecha_inicio/:fecha_fin` *(totals by payment method)*

### 🧾 Sample request bodies
```jsonc
// POST /pacientes
{ "nombre": "Ana Pérez", "email": "ana@example.com" }

// POST /medicos
{ "nombre": "Dr. Ruiz", "especialidad": "Dermatología" }

// POST /usuarios
{ "usuario": "admin", "contrasenia": "1234" }

// POST /citas
{
  "id_paciente": 1,
  "id_medico": 1,
  "fecha": "2025-08-20",
  "hora": "09:00:00",
  "motivo": "Chequeo",
  "descripcion": "N/A",
  "ubicacion": "Sede Norte",
  "metodo_pago": "Efectivo",
  "estatus": "Confirmada"
}
```

### 🔐 Auth (note)
Frontend login checks against `/usuarios`, but the backend ships **no password hashing/JWT** (educational use). Do **not** use in production without adding proper security.

### 🛠️ Tech stack
- **Backend:** Node.js, Express 5, mysql2, dotenv, CORS
- **Frontend:** Vite, HTML/vanilla JS (simple SPA routing)
- **Utilities:** csv-parser / csv-parse for CSV loading

### 🧩 Common pitfalls
- **CORS**: backend allows `http://localhost:5173` by default; if you change the frontend port, update `app.use(cors({ origin: ... }))` in `backend/app.js`.
- **Dates/time**: use `YYYY-MM-DD` (date) and `HH:MM:SS` (time).
- **Schema**: if your column names differ, adjust the controllers in `backend/crud/*`.

### 📄 License
No explicit license is provided in the original repo. Add one if needed.
