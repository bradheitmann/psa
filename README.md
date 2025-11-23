# PSA - Personal System Assistant

<p align="center">
  <img src="assets/psa_dashboard_logo.png" alt="PSA Logo" width="400"/>
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

PSA uses `~/.psa/config.json`:

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
