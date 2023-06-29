# Docker Traefik

## Features
- Traefik Proxy *( Auto TLS )*
- Portainer
- Uptime Kuma
- Grafana
- MinIO
- PostgreSQL *( Private Network )*
- Redis *( Private Network )*

## Setup Docker Traefik
- duplicate `.env.example` to `.env` 
- change domain url, for example `traefik.localhost` to `traefik.yourdomain.com`
- generate basic auth with htpasswd, `htpasswd -c -B -b users.htpasswd your_username your_password`
- `cat users.htpasswd`, copy user basic auth
  
  ```yml
  ...
  basicAuth:
        users:
          - "admin:$2y$10$pWij3ooPsrOieZs7SkIBw.sOwM/r90DqMI3nli6XGMSt799.v15zq" # change your basic auth
  ...
  ```

- change your email support acme
  
  ```yml
  ...
  certificatesResolvers:
  letsencrypt:
    acme:
      email: your_email@domain.com
      storage: acme.json
  
  ...
  ```

- after change domain url on `.env`, register `yourdomain.com` or `subdomain.yourdomain.com` on your domain provider.
- if your VM not installed Makefile, install first Makefile, for debian kernel, install with command `sudo apt-get install make`
- install `docker.engine` on your `VM`
- after install docker engine, run command `make network.proxy`
- run command `make acme.permission`
- and run command `make docker.up`