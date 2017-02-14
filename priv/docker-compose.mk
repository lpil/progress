D=docker-compose -f rel/docker-compose.yml

.PHONY: dc-up
dc-up: ## Run the app with docker compose
	 $D up

.PHONY: dc-build
dc-build: ## Build images for docker compose
	 $D build
