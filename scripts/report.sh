#!/bin/bash

# PSA Anecdote Reporting Script
# Reports learnings about agent loadouts to the global master

set -e

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
BLUE="\033[34m"
RESET="\033[0m"

MASTER_FILE="${PSA_HOME:-$HOME/.psa}/AGENTS_MASTER.md"

# Check if master file exists
if [ ! -f "$MASTER_FILE" ]; then
    echo -e "${RED}Error: AGENTS_MASTER.md not found at $MASTER_FILE${RESET}"
    echo "Please run: psa init"
    exit 1
fi

# Parse arguments
LOADOUT_NAME="$1"
ANECDOTE="$2"

if [ -z "$LOADOUT_NAME" ] || [ -z "$ANECDOTE" ]; then
    echo -e "${BOLD}${BLUE}PSA Anecdote Reporter${RESET}"
    echo ""
    echo "Usage: psa report <loadout-name> <anecdote>"
    echo ""
    echo "Examples:"
    echo "  psa report \"claude-sonnet-4-5-warp\" \"Excellent at TypeScript refactoring\""
    echo "  psa report \"gpt-5-codex\" \"Generates more verbose code than Claude\""
    echo ""
    exit 1
fi

# Get current date
CURRENT_DATE=$(date +%Y-%m-%d)

# Try to determine project name from git (if in a git repo)
PROJECT_NAME="unknown"
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    PROJECT_NAME=$(basename "$(git rev-parse --show-toplevel)")
fi

# Format the anecdote entry
ANECDOTE_ENTRY="- **${CURRENT_DATE}** [${PROJECT_NAME}]: ${ANECDOTE}"

# Search for the loadout section in the master file
LOADOUT_SECTION="### Loadout: ${LOADOUT_NAME}"

if ! grep -q "$LOADOUT_SECTION" "$MASTER_FILE"; then
    echo -e "${YELLOW}Warning: Loadout '${LOADOUT_NAME}' not found in AGENTS_MASTER.md${RESET}"
    echo "Available loadouts:"
    grep "^### Loadout:" "$MASTER_FILE" | sed 's/### Loadout: /  - /'
    echo ""
    read -p "Continue anyway and add to general notes? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
    # Add to end of file under a general notes section
    echo "" >> "$MASTER_FILE"
    echo "### General Anecdotes" >> "$MASTER_FILE"
    echo "" >> "$MASTER_FILE"
    echo "$ANECDOTE_ENTRY" >> "$MASTER_FILE"
else
    # Find the "Anecdotes & Learnings" section for this loadout
    # Use awk to insert after the "Anecdotes & Learnings" header
    awk -v loadout="$LOADOUT_SECTION" -v anecdote="$ANECDOTE_ENTRY" '
        /^### Loadout:/ { in_loadout = ($0 == loadout) }
        in_loadout && /^#### Anecdotes & Learnings/ {
            print
            getline
            print
            print anecdote
            in_loadout = 0
            next
        }
        { print }
    ' "$MASTER_FILE" > "$MASTER_FILE.tmp"

    mv "$MASTER_FILE.tmp" "$MASTER_FILE"
fi

echo -e "${GREEN}✓${RESET} Anecdote added to AGENTS_MASTER.md"
echo -e "${BLUE}Loadout:${RESET} $LOADOUT_NAME"
echo -e "${BLUE}Project:${RESET} $PROJECT_NAME"
echo -e "${BLUE}Date:${RESET} $CURRENT_DATE"
echo -e "${BLUE}Note:${RESET} $ANECDOTE"
echo ""
echo -e "View master: ${BOLD}psa view-master${RESET}"
