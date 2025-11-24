#!/bin/bash

# PSA Environment Initializer
# Creates/updates ~/.zshenv with required configuration for PSA

set -euo pipefail

# Colors
BOLD="\033[1m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
RESET="\033[0m"

ZSHENV="$HOME/.zshenv"
ZSHRC="$HOME/.zshrc"
BACKUP_DIR="$HOME/.psa/backups/shell-config"

echo -e "${BOLD}${CYAN}PSA Environment Initializer${RESET}"
echo "============================"
echo ""

# ============================================================================
# BACKUP EXISTING FILES
# ============================================================================

mkdir -p "$BACKUP_DIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

if [ -f "$ZSHENV" ]; then
    BACKUP="$BACKUP_DIR/zshenv.$TIMESTAMP"
    echo "Backing up existing ~/.zshenv to:"
    echo "  $BACKUP"
    cp "$ZSHENV" "$BACKUP"
    echo ""
fi

if [ -f "$ZSHRC" ]; then
    BACKUP="$BACKUP_DIR/zshrc.$TIMESTAMP"
    echo "Backing up existing ~/.zshrc to:"
    echo "  $BACKUP"
    cp "$ZSHRC" "$BACKUP"
    echo ""
fi

# ============================================================================
# HELPER FUNCTION: Add line if not present
# ============================================================================

add_if_missing() {
    local line="$1"
    local file="$2"
    local description="$3"

    # Ensure file exists
    touch "$file"

    # Check if line already present (exact match or similar)
    local pattern=$(echo "$line" | sed 's/[]\/$*.^|[]/\\&/g' | sed 's/=.*/=/')

    if grep -q "$pattern" "$file" 2>/dev/null; then
        echo -e "  ${CYAN}Already set:${RESET} $description"
        return 0
    else
        echo "$line" >> "$file"
        echo -e "  ${GREEN}Added:${RESET} $description"
        return 1
    fi
}

# ============================================================================
# CONFIGURE ~/.zshenv
# ============================================================================

echo -e "${BOLD}Configuring ~/.zshenv${RESET}"
echo "(Loaded for ALL zsh sessions - interactive and non-interactive)"
echo ""

# Header comment
if ! grep -q "PSA Environment" "$ZSHENV" 2>/dev/null; then
    cat >> "$ZSHENV" << 'EOF'

# ============================================================================
# PSA Environment Configuration
# This file is loaded for ALL zsh sessions (interactive + non-interactive)
# Required for: Claude Code, scripts, automation, cron jobs
# ============================================================================

EOF
fi

# Homebrew (Apple Silicon)
add_if_missing 'eval "$(/opt/homebrew/bin/brew shellenv)"' "$ZSHENV" "Homebrew initialization"

# PSA_HOME
add_if_missing 'export PSA_HOME="$HOME/.psa"' "$ZSHENV" "PSA home directory"
add_if_missing 'export PATH="$PSA_HOME/bin:$PATH"' "$ZSHENV" "PSA bin in PATH"

# Alternative: scripts directory if bin doesn't exist
if [ -d "$HOME/.psa/scripts" ] && [ ! -d "$HOME/.psa/bin" ]; then
    add_if_missing 'export PATH="$PSA_HOME/scripts:$PATH"' "$ZSHENV" "PSA scripts in PATH"
fi

# pnpm (CRITICAL for package management)
add_if_missing 'export PNPM_HOME="$HOME/Library/pnpm"' "$ZSHENV" "pnpm home directory"
add_if_missing 'export PATH="$PNPM_HOME:$PATH"' "$ZSHENV" "pnpm bin in PATH"

# Bun
if [ -d "$HOME/.bun" ]; then
    add_if_missing 'export BUN_INSTALL="$HOME/.bun"' "$ZSHENV" "Bun installation"
    add_if_missing 'export PATH="$BUN_INSTALL/bin:$PATH"' "$ZSHENV" "Bun bin in PATH"
fi

# Cargo (Rust) - if installed
if [ -d "$HOME/.cargo" ]; then
    add_if_missing 'export PATH="$HOME/.cargo/bin:$PATH"' "$ZSHENV" "Cargo (Rust) bin in PATH"
