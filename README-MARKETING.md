# <img src="docs/logo.png" width="40" align="left"/> PSA - Project State Agent

<p align="center">
  <img src="screenshots/hero-banner.png" alt="PSA Hero Banner" width="100%"/>
</p>

<h3 align="center">
  Beautiful terminal dashboard for managing any coding project
</h3>

<p align="center">
  Python • JavaScript • Rust • Go • Any Language<br/>
  <strong>With or without AI</strong> • Optional Claude Code integration
</p>

<p align="center">
  <a href="#quick-install">Quick Install</a> •
  <a href="#screenshots">Screenshots</a> •
  <a href="#features">Features</a> •
  <a href="#tutorials">Tutorials</a> •
  <a href="https://github.com/bradheitmann/psa/blob/main/docs/README-CLARIFICATION.md">Works with ANY Project</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/version-2.0.0-blue.svg" alt="Version"/>
  <img src="https://img.shields.io/badge/license-MIT-green.svg" alt="License"/>
  <img src="https://img.shields.io/badge/terminal-agnostic-purple.svg" alt="Terminal Agnostic"/>
</p>

---

## 📸 Screenshots

### Dashboard Overview
<img src="screenshots/dashboard-overview.png" alt="PSA Dashboard" width="100%"/>
<p align="center"><em>Colorful ASCII dashboard with metrics, progress bars, and sparklines</em></p>

### Project List with Interactive Search
<img src="screenshots/project-list.png" alt="Project List" width="100%"/>
<p align="center"><em>Fuzzy search powered by fzf with live preview</em></p>

### Project Details
<img src="screenshots/project-detail.png" alt="Project Details" width="100%"/>
<p align="center"><em>Detailed project view with git integration and metrics</em></p>

### Beautiful Visualizations
<img src="screenshots/metrics-charts.png" alt="Metrics Charts" width="100%"/>
<p align="center"><em>ASCII bar charts, sparklines, and progress indicators</em></p>

### Quick Commands
<img src="screenshots/commands-demo.gif" alt="Commands Demo" width="100%"/>
<p align="center"><em>Fast, keyboard-driven workflow</em></p>

---

## ⚡ Quick Install

```bash
# Homebrew (macOS/Linux)
brew tap bradheitmann/psa
brew install psa

# Manual install
git clone https://github.com/bradheitmann/psa.git
cd psa && ./install.sh

# Verify
psa version
```

**That's it!** Now run `psa` to see your dashboard.

---

## ✨ Features

<table>
<tr>
<td width="50%" valign="top">

### 🎨 **Visual Experience**
- Colorful ASCII visualizations
- Bar charts, sparklines, gauges
- Unicode box-drawing
- Nerd Font icons
- 3 color schemes (Gruvbox, Catppuccin, Tokyo Night)
- Progress bars with gradients

</td>
<td width="50%" valign="top">

### 🚀 **Works Everywhere**
- Any terminal (Warp, iTerm2, VS Code, SSH)
- macOS & Linux
- Works with ANY language/project
- No GUI required
- Fast, keyboard-driven
- Portable (XDG compliant)

</td>
</tr>
<tr>
<td width="50%" valign="top">

### 📊 **Core Metrics** (All Projects)
- Lines of code (LOC)
- Test coverage %
- File/module counts
- Git activity tracking
- Custom metrics support
- Progress percentages

</td>
<td width="50%" valign="top">

### 🤖 **AI Enhanced** (Optional)
- Token usage tracking
- Agent efficiency (tokens/line)
- Cost estimation
- PM review templates
- Dev handoff workflows
- Evidence bundles

</td>
</tr>
<tr>
<td width="50%" valign="top">

### 🔍 **Interactive**
- Fuzzy search (fzf)
- Live JSON previews
- File browsing (yazi)
- Git diffs (delta)
- Syntax highlighting (bat)
- Tab completion ready

</td>
<td width="50%" valign="top">

