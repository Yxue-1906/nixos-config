#!/bin/bash

set -e -o pipefail

git config --local user.email "github-action@users.noreply.github.com"
git config --local user.name "GitHub Action"
git remote add github https://github-action:$GITHUB_TOKEN@github.com/Yxue-1906/nixos-config.git

fmt='
	git checkout -f %(refname:lstrip=3)
	git restore --source=origin/common --worktree .
	git add --all -- :\!profile :\!.gitignore :\!.github
	# prevent nothing to commit resulting git commit exit with non-zero
	git commit -m "update: merge common config" || true
	git push github %(refname:lstrip=3)
'

eval=`git for-each-ref --shell --format="$fmt" --exclude=refs/remotes/origin/fix-* --exclude=refs/remotes/origin/feat-* --exclude=refs/remotes/origin/common --exclude=refs/remotes/origin/HEAD refs/remotes/origin/*`

eval "$eval"
