#!/bin/bash

# PSA Context
# Shows current system state for LLM prompts

set -e

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
BLUE="\033[34m"
CYAN="\033[36m"
RESET="\033[0m"

MODE="${1:-display}"

# Get current date
CURRENT_DATE=$(date +"%Y-%m-%d")

# Get versions
NODE_VERSION=$(node --version 2>/dev/null | sed 's/v//' || echo "not installed")
BUN_VERSION=$(bun --version 2>/dev/null || echo "not installed")
PYTHON_VERSION=$(python3 --version 2>/dev/null | awk '{print $2}' || echo "not installed")
GIT_VERSION=$(git --version 2>/dev/null | awk '{print $3}' || echo "not installed")
UV_VERSION=$(uv --version 2>/dev/null | awk '{print $2}' || echo "not installed")

# Get pnpm global packages
PNPM_PACKAGES=$(npx pnpm list -g --depth=0 2>/dev/null | grep -E "^[├└]" | sed 's/[├└]── //' | sed 's/ /: /' || echo "none")

# Display mode
if [ "$MODE" = "display" ] || [ "$MODE" = "--display" ]; then
    echo -e "${BOLD}${BLUE}🖥️  Current System Context${RESET}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo -e "${BOLD}Date:${RESET} $CURRENT_DATE"
    echo ""
    echo -e "${BOLD}Language Runtimes:${RESET}"
    echo -e "  Node.js:  $NODE_VERSION"
    echo -e "  Bun:      $BUN_VERSION"
    echo -e "  Python:   $PYTHON_VERSION"
    echo ""
    echo -e "${BOLD}System Tools:${RESET}"
    echo -e "  git:      $GIT_VERSION"
    echo -e "  uv:       $UV_VERSION"
    echo ""
    echo -e "${BOLD}Global CLI Tools (pnpm):${RESET}"
    echo "$PNPM_PACKAGES" | while IFS= read -r line; do
        if [ -n "$line" ]; then
            echo -e "  $line"
        fi
    done
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo -e "${CYAN}💡 Usage:${RESET}"
    echo -e "  ${GREEN}psa context${RESET}          - Show this display"
    echo -e "  ${GREEN}psa context --llm${RESET}    - Format for LLM prompts"
    echo -e "  ${GREEN}psa context --copy${RESET}   - Copy to clipboard (macOS)"
    echo -e "  ${GREEN}psa context --update${RESET} - Update CLAUDE.md versions"
    echo ""
fi

# LLM mode (plain text for copying into prompts)
if [ "$MODE" = "--llm" ]; then
    cat <<EOF
Current System Environment Context:

Date: $CURRENT_DATE

⚠️ IMPORTANT FOR LLM AGENTS:
Your training data may be outdated. This is the ACTUAL current environment.
Do NOT assume package availability based on your training cutoff.
ALWAYS verify packages exist before recommending them.

Language Runtimes:
- Node.js: $NODE_VERSION
- Bun: $BUN_VERSION
- Python: $PYTHON_VERSION

System Tools:
- git: $GIT_VERSION
- uv: $UV_VERSION (modern Python package manager)

Global CLI Tools (pnpm):
$PNPM_PACKAGES

Package Manager Rules:
- JavaScript/TypeScript: Use Bun (projects) or pnpm (global/existing projects)
- Python: Use uv (projects) or pipx (global tools)
- NEVER use npm (it's blocked and redirects to pnpm)

Before suggesting any package:
1. Verify it exists: npx pnpm view <package>
2. Check compatibility with current Node/Python versions
3. Review changelog for breaking changes

Protocol Reference: $PSA_HOME/protocols/PACKAGE-MANAGER-v1.0.md
EOF
fi

# Copy mode (macOS only)
if [ "$MODE" = "--copy" ]; then
    if command -v pbcopy &> /dev/null; then
        "$0" --llm | pbcopy
        echo -e "${GREEN}✅ Context copied to clipboard!${RESET}"
        echo -e "${CYAN}Paste into your LLM conversation.${RESET}"
    else
        echo -e "${RED}Error: pbcopy not available (macOS only)${RESET}"
        echo -e "${CYAN}Use: ${GREEN}psa context --llm${RESET} and copy manually"
        exit 1
    fi
fi

# Update mode (update CLAUDE.md)
if [ "$MODE" = "--update" ]; then
    CLAUDE_MD="$PWD/CLAUDE.md"

    if [ ! -f "$CLAUDE_MD" ]; then
        echo -e "${RED}Error: CLAUDE.md not found in current directory${RESET}"
        echo -e "${CYAN}Run this command from a project root with CLAUDE.md${RESET}"
        exit 1
    fi

    echo -e "${YELLOW}Updating version context in CLAUDE.md...${RESET}"

    # Create context block
    CONTEXT_BLOCK="## Current Environment Context

**Last Updated:** $CURRENT_DATE (Auto-updated by PSA)
**LLM Notice:** You are operating on $CURRENT_DATE. Your training data may be outdated.

### Installed Tools:

**Language Runtimes:**
- Node.js: $NODE_VERSION
- Bun: $BUN_VERSION
- Python: $PYTHON_VERSION

**System Tools:**
- git: $GIT_VERSION
- uv: $UV_VERSION

**Global CLI Tools (pnpm):**
$PNPM_PACKAGES

### Before Suggesting Packages:

1. **ALWAYS verify package exists:**
   \`\`\`bash
   npx pnpm view <package>        # Check if exists
   npx pnpm view <package> version  # Get latest version
   \`\`\`

2. **NEVER assume package availability from training data**
3. **Check compatibility** with current Node/Python versions
4. **Review changelogs** for breaking changes

### Package Manager Rules:
- See \"Package Management Rules\" section above
- Reference: $PSA_HOME/protocols/PACKAGE-MANAGER-v1.0.md"

    # Check if context block already exists
    if grep -q "## Current Environment Context" "$CLAUDE_MD"; then
        echo -e "${YELLOW}Context block found, updating...${RESET}"
        # Remove old context block (from "## Current Environment Context" to next "##" or end of file)
        # This is complex in bash, so we'll just append and warn user
        echo -e "${YELLOW}⚠️  Manual update required${RESET}"
        echo -e "${CYAN}Please manually replace the 'Current Environment Context' section in CLAUDE.md${RESET}"
        echo ""
        echo "New content:"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "$CONTEXT_BLOCK"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    else
        echo -e "${GREEN}Adding new context block to CLAUDE.md...${RESET}"
        echo "" >> "$CLAUDE_MD"
        echo "$CONTEXT_BLOCK" >> "$CLAUDE_MD"
        echo -e "${GREEN}✅ Context block added to CLAUDE.md${RESET}"
    fi

    echo ""
fi
