#!/usr/bin/env bash

remove_package() {
    local package_name="$@"  # Փոխել $1-ը $@-ով
    if [ -z "$package_name" ]; then
        log_error "Package name is required"
        return 1
    fi

    for pkg in "$@"; do
        log_info "Removing $pkg..."
        if [ ! -f "$PACKAGES_DIR/$pkg" ]; then
            log_error "Package '$pkg' is not installed"
            return 1
        fi
        rm -f "$PACKAGES_DIR/$pkg"
        log_success "$pkg removed successfully!"
    done
}
