D=docker-compose -f rel/docker-compose.yml

.PHONY: dc-up
dc-up: ## Run the app in docker compose
	 $D up

.PHONY: dc-test
dc-test: ## Run the tests in docker compose
	 $D run app mix test

.PHONY: dc-build
dc-build: ## Build images for docker compose
	 $D build
