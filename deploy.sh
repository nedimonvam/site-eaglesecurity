#!/usr/bin/env bash
# Deploy built site to GitHub Pages (publish branch per TZ).
# For custom domain run: CUSTOM_DOMAIN=1 ./deploy.sh
# For GitHub Pages at https://<user>.github.io/site-eaglesecurity/ run: ./deploy.sh (or GITHUB_PAGES=1)
set -e
ROOT="$(cd "$(dirname "$0")" && pwd)"
SRC="$ROOT/src"

if ! command -v node >/dev/null 2>&1; then
  echo "Node.js is required. Install from https://nodejs.org/"
  exit 1
fi

if [ ! -d "$SRC/node_modules" ]; then
  echo "Installing dependencies..."
  (cd "$SRC" && npm install)
fi

# Get repo URL (use REMOTE if set, e.g. when developing in lide: REMOTE=site-eaglesecurity)
REPO=$(cd "$ROOT" && git config --get remote.${REMOTE:-origin}.url 2>/dev/null || true)
if [[ -n "$REPO" && "$REPO" =~ ^https://github\.com/([^/]+)/([^/.]+)(\.git)?$ ]]; then
  REPO="git@github.com:${BASH_REMATCH[1]}/${BASH_REMATCH[2]}.git"
fi
if [[ -n "$REMOTE" ]]; then
  echo "Deploying to remote: $REMOTE ($REPO)"
fi

# Custom domain = no pathPrefix. Otherwise site-eaglesecurity repo = pathPrefix /site-eaglesecurity
if [[ -n "$CUSTOM_DOMAIN" ]]; then
  export GITHUB_PAGES=
  echo "Building for custom domain (no pathPrefix)"
elif [[ -n "$GITHUB_PAGES" ]]; then
  export GITHUB_PAGES=1
  echo "Building with pathPrefix /site-eaglesecurity/ for *.github.io/site-eaglesecurity/"
elif [[ -n "$REPO" && ("$REPO" =~ /site-eaglesecurity\.git$ || "$REPO" =~ /site-eaglesecurity$) ]]; then
  export GITHUB_PAGES=1
  echo "Building with pathPrefix /site-eaglesecurity/ for *.github.io/site-eaglesecurity/"
fi

# Clean output so removed pages don't persist
rm -rf "$SRC/_site"
(cd "$SRC" && node node_modules/@11ty/eleventy/cmd.cjs)

if [[ -n "$CUSTOM_DOMAIN" ]]; then
  echo "${CUSTOM_DOMAIN_NAME:-eaglesecurity.app}" > "$SRC/_site/CNAME"
  echo "Added CNAME for custom domain."
fi

echo "Clearing gh-pages cache..."
(cd "$SRC" && node -e "try { require('gh-pages').clean(); } catch (e) {}")
rm -rf "$SRC/node_modules/.cache/gh-pages" 2>/dev/null || true

REPO_FLAG=""
if [[ -n "$REPO" ]]; then
  REPO_FLAG="-r $REPO"
fi

# TZ specifies publish branch; also push to gh-pages so Pages works if user leaves default branch
echo "Pushing _site to publish branch..."
(cd "$SRC" && npx gh-pages -d _site -b publish -f $REPO_FLAG)
if [[ -n "$REPO" && ("$REPO" =~ /site-eaglesecurity\.git$ || "$REPO" =~ /site-eaglesecurity$) ]]; then
  echo "Pushing _site to gh-pages branch (for GitHub Pages default source)..."
  (cd "$SRC" && npx gh-pages -d _site -b gh-pages -f $REPO_FLAG)
fi

echo "Done. Site will be live in a minute (GitHub Pages or your custom domain)."
