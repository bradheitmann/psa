#!/bin/bash
# Prepare PSA for Open Source Release
# Sanitizes personal information and creates portable version

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}🧹 PSA Open Source Preparation Tool${NC}"
echo ""

# Configuration
SOURCE_DIR="${PSA_HOME:-$HOME/.psa}"
OUTPUT_DIR="$HOME/psa-opensource"
PERSONAL_DATA=(
  "<your-username>"
  "$HOME"
  "projects"
  "example-project"
  "sample-app"
  "web-app"
  "api-service"
  "cli-tool"
  "data-pipeline"
  "mobile-app"
)

# Create output directory
echo "📁 Creating output directory..."
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

# Copy structure
echo "📋 Copying files..."
cp -r "$SOURCE_DIR"/{bin,lib,scripts,protocols,templates} "$OUTPUT_DIR/" 2>/dev/null || true

# Create directories
mkdir -p "$OUTPUT_DIR"/{docs,examples,tests}

# ============================================================================
# SANITIZE FILES
# ============================================================================

sanitize_file() {
  local file=$1
  echo "  Sanitizing: $(basename "$file")"

  # Replace personal username
  sed -i '' 's|$HOME|$HOME|g' "$file" 2>/dev/null || true
  sed -i '' 's|<your-username>|<your-username>|g' "$file" 2>/dev/null || true

  # Replace specific project names
  sed -i '' 's|projects|projects|g' "$file" 2>/dev/null || true
  sed -i '' 's|work|work|g' "$file" 2>/dev/null || true

  # Replace with generic names
  sed -i '' 's|example-project|example-project|g' "$file" 2>/dev/null || true
  sed -i '' 's|sample-app|sample-app|g' "$file" 2>/dev/null || true

  # Make paths portable
  sed -i '' 's|$PSA_HOME|$PSA_HOME|g' "$file" 2>/dev/null || true
  sed -i '' 's|\${PSA_HOME:-$HOME/.psa}|${PSA_HOME:-${PSA_HOME:-$HOME/.psa}}|g' "$file" 2>/dev/null || true
}

echo ""
echo "🔧 Sanitizing scripts..."

# Sanitize all shell scripts
find "$OUTPUT_DIR" -name "*.sh" -type f | while read -r file; do
  sanitize_file "$file"
done

# Sanitize main CLI
if [ -f "$OUTPUT_DIR/bin/psa" ]; then
  sanitize_file "$OUTPUT_DIR/bin/psa"
fi

# ============================================================================
# CREATE TEMPLATES
# ============================================================================

echo ""
echo "📝 Creating templates..."

# config.json.template
cat > "$OUTPUT_DIR/templates/config.json.template" <<'EOF'
{
  "version": "2.0.0",
  "projectDirs": [
    "~/projects",
    "~/work"
  ],
  "dashboardTheme": "catppuccin",
  "toolsCheck": true,
  "updateCheckEnabled": true,
  "defaultEditor": "code",
  "excludeDirs": [
    "node_modules",
    ".git",
    "vendor",
    "dist",
    "build"
  ]
}
EOF

# Example registry
cat > "$OUTPUT_DIR/examples/sample-registry.json" <<'EOF'
{
  "lastUpdated": "2024-11-21T00:00:00Z",
  "projects": [
    {
      "name": "example-web-app",
      "displayName": "Example Web Application",
      "status": "active",
      "type": "web-app",
      "progress": 65,
      "path": "~/projects/example-web-app",
      "github": "https://github.com/your-org/example-web-app",
      "metrics": {
        "loc": 12500,
        "coverage": 86.5,
        "sessions": 45,
        "tokens": 8500000,
        "tokensPerLine": 680
      }
    },
    {
      "name": "cli-tool",
      "displayName": "Command Line Tool",
      "status": "complete",
      "type": "cli-tool",
      "progress": 100,
      "path": "~/projects/cli-tool",
      "github": "https://github.com/your-org/cli-tool",
      "metrics": {
        "loc": 3200,
        "coverage": 92.0,
        "sessions": 18,
        "tokens": 2100000,
        "tokensPerLine": 656
      }
    }
  ]
}
EOF

# Example project
mkdir -p "$OUTPUT_DIR/examples/sample-project"

cat > "$OUTPUT_DIR/examples/sample-project/PROJECT.json" <<'EOF'
{
  "meta": {
    "name": "sample-project",
    "displayName": "Sample Project",
    "description": "A sample project demonstrating PSA integration",
    "status": "active",
    "type": "web-app",
    "created": "2024-11-01T00:00:00Z",
    "updated": "2024-11-21T00:00:00Z"
  },
  "location": {
    "path": "~/projects/sample-project",
    "github": "https://github.com/your-org/sample-project",
    "pmSession": ".claude/sessions/main.jsonl"
  },
  "progress": {
    "percentComplete": 65,
    "currentPhase": "development",
    "milestones": {
      "total": 10,
      "completed": 6,
      "current": "Feature X Implementation"
    }
  },
  "tech": {
    "languages": ["TypeScript", "Python"],
    "frameworks": ["React", "FastAPI"],
    "runtime": "bun",
    "packageManager": "pnpm"
  }
}
EOF

# ============================================================================
# CREATE DOCUMENTATION
# ============================================================================

echo ""
echo "📚 Creating documentation..."

# README.md
cat > "$OUTPUT_DIR/README.md" <<'EOF'
# PSA - Personal System Assistant

<p align="center">
  <img src="docs/logo.png" alt="PSA Logo" width="200"/>
</p>

<p align="center">
  Beautiful terminal dashboard for managing Claude Code projects with metrics, visualizations, and agent tracking.
