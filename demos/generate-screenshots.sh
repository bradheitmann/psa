#!/bin/bash
# Generate all PSA screenshots using VHS

set -e

echo "🎬 Generating PSA Screenshots with VHS"
echo ""

DEMO_DIR="$(cd "$(dirname "$0")" && pwd)"
SCREENSHOTS_DIR="$DEMO_DIR/../screenshots"

# Create screenshots directory
mkdir -p "$SCREENSHOTS_DIR"

# Check if VHS is installed
if ! command -v vhs &> /dev/null; then
    echo "❌ VHS not found. Install with: brew install vhs"
    exit 1
fi

# Generate screenshots from tapes
echo "📸 Recording demos..."

tapes=(
    "01-dashboard-overview.tape"
    "02-project-init.tape"
    "03-project-list.tape"
)

for tape in "${tapes[@]}"; do
    if [ -f "$DEMO_DIR/$tape" ]; then
        echo "  Processing: $tape"
        vhs "$DEMO_DIR/$tape"
    else
        echo "  ⚠️  Skipping: $tape (not found)"
    fi
done

echo ""
echo "✅ Screenshots generated in: $SCREENSHOTS_DIR"
echo ""
echo "Generated files:"
ls -lh "$SCREENSHOTS_DIR"

echo ""
echo "Next steps:"
echo "  1. Review screenshots in: $SCREENSHOTS_DIR"
echo "  2. Replace README-MARKETING.md with actual screenshot paths"
echo "  3. Commit to repository"
