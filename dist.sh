#!/usr/bin/env bash

. ./dist-env
mkdir -p intermediate
cp index.template.html intermediate/index.html

version="$(git rev-parse --short HEAD)"

# use short commit hash to create unique url unless the tree is dirty. Assumes `npm build`
[[ -z $(git status -s) ]] \
&& unique="$version" \
|| unique="$(find ./public -type f -exec cat {} \; | sha256sum | awk '{ print $1 }' | tr -d '\n')"

base_path="$host/$unique"

find ./public -type f  -print0 |
while IFS= read -r -d '' file; do
    relative_path="$(echo "$file" | sed 's!./public!!g')";
    hash=sha256-"$(sha256sum "$file"| awk '{ print $1 }' | xxd -r -p | base64)";
    sed -i -E "s!((href|src)=')$relative_path(')!integrity='$hash' \1${base_path}${relative_path}\3!g" intermediate/index.html ;
done

html="$(cat intermediate/index.html)"
sed "/__INSERT__/ r /dev/stdin" userscript.template.js > userscript.js <<EOF
// @version $version

let str = \`$html\`
EOF
sed -i '/__INSERT__/{N;s/__INSERT__\n//;}' userscript.js