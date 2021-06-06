#!/usr/bin/env bash

# Terminate on error
set -e

DESTINATION="$1"
APP_NAME="$2"

usage() {
  echo "Usage: ./setup.bash <destination> <app-name>"
  exit 1
}

if [ "$DESTINATION" == "" ] || [ "$APP_NAME" == "" ]; then
  usage
fi

mkdir -p "$DESTINATION"
cp .eslintignore .eslintrc.js .gitignore .prettierrc package.json tsconfig.json yarn.lock "$DESTINATION"
cp -r src "$DESTINATION"/src
cp -r public "$DESTINATION"/public
cp README-template.md "$DESTINATION"/README.md

lower() {
  echo "$1" | tr '[:upper:]' '[:lower:]'
}

# TODO: figure out how to DRY this
sed -i '' 's/${CRA_TEMPLATE_APP_NAME}/'"$APP_NAME"'/g' "$DESTINATION"'/public/manifest.json'
sed -i '' 's/${CRA_TEMPLATE_APP_NAME}/'"$APP_NAME"'/g' "$DESTINATION"'/public/index.html'
sed -i '' 's/${CRA_TEMPLATE_APP_NAME}/'"$APP_NAME"'/g' "$DESTINATION"'/README.md'
sed -i '' 's/${CRA_TEMPLATE_APP_NAME_LOWERCASE}/'"$(lower $APP_NAME)"'/g' "$DESTINATION"'/package.json'

cd "$DESTINATION"
yarn upgrade -L
