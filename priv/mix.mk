.PHONY: test
test: ## Run mix test
	mix test

.PHONY: test.watch test-watch
test.watch: test-watch
test-watch: ## Run mix test.watch
	mix test.watch
