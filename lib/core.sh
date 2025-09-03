#!/usr/bin/env bash

update_index() {
        log_info "Updating package index..."
        mkdir -p "$CACHE_DIR" # Ստեղծում ենք քեշի թղթապանակը, եթե այն գոյություն չունի:
        if wget -q -O "$CACHE_DIR/packages.idx" "$PACKAGES_INDEX_URL"; then
                log_success "Package index updated successfully"
        else
                log_error "Failed to update package index"
                return 1
        fi
}
get_package_info() {
    local package_name="$1"
    if [ ! -f "$CACHE_DIR/packages.idx" ]; then
        update_index || return 1
    fi
    grep "^$package_name|" "$CACHE_DIR/packages.idx"
}

package_exists() {
    local package_name="$1"
    if [ ! -f "$CACHE_DIR/packages.idx" ]; then
        update_index || return 1
    fi
    grep -q "^$package_name|" "$CACHE_DIR/packages.idx"
}
verify_package() {
    local package_file="$1"
    local expected_hash="$2"
    if [ -z "$expected_hash" ]; then
        log_warning "No hash provided for verification"
        return 0
    fi
    local actual_hash=$(sha256sum "$package_file" | awk '{print $1}')
    if [ "$actual_hash" = "$expected_hash" ]; then
        log_success "Package hash verified"
        return 0
    else
        log_error "Package hash verification failed"
        log_error "Expected: $expected_hash"
        log_error "Actual: $actual_hash"
        return 1
    fi
}
