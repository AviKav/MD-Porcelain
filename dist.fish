#!/usr/bin/env fish
. ./dist-env
mkdir -p intermediate/worktree

set short_hash (git rev-parse --short HEAD)

set asset_path intermediate/worktree/content-addressed-assets

git worktree list --porcelain \
| grep -A 2 'worktree '(pwd)/{$asset_path} \
| grep 'branch refs/heads/'(basename $asset_path) >/dev/null;
and git worktree repair $asset_path
or begin
    git worktree remove -f $asset_path 2>/dev/null
    git worktree add $asset_path
end

function prop
    echo \"$argv[1]:\" \"$argv[2]\",
end

set generated (begin \
    echo '// @version '$short_hash
    echo '// ==/UserScript=='
    echo
    echo 'let data = {'
    for file in (find ./public -type f -not -name 'index.html' -print0 | string split0)
        set hash (sha256sum $file | awk '{ print $1 }' | tr -d \n )
        mkdir -p {$asset_path}/assets/{$hash}/
        rsync $file {$asset_path}/assets/{$hash}/

        echo \"(echo -n $file | sed 's!./public!!')'": {'
        begin
            prop sri sha256-{$hash}
            prop web {$host}/assets/{$hash}/(basename $file)
        end
        echo '},'
    end
    echo '}'
end | string collect)
echo -n $generated | sed "/__INSERT__/ r /dev/stdin" userscript.template.js > intermediate/userscript.js
# Remove marker
sed -i '/__INSERT__/{N;s/__INSERT__\n//;}' intermediate/userscript.js
