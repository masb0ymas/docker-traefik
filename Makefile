DOCKER_COMPOSE_UP = docker-compose.yml up -d --build
DOCKER_COMPOSE_DOWN = docker-compose.yml down

.PHONY: network.traefik
network.traefik:
	docker network create traefik-network

.PHONY: docker.minio.up
docker.minio.up:
	docker compose -f minio/${DOCKER_COMPOSE_UP}

.PHONY: docker.minio.down
docker.minio.down:
	docker compose -f minio/${DOCKER_COMPOSE_DOWN}
