#!/bin/bash

# PSA Environment Doctor
# Validates shell environment configuration for PSA compatibility

set -euo pipefail

# Colors
BOLD="\033[1m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
CYAN="\033[0;36m"
RESET="\033[0m"

PSA_HOME="${PSA_HOME:-$HOME/.psa}"

echo -e "${BOLD}${CYAN}PSA Environment Doctor${RESET}"
echo "======================"
echo ""

ERRORS=0
WARNINGS=0

# ============================================================================
# CHECK 1: ~/.zshenv exists
# ============================================================================

echo -n "Checking ~/.zshenv exists... "
if [ ! -f "$HOME/.zshenv" ]; then
    echo -e "${RED}✗ CRITICAL${RESET}"
    echo -e "  ${RED}Problem:${RESET} ~/.zshenv not found"
    echo "  ${CYAN}Why:${RESET} Non-interactive shells (Claude Code, scripts) need this file"
    echo "  ${GREEN}Fix:${RESET} Run: psa init-env"
    ((ERRORS++))
else
    echo -e "${GREEN}✓${RESET}"
fi

# ============================================================================
# CHECK 2: PNPM_HOME configured
# ============================================================================

echo -n "Checking PNPM_HOME configured... "
if ! grep -q "PNPM_HOME" "$HOME/.zshenv" 2>/dev/null; then
    echo -e "${RED}✗ CRITICAL${RESET}"
    echo -e "  ${RED}Problem:${RESET} PNPM_HOME not set in ~/.zshenv"
    echo "  ${CYAN}Why:${RESET} pnpm will fail with ERR_PNPM_NO_GLOBAL_BIN_DIR"
    echo "  ${GREEN}Fix:${RESET} Run: psa init-env"
    ((ERRORS++))
else
    echo -e "${GREEN}✓${RESET}"

    # Verify PNPM_HOME is actually set
    if [ -z "${PNPM_HOME:-}" ]; then
        echo -e "  ${YELLOW}⚠ WARNING: PNPM_HOME not loaded in current session${RESET}"
        echo "  ${CYAN}Why:${RESET} Need to restart terminal or run: source ~/.zshenv"
        echo "  ${GREEN}Fix:${RESET} Open new terminal window or: exec zsh"
        ((WARNINGS++))
    fi
fi

# ============================================================================
# CHECK 3: PSA_HOME configured
# ============================================================================

echo -n "Checking PSA_HOME configured... "
if ! grep -q "PSA_HOME" "$HOME/.zshenv" 2>/dev/null; then
    echo -e "${YELLOW}⚠ WARNING${RESET}"
    echo "  ${YELLOW}Problem:${RESET} PSA_HOME not set in ~/.zshenv"
    echo "  ${CYAN}Impact:${RESET} Scripts may use wrong PSA directory"
    echo "  ${GREEN}Fix:${RESET} Run: psa init-env"
    ((WARNINGS++))
else
    echo -e "${GREEN}✓${RESET}"
fi

# ============================================================================
# CHECK 4: pnpm binary exists
# ============================================================================

echo -n "Checking pnpm installed... "
if ! command -v pnpm &> /dev/null; then
    echo -e "${RED}✗ CRITICAL${RESET}"
    echo -e "  ${RED}Problem:${RESET} pnpm command not found"
    echo "  ${CYAN}Why:${RESET} Required for PSA package management"
    echo "  ${GREEN}Fix:${RESET} brew install pnpm"
    ((ERRORS++))
else
    PNPM_VERSION=$(pnpm --version 2>/dev/null || echo "unknown")
    echo -e "${GREEN}✓${RESET} (version: $PNPM_VERSION)"
fi

# ============================================================================
# CHECK 5: pnpm global bin accessible
# ============================================================================

echo -n "Checking pnpm global bin accessible... "
if command -v pnpm &> /dev/null; then
    if PNPM_BIN=$(pnpm bin -g 2>/dev/null); then
        echo -e "${GREEN}✓${RESET} ($PNPM_BIN)"

        # Check if in PATH
        if [[ ":$PATH:" != *":$PNPM_BIN:"* ]] && [[ ":$PATH:" != *"pnpm"* ]]; then
            echo -e "  ${YELLOW}⚠ WARNING: pnpm global bin not in PATH${RESET}"
            echo "  ${CYAN}Impact:${RESET} Globally installed tools won't be accessible"
            echo "  ${GREEN}Fix:${RESET} Add to ~/.zshenv: export PATH=\"$PNPM_BIN:\$PATH\""
            ((WARNINGS++))
        fi
    else
        echo -e "${RED}✗ CRITICAL${RESET}"
        echo -e "  ${RED}Problem:${RESET} pnpm bin -g failed"
        echo "  ${CYAN}Why:${RESET} pnpm not configured correctly"
        echo "  ${GREEN}Fix:${RESET} Run: psa init-env"
        ((ERRORS++))
    fi