### 📁 **Multi-Project**
- Global overview dashboard
- Track unlimited projects
- Per-project metrics
- Cross-project analytics
- Auto-discovery
- Workspace support

</td>
</tr>
</table>

---

## 🎯 Use Cases

### For Solo Developers
<img src="screenshots/use-case-solo.png" alt="Solo Dev" width="100%"/>

Track personal projects with beautiful visualizations better than plain `git log`.

```bash
psa              # See all your projects
psa:init my-app  # Start tracking
psa list         # Quick overview
```

---

### For Team Leads
<img src="screenshots/use-case-team.png" alt="Team Lead" width="100%"/>

Manage multiple microservices/repos in one unified dashboard.

```bash
psa scan         # Discover all repos
psa              # Team overview
psa show api     # Check service status
```

---

### For AI-Assisted Development
<img src="screenshots/use-case-ai.png" alt="AI Development" width="100%"/>

Full token tracking, efficiency metrics, and cost estimation for Claude Code projects.

```bash
psa:analyze:tokens      # Token usage
psa:pm:review story-13  # PM workflows
psa:analyze:costs       # Cost breakdown
```

---

## 🚦 Quick Start

### 1. Initialize Your First Project

```bash
cd ~/projects/my-app
psa:init my-app
```

Creates `PROJECT.json` with metadata:
```json
{
  "name": "my-app",
  "status": "active",
  "progress": 0,
  "type": "web-app"
}
```

---

### 2. Scan Your Projects

```bash
psa scan
```

Discovers all projects in `~/projects` and `~/work`.

---

### 3. View Dashboard

```bash
psa
```

Beautiful, colorful overview of all your projects!

---

### 4. Explore Commands

```bash
psa help                # Full command list
psa list                # List all projects
psa show my-app         # Project details
psa:analyze:tokens      # AI metrics (if using Claude Code)
```

---

## 📚 Tutorials

**New to PSA?** Follow these step-by-step guides:

1. **[Getting Started](tutorials/01-GETTING-STARTED.md)** - Your first project (5 min)
2. **[Global Management](tutorials/02-GLOBAL-MANAGEMENT.md)** - Multi-project workflows (10 min)
3. **[Metrics & Tracking](tutorials/03-METRICS-TRACKING.md)** - Custom metrics (15 min)
4. **[Claude Code Integration](tutorials/04-CLAUDE-CODE.md)** - AI features (10 min)

---

## 🎨 Visual Library

PSA's colorful interface is powered by a custom visual library:

### Color Schemes
- **Gruvbox** - Warm, retro colors
- **Catppuccin** - Modern pastels
- **Tokyo Night** - Neon cyberpunk

### ASCII Art Elements
- ✅ Bar charts (horizontal & vertical)
- ✅ Sparklines (inline mini-charts)
- ✅ Progress bars with gradients
- ✅ Gauges (circular indicators)
- ✅ Unicode box-drawing
- ✅ Nerd Font icons (30+ icons)

<img src="screenshots/visual-library.png" alt="Visual Library" width="100%"/>

---

## 🛠️ Configuration

PSA is highly customizable via `~/.psa/config.json`:

```json
{
  "version": "2.0.0",
  "projectDirs": [
    "~/projects",
    "~/work",
    "~/open-source"
  ],
  "dashboardTheme": "catppuccin",
  "toolsCheck": true,
  "updateCheckEnabled": true,
  "defaultEditor": "code",
  "excludeDirs": [
    "node_modules",
    ".git",
    "vendor",
    "dist"
  ]
}
```

**Edit:**
```bash
psa:config:edit
```

---

## 📦 Dependencies

### Required
- ✅ `jq` - JSON processing
- ✅ `git` - Version control

### Optional (Enhanced Experience)

| Tool | Purpose | Impact |
|------|---------|--------|
| `fzf` | Fuzzy search | ⭐⭐⭐⭐⭐ |
| `gum` | TUI components | ⭐⭐⭐⭐ |
| `bat` | Syntax highlighting | ⭐⭐⭐ |
| `delta` | Git diffs | ⭐⭐⭐ |
| `eza` | Modern ls | ⭐⭐⭐ |
| `yazi` | File manager | ⭐⭐⭐ |
| `figlet` | ASCII art | ⭐⭐ |
| `lolcat` | Rainbow colors | ⭐⭐ |
| `gnuplot` | Charts | ⭐⭐⭐ |

