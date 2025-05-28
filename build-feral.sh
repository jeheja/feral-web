#!/bin/bash
# Feral Web Build Script with desktop-only enforcement

set -e

echo "🌿 Building Feral Web (Desktop-only mode)..."

# Apply patches
echo "🔧 Applying Feral patches..."
for patch in patches/*.patch; do
    if [ -f "$patch" ]; then
        echo "   Applying $(basename $patch)..."
        git apply "$patch" || {
            echo "❌ Error: Failed to apply patch $patch"
            exit 1
        }
    fi
done

# Run the build
echo "🔨 Building..."
yarn build

# Revert patches
echo "🔧 Reverting patches..."
for patch in patches/*.patch; do
    if [ -f "$patch" ]; then
        git apply -R "$patch" || true
    fi
done

echo "✅ Feral Web build complete!"