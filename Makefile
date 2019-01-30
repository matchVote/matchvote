.PHONY: help

APP_NAME = 'matchvote'
APP_VSN ?= `grep 'VERSION' config/application.rb | sed -e 's/VERSION =//g' -e "s/[ ']//g"`

help:
	@echo $(APP_NAME):$(APP_VSN)
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

version: ## Show latest app version
	@echo $(APP_VSN)

build: ## Build the Docker image
	docker build -t $(APP_NAME):$(APP_VSN) .
