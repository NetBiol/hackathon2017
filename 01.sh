GITHUB_REPO_URL=`git remote -v | grep -m1 '^origin' | sed -Ene's#.*(https://[^[:space:]]*).*#\1#p'`
GITHUB_USER=`echo $GITHUB_REPO_URL | sed -Ene's#https://github.com/([^/]*)/(.*).git#\1#p'`
GITHUB_REPO=`echo $GITHUB_REPO_URL | sed -Ene's#https://github.com/([^/]*)/(.*).git#\2#p'`
GITHUB_REPO_SSH_URL="git@github.com:$GITHUB_USER/$GITHUB_REPO.git"
git remote set-url origin $GITHUB_REPO_SSH_URL

# deploy docs
mkdocs gh-deploy
