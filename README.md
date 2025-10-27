# Contracts

[![OpenAPI v3](https://img.shields.io/badge/OpenAPI-v3-green)](https://swagger.io/specification/)

This repository contains OpenAPI schemas for defining API specifications. These schemas provide a structured and
standardized way to describe the API endpoints, data models, and interactions used in the project.

For understanding the architecture, see the [documentation](https://github.com/Vyacheslav1557/docs).

## Overview

The OpenAPI schemas in this repository serve as the contract for the API, ensuring consistency and clarity for
developers, testers, and other stakeholders. They can be used to:

- Generate API documentation
- Validate API requests and responses
- Facilitate client and server code generation
- Support API testing and mocking

## Repository Structure

- `/[service-name]/[version]`: Contains the OpenAPI schema file (e.g., `.yaml` or `.json`).

## Prerequisites

- **Go** 1.20+ - for Go code generation
- **Node.js** 18+ with npm - for TypeScript code generation

## Getting Started

1. **Clone the Repository**:

```bash
git clone https://github.com/Vyacheslav1557/contracts.git
cd contracts
```

2. **Install Dependencies**:

```bash
make dependencies
```

3. **Generate Code**:

Generate both Go and TypeScript code:

```bash
make all
```

Or generate them separately:

```bash
make go-gen   # Generate Go code only
make ts-gen   # Generate TypeScript code only
```

4. **Clean Generated Files**:

```bash
make clean
```

## Available Commands

- `make all` - Generate all code (Go + TypeScript)
- `make go-gen` - Generate Go code from OpenAPI spec
- `make ts-gen` - Generate TypeScript code from OpenAPI spec
- `make dependencies` - Install all dependencies
- `make go-dependencies` - Install Go dependencies
- `make ts-dependencies` - Install Node dependencies
- `make clean` - Remove generated files
