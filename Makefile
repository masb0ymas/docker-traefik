DOCKER_COMPOSE_UP = docker-compose.yaml up -d --build
DOCKER_COMPOSE_DOWN = docker-compose.yaml down

APP_DOCKER_COMPOSE_UP = docker-compose-app.yaml up -d --build
APP_DOCKER_COMPOSE_DOWN = docker-compose-app.yaml down

.PHONY: setup
setup: 
	chmod +x setup.sh
	bash setup.sh
	docker network create proxy
	sudo chmod 600 ./config/acme.json
	docker compose -f ${DOCKER_COMPOSE_UP}

.PHONY: secret
secret:
	chmod +x secret.sh
	bash secret.sh

.PHONY: network.proxy
network.proxy:
	docker network create proxy

.PHONY: acme.permission
acme.permission:
	sudo chmod 600 ./config/acme.json

.PHONY: docker.setup
docker.setup:
	docker network create proxy
	sudo chmod 600 ./config/acme.json

.PHONY: docker.up
docker.up:
	docker compose -f ${DOCKER_COMPOSE_UP}

.PHONY: docker.down
docker.down:
	docker compose -f ${DOCKER_COMPOSE_DOWN}

.PHONY: app.up
app.up:
	docker compose -f ${APP_DOCKER_COMPOSE_UP}

.PHONY: app.down
app.down:
	docker compose -f ${APP_DOCKER_COMPOSE_DOWN}
