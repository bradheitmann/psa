#!/bin/bash

# PSA Project Initialization Script
# Creates a new project with AGENTS.md from master template

set -e

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
BLUE="\033[34m"
RESET="\033[0m"

MASTER_FILE="${PSA_HOME:-$HOME/.psa}/AGENTS_MASTER.md"
TEMPLATE_FILE="${PSA_HOME:-$HOME/.psa}/templates/AGENTS.md.template"

# Check if master exists
if [ ! -f "$MASTER_FILE" ]; then
    echo -e "${RED}Error: AGENTS_MASTER.md not found${RESET}"
    exit 1
fi

# Parse arguments
PROJECT_NAME="$1"
PROJECT_PATH="$2"

if [ -z "$PROJECT_NAME" ]; then
    echo -e "${BOLD}${BLUE}PSA Project Initialization${RESET}"
    echo ""
    echo "Usage: psa init-project <project-name> [project-path]"
    echo ""
    echo "Example:"
    echo "  psa init-project my-app ~/projects/my-app"
    echo ""
    exit 1
fi

# Default path if not provided
if [ -z "$PROJECT_PATH" ]; then
    PROJECT_PATH="$HOME/projects/$PROJECT_NAME"
fi

# Expand tilde if present
PROJECT_PATH="${PROJECT_PATH/#\~/$HOME}"

echo -e "${BOLD}${BLUE}Initializing PSA project: ${PROJECT_NAME}${RESET}"
echo -e "${BLUE}Path:${RESET} $PROJECT_PATH"
echo ""

# Create project directory if it doesn't exist
if [ ! -d "$PROJECT_PATH" ]; then
    read -p "Create directory $PROJECT_PATH? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mkdir -p "$PROJECT_PATH"
        echo -e "${GREEN}✓${RESET} Created directory"
    else
        exit 1
    fi
fi

# Navigate to project
cd "$PROJECT_PATH"

# Create AGENTS.md from template or generate from master
AGENTS_FILE="$PROJECT_PATH/AGENTS.md"

if [ -f "$AGENTS_FILE" ]; then
    echo -e "${YELLOW}Warning: AGENTS.md already exists${RESET}"
    read -p "Overwrite? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Generate AGENTS.md for the project
cat > "$AGENTS_FILE" << 'EOF'
# AGENTS.md

**Project:** PROJECT_NAME_PLACEHOLDER
**Last Updated:** DATE_PLACEHOLDER

This file provides guidance to AI coding agents working in this codebase.

---

## Development Environment

**Runtime & Package Manager:**
```bash
# Configure for your project's package manager:
# Bun:    bun install && bun run dev
# pnpm:   pnpm install && pnpm dev
# Python: uv pip install -r requirements.txt && python main.py
# Go:     go mod download && go run .
# Rust:   cargo build && cargo run
#
# ⚠️  npm is BLOCKED system-wide (redirects to pnpm)
# See docs/protocols/PACKAGE-MANAGER-v1.0.md for complete rules
```

**Prerequisites:**
- [Add prerequisites]

**Environment Setup:**
```bash
cp .env.example .env
# Configure environment variables
```

---

## Build & Test Commands

**Development:**
```bash
# [Add dev commands]
```

**Testing:**
```bash
# [Add test commands]
```

**Quality Checks:**
```bash
# [Add linting, type checking, etc.]
```

---

## Project Architecture

**Core Structure:**
```
[Add your project structure]
```

**Key Architectural Patterns:**
- [Document patterns]

---

## Code Conventions

**[Language] Conventions:**
- [Document conventions]

**Error Handling:**
- [Document error handling patterns]

**Testing:**
- [Document testing approach]

---

## Protocols & Standards

This project follows these development protocols:

[Reference protocols from global master as needed]

---

## Agent Loadouts

### Active Loadouts for This Project

**Loadout: [Primary Agent]**
- **Model:** [model-version]
- **IDE:** [environment]
- **Use Cases:** [when to use]
- **Notes:** [project-specific notes]

### Reporting Learnings

To report anecdotes or learnings about agent behavior:
```bash
psa report "loadout-name" "your observation here"
```

---

## Additional Resources

- **CLAUDE.md** - Claude Code specific guidance (if present)
- **README.md** - Project documentation
- **docs/** - Additional documentation

---

_This file is maintained as part of the PSA protocol and follows the industry standard AGENTS.md format._
_Global configuration: $PSA_HOME/AGENTS_MASTER.md_
EOF

# Replace placeholders
CURRENT_DATE=$(date +%Y-%m-%d)
sed -i '' "s/PROJECT_NAME_PLACEHOLDER/$PROJECT_NAME/g" "$AGENTS_FILE"
sed -i '' "s/DATE_PLACEHOLDER/$CURRENT_DATE/g" "$AGENTS_FILE"

echo -e "${GREEN}✓${RESET} Created AGENTS.md"

# Create CLAUDE.md as symlink or copy
if [ ! -f "$PROJECT_PATH/CLAUDE.md" ]; then
    read -p "Create CLAUDE.md as symlink to AGENTS.md? (Y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        ln -s AGENTS.md CLAUDE.md
        echo -e "${GREEN}✓${RESET} Created CLAUDE.md symlink"
    fi
fi

# Update global master to track this project
PROJECT_ENTRY="| $PROJECT_NAME | $PROJECT_PATH | [TBD] | Active |"

if ! grep -q "$PROJECT_NAME" "$MASTER_FILE"; then
    # Add to project tracking table (find the table and append)
    awk -v entry="$PROJECT_ENTRY" '
        /\| Project \| Path \| Primary Loadout \| Status \|/ {
            print
            getline
            print
            print entry
            next
        }
        { print }
    ' "$MASTER_FILE" > "$MASTER_FILE.tmp"
    mv "$MASTER_FILE.tmp" "$MASTER_FILE"
    echo -e "${GREEN}✓${RESET} Added to global project tracking"
fi

echo ""
echo -e "${BOLD}${GREEN}Project initialized successfully!${RESET}"
echo ""
echo "Next steps:"
echo "  1. cd $PROJECT_PATH"
echo "  2. Customize AGENTS.md with project-specific details"
echo "  3. Start development"
echo "  4. Report learnings: psa report <loadout> <observation>"
echo ""
