#!/bin/bash

# PSA Update Self
# Updates PSA from GitHub repository while preserving local customizations

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

echo -e "${BOLD}${BLUE}PSA Update Self${RESET}"
echo ""

# ============================================================================
# CHECK IF GIT REPO
# ============================================================================

check_git_repo() {
    cd "$PSA_DIR"

    if [ ! -d ".git" ]; then
        echo -e "${RED}Error: PSA is not a git repository${RESET}"
        echo ""
        echo "PSA appears to be installed but not from git."
        echo "To enable updates, initialize git:"
        echo ""
        echo "  cd $PSA_HOME"
        echo "  git init"
        echo "  git add ."
        echo "  git commit -m 'Initial commit'"
        echo "  git remote add origin <github-url>"
        echo ""
        exit 1
    fi
}

# ============================================================================
# CHECK FOR REMOTE
# ============================================================================

check_remote() {
    if ! git remote get-url origin > /dev/null 2>&1; then
        echo -e "${YELLOW}⚠️  No git remote configured${RESET}"
        echo ""
        echo "To enable updates from GitHub, add a remote:"
        echo "  cd $PSA_HOME"
        echo "  git remote add origin https://github.com/username/psa.git"
        echo ""
        read -p "Continue with local update only? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 0
        fi
        echo ""
        return 1
    fi
    return 0
}

# ============================================================================
# CHECK FOR LOCAL CHANGES
# ============================================================================

check_local_changes() {
    echo -e "${BOLD}🔍 Checking for local changes${RESET}"

    if ! git diff --quiet || ! git diff --cached --quiet; then
        echo -e "${YELLOW}  ⚠️  You have uncommitted changes:${RESET}"
        echo ""
        git status --short
        echo ""
        read -p "Stash changes and continue? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Cancelled. Commit or stash your changes first."
            exit 0
        fi

        echo -e "${CYAN}  Stashing changes...${RESET}"
        git stash push -m "PSA update-self auto-stash $(date +%Y-%m-%d_%H:%M:%S)"
        echo -e "  ${GREEN}✓${RESET} Changes stashed"
        echo ""
        return 0  # Indicate we stashed
    else
        echo -e "  ${GREEN}✓${RESET} No local changes"
        echo ""
        return 1  # Indicate no stash
    fi
}

# ============================================================================
# PULL UPDATES
# ============================================================================

pull_updates() {
    local has_remote=$1

    if [ $has_remote -eq 0 ]; then
        echo -e "${BOLD}📥 Pulling updates from GitHub${RESET}"

        local current_branch=$(git branch --show-current)
        echo -e "  ${CYAN}Current branch: $current_branch${RESET}"

        if git pull origin "$current_branch"; then
            echo -e "  ${GREEN}✓${RESET} Updates pulled successfully"
            echo ""
            return 0
        else
            echo -e "  ${RED}✗${RESET} Pull failed"
            echo ""
            return 1
        fi
    else
        echo -e "${YELLOW}Skipping pull (no remote configured)${RESET}"
        echo ""
        return 1
    fi
}

# ============================================================================
# RESTORE STASH
# ============================================================================

restore_stash() {
    local was_stashed=$1

    if [ $was_stashed -eq 0 ]; then
        echo -e "${BOLD}📦 Restoring stashed changes${RESET}"

        if git stash pop; then
            echo -e "  ${GREEN}✓${RESET} Stash restored"
            echo ""
        else
            echo -e "  ${YELLOW}⚠️  Stash restore had conflicts${RESET}"
            echo ""
            echo "Resolve conflicts manually:"
            echo "  cd $PSA_HOME"
            echo "  git status"
            echo "  # Fix conflicts"
            echo "  git add ."
            echo "  git stash drop  # When done"
            echo ""
        fi
    fi
}

# ============================================================================
# UPDATE GLOBAL SLASH COMMANDS
# ============================================================================

update_global_commands() {
    echo -e "${BOLD}🤖 Updating Global Claude Code Commands${RESET}"

    if [ ! -d "$PSA_DIR/examples/commands" ]; then
        echo -e "  ${YELLOW}No example commands found${RESET}"
        echo ""
        return
    fi

    mkdir -p "$HOME/.claude/commands"

    local count=0
    for cmd in "$PSA_DIR/examples/commands"/*.md; do
        if [ -f "$cmd" ]; then
            local filename=$(basename "$cmd")
            cp "$cmd" "$HOME/.claude/commands/"
            echo -e "  ${GREEN}✓${RESET} $filename"
            ((count++))
        fi
    done

    echo -e "  ${CYAN}Updated $count command(s)${RESET}"
    echo ""
}

# ============================================================================
# SHOW WHAT CHANGED
# ============================================================================

show_changes() {
    local has_remote=$1

    if [ $has_remote -eq 0 ]; then
        echo -e "${BOLD}📊 Recent Changes${RESET}"
        echo ""
        git log --oneline --since="1 week ago" -10 || true
        echo ""
    fi
}

# ============================================================================
# MAIN
# ============================================================================

main() {
    check_git_repo

    # Check for remote (returns 0 if exists, 1 if not)
    check_remote
    local has_remote=$?

    # Check for local changes (returns 0 if stashed, 1 if not)
    check_local_changes
    local was_stashed=$?

    # Pull updates
    pull_updates $has_remote
    local pull_success=$?

    # Restore stash if we created one
    restore_stash $was_stashed

    # Update global commands
    update_global_commands

    # Show what changed
    show_changes $has_remote

    if [ $pull_success -eq 0 ] || [ $has_remote -eq 1 ]; then
        echo -e "${GREEN}✅ PSA updated successfully!${RESET}"
        echo ""
        echo -e "${CYAN}Next steps:${RESET}"
        echo "  1. Test PSA commands: psa help"
        echo "  2. Test Claude commands: /psa-help"
        echo "  3. Sync to projects: psa sync-all-projects"
        echo ""
        echo -e "${BOLD}New features:${RESET}"
        echo "  • psa dash              - Global project dashboard"
        echo "  • psa sync-to-project   - Sync PSA to current project"
        echo "  • psa sync-all-projects - Sync PSA to all projects"
        echo "  • /psa-help             - Comprehensive command reference"
        echo "  • /psa-shortcuts        - Expanded shortcuts guide"
        echo ""
    else
        echo -e "${YELLOW}⚠️  Update incomplete${RESET}"
        echo ""
        echo "Check for errors above and try again."
        echo ""
    fi
}

main