**Install all:**
```bash
brew install jq fzf gum bat git-delta eza yazi figlet lolcat gnuplot
```

---

## 🔥 Examples

### Example 1: Regular Python Project (No AI)

```bash
cd ~/projects/flask-api
psa:init flask-api

# Edit PROJECT.json
{
  "name": "flask-api",
  "status": "active",
  "progress": 60,
  "type": "web-app",
  "tech": {
    "languages": ["Python"],
    "frameworks": ["Flask"]
  }
}

psa show flask-api
```

**Result:** Beautiful dashboard showing LOC, git commits, progress.

---

### Example 2: Mixed Projects

```bash
~/projects/
  ├── ai-chatbot/      # Claude Code project → shows tokens
  ├── website/         # Regular HTML/CSS → shows basic metrics
  └── python-lib/      # Pure Python → shows coverage

psa scan  # Discovers all 3
psa       # Unified dashboard
```

**Result:** One dashboard for ALL projects, AI or not.

---

### Example 3: Team Microservices

```bash
~/work/
  ├── api-gateway/
  ├── auth-service/
  ├── payment-service/
  └── notification-service/

psa scan  # Discovers all services
psa list  # Quick health check
```

**Result:** Monitor all microservices at a glance.

---

## 🎬 Demo Videos

### Quick Tour (2 min)
[![Quick Tour](screenshots/video-thumb-tour.png)](demos/tour.gif)

### Features Deep Dive (5 min)
[![Features](screenshots/video-thumb-features.png)](demos/features.gif)

### Claude Code Integration (3 min)
[![Claude Code](screenshots/video-thumb-claude.png)](demos/claude-integration.gif)

---

## 🌟 Why PSA?

### ❌ Before PSA
```bash
# Jump between projects manually
cd ~/projects/app1 && git status
cd ~/projects/app2 && git status
cd ~/projects/app3 && git status

# Count LOC with wc
find . -name "*.py" | xargs wc -l

# Check test coverage
pytest --cov

# Track progress... in your head?
```

### ✅ With PSA
```bash
psa

# Output:
# ╔═══════════════════════════════════╗
# ║  3 ACTIVE PROJECTS                ║
# ║  ██████████████░░░░░░  65% avg    ║
# ║  25K total LOC                    ║
# ║  82% average coverage             ║
# ╚═══════════════════════════════════╝
```

**One command. Beautiful visualization. All projects.**

---

## 🤝 Contributing

Contributions are welcome!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing`)
5. Open a Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## 📄 License

MIT License - see [LICENSE](LICENSE)

Free to use, modify, and distribute.

---

## 🙏 Acknowledgments

**Built with:**
- [Charm](https://charm.sh/) tools (gum, glow, vhs)
- [fzf](https://github.com/junegunn/fzf) - Fuzzy finder
- [jq](https://stedolan.github.io/jq/) - JSON processor
- Inspired by: `starship`, `bat`, `eza`, `btop`

**Special thanks to:**
- Claude Code for AI-assisted development
- Terminal enthusiasts worldwide
- Open source community

---

## 📞 Support

- **Documentation:** [docs/](docs/)
- **Issues:** [GitHub Issues](https://github.com/bradheitmann/psa/issues)
- **Discussions:** [GitHub Discussions](https://github.com/bradheitmann/psa/discussions)

---

<p align="center">
  <strong>Made with ❤️ for developers who love the command line</strong>
</p>

<p align="center">
  <a href="#quick-install">Get Started</a> •
  <a href="tutorials/01-GETTING-STARTED.md">Tutorial</a> •
  <a href="https://github.com/bradheitmann/psa">Star on GitHub ⭐</a>
</p>
