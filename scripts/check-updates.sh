#!/bin/bash

# PSA Check Updates
# Checks for outdated Homebrew and pnpm global packages

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
CACHE_FILE="$PSA_DIR/.update-check-cache"
CACHE_AGE_SECONDS=86400  # 24 hours

echo -e "${BOLD}${BLUE}📦 PSA Update Check${RESET}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if cache exists and is recent
if [ -f "$CACHE_FILE" ]; then
    CACHE_AGE=$(($(date +%s) - $(stat -f %m "$CACHE_FILE" 2>/dev/null || stat -c %Y "$CACHE_FILE" 2>/dev/null)))
    if [ $CACHE_AGE -lt $CACHE_AGE_SECONDS ]; then
        HOURS_AGO=$((CACHE_AGE / 3600))
        echo -e "${CYAN}Last checked: ${HOURS_AGO} hours ago${RESET}"
        echo ""
    fi
fi

# Check pnpm global packages
echo -e "${BOLD}Global CLI Tools (pnpm):${RESET}"
echo ""

PNPM_OUTDATED=$(npx pnpm outdated -g --format json 2>/dev/null || echo "[]")

if [ "$PNPM_OUTDATED" = "[]" ] || [ -z "$PNPM_OUTDATED" ]; then
    echo -e "  ${GREEN}✅ All global tools are up to date${RESET}"
else
    # Parse and display outdated packages
    echo "$PNPM_OUTDATED" | npx --yes json-parse 2>/dev/null | while IFS= read -r line; do
        PACKAGE=$(echo "$line" | grep -o '"name":"[^"]*"' | cut -d'"' -f4)
        CURRENT=$(echo "$line" | grep -o '"current":"[^"]*"' | cut -d'"' -f4)
        LATEST=$(echo "$line" | grep -o '"latest":"[^"]*"' | cut -d'"' -f4)

        if [ -n "$PACKAGE" ]; then
            # Determine update type (major/minor/patch)
            MAJOR_CURRENT=$(echo "$CURRENT" | cut -d'.' -f1)
            MAJOR_LATEST=$(echo "$LATEST" | cut -d'.' -f1)
            MINOR_CURRENT=$(echo "$CURRENT" | cut -d'.' -f2)
            MINOR_LATEST=$(echo "$LATEST" | cut -d'.' -f2)

            if [ "$MAJOR_CURRENT" != "$MAJOR_LATEST" ]; then
                echo -e "  ${RED}🔴 $PACKAGE:${RESET} $CURRENT → $LATEST ${RED}(major, breaking!)${RESET}"
            elif [ "$MINOR_CURRENT" != "$MINOR_LATEST" ]; then
                echo -e "  ${YELLOW}⚠️  $PACKAGE:${RESET} $CURRENT → $LATEST ${YELLOW}(minor, review)${RESET}"
            else
                echo -e "  ${GREEN}✨ $PACKAGE:${RESET} $CURRENT → $LATEST ${GREEN}(patch, safe)${RESET}"
            fi
        fi
    done || {
        # Fallback: simpler parsing if json-parse not available
        npx pnpm outdated -g 2>/dev/null | tail -n +3 | while IFS= read -r line; do
            if [ -n "$line" ]; then
                echo -e "  ${YELLOW}⚠️  $line${RESET}"
            fi
        done
    }
fi

echo ""

# Check Homebrew packages
echo -e "${BOLD}System Tools (Homebrew):${RESET}"
echo ""

BREW_OUTDATED=$(brew outdated --formula 2>/dev/null || echo "")

if [ -z "$BREW_OUTDATED" ]; then
    echo -e "  ${GREEN}✅ All Homebrew formulas are up to date${RESET}"
else
    echo "$BREW_OUTDATED" | head -20 | while IFS= read -r line; do
        PACKAGE=$(echo "$line" | awk '{print $1}')
        CURRENT=$(echo "$line" | awk '{print $2}')
        LATEST=$(echo "$line" | awk '{print $4}')

        if [ -n "$PACKAGE" ]; then
            echo -e "  ${CYAN}✨ $PACKAGE:${RESET} $CURRENT → $LATEST"
        fi
    done

    TOTAL_OUTDATED=$(echo "$BREW_OUTDATED" | wc -l | tr -d ' ')
    if [ "$TOTAL_OUTDATED" -gt 20 ]; then
        echo -e "  ${YELLOW}... and $((TOTAL_OUTDATED - 20)) more${RESET}"
    fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${BOLD}Available Commands:${RESET}"
echo -e "  ${GREEN}psa upgrade-global${RESET}  - Upgrade all global CLI tools (pnpm)"
echo -e "  ${GREEN}psa upgrade-system${RESET}  - Upgrade system tools (Homebrew)"
echo -e "  ${GREEN}psa upgrade-all${RESET}     - Upgrade everything"
echo ""

# Update cache timestamp
touch "$CACHE_FILE"