fi

# Local bin
add_if_missing 'export PATH="$HOME/.local/bin:$PATH"' "$ZSHENV" "Local bin in PATH"

echo ""

# ============================================================================
# CLEAN UP ~/.zshrc
# ============================================================================

echo -e "${BOLD}Cleaning up ~/.zshrc${RESET}"
echo "(Removing duplicates - environment vars now in ~/.zshenv)"
echo ""

# Create temp file without env vars
if [ -f "$ZSHRC" ]; then
    # Remove Homebrew initialization (now in .zshenv)
    sed '/# Homebrew initialization/,/eval.*brew shellenv/d' "$ZSHRC" > "$ZSHRC.tmp"

    # Remove PSA exports (now in .zshenv)
    sed '/export PSA_HOME/d; /export PATH.*PSA_HOME/d' "$ZSHRC.tmp" > "$ZSHRC.tmp2"

    # Remove pnpm exports (now in .zshenv)
    sed '/# pnpm$/,/# pnpm end$/d' "$ZSHRC.tmp2" > "$ZSHRC.tmp3"
    sed '/export PNPM_HOME/d' "$ZSHRC.tmp3" > "$ZSHRC.tmp4"

    # Add header if not present
    if ! grep -q "Environment variables are now in ~/.zshenv" "$ZSHRC.tmp4" 2>/dev/null; then
        cat > "$ZSHRC" << 'EOF'
# Environment variables are now in ~/.zshenv (loaded for all shells)
# This file contains only interactive shell configuration (aliases, prompts, etc.)

EOF
        cat "$ZSHRC.tmp4" >> "$ZSHRC"
    else
        mv "$ZSHRC.tmp4" "$ZSHRC"
    fi

    # Clean up temp files
    rm -f "$ZSHRC".tmp*

    echo -e "  ${GREEN}✓${RESET} Removed duplicate environment variables from ~/.zshrc"
else
    echo -e "  ${CYAN}No ~/.zshrc found (creating minimal version)${RESET}"
    cat > "$ZSHRC" << 'EOF'
# Environment variables are in ~/.zshenv
# This file is for interactive shell configuration only

# PSA Aliases
alias psa-projects='cd $PSA_PROJECTS_DIR && ls -la'
alias psa-new='psa init-project'
EOF
fi

echo ""

# ============================================================================
# VERIFICATION
# ============================================================================

echo -e "${BOLD}Verifying configuration...${RESET}"
echo ""

# Test in fresh shell
if zsh -c 'source ~/.zshenv && [ -n "$PNPM_HOME" ]' 2>/dev/null; then
    echo -e "${GREEN}✓${RESET} PNPM_HOME loads in fresh shell"
else
    echo -e "${RED}✗${RESET} PNPM_HOME not loading correctly"
    ((ERRORS++))
fi

if zsh -c 'source ~/.zshenv && command -v psa' &>/dev/null; then
    echo -e "${GREEN}✓${RESET} psa command accessible in fresh shell"
else
    echo -e "${YELLOW}⚠${RESET} psa command may not be in PATH"
fi

echo ""

# ============================================================================
# SUMMARY
# ============================================================================

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✓ Environment configuration complete!${RESET}"
    echo ""
    echo -e "${BOLD}IMPORTANT: Restart your terminal${RESET}"
    echo ""
    echo "Options:"
    echo "  1. Open a new terminal window (recommended)"
    echo "  2. Run: ${GREEN}exec zsh${RESET} (restarts current shell)"
    echo "  3. Run: ${GREEN}source ~/.zshenv${RESET} (temporary for this session)"
    echo ""
    echo "After restart, verify:"
    echo "  ${GREEN}psa doctor${RESET}"
    echo ""
    echo "For Claude Code sessions:"
    echo "  Exit Claude Code and start a new session"
    echo ""
else
    echo -e "${RED}✗ Configuration completed with errors${RESET}"
    echo ""
    echo "Please review errors above and fix manually if needed."
    echo ""
    exit 1
fi
