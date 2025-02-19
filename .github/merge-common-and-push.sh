#!/usr/bin/env bash

git config --local user.email "github-action@users.noreply.github.com"
git config --local user.name "GitHub Action"

fmt='
     git checkout %(refname:short)
     git restore --source=common --worktree .
     git add --all -- ":!basic-config/hardware.nix" ":!.gitignore" ":!.github"
     git commit -m "update: merge common config"
     git push
'

eval=`git for-each-ref --shell --format="$fmt" --exclude=refs/heads/master refs/heads/*`

eval "$eval"
