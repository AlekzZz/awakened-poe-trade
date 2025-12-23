# Multi-stage build for Awakened PoE Trade
FROM node:22-bookworm AS builder

# Install system dependencies needed for electron-builder
RUN apt-get update && apt-get install -y \
    libgtk-3-0 \
    libnotify4 \
    libnss3 \
    libxss1 \
    libxtst6 \
    xdg-utils \
    libatspi2.0-0 \
    libdrm2 \
    libgbm1 \
    libxcb-dri3-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

# Copy package files
COPY renderer/package*.json ./renderer/
COPY main/package*.json ./main/

# Install dependencies
RUN cd renderer && npm ci
RUN cd main && npm ci

# Copy source code
COPY renderer ./renderer
COPY main ./main
COPY ipc ./ipc

# Build renderer
WORKDIR /build/renderer
RUN npm run make-index-files && npm run build

# Build main
WORKDIR /build/main
RUN npm run build

# Package application
RUN npm run package -- --linux AppImage

# Final stage - just the artifacts
FROM scratch AS export
COPY --from=builder /build/dist /dist
