#!/bin/bash

# Stash changes.
git stash

# Checkout develop and build
git checkout develop
stack exec site clean
stack exec site build

# Checkout master and copy changes
git fetch --all
git checkout master
cp -a _site/. .

# Commit and push
if ! git diff-index --quiet HEAD --; then
    git add -A
    git commit -m "Publish."
    git push origin master:master
else
    echo "No changes..."
fi


# Reset back to develop.
git checkout develop
git branch -D master
