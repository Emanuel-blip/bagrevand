#!/usr/bin/env bash

upgrade_packages() {
    local package_name="$1"
    if [ -n "$package_name" ]; then
        log_info "Upgrading $package_name..."
        remove_package "$package_name"
        install_package "$package_name"
    else
        log_info "Upgrading all packages..."
        update_index
        if [ ! -d "$PACKAGES_DIR" ]; then
            log_info "No packages to upgrade"
            return 0
        fi
        for package in "$PACKAGES_DIR"/*; do
            if [ -f "$package" ]; then
                local package_name=$(basename "$package")
                log_info "Upgrading $package_name..."
                remove_package "$package_name"
                install_package "$package_name"
            fi
        done
    fi
}
