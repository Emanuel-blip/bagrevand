#!/usr/bin/env bash

search_packages() {
    local search_term="$1"
    if [ -z "$search_term" ]; then
        log_info "Available packages:"
        if [ ! -f "$CACHE_DIR/packages.idx" ]; then
            update_index || return 1
        fi
        while IFS='|' read -r name url hash version size desc; do
            echo "  $name (v$version) - $desc"
        done < "$CACHE_DIR/packages.idx"
    else
        log_info "Searching for packages matching '$search_term':"
        if [ ! -f "$CACHE_DIR/packages.idx" ]; then
            update_index || return 1
        fi
        while IFS='|' read -r name url hash version size desc; do
            if [[ "$name" == *"$search_term"* ]] || [[ "$desc" == *"$search_term"* ]]; then
                echo "  $name (v$version) - $desc"
            fi
        done < "$CACHE_DIR/packages.idx"
    fi
}
