#!/bin/bash

set -e -o pipefail

git config --local user.email "github-action@users.noreply.github.com"
git config --local user.name "GitHub Action"
git remote add github https://github-action:$GITHUB_TOKEN@github.com/Yxue-1906/nixos-config.git

fmt='
        echo %(refname:lstrip=3)
	git checkout %(refname:lstrip=3)
	echo after checkout 
	git restore --source=origin/common --worktree .
	echo after restore
	git add --all -- :\!basic-config/hardware.nix :\!.gitignore :\!.github
	echo after add
	git commit -m "update: merge common config"
	echo after commit
	git push github %(refname:lstrip=3)
	echo after push
'

git for-each-ref --shell --format='%(refname)' 'refs/remotes/origin/*'

eval=`git for-each-ref --shell --format="$fmt" --exclude=refs/remotes/origin/common --exclude=refs/remotes/origin/HEAD refs/remotes/origin/*`

eval "$eval"
