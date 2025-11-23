# PSA - Project State Agent

<p align="center">
  <img src="docs/logo.png" alt="PSA Logo" width="200"/>
</p>

<p align="center">
  Beautiful terminal dashboard for managing <strong>any</strong> coding project with metrics, visualizations, and tracking.
</p>

<p align="center">
  Works with Python, JavaScript, Rust, Go, and any language. <br/>
  Optional Claude Code integration for AI-assisted development metrics.
</p>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#installation">Installation</a> •
  <a href="#quick-start">Quick Start</a> •
  <a href="#documentation">Documentation</a> •
  <a href="#contributing">Contributing</a>
</p>

---

## ⚠️ PSA Works with ANY Project

**Claude Code is optional.** PSA provides beautiful project dashboards for:
- ✅ Python, JavaScript, TypeScript, Rust, Go, Java projects
- ✅ Solo developers or teams
- ✅ With or without AI coding assistants

**Bonus:** If you use Claude Code, get enhanced metrics (tokens, agent efficiency, costs).

[See full comparison →](docs/README-CLARIFICATION.md)

---

## Features

### Core Features (All Projects)
- 🎨 **Colorful ASCII Visualizations** - Bar charts, sparklines, gauges with rich color schemes
- 📊 **Project Metrics** - LOC, test coverage, file counts, git activity
- 🚀 **Multi-project Overview** - Global dashboard for all your projects
- 💾 **Git Integration** - Track commits, branches, and activity
- 🔍 **Interactive Navigation** - Powered by fzf for fuzzy searching
- ⚡ **Terminal-Agnostic** - Works in Warp, iTerm2, VS Code, SSH sessions
- 🎯 **Progress Tracking** - Visual completion percentages

### Enhanced Features (Claude Code Projects)
- 🤖 **Token Usage Analysis** - Track AI token consumption
- 📈 **Agent Efficiency** - Tokens per line, cost estimation
- 📝 **PM/Dev Workflows** - Reviews, handoffs, evidence bundles
- 💰 **Cost Tracking** - Estimate development costs

---

## Screenshots

[Coming soon]

---

## Installation

### Homebrew (Recommended for macOS/Linux)

```bash
brew tap bradheitmann/psa
brew install psa
```

### Manual Install

```bash
git clone https://github.com/bradheitmann/psa.git
cd psa
./install.sh
```

### npm

```bash
npm install -g @bradheitmann/psa
```

### One-liner

```bash
curl -fsSL https://raw.githubusercontent.com/bradheitmann/psa/main/install.sh | bash
```

---

## Quick Start

### For Any Project

```bash
# Navigate to your project
cd ~/projects/my-app

# Initialize PSA tracking
psa:init my-app

# Scan all projects
psa scan

# View dashboard
psa
```

### With Claude Code

```bash
# Same as above, plus:
psa:analyze:tokens        # View token usage
psa:pm:review story-13    # Create PM review
psa:analyze:efficiency    # Agent efficiency
```

---

## Configuration

PSA uses `~/.psa/config.json`:

```json
{
  "projectDirs": ["~/projects", "~/work"],
  "dashboardTheme": "catppuccin",
  "defaultEditor": "code"
}
```

Edit with: `psa:config:edit`

Or manually:
```bash
vim ~/.psa/config.json
```

---

## Documentation

- [Installation Guide](docs/installation.md)
- [Works with ANY Project](docs/README-CLARIFICATION.md) ⭐ Read this!
- [Configuration](docs/configuration.md)
- [Usage Guide](docs/usage.md)
- [Contributing](CONTRIBUTING.md)
- [Security](docs/security.md)

---

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

---

## Example: Non-AI Project

```bash
# Regular Python Flask project
cd ~/projects/my-flask-app
psa:init my-flask-app

# Edit PROJECT.json with your info
{
  "name": "my-flask-app",
  "status": "active",
  "progress": 60,
  "type": "web-app"
}

# View dashboard
psa

# Output:
# ╔═══════════════════════════╗
# ║   my-flask-app            ║
# ║   ● ACTIVE                ║
# ║   Progress: ████████░░ 60%║
# ║   LOC: 5,000              ║
# ╚═══════════════════════════╝
```

**No Claude Code? No problem!** You still get beautiful visualizations.

---

## Example: Mixed Projects

```bash
~/projects/
  ├── ai-chatbot/      # Uses Claude Code → Shows token metrics
  ├── website/         # Regular project → Shows basic metrics
  └── python-lib/      # Regular project → Shows basic metrics

psa scan  # Discovers all 3
psa       # Unified dashboard for all
```

---

## Use Cases

### Solo Developer
Track personal projects with beautiful visualizations better than plain git logs.

### Team Lead
Overview of multiple microservices/repos in one dashboard.

### AI-Assisted Development
Full token tracking, efficiency metrics, and cost estimation for Claude Code projects.

### Open Source Maintainer
Track contributions, LOC growth, and project health across multiple repos.

---

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md).

---

## License

MIT License - see [LICENSE](LICENSE)

---

## Acknowledgments

- Inspired by modern CLI tools: `starship`, `bat`, `eza`
- Works with any coding workflow (AI or traditional)
- Built with love for terminal enthusiasts

---

**Made with ❤️ for developers who love the command line**
