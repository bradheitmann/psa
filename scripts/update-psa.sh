#!/bin/bash

# PSA Update Script
# Updates PSA to latest version from GitHub

set -e

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
BLUE="\033[34m"
CYAN="\033[36m"
RESET="\033[0m"

PSA_DIR="${PSA_HOME:-$HOME/.psa}"

echo -e "${BOLD}${BLUE}⬆️  Updating PSA${RESET}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if .psa is a git repo
if [ ! -d "$PSA_DIR/.git" ]; then
    echo -e "${RED}Error: $PSA_DIR is not a git repository${RESET}"
    echo ""
    echo "PSA was not installed via git clone."
    echo "To fix, backup your data and reinstall:"
    echo ""
    echo "  1. Backup: cp -r $PSA_HOME $PSA_HOME.backup"
    echo "  2. Remove: rm -rf $PSA_HOME"
    echo "  3. Clone: git clone https://github.com/your-username/psa.git $PSA_HOME"
    echo "  4. Install: cd $PSA_HOME && ./install.sh"
    echo ""
    exit 1
fi

cd "$PSA_DIR"

# Check for local changes
if ! git diff-index --quiet HEAD --; then
    echo -e "${YELLOW}⚠️  You have uncommitted local changes${RESET}"
    echo ""
    git status --short
    echo ""
    read -p "Stash changes and continue? (y/N) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git stash push -m "PSA update $(date +%Y-%m-%d-%H%M%S)"
        echo -e "${GREEN}✓ Changes stashed${RESET}"
        echo ""
    else
        echo -e "${RED}Update cancelled.${RESET}"
        exit 0
    fi
fi

# Fetch latest
echo -e "${YELLOW}Fetching latest from GitHub...${RESET}"
git fetch origin main

# Show what will be updated
BEHIND=$(git rev-list HEAD..origin/main --count)

if [ "$BEHIND" -eq 0 ]; then
    echo -e "${GREEN}✓ PSA is already up to date!${RESET}"
    echo ""
    exit 0
fi

echo ""
echo -e "${CYAN}Updates available: $BEHIND commits behind${RESET}"
echo ""
echo -e "${BOLD}Recent changes:${RESET}"
git log HEAD..origin/main --oneline --max-count=10
echo ""

read -p "Update to latest version? (Y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]] && [ -n "$REPLY" ]; then
    echo -e "${RED}Update cancelled.${RESET}"
    exit 0
fi

# Pull latest
echo ""
echo -e "${YELLOW}Pulling latest changes...${RESET}"
git pull origin main

# Re-run installer to update permissions, links, etc.
echo ""
echo -e "${YELLOW}Running installer to update permissions...${RESET}"

if [ -x "./install.sh" ]; then
    ./install.sh --update
else
    echo -e "${YELLOW}No installer found, setting permissions manually...${RESET}"
    chmod +x scripts/*.sh
fi

echo ""
echo -e "${GREEN}✓ PSA updated successfully!${RESET}"
echo ""

# Show version
if [ -f "VERSION" ]; then
    echo -e "${BOLD}Current version:${RESET}"
    cat VERSION
    echo ""
fi

echo -e "${CYAN}💡 New features available - run:${RESET}"
echo -e "  ${GREEN}psa help${RESET} - See all commands"
echo ""

# Reload shell (suggestion)
echo -e "${YELLOW}Tip: Reload your shell to use updated commands:${RESET}"
echo -e "  ${GREEN}source ~/.zshrc${RESET}"
echo ""
