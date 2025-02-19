#!/usr/bin/env bash

git config --local user.email "github-action@users.noreply.github.com"
git config --local user.name "GitHub Action"
git remote add github https://github-action:$GITHUB_TOKEN@github.com/Yxue-1906/nixos-configs.git

fmt='
     git checkout %(refname:short)
     git restore --source=common --worktree .
     git add --all -- ":!basic-config/hardware.nix" ":!.gitignore" ":!.github"
     git commit -m "update: merge common config"
     git push github %(refname:short)
'

eval=`git for-each-ref --shell --format="$fmt" --exclude=refs/heads/common refs/heads/*`

eval "$eval"
