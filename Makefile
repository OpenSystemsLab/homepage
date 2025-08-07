# Open Systems Lab Homepage - Development Makefile

.PHONY: help install dev build test clean deploy act-test act-test-build act-test-lint

# Default target
help: ## Show this help message
	@echo "Open Systems Lab Homepage - Available Commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Install dependencies and initialize submodules
	@echo "📦 Installing dependencies..."
	git submodule update --init --recursive
	@if [ -f package.json ]; then npm ci; fi
	@echo "✅ Dependencies installed"

dev: ## Start Hugo development server
	@echo "🚀 Starting Hugo development server..."
	hugo server --buildDrafts --buildFuture --bind 0.0.0.0 --port 1313

build: ## Build site for production
	@echo "🏗️  Building site for production..."
	hugo --minify --environment production
	@echo "✅ Build complete - files in ./public/"

test: ## Run local build tests
	@echo "🧪 Running local tests..."
	@echo "📋 Testing Hugo configuration..."
	hugo config
	@echo "🏗️  Testing development build..."
	hugo --buildDrafts --buildFuture
	@echo "🚀 Testing production build..."
	rm -rf public/
	hugo --minify --environment production
	@echo "✅ All tests passed!"

clean: ## Clean build artifacts
	@echo "🧹 Cleaning build artifacts..."
	rm -rf public/
	rm -rf resources/
	rm -f hugo_stats.json
	rm -f .hugo_build.lock
	@echo "✅ Cleaned"

deploy: build ## Build and deploy to production
	@echo "🚀 Deploying to production..."
	@echo "ℹ️  Deployment will be handled by GitHub Actions on push to master"
	@echo "ℹ️  Or configure Netlify CLI for manual deployment"

# ACT (Local GitHub Actions Testing) Commands

act-check: ## Check if ACT is installed
	@if ! command -v act > /dev/null; then \
		echo "❌ ACT is not installed. Please install it:"; \
		echo "  macOS: brew install act"; \
		echo "  Linux: curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash"; \
		echo "  More info: https://github.com/nektos/act"; \
		exit 1; \
	else \
		echo "✅ ACT is installed: $$(act --version)"; \
	fi

act-test: act-check ## Run full test suite with ACT (local GitHub Actions)
	@echo "🧪 Running ACT tests (full suite)..."
	act workflow_dispatch \
		-W .github/workflows/test.yml \
		--config .github/act/config.yaml \
		--input test_mode=full \
		--input act_testing=true \
		--input debug_mode=true

act-test-build: act-check ## Run build-only tests with ACT
	@echo "🧪 Running ACT tests (build only)..."
	act workflow_dispatch \
		-W .github/workflows/test.yml \
		--config .github/act/config.yaml \
		--input test_mode=build-only \
		--input act_testing=true \
		--input debug_mode=true

act-test-lint: act-check ## Run lint-only tests with ACT
	@echo "🧪 Running ACT tests (lint only)..."
	act workflow_dispatch \
		-W .github/workflows/test.yml \
		--config .github/act/config.yaml \
		--input test_mode=lint-only \
		--input act_testing=true \
		--input debug_mode=true

act-list: act-check ## List available ACT workflows
	@echo "📋 Available ACT workflows:"
	act -l

act-dry-run: act-check ## Dry run ACT test workflow
	@echo "🔍 ACT dry run..."
	act workflow_dispatch \
		-W .github/workflows/test.yml \
		--config .github/act/config.yaml \
		--input act_testing=true \
		--dry-run

# Development helpers

serve: dev ## Alias for dev command

watch: ## Watch for changes and rebuild
	@echo "👀 Watching for changes..."
	hugo server --buildDrafts --buildFuture --watch

preview: ## Build and serve production version locally
	@echo "🔍 Building and serving production preview..."
	hugo --minify --environment production
	python3 -m http.server 8080 --directory public

lint: ## Lint Hugo configuration and content
	@echo "🔍 Linting Hugo configuration..."
	hugo config
	@echo "🔍 Checking for draft content..."
	@if grep -r "draft.*true" content/; then \
		echo "⚠️  Draft content found"; \
	else \
		echo "✅ No draft content"; \
	fi

stats: ## Show site statistics
	@echo "📊 Site Statistics:"
	@echo "  Content files: $$(find content -name '*.md' | wc -l)"
	@echo "  Theme: $$(grep '^theme' config.toml | cut -d' ' -f3 | tr -d '\"')"
	@hugo --buildDrafts --buildFuture > /dev/null 2>&1
	@echo "  Generated pages: $$(find public -name '*.html' | wc -l)"
	@echo "  Total size: $$(du -sh public/ | cut -f1)"

# Docker commands (optional)

docker-build: ## Build Hugo site in Docker container
	@echo "🐳 Building site in Docker container..."
	docker run --rm -v $(PWD):/src -w /src klakegg/hugo:0.148.2-ext hugo --minify

docker-serve: ## Serve site using Docker
	@echo "🐳 Serving site with Docker..."
	docker run --rm -p 1313:1313 -v $(PWD):/src -w /src klakegg/hugo:0.148.2-ext hugo server --bind 0.0.0.0
