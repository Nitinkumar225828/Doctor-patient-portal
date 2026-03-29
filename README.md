# Doctor Patient Portal

Doctor/patient appointment portal built with JSP, Servlets, Tomcat, and JDBC.

## Demo Login

- Admin: `admin@gmail.com` / `admin`
- User: `patient@example.com` / `patient123`
- Doctor: `ayesha@hospital.com` / `doctor123`

## Local Run

By default, the app connects to MySQL with these fallback values:

- `DB_HOST=127.0.0.1`
- `DB_PORT=3307`
- `DB_NAME=hospital`
- `DB_USER=root`
- `DB_PASSWORD=wasim`

## Render Deploy

This repo includes:

- [`Dockerfile`](./Dockerfile) for Tomcat-based deployment
- [`render.yaml`](./render.yaml) for one-click Render setup
- H2-based demo bootstrap for Render via `BOOTSTRAP_DB=true`

Render deployment uses an in-memory H2 database so the project can come online without a separate MySQL service. Demo data is auto-seeded on startup.
