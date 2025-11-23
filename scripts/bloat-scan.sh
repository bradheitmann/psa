#!/bin/bash

# PSA Bloat Scan
# Scans current project for deletable bloat

set -e

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
CYAN="\033[36m"
RESET="\033[0m"

PROJECT_PATH="${1:-.}"
CONFIG_FILE="${PSA_HOME:-$HOME/.psa}/bloat/config.json"

# Detect current story
CURRENT_STORY=$(ls -d "$PROJECT_PATH/docs/evidence/story-"* 2>/dev/null | wc -l | tr -d ' ')
if [ "$CURRENT_STORY" -eq 0 ]; then
    echo -e "${YELLOW}No evidence directories found. Not an MVC project?${RESET}"
    exit 0
fi

echo -e "${BOLD}${CYAN}📊 PSA Bloat Scan${RESET}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${CYAN}Project:${RESET} $PROJECT_PATH"
echo -e "${CYAN}Current Story:${RESET} ~$CURRENT_STORY"
echo ""

# Calculate sizes
TOTAL_EVIDENCE_SIZE=0
KEEP_SIZE=0
DELETE_SIZE=0
CANONICAL_CANDIDATES=0

echo -e "${BOLD}Evidence Bundle Analysis:${RESET}"
echo ""

for evidence_dir in "$PROJECT_PATH/docs/evidence/story-"*/ ; do
    if [ ! -d "$evidence_dir" ]; then
        continue
    fi

    story_name=$(basename "$evidence_dir")
    story_num=$(echo "$story_name" | grep -o '[0-9]\+' | head -1)
    size_kb=$(du -sk "$evidence_dir" | cut -f1)
    size_mb=$(echo "scale=2; $size_kb/1024" | bc)

    TOTAL_EVIDENCE_SIZE=$(echo "$TOTAL_EVIDENCE_SIZE + $size_mb" | bc)

    # Determine retention
    offset=$((CURRENT_STORY - story_num))

    if [ "$offset" -le 2 ]; then
        # Active sprint (keep)
        echo -e "  ${GREEN}✓ Keep${RESET} $story_name (${size_mb}MB) - Active sprint"
        KEEP_SIZE=$(echo "$KEEP_SIZE + $size_mb" | bc)
    elif [ "$offset" -eq 3 ]; then
        # Review for canonical
        echo -e "  ${YELLOW}⚠ Review${RESET} $story_name (${size_mb}MB) - Canonical check at Story $((CURRENT_STORY + 1))"
        CANONICAL_CANDIDATES=$((CANONICAL_CANDIDATES + 1))
        KEEP_SIZE=$(echo "$KEEP_SIZE + $size_mb" | bc)
    else
        # Old, candidate for deletion
        echo -e "  ${RED}✗ Delete${RESET} $story_name (${size_mb}MB) - Story $((story_num)) is ${offset} stories old"
        DELETE_SIZE=$(echo "$DELETE_SIZE + $size_mb" | bc)
    fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${BOLD}Summary:${RESET}"
echo -e "  Total evidence size: ${CYAN}${TOTAL_EVIDENCE_SIZE}MB${RESET}"
echo -e "  Keeping (active + canonical): ${GREEN}${KEEP_SIZE}MB${RESET}"
echo -e "  Deletable: ${RED}${DELETE_SIZE}MB${RESET}"
echo -e "  Canonical candidates: ${YELLOW}${CANONICAL_CANDIDATES}${RESET}"
echo ""

# Warning if bloat high
if [ "$(echo "$TOTAL_EVIDENCE_SIZE > 100" | bc)" -eq 1 ]; then
    echo -e "${YELLOW}⚠️  Evidence size exceeds 100MB${RESET}"
    echo -e "   Consider: ${GREEN}psa bloat-clean --dry-run${RESET}"
    echo ""
fi

# Show canonical candidates
if [ "$CANONICAL_CANDIDATES" -gt 0 ]; then
    echo -e "${CYAN}💡 Canonical Review Available${RESET}"
    echo -e "   Check stories marked 'Review' for canonical potential"
    echo -e "   Command: ${GREEN}psa canonicalize <story-name>${RESET}"
    echo ""
fi

echo -e "${BOLD}Commands:${RESET}"
echo -e "  ${GREEN}psa canonicalize <story>${RESET}  - Extract canonical examples"
echo -e "  ${GREEN}psa bloat-clean --dry-run${RESET}  - Preview cleanup"
echo -e "  ${GREEN}psa bloat-stats${RESET}           - Detailed statistics"
echo ""
