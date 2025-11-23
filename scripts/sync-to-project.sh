#!/bin/bash

# PSA Sync to Project
# Syncs PSA protocols and commands to current project while preserving customizations

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
PROJECT_DIR="${1:-.}"  # Default to current directory

# Change to project directory
cd "$PROJECT_DIR"
PROJECT_DIR="$(pwd)"  # Get absolute path

echo -e "${BOLD}${BLUE}PSA Sync to Project${RESET}"
echo -e "${CYAN}Project:${RESET} $PROJECT_DIR"
echo ""

# ============================================================================
# CHECK IF PROJECT HAS PSA
# ============================================================================

check_psa_project() {
    if [ ! -f "CLAUDE.md" ] && [ ! -f "AGENTS.md" ]; then
        echo -e "${YELLOW}⚠️  This project doesn't appear to have PSA initialized${RESET}"
        echo ""
        echo "Initialize PSA first:"
        echo "  psa init-project $(basename "$PROJECT_DIR") $PROJECT_DIR"
        echo ""
        exit 1
    fi
}

# ============================================================================
# SYNC PROTOCOLS
# ============================================================================

sync_protocols() {
    echo -e "${BOLD}📄 Syncing Protocols${RESET}"

    if [ ! -d "$PSA_DIR/protocols" ]; then
        echo -e "${YELLOW}  No protocols found in PSA${RESET}"
        return
    fi

    # Create docs/protocols if it doesn't exist
    mkdir -p "$PROJECT_DIR/docs/protocols"

    # Copy all protocols
    local count=0
    for protocol in "$PSA_DIR/protocols"/*.md; do
        if [ -f "$protocol" ]; then
            local filename=$(basename "$protocol")
            cp "$protocol" "$PROJECT_DIR/docs/protocols/"
            echo -e "  ${GREEN}✓${RESET} $filename"
            ((count++))
        fi
    done

    echo -e "  ${CYAN}Synced $count protocol(s)${RESET}"
    echo ""
}

# ============================================================================
# SYNC SLASH COMMANDS
# ============================================================================

sync_slash_commands() {
    echo -e "${BOLD}🤖 Syncing Claude Code Slash Commands${RESET}"

    if [ ! -d "$PSA_DIR/examples/commands" ]; then
        echo -e "${YELLOW}  No example commands found in PSA${RESET}"
        return
    fi

    # Create .claude/commands if it doesn't exist
    mkdir -p "$PROJECT_DIR/.claude/commands"

    # Copy PSA commands only (not project-specific ones like launch-dev)
    local count=0
    for cmd in "$PSA_DIR/examples/commands"/psa*.md; do
        if [ -f "$cmd" ]; then
            local filename=$(basename "$cmd")

            # Check if file exists and has customizations
            if [ -f "$PROJECT_DIR/.claude/commands/$filename" ]; then
                # Compare files
                if ! diff -q "$cmd" "$PROJECT_DIR/.claude/commands/$filename" > /dev/null 2>&1; then
                    echo -e "  ${YELLOW}⚠${RESET}  $filename (differs - backed up as ${filename}.backup)"
                    cp "$PROJECT_DIR/.claude/commands/$filename" "$PROJECT_DIR/.claude/commands/${filename}.backup"
                    cp "$cmd" "$PROJECT_DIR/.claude/commands/$filename"
                else
                    echo -e "  ${GREEN}✓${RESET} $filename (no changes)"
                fi
            else
                cp "$cmd" "$PROJECT_DIR/.claude/commands/"
                echo -e "  ${GREEN}✓${RESET} $filename (new)"
            fi
            ((count++))
        fi
    done

    echo -e "  ${CYAN}Synced $count command(s)${RESET}"
    echo ""
}

# ============================================================================
# UPDATE CLAUDE.MD CONTEXT
# ============================================================================

update_claude_context() {
    echo -e "${BOLD}📝 Updating CLAUDE.md Context${RESET}"

    if [ ! -f "$PROJECT_DIR/CLAUDE.md" ]; then
        echo -e "${YELLOW}  No CLAUDE.md found${RESET}"
        return
    fi

    # Use psa context --update to update the environment context section
    if command -v psa > /dev/null 2>&1; then
        echo -e "  ${CYAN}Running: psa context --update${RESET}"
        psa context --update > /dev/null 2>&1 || true
        echo -e "  ${GREEN}✓${RESET} Environment context updated"
    else
        echo -e "${YELLOW}  PSA command not found${RESET}"
    fi

    echo ""
}

# ============================================================================
# GIT STATUS CHECK
# ============================================================================

show_git_status() {
    if [ -d ".git" ]; then
        echo -e "${BOLD}📊 Git Status${RESET}"
        echo ""

        # Check if there are changes
        if ! git diff --quiet || ! git diff --cached --quiet || [ -n "$(git ls-files --others --exclude-standard)" ]; then
            git status --short
            echo ""
            echo -e "${CYAN}Review changes with:${RESET}"
            echo "  git diff"
            echo "  git diff docs/protocols/"
            echo "  git diff .claude/commands/"
        else
            echo -e "  ${GREEN}✓${RESET} No changes (already up to date)"
        fi
        echo ""
    fi
}

# ============================================================================
# MAIN
# ============================================================================

main() {
    check_psa_project
    sync_protocols
    sync_slash_commands
    update_claude_context
    show_git_status

    echo -e "${GREEN}✅ Sync complete!${RESET}"
    echo ""
    echo -e "${CYAN}Next steps:${RESET}"
    echo "  1. Review changes: git diff"
    echo "  2. Test commands: /psa-help, /psa-shortcuts"
    echo "  3. Commit if satisfied: git add . && git commit -m 'chore: sync PSA updates'"
    echo ""
}

main
