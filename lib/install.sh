#!/usr/bin/env bash

install_package() {
    local package_name="$1"
    if [ -z "$package_name" ]; then
        log_error "Package name is required"
        return 1
    fi

    log_info "Installing $package_name..."

    # Փորձում ենք ստանալ փաթեթի տվյալները
    local package_info=$(get_package_info "$package_name")

    if [ -z "$package_info" ]; then
        log_error "Package '$package_name' not found in repository."
        return 1
    fi
    
    local package_url=$(echo "$package_info" | cut -d'|' -f2)
    local package_hash=$(echo "$package_info" | cut -d'|' -f3)
    local package_version=$(echo "$package_info" | cut -d'|' -f4)

    if [ -f "$PACKAGES_DIR/$package_name" ]; then
        log_warning "Package '$package_name' is already installed"
        return 0
    fi
    
    log_info "Downloading $package_name (version $package_version)..."
    if wget -q -O "$PACKAGES_DIR/$package_name" "$package_url"; then
        log_success "Downloaded $package_name"
    else
        log_error "Failed to download $package_name"
        return 1
    fi
    
    if ! verify_package "$PACKAGES_DIR/$package_name" "$package_hash"; then
        rm -f "$PACKAGES_DIR/$package_name"
        return 1
    fi
    
    chmod +x "$PACKAGES_DIR/$package_name"
    log_success "$package_name installed successfully!"
}
