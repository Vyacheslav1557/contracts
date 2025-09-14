.PHONY: all go-gen ts-gen dependencies go-dependencies ts-dependencies

PROJECT_DIR := $(CURDIR)

GO_CACHE  := $(HOME)/.cache/go
NPM_CACHE := $(HOME)/.cache/npm

GO_IMAGE  := golang:1.24.6-alpine
NODE_IMAGE := node:24-alpine

define docker_run
docker run --rm \
	-v $(PROJECT_DIR):/app -w /app \
	$(2) \
	$(1) $(3)
endef

go-dependencies: go.sum go.mod
	$(call docker_run,$(GO_IMAGE),-v $(GO_CACHE)/mod:/go/pkg/mod -v $(GO_CACHE)/build:/root/.cache/go-build,go mod download)

go-gen: go-dependencies
	$(call docker_run,$(GO_IMAGE),-v $(GO_CACHE)/mod:/go/pkg/mod -v $(GO_CACHE)/build:/root/.cache/go-build,go run github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen -config cfg.yaml ./tester/v1/openapi.yaml)

ts-dependencies: package.json package-lock.json
	$(call docker_run,$(NODE_IMAGE),-v $(NPM_CACHE):/root/.npm,npm ci --prefer-offline)

ts-gen: ts-dependencies
	$(call docker_run,$(NODE_IMAGE),-v $(NPM_CACHE):/root/.npm,npm run gen)

dependencies: go-dependencies ts-dependencies

all: go-gen ts-gen

