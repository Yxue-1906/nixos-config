#!/bin/bash

set -e -o pipefail

echo before config user name and email

git config --local user.email "github-action@users.noreply.github.com"
git config --local user.name "GitHub Action"
git remote add github https://github-action:$GITHUB_TOKEN@github.com/Yxue-1906/nixos-config.git

echo before set fmt

fmt='
	git checkout %(refname:lstrip=3)
	git restore --source=origin/common --worktree .
	git add --all -- :\!basic-config/hardware.nix :\!.gitignore :\!.github
	git commit -m "update: merge common config"
	git push github %(refname:lstrip=3)
'

echo before set eval

eval=`git for-each-ref --shell --format="$fmt" --exclude=refs/remotes/origin/common --exclude=refs/remotes/origin/HEAD refs/remotes/origin/*`

echo before eval

eval "$eval"

echo after eval

