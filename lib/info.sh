#!/usr/bin/env bash

show_package_info() {
    local package_name="$1"
    if [ -z "$package_name" ]; then
        log_error "Package name is required"
        return 1
    fi
    if ! package_exists "$package_name"; then
        log_error "Package '$package_name' not found"
        return 1
    fi
    local package_info=$(get_package_info "$package_name")
    local package_url=$(echo "$package_info" | cut -d'|' -f2)
    local package_hash=$(echo "$package_info" | cut -d'|' -f3)
    local package_version=$(echo "$package_info" | cut -d'|' -f4)
    local package_size=$(echo "$package_info" | cut -d'|' -f5)
    local package_desc=$(echo "$package_info" | cut -d'|' -f6)
    echo "Package: $package_name"
    echo "Version: $package_version"
    echo "Description: $package_desc"
    echo "Size: $package_size bytes"
    echo "URL: $package_url"
    echo "SHA256: $package_hash"
    if [ -f "$PACKAGES_DIR/$package_name" ]; then
        echo "Status: Installed"
    else
        echo "Status: Not installed"
    fi
}
