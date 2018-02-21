RELEASE=true

all: clean test ## Alias for compile.

compile: ## Compile with bin/build.sh && test.
	@echo 'Compile'

test: compile ## Run tests with bin/verify.sh
	@echo 'Test'

clean: ## Run go clean.
	@echo 'Clean'

images: ## Make docker images
	@echo 'Images'
	cd docker && $(MAKE) image

push-all-images: ## Push all docker images
	@echo 'Push'
	cd docker && $(MAKE) push

help: ## Display help text.
	@echo 'Help'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'



.PHONY: all compile test clean help images push-all-images
.DEFAULT_GOAL := help
