#!/bin/bash

# ============================================================
# Lynkflow Website Auto-Push
# Handles: text, images (jpg/png/webp/gif), videos (mp4/webm)
# Usage:
#   ./push.sh                          — push everything changed
#   ./push.sh "added new post"         — push with custom message
#   ./push.sh media/image.jpg          — push specific file
# ============================================================

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_DIR"

MSG="${1:-auto update $(date '+%Y-%m-%d %H:%M')}"

# Check git is set up
if [ ! -d ".git" ]; then
  echo "❌ Not a git repo. Run setup first:"
  echo "   git init && git remote add origin https://github.com/randomsci/Lynkflow_Website.git"
  exit 1
fi

# Show what's changed
echo "📦 Files changed:"
git status --short

if [ -z "$(git status --short)" ]; then
  echo "✅ Nothing to push — already up to date."
  exit 0
fi

# Stage everything — handles all file types automatically
git add -A

# Commit
git commit -m "$MSG"

# Push
echo ""
echo "🚀 Pushing to GitHub..."
git push origin main

if [ $? -eq 0 ]; then
  echo ""
  echo "✅ Done! Site will update in ~30 seconds."
  echo "🌐 https://randomsci.github.io/Lynkflow_Website"
else
  echo ""
  echo "❌ Push failed. Check your GitHub credentials."
fi
