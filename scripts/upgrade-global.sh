#!/bin/bash

# PSA Upgrade Global Tools
# Upgrades all pnpm global packages

set -e

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
BLUE="\033[34m"
RESET="\033[0m"

echo -e "${BOLD}${BLUE}⬆️  Upgrading Global CLI Tools (pnpm)${RESET}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check what's outdated first
echo -e "${YELLOW}Checking for outdated packages...${RESET}"
echo ""

OUTDATED=$(npx pnpm outdated -g 2>/dev/null || echo "")

if [ -z "$OUTDATED" ]; then
    echo -e "${GREEN}✅ All global tools are already up to date!${RESET}"
    echo ""
    exit 0
fi

echo "$OUTDATED"
echo ""

# Confirm before upgrading
echo -e "${YELLOW}This will upgrade all outdated global tools.${RESET}"
echo -e "${YELLOW}Major version upgrades may have breaking changes.${RESET}"
echo ""
read -p "Continue? (y/N) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Upgrade cancelled.${RESET}"
    exit 0
fi

echo ""
echo -e "${BOLD}Upgrading packages...${RESET}"
echo ""

# Upgrade all global packages
npx pnpm update -g --latest

echo ""
echo -e "${GREEN}✅ Global tools upgraded successfully!${RESET}"
echo ""
echo -e "${BOLD}Updated packages:${RESET}"
npx pnpm list -g --depth=0

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${CYAN}💡 Tip: Test your tools after upgrading${RESET}"
echo -e "  Run: ${GREEN}psa context${RESET} to see updated versions"
echo ""
