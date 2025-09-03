#!/usr/bin/env bash

init_dirs() {
    mkdir -p "$PACKAGES_DIR"
    mkdir -p "$CACHE_DIR"

    if [[ ":$PATH:" != *":$PACKAGES_DIR:"* ]]; then
        echo "export PATH=\"$PACKAGES_DIR:\$PATH\"" >> "$HOME/.bashrc"
    fi
}
