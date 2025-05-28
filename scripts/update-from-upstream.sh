#!/bin/bash
# Script to update from upstream Element while preserving Feral customizations

set -e

echo "=== Feral Web Upstream Update Script ==="
echo

# Check if we're on the feral-customizations branch
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "feral-customizations" ]; then
    echo "ERROR: You must be on the 'feral-customizations' branch"
    echo "Current branch: $CURRENT_BRANCH"
    echo "Run: git checkout feral-customizations"
    exit 1
fi

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo "ERROR: You have uncommitted changes. Please commit or stash them first."
    exit 1
fi

# Add upstream remote if it doesn't exist
if ! git remote | grep -q "^upstream$"; then
    echo "Adding upstream remote..."
    git remote add upstream https://github.com/element-hq/element-web.git
fi

echo "1. Fetching latest from upstream..."
git fetch upstream

echo
echo "2. Checking out develop branch..."
git checkout develop

echo
echo "3. Merging upstream changes..."
git merge upstream/develop

echo
echo "4. Returning to feral-customizations branch..."
git checkout feral-customizations

echo
echo "5. Rebasing customizations on top of latest upstream..."
echo "   If there are conflicts, resolve them and run:"
echo "   git rebase --continue"
echo
git rebase develop

echo
echo "=== Update Complete ==="
echo
echo "Next steps:"
echo "1. Test the application thoroughly"
echo "2. Update config.json if needed"
echo "3. Run: npm install (if package.json changed)"
echo "4. Run: npm run build"
echo
echo "If the rebase had conflicts that you resolved:"
echo "- Test everything works correctly"
echo "- Consider updating DEPLOYMENT_GUIDE.md if needed"