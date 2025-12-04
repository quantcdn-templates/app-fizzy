# Fizzy - Quant Cloud Template

Deployment configuration for [Fizzy](https://github.com/basecamp/fizzy) on Quant Cloud. Adds SMTP configuration, URL management, and container-compatible job processing to the base application.

## Quick Start

```bash
cp docker-compose.override.yml.example docker-compose.override.yml
echo "SECRET_KEY_BASE=$(docker compose run fizzy bin/rails secret)" >> .env
docker compose up -d --build
```

- **Application**: http://localhost:3000
- **MailHog** (email viewer): http://localhost:8025

Sign in by entering any email, then view the magic link in MailHog.

## Production Deployment

Required environment variables:

```bash
SECRET_KEY_BASE=<openssl rand -hex 64>
RAILS_ENV=production
APP_HOST=fizzy.yourdomain.com
RAILS_FORCE_SSL=true

# Database
DB_HOST=<database-host>
DB_DATABASE=fizzy
DB_USERNAME=<username>
DB_PASSWORD=<password>

# SMTP (required for magic link auth)
SMTP_ADDRESS=smtp.provider.com
SMTP_PORT=587
SMTP_DOMAIN=yourdomain.com
SMTP_USER_NAME=<username>
SMTP_PASSWORD=<password>

# Run background jobs in-process
RUN_WORKER=true
```

Image: `ghcr.io/quantcdn-templates/app-fizzy:latest`

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `SECRET_KEY_BASE` | ✅ | - | Rails secret key |
| `APP_HOST` | ✅ | - | Hostname (e.g., `localhost:3000` or `fizzy.example.com`) |
| `RAILS_ENV` | - | `production` | Environment |
| `RAILS_FORCE_SSL` | - | `false` | Force HTTPS |
| `DB_HOST` | - | `db` | Database host |
| `DB_DATABASE` | - | `fizzy` | Database name |
| `DB_USERNAME` | - | `fizzy` | Database user |
| `DB_PASSWORD` | - | `fizzy` | Database password |
| `SMTP_ADDRESS` | ✅ | - | SMTP server |
| `SMTP_PORT` | - | `587` | SMTP port |
| `SMTP_DOMAIN` | - | `APP_HOST` | SMTP domain |
| `SMTP_USER_NAME` | - | - | SMTP auth user |
| `SMTP_PASSWORD` | - | - | SMTP auth password |
| `SMTP_ENABLE_STARTTLS_AUTO` | - | `true` | Enable STARTTLS |
| `RUN_WORKER` | - | `false` | Run Solid Queue in-process |

## Commands

```bash
# Rails console
docker compose exec fizzy bin/rails console

# View logs
docker compose logs -f fizzy

# Reset local environment
docker compose down -v && docker compose up -d --build
```

## Licence

MIT
