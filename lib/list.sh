list_packages() {
    log_info "Installed packages:"
    if [ ! -d "$PACKAGES_DIR" ] || [ -z "$(ls -A "$PACKAGES_DIR" 2>/dev/null)" ]; then
        echo "No packages installed"
        return 0
    fi

    for package in "$PACKAGES_DIR"/*; do
        if [ -f "$package" ]; then
            local package_name=$(basename "$package")
            local package_info=$(get_package_info "$package_name" 2>/dev/null)
            if [ -n "$package_info" ]; then
                local version=$(echo "$package_info" | cut -d'|' -f4)
                echo "  $package_name (v$version)"
            else
                echo "  $package_name (unknown version)"
            fi
        fi
    done
}
