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
REPO=`git config remote.origin.url`
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
git remote set-url origin $SSH_REPO

# deploy docs
mkdocs gh-deploy
