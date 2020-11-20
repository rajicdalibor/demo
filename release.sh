#!/usr/bin/env bash

set -eo

if [[ "${CIRCLE_BRANCH}" =~ "master" ]]; then
  VERSION=$(npm run version --prefix client --silent)

  echo "Configure git"
  git config user.email "rajicdalibor@yahoo.com"
  git config user.name "rajicdalibor"

  echo "Git commit release '${VERSION}"
  git add client/package.json client/package-lock.json
  git commit -m "[skip ci] release '${VERSION}'"
  git tag ${VERSION}

  git push --set-upstream origin $CIRCLE_BRANCH
  git push origin --tags
else
  echo "Skip releasing"
fi