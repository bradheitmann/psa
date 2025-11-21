#!/bin/bash

# PSA Upgrade System Tools
# Upgrades all Homebrew packages

set -e

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
BLUE="\033[34m"
CYAN="\033[36m"
RESET="\033[0m"

echo -e "${BOLD}${BLUE}⬆️  Upgrading System Tools (Homebrew)${RESET}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Update Homebrew first
echo -e "${YELLOW}Updating Homebrew...${RESET}"
brew update 2>&1 | grep -E "(Updated|Already|New Formulae)" || true
echo ""

# Check what's outdated
echo -e "${YELLOW}Checking for outdated packages...${RESET}"
echo ""

OUTDATED=$(brew outdated --formula 2>/dev/null || echo "")

if [ -z "$OUTDATED" ]; then
    echo -e "${GREEN}✅ All Homebrew formulas are already up to date!${RESET}"
    echo ""
    exit 0
fi

echo "$OUTDATED" | head -20
TOTAL=$(echo "$OUTDATED" | wc -l | tr -d ' ')
if [ "$TOTAL" -gt 20 ]; then
    echo -e "${YELLOW}... and $((TOTAL - 20)) more${RESET}"
fi
echo ""

# Confirm before upgrading
echo -e "${YELLOW}This will upgrade all outdated Homebrew formulas.${RESET}"
echo -e "${RED}⚠️  Warning: System tool upgrades can occasionally break scripts.${RESET}"
echo -e "${CYAN}💡 Consider upgrading one at a time for critical tools.${RESET}"
echo ""
read -p "Continue with full upgrade? (y/N) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Upgrade cancelled.${RESET}"
    echo ""
    echo -e "${CYAN}To upgrade specific packages:${RESET}"
    echo -e "  ${GREEN}brew upgrade <package-name>${RESET}"
    echo ""
    exit 0
fi

echo ""
echo -e "${BOLD}Upgrading packages...${RESET}"
echo ""

# Upgrade all Homebrew packages
brew upgrade

echo ""
echo -e "${GREEN}✅ System tools upgraded successfully!${RESET}"
echo ""

# Clean up old versions
echo -e "${YELLOW}Cleaning up old versions...${RESET}"
brew cleanup
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${CYAN}💡 Tips after upgrading:${RESET}"
echo -e "  1. Test critical tools (git, node, etc.)"
echo -e "  2. Run: ${GREEN}psa context${RESET} to see updated versions"
echo -e "  3. Restart terminal if PATH issues occur"
echo ""
