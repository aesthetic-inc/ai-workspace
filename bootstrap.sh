#!/bin/bash
# Bootstrap script for setting up development environment on a new device
# Usage (private repo): gh api repos/aesthetic-inc/ai-workspace/contents/bootstrap.sh -H "Accept: application/vnd.github.raw" | bash
# Or: ./bootstrap.sh

set -e

GITHUB_USER="aesthetic-inc"
DEV_DIR="$HOME/dev"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Development Environment Bootstrap ===${NC}"

# Check for required tools
command -v git >/dev/null 2>&1 || { echo -e "${RED}git is required but not installed.${NC}"; exit 1; }
command -v gh >/dev/null 2>&1 || { echo -e "${YELLOW}gh CLI not found. Install with: brew install gh${NC}"; }

# All repositories are private: let git use the gh login for HTTPS
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
    gh auth setup-git >/dev/null 2>&1 || true
else
    echo -e "${YELLOW}Not logged in to GitHub CLI. Run: gh auth login && gh auth setup-git${NC}"
fi

# Create dev directory
mkdir -p "$DEV_DIR"
cd "$DEV_DIR"

echo -e "${GREEN}Cloning repositories...${NC}"

# Repository list
REPOS=(
    "ai-workspace"
    "space-rental-platform"
    "chatgpt-export"
    "mf-cloud-auth"
    "clawd"
)

for repo in "${REPOS[@]}"; do
    if [ -d "$repo" ]; then
        echo -e "${YELLOW}$repo already exists, pulling latest...${NC}"
        cd "$repo"
        git pull origin main 2>/dev/null || git pull origin master 2>/dev/null || echo "Could not pull"
        cd ..
    else
        echo -e "${GREEN}Cloning $repo...${NC}"
        git clone "https://github.com/$GITHUB_USER/$repo.git" 2>/dev/null || \
        git clone "git@github.com:$GITHUB_USER/$repo.git" || \
        echo -e "${RED}Failed to clone $repo${NC}"
    fi
done

echo ""
echo -e "${GREEN}=== Setup Complete ===${NC}"
echo ""
echo "Next steps:"
echo "  1. Copy .env files from secure storage (1Password, etc.)"
echo "  2. Run 'npm install' or 'pnpm install' in each project"
echo ""
echo "Projects cloned to: $DEV_DIR"
ls -la "$DEV_DIR"
