#!/bin/bash

# PSA Upgrade All
# Upgrades both pnpm global and Homebrew packages

set -e

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
BLUE="\033[34m"
CYAN="\033[36m"
RESET="\033[0m"

SCRIPTS_DIR="${PSA_HOME:-$HOME/.psa}/scripts"

echo -e "${BOLD}${BLUE}⬆️  Upgrade All Tools${RESET}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${YELLOW}This will upgrade:${RESET}"
echo -e "  1. Global CLI tools (pnpm)"
echo -e "  2. System tools (Homebrew)"
echo ""
echo -e "${RED}⚠️  Warning: Full system upgrade. Use with caution!${RESET}"
echo ""
read -p "Continue? (y/N) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Upgrade cancelled.${RESET}"
    exit 0
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Step 1: Upgrade global tools
echo -e "${BOLD}Step 1/2: Upgrading Global CLI Tools${RESET}"
echo ""
"$SCRIPTS_DIR/upgrade-global.sh" || {
    echo -e "${RED}Global upgrade failed or was cancelled${RESET}"
    exit 1
}

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Step 2: Upgrade system tools
echo -e "${BOLD}Step 2/2: Upgrading System Tools${RESET}"
echo ""
"$SCRIPTS_DIR/upgrade-system.sh" || {
    echo -e "${RED}System upgrade failed or was cancelled${RESET}"
    exit 1
}

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${BOLD}${GREEN}✅ All upgrades complete!${RESET}"
echo ""
echo -e "${CYAN}💡 Next steps:${RESET}"
echo -e "  1. Run: ${GREEN}psa context${RESET} to see updated versions"
echo -e "  2. Test critical tools before working on projects"
echo -e "  3. Restart terminal if you encounter PATH issues"
echo ""
