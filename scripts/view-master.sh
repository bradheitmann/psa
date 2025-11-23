#!/bin/bash

# PSA View Master Script
# Displays the global AGENTS_MASTER.md

MASTER_FILE="${PSA_HOME:-$HOME/.psa}/AGENTS_MASTER.md"

# Colors
RED="\033[31m"
RESET="\033[0m"

if [ ! -f "$MASTER_FILE" ]; then
    echo -e "${RED}Error: AGENTS_MASTER.md not found at $MASTER_FILE${RESET}"
    exit 1
fi

# Use glow if available, otherwise cat
if command -v glow &> /dev/null; then
    glow "$MASTER_FILE"
elif command -v bat &> /dev/null; then
    bat "$MASTER_FILE"
else
    cat "$MASTER_FILE"
fi
