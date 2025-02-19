#!/usr/bin/env bash

git config --local user.email "github-action@users.noreply.github.com"
git config --local user.name "GitHub Action"
git remote add origin https://github-action:$GITHUB_TOKEN@github.com/Yxue-1906/nixos-config.git
fmt='
     git checkout %(refname:lstrip=3)
     git restore --source=origin/common --worktree .
     git add --all -- :\!basic-config/hardware.nix :\!.gitignore :\!.github
     git commit -m "update: merge common config"
     git push github %(refname:lstrip=3)
'

eval=`git for-each-ref --shell --format="$fmt" --exclude=refs/remotes/origin/common --exclude=refs/remotes/origin/HEAD refs/remotes/origin/*`

# for debug
echo "$eval"

eval "$eval"
