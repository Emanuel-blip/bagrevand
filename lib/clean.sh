#!/usr/bin/env bash

clean_cache() {
    log_info "Cleaning package cache..."
    if [ -f "$CACHE_DIR/packages.idx" ]; then
        rm -f "$CACHE_DIR/packages.idx"
        log_success "Package cache cleaned successfully!"
    else
        log_warning "No cache found to clean."
    fi
}
