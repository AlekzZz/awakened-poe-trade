.PHONY: build release clean help sync

# (default: Linux AppImage)
build:
	@echo "Building for Linux (AppImage) with Docker..."
	docker build --target export --output type=local,dest=./dist .
	@echo "Build complete! Binaries in dist/"

# Full cycle: build + package
release: build
	@echo "Release build complete! Check dist/ for binaries"

# Cleanup dist
clean:
	@echo "Cleaning build artifacts..."
	rm -rf dist
	@echo "Cleaning Docker build cache..."
	docker builder prune -f

# Sync with upstream repo
sync:
	@echo "Fetching from upstream..."
	git fetch upstream
	@echo ""
	@echo "Merging upstream/master into current branch..."
	git merge upstream/master
	@echo ""
	@echo "Sync complete! Push to your fork with: git push origin master"

# Show some "help"
help:
	@echo "Available targets:"
	@echo "  make build        - Build using Docker"
	@echo "  make release      - Complete release build"
	@echo "  make sync         - Sync with original repository"
	@echo "  make clean        - Remove build artifacts and Docker cache"
