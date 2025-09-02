function remove_package() {
    local package_name="$1"
    if [ -z "$package_name" ]; then
        echo "Error: Please specify a package to remove." >&2
        return 1
    fi

    if [[ "$IS_GLOBAL" == "true" ]]; then
        if [ ! -f "/usr/local/bin/$package_name" ]; then
            echo "Error: Package '$package_name' is not installed globally." >&2
            return 1
        fi
        sudo rm "/usr/local/bin/$package_name"
    else
        if [ ! -f "$PACKAGES_DIR/$package_name" ]; then
            echo "Error: Package '$package_name' is not installed locally." >&2
            return 1
        fi
        rm "$PACKAGES_DIR/$package_name"
    fi
    echo "Successfully removed '$package_name'."
    return 0
}
