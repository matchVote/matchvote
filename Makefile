.PHONY: help

APP_NAME = 'matchvote'
APP_VSN ?= `grep 'VERSION' config/application.rb | sed -e 's/VERSION =//g' -e "s/[ ']//g"`

help:
	@echo $(APP_NAME):$(APP_VSN)
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

version: ## Show latest app version
	@echo $(APP_VSN)

hub-release: ## Build the production Docker image and push to Docker Hub
ifeq ($(origin ACCOUNT),undefined)
	@echo "ACCOUNT= argument empty"
else
	docker build \
	  --build-arg AWS_REGION= \
	  --build-arg MV_PROFILE_PIC_BUCKET= \
	  -t $(ACCOUNT)/$(APP_NAME):$(APP_VSN) .
	docker push $(ACCOUNT)/$(APP_NAME):$(APP_VSN)
endif

build: ## Build the production Docker image
	docker build \
	  --build-arg AWS_REGION= \
	  --build-arg MV_PROFILE_PIC_BUCKET= \
	  -t $(APP_NAME):$(APP_VSN) .
