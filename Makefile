DOCKER_COMPOSE_UP = docker-compose.yml up -d --build
DOCKER_COMPOSE_DOWN = docker-compose.yml down

.PHONY: network.traefik
network.traefik:
	docker network create proxy

.PHONY: acme.permission
acme.permission:
	sudo chmod 600 ./config/acme.json

.PHONY: docker.up
docker.up:
	docker compose -f ${DOCKER_COMPOSE_UP}

.PHONY: docker.down
docker.down:
	docker compose -f ${DOCKER_COMPOSE_DOWN}
