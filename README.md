# Docker Traefik

## Features
- Traefik Proxy with Auto TLS Support
- Portainer (Container Management UI)
- Dozzle (Logger)
- PostgreSQL (Private Network)
- Redis (Private Network)

## Prerequisites
- Docker and Docker Compose installed
- Domain name with DNS configured
- Cloudflare account (if using Cloudflare)
- `htpasswd` utility (`apache2-utils` package)

## Setup Instructions

### 1. Initial Configuration
1. Generate Basic Auth credentials
  ```bash
  htpasswd -c -B -b users.htpasswd your_username your_password
  ```
  Copy the generated hash from `users.htpasswd`

### 2. Update Configuration Files

1. Update Basic Auth in configuration
  ```yaml
  basicAuth:
    users:
     - "admin:$2y$10$pWij3ooPsrOieZs7SkIBw.sOwM/r90DqMI3nli6XGMSt799.v15zq" # Replace with your hash
  ```

2. Configure ACME (Let's Encrypt) email
  ```yaml
  certificatesResolvers:
    letsencrypt:
     acme:
      email: your_email@domain.com
      storage: acme.json
  ```

### 3. SSL Configuration
- If using Cloudflare, set SSL/TLS encryption mode to "Full (strict)" in Cloudflare dashboard
- This is required for proper SSL handshake between Cloudflare and your server

### 4. Deploy
1. Install Make (if not installed)
  ```bash
  # For Debian/Ubuntu
  sudo apt-get install make
  ```

2. Run the setup script
  ```bash
  make setup
  ```

The setup script will automatically configure and start all services.