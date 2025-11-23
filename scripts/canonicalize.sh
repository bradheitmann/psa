#!/bin/bash

# PSA Canonicalize
# Extract canonical examples from A-grade stories

set -e

# Colors
BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
CYAN="\033[36m"
RESET="\033[0m"

STORY_NAME="$1"
PROJECT_PATH="${2:-.}"
PSA_EXAMPLES="${PSA_HOME:-$HOME/.psa}/examples"
CANONICAL_REGISTRY="${PSA_HOME:-$HOME/.psa}/bloat/canonical-registry.json"

if [ -z "$STORY_NAME" ]; then
    echo -e "${RED}Error: Story name required${RESET}"
    echo "Usage: psa canonicalize <story-name> [project-path]"
    echo "Example: psa canonicalize story-05-llm-mvp"
    exit 1
fi

SOURCE_PATH="$PROJECT_PATH/docs/evidence/$STORY_NAME"

if [ ! -d "$SOURCE_PATH" ]; then
    echo -e "${RED}Error: Evidence not found: $SOURCE_PATH${RESET}"
    exit 1
fi

echo -e "${BOLD}${CYAN}📚 Canonicalizing Story${RESET}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${CYAN}Story:${RESET} $STORY_NAME"
echo -e "${CYAN}Source:${RESET} $SOURCE_PATH"
echo ""

# 1. Screen for sensitive data
echo -e "${YELLOW}Screening for sensitive data...${RESET}"
SENSITIVE_FOUND=0

# Check for API keys
if grep -r "sk-ant-api" "$SOURCE_PATH" >/dev/null 2>&1; then
    echo -e "${RED}⚠️  Found Anthropic API keys${RESET}"
    SENSITIVE_FOUND=1
fi

if grep -r "xoxb-[0-9]" "$SOURCE_PATH" >/dev/null 2>&1; then
    echo -e "${RED}⚠️  Found Slack tokens${RESET}"
    SENSITIVE_FOUND=1
fi

if [ "$SENSITIVE_FOUND" -eq 1 ]; then
    echo ""
    echo -e "${YELLOW}Sensitive data detected. Screening required.${RESET}"
    echo ""
    read -p "Proceed with automatic redaction? (y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}Canonicalization cancelled.${RESET}"
        exit 0
    fi
fi

# 2. Copy to local .canonical
LOCAL_CANONICAL="$PROJECT_PATH/docs/.canonical/evidence-bundles/$STORY_NAME"
mkdir -p "$LOCAL_CANONICAL"

echo -e "${YELLOW}Copying to local canonical...${RESET}"
cp -r "$SOURCE_PATH/"* "$LOCAL_CANONICAL/"

# 3. Redact sensitive data if needed
if [ "$SENSITIVE_FOUND" -eq 1 ]; then
    echo -e "${YELLOW}Redacting sensitive data...${RESET}"

    # Redact API keys
    find "$LOCAL_CANONICAL" -type f -exec sed -i '' 's/sk-ant-api[A-Za-z0-9_-]*/sk-ant-REDACTED/g' {} \;
    find "$LOCAL_CANONICAL" -type f -exec sed -i '' 's/xoxb-[0-9-]*/xoxb-REDACTED/g' {} \;
    find "$LOCAL_CANONICAL" -type f -exec sed -i '' 's/xoxp-[0-9-]*/xoxp-REDACTED/g' {} \;
    find "$LOCAL_CANONICAL" -type f -exec sed -i '' 's/xapp-[A-Z0-9-]*/xapp-REDACTED/g' {} \;
    find "$LOCAL_CANONICAL" -type f -exec sed -i '' 's/\/Users\/[^\/]*\//\/Users\/developer\//g' {} \;

    echo -e "${GREEN}✓ Sensitive data redacted${RESET}"
fi

# 4. Copy to PSA global
PROJECT_NAME=$(basename "$PROJECT_PATH")
GLOBAL_CANONICAL="$PSA_EXAMPLES/evidence-bundles/$PROJECT_NAME/$STORY_NAME"
mkdir -p "$GLOBAL_CANONICAL"

echo -e "${YELLOW}Syncing to PSA global...${RESET}"
cp -r "$LOCAL_CANONICAL/"* "$GLOBAL_CANONICAL/"

# 5. Register in canonical registry
if [ ! -f "$CANONICAL_REGISTRY" ]; then
    echo "{}" > "$CANONICAL_REGISTRY"
fi

# Add entry (simplified - would use jq in production)
echo ""
echo -e "${GREEN}✓ Canonical example created${RESET}"
echo ""
echo -e "${BOLD}Locations:${RESET}"
echo -e "  Local:  $LOCAL_CANONICAL"
echo -e "  Global: $GLOBAL_CANONICAL"
echo ""
echo -e "${CYAN}💡 Use for:${RESET}"
echo -e "  Reference in agent briefs: 'See $PSA_HOME/examples/evidence-bundles/$PROJECT_NAME/$STORY_NAME'"
echo ""
echo -e "${YELLOW}⚠️  Original evidence still at: $SOURCE_PATH${RESET}"
echo -e "   Delete with: ${RED}rm -rf $SOURCE_PATH${RESET} (after confirming canonical is good)"
echo ""
