#!/bin/bash

# PSA Sync All Projects
# Syncs PSA updates to all tracked projects

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
REGISTRY_FILE="$PSA_DIR/data/projects-registry.json"
SYNC_SCRIPT="$PSA_DIR/scripts/sync-to-project.sh"

echo -e "${BOLD}${BLUE}PSA Sync All Projects${RESET}"
echo ""

# ============================================================================
# CHECK PREREQUISITES
# ============================================================================

check_prerequisites() {
    # Check if jq is installed
    if ! command -v jq &> /dev/null; then
        echo -e "${RED}Error: jq is required${RESET}"
        echo "Install: brew install jq"
        exit 1
    fi

    # Check if registry exists
    if [ ! -f "$REGISTRY_FILE" ]; then
        echo -e "${YELLOW}No project registry found${RESET}"
        echo ""
        echo "Scan projects first:"
        echo "  psa scan-projects"
        echo ""
        exit 1
    fi

    # Check if sync script exists
    if [ ! -f "$SYNC_SCRIPT" ]; then
        echo -e "${RED}Error: sync-to-project.sh not found${RESET}"
        exit 1
    fi
}

# ============================================================================
# SYNC ALL PROJECTS
# ============================================================================

sync_all() {
    local project_count=$(jq '.projects | length' "$REGISTRY_FILE")

    echo -e "${CYAN}Found $project_count project(s) in registry${RESET}"
    echo ""

    # Confirm before proceeding
    read -p "Sync PSA updates to all projects? (y/N) " -n 1 -r
    echo
    echo ""

    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Cancelled"
        exit 0
    fi

    # Track results
    local success_count=0
    local skip_count=0
    local error_count=0
    local errors_log="/tmp/psa-sync-errors.log"
    > "$errors_log"  # Clear log

    # Iterate through projects
    jq -c '.projects[]' "$REGISTRY_FILE" | while IFS= read -r project; do
        local name=$(echo "$project" | jq -r '.name')
        local path=$(echo "$project" | jq -r '.path')
        local status=$(echo "$project" | jq -r '.status // "unknown"')

        echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
        echo -e "${BOLD}$name${RESET} ${CYAN}($path)${RESET}"
        echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
        echo ""

        # Skip archived projects
        if [ "$status" == "archived" ]; then
            echo -e "${YELLOW}⏭  Skipping (archived)${RESET}"
            echo ""
            ((skip_count++))
            continue
        fi

        # Check if path exists
        if [ ! -d "$path" ]; then
            echo -e "${RED}✗  Path not found${RESET}"
            echo "$name: Path not found ($path)" >> "$errors_log"
            echo ""
            ((error_count++))
            continue
        fi

        # Run sync
        if "$SYNC_SCRIPT" "$path" 2>&1; then
            ((success_count++))
        else
            echo -e "${RED}✗  Sync failed${RESET}"
            echo "$name: Sync failed" >> "$errors_log"
            ((error_count++))
        fi

        echo ""
    done

    # Summary
    echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "${BOLD}Summary${RESET}"
    echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo ""
    echo -e "  ${GREEN}✓${RESET} Synced:  $success_count"
    echo -e "  ${YELLOW}⏭${RESET}  Skipped: $skip_count"
    echo -e "  ${RED}✗${RESET}  Errors:  $error_count"
    echo ""

    if [ $error_count -gt 0 ]; then
        echo -e "${RED}Errors occurred:${RESET}"
        cat "$errors_log"
        echo ""
    fi

    if [ $success_count -gt 0 ]; then
        echo -e "${GREEN}✅ Sync complete!${RESET}"
        echo ""
        echo -e "${CYAN}Next steps:${RESET}"
        echo "  1. Review changes in each project"
        echo "  2. Test PSA commands"
        echo "  3. Commit changes if satisfied"
        echo ""
    fi
}

# ============================================================================
# MAIN
# ============================================================================

main() {
    check_prerequisites
    sync_all
}

main
