#!/bin/bash

# PSA Sync Protocols
# Copies latest protocols from $PSA_HOME/protocols/ to current project

set -e

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
BLUE="\033[34m"
CYAN="\033[36m"
RESET="\033[0m"

PSA_PROTOCOLS="${PSA_HOME:-$HOME/.psa}/protocols"
PROJECT_PROTOCOLS="./docs/protocols"

echo -e "${BOLD}${BLUE}📋 Sync PSA Protocols${RESET}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if we're in a project directory
if [ ! -f "package.json" ] && [ ! -f "CLAUDE.md" ] && [ ! -f "pyproject.toml" ]; then
    echo -e "${RED}Error: Not in a project root directory${RESET}"
    echo -e "${CYAN}Run this command from your project root (where CLAUDE.md is)${RESET}"
    exit 1
fi

# Create docs/protocols if it doesn't exist
if [ ! -d "$PROJECT_PROTOCOLS" ]; then
    echo -e "${YELLOW}Creating docs/protocols directory...${RESET}"
    mkdir -p "$PROJECT_PROTOCOLS"
fi

# List available protocols
echo -e "${BOLD}Available PSA protocols:${RESET}"
echo ""

PROTOCOL_COUNT=0
for protocol in "$PSA_PROTOCOLS"/*.md; do
    if [ -f "$protocol" ]; then
        PROTOCOL_NAME=$(basename "$protocol")
        PROTOCOL_COUNT=$((PROTOCOL_COUNT + 1))
        echo -e "  ${CYAN}$PROTOCOL_COUNT.${RESET} $PROTOCOL_NAME"
    fi
done

if [ $PROTOCOL_COUNT -eq 0 ]; then
    echo -e "${RED}No protocols found in $PSA_HOME/protocols/${RESET}"
    exit 1
fi

echo ""
echo -e "${YELLOW}This will copy all protocols to: $PROJECT_PROTOCOLS${RESET}"
echo ""
read -p "Continue? (Y/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo -e "${RED}Sync cancelled.${RESET}"
    exit 0
fi

echo ""
echo -e "${BOLD}Syncing protocols...${RESET}"
echo ""

COPIED=0
UPDATED=0
SKIPPED=0

for protocol in "$PSA_PROTOCOLS"/*.md; do
    if [ -f "$protocol" ]; then
        PROTOCOL_NAME=$(basename "$protocol")
        DEST="$PROJECT_PROTOCOLS/$PROTOCOL_NAME"

        if [ -f "$DEST" ]; then
            # Check if files are different
            if ! diff -q "$protocol" "$DEST" > /dev/null 2>&1; then
                cp "$protocol" "$DEST"
                echo -e "  ${YELLOW}⬆️  Updated:${RESET} $PROTOCOL_NAME"
                UPDATED=$((UPDATED + 1))
            else
                echo -e "  ${GREEN}✓${RESET} Already current: $PROTOCOL_NAME"
                SKIPPED=$((SKIPPED + 1))
            fi
        else
            cp "$protocol" "$DEST"
            echo -e "  ${GREEN}✨ Copied:${RESET} $PROTOCOL_NAME"
            COPIED=$((COPIED + 1))
        fi
    fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${BOLD}Summary:${RESET}"
echo -e "  ${GREEN}✨ New:${RESET} $COPIED"
echo -e "  ${YELLOW}⬆️  Updated:${RESET} $UPDATED"
echo -e "  ${CYAN}✓ Already current:${RESET} $SKIPPED"
echo ""

if [ $COPIED -gt 0 ] || [ $UPDATED -gt 0 ]; then
    echo -e "${CYAN}💡 Don't forget to commit the updated protocols!${RESET}"
    echo -e "   ${GREEN}git add docs/protocols/${RESET}"
    echo -e "   ${GREEN}git commit -m \"Update PSA protocols\"${RESET}"
    echo ""
fi

echo -e "${BOLD}Protocols are now synced!${RESET}"
echo ""
echo -e "${CYAN}Agents working on this project will now have access to:${RESET}"
ls -1 "$PROJECT_PROTOCOLS" | sed 's/^/  - /'
echo ""
