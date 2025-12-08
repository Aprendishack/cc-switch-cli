#!/bin/bash
# Create a new git tag with automatic README version update

set -e

if [ -z "$1" ]; then
    echo "Usage: ./scripts/create-tag.sh <version>"
    echo "Example: ./scripts/create-tag.sh v4.2.0"
    exit 1
fi

VERSION="$1"

# 切换到项目根目录
cd "$(dirname "$0")/.."

# 先更新 README 版本
echo "Updating README version..."
./scripts/update-readme-version.sh

# 提交更改（如果有）
if ! git diff --quiet README.md 2>/dev/null; then
    git add README.md
    git commit -m "chore: Update version to $VERSION"
    echo "✓ README updated and committed"
fi

# 创建 tag
git tag "$VERSION"

echo "✓ Tag $VERSION created"
echo ""
echo "To push the tag, run:"
echo "  git push origin $VERSION"
