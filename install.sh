#!/bin/bash

# PSA (Project State Agent) Installation Script
# Interactive guided setup for first-time users

set -e

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
BLUE="\033[34m"
CYAN="\033[36m"
RESET="\033[0m"

PSA_DIR="$HOME/.psa"
DEFAULT_PROJECTS_DIR="$HOME/dev_projects"

clear

echo ""
echo -e "${BOLD}${BLUE}╔════════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${BLUE}║                                                    ║${RESET}"
echo -e "${BOLD}${BLUE}║   PSA (Project State Agent) Installation          ║${RESET}"
echo -e "${BOLD}${BLUE}║   Meta-Learning System for AI Development         ║${RESET}"
echo -e "${BOLD}${BLUE}║                                                    ║${RESET}"
echo -e "${BOLD}${BLUE}╚════════════════════════════════════════════════════╝${RESET}"
echo ""

# Check if update mode
if [ "$1" = "--update" ]; then
    echo -e "${CYAN}Running in update mode...${RESET}"
    chmod +x scripts/*.sh 2>/dev/null || true
    echo -e "${GREEN}✓ Permissions updated${RESET}"
    exit 0
fi

# Welcome message
echo -e "${BOLD}Welcome to PSA!${RESET}"
echo ""
echo "PSA helps you:"
echo "  • Track AI agent performance across projects"
echo "  • Manage development tools and environments"
echo "  • Follow MVC (Minimum Viable Context) protocol"
echo "  • Build canonical example library"
echo "  • Upgrade tools automatically"
echo ""
echo "This installer will set up PSA on your system."
echo ""

# Check if already installed
if [ -f "$HOME/.psa-configured" ]; then
    echo -e "${YELLOW}PSA appears to be already configured.${RESET}"
    read -p "Reconfigure? This will reset some settings (y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
fi

# Step 1: Projects Directory
echo -e "${BOLD}${CYAN}Step 1/5: Configure Projects Directory${RESET}"
echo ""
echo "PSA organizes all your development projects in one location."
echo ""
echo -e "${BOLD}Recommended:${RESET} $DEFAULT_PROJECTS_DIR"
echo -e "${CYAN}This creates:${RESET}"
echo "  dev_projects/"
echo "    ├── .psa_reports/      (project analytics)"
echo "    ├── .templates/        (project templates)"
echo "    ├── README.md          (quick reference)"
echo "    └── [your projects]/   (actual projects)"
echo ""
read -p "Use default location? (Y/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo ""
    echo "Enter your preferred projects directory path:"
    echo "(Example: ~/code or ~/workspace or ~/projects)"
    read -r PROJECTS_DIR
    PROJECTS_DIR="${PROJECTS_DIR/#\~/$HOME}"
else
    PROJECTS_DIR="$DEFAULT_PROJECTS_DIR"
fi

echo ""
echo -e "${CYAN}→ Projects directory: $PROJECTS_DIR${RESET}"

# Create projects directory structure
if [ ! -d "$PROJECTS_DIR" ]; then
    echo -e "${YELLOW}Creating directory...${RESET}"
    mkdir -p "$PROJECTS_DIR"
fi

mkdir -p "$PROJECTS_DIR/.psa_reports"
mkdir -p "$PROJECTS_DIR/.templates"

echo -e "${GREEN}✓ Project structure created${RESET}"
echo ""

# Step 2: Shell Integration
echo -e "${BOLD}${CYAN}Step 2/5: Configure Shell Integration${RESET}"
echo ""

SHELL_RC="$HOME/.zshrc"
if [ ! -f "$SHELL_RC" ]; then
    SHELL_RC="$HOME/.bashrc"
fi

echo -e "${CYAN}Configuring: $SHELL_RC${RESET}"

if grep -q "PSA_PROJECTS_DIR" "$SHELL_RC" 2>/dev/null; then
    echo -e "${YELLOW}PSA already in $SHELL_RC (skipping)${RESET}"
else
    echo -e "${YELLOW}Adding PSA to shell configuration...${RESET}"

    cat >> "$SHELL_RC" << EOF

# ===== PSA (Project State Agent) =====
# Added: $(date +%Y-%m-%d)
export PSA_PROJECTS_DIR="$PROJECTS_DIR"
export PATH="\$HOME/.psa/scripts:\$PATH"

# Quick aliases
alias psa-projects='cd \$PSA_PROJECTS_DIR && ls -la'
alias psa-new='psa init-project'
alias psa-reports='cat \$PSA_PROJECTS_DIR/.psa_reports/projects-summary.md'
# =====================================
EOF

    echo -e "${GREEN}✓ Shell configured${RESET}"
fi

echo ""

# Step 3: Set Permissions
echo -e "${BOLD}${CYAN}Step 3/5: Set Script Permissions${RESET}"
echo ""

echo -e "${YELLOW}Making PSA scripts executable...${RESET}"
chmod +x scripts/*.sh 2>/dev/null || true
chmod +x scripts/psa 2>/dev/null || true
echo -e "${GREEN}✓ Scripts executable${RESET}"
echo ""

# Step 4: Create README and Documentation
echo -e "${BOLD}${CYAN}Step 4/5: Generate Project Documentation${RESET}"
echo ""

# (Content from my previous message - README.md and reports README)
# Copying to actual files...

cp examples/README.md "$PROJECTS_DIR/README.md" 2>/dev/null || cat > "$PROJECTS_DIR/README.md" << 'EOF'
# Development Projects (PSA Managed)

Quick commands:
- psa init-project <name> - Create new project
- psa-projects - Navigate here
- psa help - Show all PSA commands

Claude Code commands:
- /psa-status - Project status
- /psa-tools-list - Tool inventory

See https://github.com/bradheitmann/psa for full docs.
EOF

cat > "$PROJECTS_DIR/.psa_reports/README.md" << 'EOF'
# PSA Reports

Auto-generated analytics:
- agent-performance.md - Agent grades across projects
- projects-summary.md - All projects status
- canonical-examples.md - Gold-standard examples index
- tools-inventory.md - Development tools status

Updated automatically on PSA commands.
EOF

echo -e "${GREEN}✓ Documentation created${RESET}"
echo ""

# Step 5: Initialize Configuration
echo -e "${BOLD}${CYAN}Step 5/5: Initialize PSA Configuration${RESET}"
echo ""

# Create VERSION
echo "PSA_VERSION=1.0.1
INSTALL_DATE=$(date +%Y-%m-%d)
PROJECTS_DIR=$PROJECTS_DIR
SHELL_RC=$SHELL_RC" > VERSION

# Create initial AGENTS_MASTER if needed
if [ ! -f "AGENTS_MASTER.md" ]; then
    echo -e "${YELLOW}Creating initial AGENTS_MASTER.md...${RESET}"
    cat > AGENTS_MASTER.md << 'EOF'
# AGENTS Master Configuration

**Version:** 1.0.0
**Last Updated:** $(date +%Y-%m-%d)

## About

Track AI agent loadouts and performance across all projects.

## Quick Reference

| Loadout | Model | IDE | Projects Used | Performance |
|---------|-------|-----|---------------|-------------|
| Claude Sonnet 4.5 + Claude Code | claude-sonnet-4-5 | Claude Code | [Your projects] | [Track performance] |

Add your loadouts as you use different AI agents.

## How to Use

Track agent performance:
```bash
psa report "Claude Sonnet 4.5 + Claude Code" "[project] Story X: grade, notes"
```

View all loadouts:
```bash
psa view-master
```

For complete PSA documentation: https://github.com/bradheitmann/psa
EOF
fi

# Mark installation complete
echo "INSTALL_DATE=$(date +%Y-%m-%d)
PROJECTS_DIR=$PROJECTS_DIR" > "$HOME/.psa-configured"

echo -e "${GREEN}✓ PSA configured${RESET}"
echo ""

# Installation complete banner
echo ""
echo -e "${BOLD}${GREEN}╔════════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${GREEN}║                                                    ║${RESET}"
echo -e "${BOLD}${GREEN}║   ✅ PSA Installation Complete!                    ║${RESET}"
echo -e "${BOLD}${GREEN}║                                                    ║${RESET}"
echo -e "${BOLD}${GREEN}╚════════════════════════════════════════════════════╝${RESET}"
echo ""

# Next steps
echo -e "${BOLD}🎯 Next Steps:${RESET}"
echo ""
echo -e "  ${BOLD}1. Reload shell:${RESET}"
echo -e "     ${GREEN}source $SHELL_RC${RESET}"
echo ""
echo -e "  ${BOLD}2. Verify PSA:${RESET}"
echo -e "     ${GREEN}psa help${RESET}"
echo ""
echo -e "  ${BOLD}3. Check tools (via Claude Code):${RESET}"
echo -e "     ${CYAN}/psa-tools-list${RESET}"
echo ""
echo -e "  ${BOLD}4. Create first project:${RESET}"
echo -e "     ${GREEN}psa init-project my-app${RESET}"
echo ""
echo -e "  ${BOLD}5. Navigate to projects:${RESET}"
echo -e "     ${GREEN}psa-projects${RESET} or ${GREEN}cd \$PSA_PROJECTS_DIR${RESET}"
echo ""

# Show configuration
echo -e "${BOLD}${CYAN}📋 Your Configuration:${RESET}"
echo ""
echo -e "  PSA System:        ${CYAN}~/.psa/${RESET}"
echo -e "  Projects:          ${CYAN}$PROJECTS_DIR${RESET}"
echo -e "  Reports:           ${CYAN}$PROJECTS_DIR/.psa_reports/${RESET}"
echo -e "  Shell:             ${CYAN}$SHELL_RC${RESET}"
echo ""

# Claude Code integration
echo -e "${BOLD}${BLUE}💡 Claude Code Users:${RESET}"
echo ""
echo "PSA commands available as slash commands:"
echo -e "  ${CYAN}/psa-status${RESET}         - Project status"
echo -e "  ${CYAN}/psa-tools-list${RESET}     - Tool inventory"
echo -e "  ${CYAN}/psa-tools-install${RESET}  - Install missing tools"
echo -e "  ${CYAN}/psa-tools-update${RESET}   - Update outdated tools"
echo -e "  ${CYAN}/psa-shortcuts${RESET}      - Terminal power shortcuts"
echo -e "  ${CYAN}/psa-update${RESET}         - Update PSA to latest"
echo ""
echo "Examples in: ~/.claude/commands/"
echo "(Copy from ~/.psa/examples/commands/ if needed)"
echo ""

echo -e "${BOLD}Documentation:${RESET} https://github.com/bradheitmann/psa"
echo ""
echo -e "${GREEN}Happy coding! 🚀${RESET}"
echo ""
