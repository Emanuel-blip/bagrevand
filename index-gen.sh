#!/usr/bin/env bash
repo_url="https://raw.githubusercontent.com/Emanuel-blip/bagrevand/main"
out="packages.idx"
: > "$out"
for f in *; do
    [ -f "$f" ] || continue
    [ "$f" = "$out" ] && continue
    sha=$(sha256sum "$f" | awk '{print $1}')
    size=$(stat -c%s "$f" 2>/dev/null || stat -f%z "$f")
    # version and desc can be set manually or derived
    echo "${f}|${repo_url}/${f}|${sha}|0.1|${size}|\"$(head -n1 "$f" | tr -d '\n' | sed 's/"/\\"/g')\"" >> "$out"
done

# Ստորագրել packages.idx ֆայլը GPG-ով
echo "Signing the packages.idx file..."
gpg --armor --detach-sig packages.idx

echo "Wrote $out"
