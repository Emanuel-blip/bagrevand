
function install_package() {
    local package_name="$1"
    
    # Ստուգել, թե արդյոք փաթեթն արդեն տեղադրված է
    if [[ "$IS_GLOBAL" == "true" ]]; then
        if [ -f "/usr/local/bin/$package_name" ]; then
            echo "Package '$package_name' is already installed globally."
            return 0
        fi
    else
        if [ -f "$PACKAGES_DIR/$package_name" ]; then
            echo "Package '$package_name' is already installed locally."
            return 0
        fi
    fi

    local index=$(fetch_index)
    local package_line=$(echo "$index" | grep "^$package_name|")

    if [ -z "$package_line" ]; then
        echo "Error: Package '$package_name' not found in index." >&2
        return 1
    fi

    local url=$(echo "$package_line" | cut -d'|' -f2)
    local expected_sha=$(echo "$package_line" | cut -d'|' -f3)

    local target_dir
    local is_binary="false"
    if [[ "$IS_GLOBAL" == "true" ]]; then
        target_dir="/usr/local/bin"
        is_binary="true"
    else
        target_dir="$PACKAGES_DIR"
    fi

    mkdir -p "$target_dir"
    local tmp_file=$(mktemp)

    wget -q -O "$tmp_file" "$url"

    local actual_sha=$(sha256sum "$tmp_file" | awk '{print $1}')
    if [ "$actual_sha" != "$expected_sha" ]; then
        echo "Error: SHA256 mismatch for '$package_name'." >&2
        rm "$tmp_file"
        return 1
    fi

    if [[ "$is_binary" == "true" ]]; then
        mv "$tmp_file" "$target_dir/$package_name"
    else
        mv "$tmp_file" "$target_dir/$package_name"
    fi

    chmod +x "$target_dir/$package_name"
    echo "Successfully installed '$package_name'."
    return 0
}
