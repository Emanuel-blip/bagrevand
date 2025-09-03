#!/usr/bin/env bash

reinstall_package() {
    local package_name="$1"
    if [ -z "$package_name" ]; then
        log_error "Package name is required"
        return 1
    fi
    log_info "Reinstalling $package_name..."
    remove_package "$package_name" && install_package "$package_name"
}
