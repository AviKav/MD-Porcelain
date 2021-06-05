#!/usr/bin/env bash

. ./dist-env

cp index.template.html public/index.html

find ./public -type f -not -name 'index.html' -print0 |
while IFS= read -r -d '' file; do
    path="$(echo "$file" | sed 's!./public!!g')";
    hash=sha256-"$(sha256sum "$file"| awk '{ print $1 }' | xxd -r -p | base64)";
    sed -i -E "s!((href|src)=')$path(')!integrity='$hash' \1${host_base}${path}\3!g" public/index.html ;
done