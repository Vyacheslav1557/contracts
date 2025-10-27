.PHONY: all go-gen ts-gen dependencies go-dependencies ts-dependencies clean

# Check if required tools are installed
check-go:
	@which go > /dev/null || (echo "Error: go is not installed" && exit 1)

check-npm:
	@which npm > /dev/null || (echo "Error: npm is not installed" && exit 1)

# Install Go dependencies
go-dependencies: check-go go.sum go.mod
	go mod download

# Generate Go code from OpenAPI spec
go-gen: go-dependencies
	go run github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen -config cfg.yaml ./tester/v1/openapi.yaml

# Install Node dependencies
ts-dependencies: check-npm package.json package-lock.json
	npm ci

# Generate TypeScript code from OpenAPI spec
ts-gen: ts-dependencies
	npm run gen

# Install all dependencies
dependencies: go-dependencies ts-dependencies

# Generate all code
all: go-gen ts-gen

# Clean generated files
clean:
	rm -f ./tester/v1/tester.go ./tester/v1/tester.ts

