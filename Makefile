.PHONY: build clean help rebuild

export VERSION 			 ?= 1.0.0

default: help

build: ## Build the site.
	stack exec site build
clean: ## Clean cached data.
	stack exec site clean
help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
publish: ## Publish the website.
	./deploy.sh
rebuild: ## Rebuild the entire site.
	stack exec site rebuild