else
    echo -e "${YELLOW}⚠ SKIPPED${RESET} (pnpm not installed)"
fi

# ============================================================================
# CHECK 6: PSA bin directory in PATH
# ============================================================================

echo -n "Checking PSA bin in PATH... "
if [ -d "$PSA_HOME/bin" ] || [ -d "$PSA_HOME/scripts" ]; then
    PSA_BIN_DIR="${PSA_HOME}/bin"
    [ -d "$PSA_HOME/scripts" ] && PSA_BIN_DIR="$PSA_HOME/scripts"

    if [[ ":$PATH:" == *":$PSA_BIN_DIR:"* ]] || [[ ":$PATH:" == *"/.psa/"* ]]; then
        echo -e "${GREEN}✓${RESET}"
    else
        echo -e "${YELLOW}⚠ WARNING${RESET}"
        echo "  ${YELLOW}Problem:${RESET} PSA bin directory not in PATH"
        echo "  ${CYAN}Impact:${RESET} psa commands won't work without full path"
        echo "  ${GREEN}Fix:${RESET} Add to ~/.zshenv: export PATH=\"$PSA_HOME/bin:\$PATH\""
        ((WARNINGS++))
    fi
else
    echo -e "${YELLOW}⚠ WARNING${RESET} (PSA bin directory doesn't exist)"
fi

# ============================================================================
# CHECK 7: Required tools
# ============================================================================

echo ""
echo -e "${BOLD}Checking required tools:${RESET}"

REQUIRED_TOOLS=(
    "git:Git version control"
    "jq:JSON processor"
)

for tool_desc in "${REQUIRED_TOOLS[@]}"; do
    IFS=':' read -r tool desc <<< "$tool_desc"
    echo -n "  $tool ($desc)... "
    if command -v "$tool" &> /dev/null; then
        echo -e "${GREEN}✓${RESET}"
    else
        echo -e "${RED}✗ MISSING${RESET}"
        echo -e "    ${GREEN}Install:${RESET} brew install $tool"
        ((ERRORS++))
    fi
done

# ============================================================================
# CHECK 8: Recommended tools
# ============================================================================

echo ""
echo -e "${BOLD}Checking recommended tools:${RESET}"

RECOMMENDED_TOOLS=(
    "bun:JavaScript runtime"
    "rg:ripgrep search"
    "fd:fd-find file finder"
    "bat:Better cat"
    "glow:Markdown viewer"
)

for tool_desc in "${RECOMMENDED_TOOLS[@]}"; do
    IFS=':' read -r tool desc <<< "$tool_desc"
    echo -n "  $tool ($desc)... "
    if command -v "$tool" &> /dev/null; then
        echo -e "${GREEN}✓${RESET}"
    else
        echo -e "${YELLOW}⚠ OPTIONAL${RESET}"
        echo -e "    ${CYAN}Install:${RESET} brew install $tool"
        ((WARNINGS++))
    fi
done

# ============================================================================
# CHECK 9: Protocol files
# ============================================================================

echo ""
echo -n "Checking protocol files... "
if [ -d "$PSA_HOME/protocols" ]; then
    PROTOCOL_COUNT=$(find "$PSA_HOME/protocols" -name "*.md" -type f | wc -l | tr -d ' ')
    echo -e "${GREEN}✓${RESET} ($PROTOCOL_COUNT protocols)"
else
    echo -e "${YELLOW}⚠ WARNING${RESET}"
    echo "  ${YELLOW}Problem:${RESET} No protocols directory"
    echo "  ${CYAN}Impact:${RESET} Agents won't have guidance"
    echo "  ${GREEN}Fix:${RESET} Run: psa sync-protocols"
    ((WARNINGS++))
fi

# ============================================================================
# SUMMARY
# ============================================================================

echo ""
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${BOLD}Summary${RESET}"
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✓ Environment configuration looks good!${RESET}"
    echo ""
    echo "PSA is ready to use."
    exit 0
elif [ $ERRORS -gt 0 ]; then
    echo -e "${RED}✗ $ERRORS critical error(s) found${RESET}"
    echo -e "${YELLOW}⚠ $WARNINGS warning(s) found${RESET}"
    echo ""
    echo -e "${BOLD}Quick Fix:${RESET}"
    echo "  ${GREEN}psa init-env${RESET}  # Automatically fix common issues"
    echo ""
    echo "Then restart your terminal or run:"
    echo "  ${GREEN}exec zsh${RESET}"
    echo ""
    exit 1
else
    echo -e "${YELLOW}⚠ $WARNINGS warning(s) found${RESET}"
    echo ""
    echo "System will work but may have issues in some contexts."
    echo "Consider running: ${GREEN}psa init-env${RESET}"
    echo ""
    exit 0
fi
