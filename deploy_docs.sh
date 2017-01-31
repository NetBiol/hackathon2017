#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

# decrypt and add RSA key to deploy
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in $RSA_key_file.enc -out $RSA_key_file -d
chmod 600 $RSA_key_file
eval `ssh-agent -s`
ssh-add $RSA_key_file

# config git
git config user.name "Travis CI"
git config user.email "$COMMIT_AUTHOR_EMAIL"
git config push.default tracking
GITHUB_REPO_URL=`git remote -v | grep -m1 '^origin' | sed -Ene's#.*(https://[^[:space:]]*).*#\1#p'`
GITHUB_USER=`echo $GITHUB_REPO_URL | sed -Ene's#https://github.com/([^/]*)/(.*).git#\1#p'`
GITHUB_REPO=`echo $GITHUB_REPO_URL | sed -Ene's#https://github.com/([^/]*)/(.*).git#\2#p'`
GITHUB_REPO_SSH_URL="git@github.com:$GITHUB_USER/$GITHUB_REPO.git"
git remote set-url origin $GITHUB_REPO_SSH_URL

# deploy docs
mkdocs gh-deploy --force
