function list_packages() {
    # Check for local and global packages
    if [ -d "$PACKAGES_DIR" ]; then
        echo "Installed packages:"
        find "$PACKAGES_DIR" -maxdepth 1 -type f -exec basename {} \;
    else
        echo "No packages installed locally."
    fi

    echo ""
    echo "Global packages:"
    find "/usr/local/bin" -maxdepth 1 -type f -perm /111 -exec basename {} \; 2>/dev/null | grep -E '^(calc|dateinfo|fswatch|hello|nvim|vim)$'

    return 0
}

function search_packages() {
    local term="$1"
    if [ -z "$term" ]; then
        echo "Error: Please provide a search term."
        return 1
    fi
    local index=$(fetch_index)
    echo "Searching for packages matching '$term'..."
    echo "$index" | grep -i "$term" | cut -d'|' -f1
    return 0
}

function info_package() {
    local package_name="$1"
    if [ -z "$package_name" ]; then
        echo "Error: Please specify a package to get info for."
        return 1
    fi

    local index=$(fetch_index)
    local package_info=$(echo "$index" | grep "^$package_name|")

    if [ -z "$package_info" ]; then
        echo "Error: Package '$package_name' not found in index."
        return 1
    fi

    local name=$(echo "$package_info" | cut -d'|' -f1)
    local version=$(echo "$package_info" | cut -d'|' -f4)
    local size=$(echo "$package_info" | cut -d'|' -f5)
    local sha=$(echo "$package_info" | cut -d'|' -f3)
    local description=$(echo "$package_info" | cut -d'|' -f6 | tr -d '\n')

    echo "--- Package Info: $name ---"
    echo "Name: $name"
    echo "Version: $version"
    echo "Size: $size bytes"
    echo "SHA256: $sha"
    echo "Description: $description"
    return 0
}
