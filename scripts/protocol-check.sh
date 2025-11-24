#!/bin/bash
# PSA Protocol Checker
# Validates commands against active protocols before execution
# Version: 1.0
# Date: 2025-11-23

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# PSA home directory
PSA_HOME="${PSA_HOME:-$HOME/.psa}"
PROTOCOL_DIR="$PSA_HOME/protocols"

# Usage
usage() {
  cat <<EOF
PSA Protocol Checker

Usage: protocol-check.sh <command> [args...]

Examples:
  protocol-check.sh npm install        # Check if npm is allowed
  protocol-check.sh bun add react      # Check if bun is allowed
  protocol-check.sh pip install flask  # Check if pip is allowed

Exit Codes:
  0 = Command is allowed
  1 = Command is forbidden (with explanation)
  2 = Protocol check failed (missing files, etc.)
EOF
  exit 2
}

# Print error and exit
error() {
  echo -e "${RED}❌ FORBIDDEN:${NC} $1" >&2
  exit 1
}

# Print protocol violation with suggestions
protocol_violation() {
  local command="$1"
  local protocol_file="$2"
  local reason="$3"
  shift 3
  local suggestions=("$@")

  echo -e "${RED}❌ FORBIDDEN:${NC} ${YELLOW}${command}${NC} is blocked by PACKAGE-MANAGER protocol" >&2
  echo "" >&2
  echo -e "${BLUE}📋 Protocol:${NC} $protocol_file" >&2
  echo "" >&2
  echo -e "${GREEN}✅ Use instead:${NC}" >&2
  for suggestion in "${suggestions[@]}"; do
    echo -e "  ${suggestion}" >&2
  done
  echo "" >&2
  echo -e "${YELLOW}❓ Why:${NC} $reason" >&2
  echo -e "   See protocol for details: $protocol_file" >&2
  exit 1
}

# Check if command is provided
if [ $# -eq 0 ]; then
  usage
fi

COMMAND="$1"
ARGS="${*:2}"

# Check npm commands
check_npm() {
  local protocol_file="$PROTOCOL_DIR/PACKAGE-MANAGER-v1.0.md"

  # Check if protocol exists
  if [ ! -f "$protocol_file" ]; then
    echo -e "${YELLOW}⚠️  WARNING:${NC} PACKAGE-MANAGER protocol not found" >&2
    echo -e "   Expected: $protocol_file" >&2
    echo -e "   Proceeding without check..." >&2
    return 0
  fi

  local reason="npm is disabled system-wide on this machine"
  local suggestions=(
    "bun install        (for project dependencies in Bun projects)"
    "pnpm install       (for existing projects or fallback)"
    "npx pnpm install -g <pkg>  (for global packages)"
  )

  # Parse the actual command
  if [[ "$ARGS" =~ ^install ]]; then
    if [[ "$ARGS" =~ -g|--global ]]; then
      # Global install
      suggestions=(
        "npx pnpm install -g <package>  (for global CLI tools)"
      )
      reason="npm global installs are blocked. Use pnpm for global tools."
    else
      # Project install
      suggestions=(
        "bun install       (for Bun projects)"
        "pnpm install      (for existing projects)"
      )
      reason="npm is blocked. Use bun (new projects) or pnpm (existing projects)."
    fi
  elif [[ "$ARGS" =~ ^add|^i ]]; then
    # Add package
    suggestions=(
      "bun add <package>   (for Bun projects)"
      "pnpm add <package>  (for existing projects)"
    )
    reason="npm is blocked. Use bun (new projects) or pnpm (existing projects)."
  elif [[ "$ARGS" =~ ^remove|^uninstall ]]; then
    # Remove package
    suggestions=(
      "bun remove <package>   (for Bun projects)"
      "pnpm remove <package>  (for existing projects)"
    )
    reason="npm is blocked. Use bun (new projects) or pnpm (existing projects)."
  elif [[ "$ARGS" =~ ^run ]]; then
    # Run script
    suggestions=(
      "bun run <script>   (for Bun projects)"
      "pnpm run <script>  (for existing projects)"
    )
    reason="npm is blocked. Use bun (new projects) or pnpm (existing projects)."
  fi

  protocol_violation "npm $ARGS" "$protocol_file" "$reason" "${suggestions[@]}"
}

# Check pip commands (without venv)
check_pip() {
  local protocol_file="$PROTOCOL_DIR/PACKAGE-MANAGER-v1.0.md"

  # Check if protocol exists
  if [ ! -f "$protocol_file" ]; then
    echo -e "${YELLOW}⚠️  WARNING:${NC} PACKAGE-MANAGER protocol not found" >&2
    echo -e "   Expected: $protocol_file" >&2
    echo -e "   Proceeding without check..." >&2
    return 0
  fi

  # Allow pip if in virtual environment
  if [[ -n "${VIRTUAL_ENV:-}" ]]; then
    return 0
  fi

  # Check for --user flag (also discouraged)
  if [[ "$ARGS" =~ --user ]]; then
    local reason="pip --user pollutes your global Python environment"
    local suggestions=(
      "pipx install <tool>       (for global CLI tools)"
      "uv pip install <package>  (inside a virtual environment)"
    )
    protocol_violation "pip $ARGS" "$protocol_file" "$reason" "${suggestions[@]}"
  fi

  # Block global pip install
  if [[ "$ARGS" =~ ^install ]]; then
    local reason="pip install outside virtual environment pollutes system Python"
    local suggestions=(
      "pipx install <tool>       (for global CLI tools like black, ruff)"
      "uv venv && uv pip install <package>  (for project dependencies)"
      "source venv/bin/activate && pip install  (if using venv)"
    )
    protocol_violation "pip $ARGS" "$protocol_file" "$reason" "${suggestions[@]}"
  fi
}

# Main check logic
case "$COMMAND" in
  npm)
    check_npm
    ;;

  pip|pip3)
    check_pip
    ;;

  # Allowed commands - exit 0
  bun|pnpm|npx|cargo|go|pipx|uv|brew)
    exit 0
    ;;

  # Unknown commands - allow by default
  *)
    exit 0
    ;;
esac

# If we get here, command is allowed
exit 0