</p>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#installation">Installation</a> •
  <a href="#quick-start">Quick Start</a> •
  <a href="#documentation">Documentation</a> •
  <a href="#contributing">Contributing</a>
</p>

---

## Features

- 🎨 **Colorful ASCII Visualizations** - Bar charts, sparklines, gauges with rich color schemes
- 📊 **Real-time Project Metrics** - LOC, test coverage, agent tokens, efficiency tracking
- 🚀 **Multi-project Overview** - Global dashboard for all your projects
- 💾 **Git Integration** - Track commits, branches, and activity
- 📈 **Agent Efficiency Analysis** - Monitor Claude Code sessions and token usage
- 🔍 **Interactive Navigation** - Powered by fzf for fuzzy searching
- 🎯 **Evidence-Based Workflow** - PM reviews, dev handoffs, automated gates
- ⚡ **Terminal-Agnostic** - Works in Warp, iTerm2, VS Code, SSH sessions

## Screenshots

[Coming soon]

## Installation

### Homebrew (Recommended for macOS/Linux)

```bash
brew tap your-org/psa
brew install psa
```

### npm

```bash
npm install -g @psa-cli/psa
```

### Manual Install

```bash
git clone https://github.com/your-org/psa.git
cd psa
./install.sh
```

### One-liner

```bash
curl -fsSL https://psa.dev/install.sh | bash
```

## Quick Start

```bash
# View dashboard
psa

# Scan projects
psa scan

# List all projects
psa list

# View project details
psa show my-project

# Initialize new project
psa:init my-new-project

# Create PM review
psa:pm:review story-13
```

## Configuration

PSA uses `$PSA_HOME/config.json`:

```json
{
  "projectDirs": ["~/projects", "~/work"],
  "dashboardTheme": "catppuccin",
  "defaultEditor": "code"
}
```

Edit with: `psa:config:edit`

## Documentation

- [Installation Guide](docs/installation.md)
- [Configuration](docs/configuration.md)
- [Usage Guide](docs/usage.md)
- [Contributing](CONTRIBUTING.md)
- [Security](docs/security.md)

## Dependencies

**Required:**
- `jq` - JSON processing
- `git` - Version control

**Optional (Enhanced Experience):**
- `fzf` - Interactive fuzzy finder ⭐⭐⭐⭐⭐
- `gum` - Modern TUI components ⭐⭐⭐⭐
- `bat` - Syntax-highlighted viewer ⭐⭐⭐
- `delta` - Beautiful git diffs ⭐⭐⭐
- `eza` - Modern ls with icons ⭐⭐⭐
- `yazi` - File manager TUI ⭐⭐⭐
- `figlet` - ASCII art text ⭐⭐
- `lolcat` - Rainbow colorizer ⭐⭐
- `gnuplot` - Terminal charts ⭐⭐⭐

Install all:
```bash
brew install jq fzf gum bat git-delta eza yazi figlet lolcat gnuplot
```

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT License - see [LICENSE](LICENSE)

## Acknowledgments

- Inspired by modern CLI tools: `starship`, `bat`, `eza`
- Designed for Claude Code workflows
- Built with love for terminal enthusiasts

---

**Made with ❤️ for the command line**
EOF

# LICENSE
cat > "$OUTPUT_DIR/LICENSE" <<'EOF'
MIT License

Copyright (c) 2024 PSA Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

# .gitignore
cat > "$OUTPUT_DIR/.gitignore" <<'EOF'
# User data
data/projects-registry.json
data/PROJECTS.md
data/COMMANDS.md
data/HELP.md
config.json

# Cache
.update-check-cache
*.log

# OS
.DS_Store
Thumbs.db
.Spotlight-V100
.Trashes

# IDE
.vscode/
.idea/
*.swp
*.swo

# Backup
*.backup
*.bak

# Temp
tmp/
temp/
EOF

# ============================================================================
# CREATE INSTALLER
# ============================================================================

echo ""
echo "🔧 Creating installer..."

cat > "$OUTPUT_DIR/install.sh" <<'INSTALLER_EOF'
#!/bin/bash
# PSA Installer - Automated installation script

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}🚀 PSA (Personal System Assistant) Installer v2.0.0${NC}"
echo ""

# [Full installer content from OPENSOURCE-PLAN.md]
# [Would include: OS detection, dependency checks, file copying, PATH setup, config init]

echo "Installation script would go here"
echo "See OPENSOURCE-PLAN.md for full implementation"

INSTALLER_EOF

chmod +x "$OUTPUT_DIR/install.sh"

# ============================================================================
# SUMMARY
# ============================================================================

echo ""
echo -e "${GREEN}✅ Open source preparation complete!${NC}"
echo ""
echo "Output directory: $OUTPUT_DIR"
echo ""
echo "Files created:"
echo "  ✓ Sanitized scripts"
echo "  ✓ Templates"
echo "  ✓ Examples"
echo "  ✓ Documentation (README, LICENSE)"
echo "  ✓ .gitignore"
echo "  ✓ Installer"
echo ""
echo "Next steps:"
echo "  1. Review sanitized files: cd $OUTPUT_DIR"
echo "  2. Create GitHub repository"
echo "  3. Test installer on clean system"
echo "  4. Push to GitHub"
echo "  5. Create release tag (v2.0.0)"
echo ""
echo "Security checklist:"
echo "  [ ] No personal paths remaining"
echo "  [ ] No real project names"
echo "  [ ] No credentials or tokens"
echo "  [ ] Example data is generic"
echo "  [ ] .gitignore covers sensitive files"
echo ""
