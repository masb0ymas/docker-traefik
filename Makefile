DOCKER_COMPOSE_UP = docker-compose.yml up -d --build
DOCKER_COMPOSE_DOWN = docker-compose.yml down

.PHONY: network.traefik
network.traefik:
	docker network create traefik-network

.PHONY: docker-traefik.up
docker-traefik.up:
	docker compose -f ${DOCKER_COMPOSE_UP}

.PHONY: docker-traefik.down
docker-traefik.down:
	docker compose -f ${DOCKER_COMPOSE_DOWN}
