# CLI Tools Reference Protocol

**Version:** 1.0
**Date:** 2024-11-21
**Status:** Active
**Purpose:** Quick reference for essential CLI tools and Homebrew commands

---

## Core Philosophy

**Use modern, Rust-based alternatives when available. They're faster, safer, and more user-friendly.**

---

## PSA Commands (Project State Agent)

**Quick Reference Cheat Sheet** - All commands use `psa` or `psa:` prefix to avoid conflicts.

### Core Commands
```bash
psa_dash                       # Show interactive dashboard
psa_dash dash                  # Show dashboard (explicit)
psa_dash scan                  # Scan projects and rebuild registry
psa_dash list                  # List all projects (table format)
psa_dash show <project>        # Show detailed project view
psa_dash help                  # Show help message
psa_dash version               # Show version
```

### Project Commands
```bash
psa:init <name>           # Initialize new project with PSA tracking
psa:metrics <project>     # Update project metrics
psa:sync                  # Sync all projects to global registry
psa:status <project>      # Quick status check
psa:open <project>        # Open project in editor
```

### Agent Workflow Commands
```bash
psa:pm:review <story>     # Generate PM review template
psa:pm:handoff <task>     # Generate PM → Dev handoff
psa:dev:report <task>     # Generate Dev completion report
psa:evidence <story>      # Create evidence bundle structure
```

### Analysis Commands
```bash
psa:analyze:tokens        # Show token usage analysis
psa:analyze:efficiency    # Show agent efficiency metrics
psa:analyze:velocity      # Show development velocity
psa:analyze:costs         # Show cost breakdown
```

### Utility Commands
```bash
psa:config:show           # Show PSA configuration
psa:config:edit           # Edit PSA configuration
psa:tools:check           # Check installed CLI tools
psa:tools:install         # Install recommended tools
psa:update                # Update PSA to latest version
```

### Examples
```bash
psa_dash                       # Open colorful dashboard
psa_dash list                  # Quick project list
psa_dash show o_bot            # View o_bot project details
psa:init my-app           # Initialize new project
psa:pm:review story-13    # Create PM review template
psa:analyze:tokens        # View token usage report
```

**Location:** `~/.psa/`
**Documentation:** `~/.psa/README.md`
**Protocols:** `~/.psa/protocols/`

---

## Essential CLI Tools

### File & Directory Navigation

#### **`eza`** - Modern `ls` replacement
```bash
brew install eza

# Usage
eza                    # Basic listing
eza -l                 # Long format
eza -la                # Include hidden files
eza --tree             # Tree view
eza --git              # Show git status
eza -lah --icons       # Everything with icons
```

#### **`fd`** - Modern `find` replacement
```bash
brew install fd

# Usage
fd pattern              # Find files/dirs matching pattern
fd -e txt               # Find by extension
fd -H pattern           # Include hidden files
fd -t f pattern         # Files only
fd -t d pattern         # Directories only
```

#### **`zoxide`** - Smart directory jumper (replaces `cd`)
```bash
brew install zoxide

# Setup (add to ~/.zshrc)
eval "$(zoxide init zsh)"

# Usage
z project              # Jump to directory matching "project"
zi                     # Interactive selection
z -                    # Go back to previous directory
```

#### **`fzf`** - Fuzzy finder
```bash
brew install fzf

# Install key bindings
$(brew --prefix)/opt/fzf/install

# Usage
fzf                    # Fuzzy find files
cat file | fzf         # Fuzzy search stdin
CTRL+R                 # Search command history
CTRL+T                 # Search files
ALT+C                  # Change directory
```

---

### File Viewing & Manipulation

#### **`bat`** - Modern `cat` with syntax highlighting
```bash
brew install bat

# Usage
bat file.js            # View with syntax highlighting
bat --style=plain      # Without line numbers
bat --diff file.js     # Show git changes
bat file1 file2        # Multiple files
```

#### **`ripgrep`** (`rg`) - Fast `grep` replacement
```bash
brew install ripgrep

# Usage
rg "pattern"           # Search in current directory
rg -i "pattern"        # Case-insensitive
rg -t js "pattern"     # Search only JavaScript files
rg --hidden "pattern"  # Include hidden files
rg -A 3 "pattern"      # Show 3 lines after match
```

#### **`jq`** - JSON processor
```bash
brew install jq

# Usage
cat file.json | jq .                    # Pretty print
cat file.json | jq '.key'               # Extract field
cat file.json | jq '.[0]'               # First array element
curl api.com/data | jq '.items[]'       # Process API response
```

---

### System Monitoring & Process Management

#### **`btop`** - Beautiful system monitor
```bash
brew install btop

# Usage
btop                   # Launch interactive monitor
```

#### **`gruyere`** - AI-powered process manager
```bash
brew install gruyere

# Usage
gruyere                # Launch TUI
gruyere list           # List processes
gruyere kill <pid>     # Kill process
```

---

### Git & Version Control

#### **`gh`** - GitHub CLI
```bash
brew install gh

# Authentication
gh auth login

# Usage
gh repo create         # Create repository
gh pr list             # List pull requests
gh pr create           # Create PR
gh issue list          # List issues
gh issue create        # Create issue
gh browse              # Open repo in browser
```

#### **`delta`** - Better git diff viewer
```bash
brew install git-delta

# Setup (add to ~/.gitconfig)
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true
    light = false

# Usage
git diff               # Automatically uses delta
git log -p             # Pretty diff in logs
```

---

### Markdown & Documentation

#### **`glow`** - Terminal markdown viewer
```bash
brew install glow

# Usage
glow README.md         # Render markdown
glow -p file.md        # Plain text output
glow -a 5 file.md      # Wrap at column 5
```

---

### Fun / Aesthetic

#### **`figlet`** - ASCII art text
```bash
brew install figlet

# Usage
figlet "Hello World"
echo "text" | figlet
```

#### **`lolcat`** - Rainbow colorizer
```bash
brew install lolcat

# Usage
echo "Hello" | lolcat
ls | lolcat
figlet "text" | lolcat
```

#### **`cowsay`** - ASCII cow messages
```bash
brew install cowsay

# Usage
cowsay "Hello!"
fortune | cowsay
```

#### **`fortune`** - Random quotes
```bash
brew install fortune

# Usage
fortune
fortune -s             # Short quotes
```

#### **`boxes`** - Text box generator
```bash
brew install boxes

# Usage
echo "Hello" | boxes
echo "text" | boxes -d stone
```

#### **`cmatrix`** - Matrix screensaver effect
```bash
brew install cmatrix

# Usage
cmatrix
cmatrix -b             # Bold characters
cmatrix -r             # Rainbow mode
```

#### **`asciiquarium`** - ASCII aquarium
```bash
brew install asciiquarium

# Usage
asciiquarium
```

---

### Archive & File Tools

#### **`p7zip`** - 7-Zip for Unix
```bash
brew install p7zip

# Usage
7z x archive.7z        # Extract
7z a archive.7z files  # Create archive
7z l archive.7z        # List contents
```

#### **`poppler`** - PDF utilities
```bash
brew install poppler

# Usage
pdfinfo file.pdf       # PDF metadata
pdftotext file.pdf     # Extract text
pdfimages file.pdf img # Extract images
```

---

### Image & SVG Tools

#### **`imagemagick`** - Image manipulation
```bash
brew install imagemagick

# Usage
convert input.jpg output.png           # Convert format
convert input.jpg -resize 50% out.jpg  # Resize
convert input.jpg -rotate 90 out.jpg   # Rotate
identify image.jpg                     # Image info
```

#### **`resvg`** - SVG renderer
```bash
brew install resvg

# Usage
resvg input.svg output.png             # Convert SVG to PNG
resvg --width 1000 input.svg out.png   # Set width
```

---

### Environment & Shell

#### **`direnv`** - Directory-specific environment variables
```bash
brew install direnv

# Setup (add to ~/.zshrc)
eval "$(direnv hook zsh)"

# Usage
# Create .envrc in project directory:
echo "export DATABASE_URL=postgres://..." > .envrc
direnv allow           # Allow .envrc
```

---

## Homebrew Essential Commands

### Installation & Updates

```bash
# Install formula (CLI tool)
brew install <package>

# Install cask (GUI app)
brew install --cask <app>

# Update Homebrew itself
brew update

# Upgrade all packages
brew upgrade

# Upgrade specific package
brew upgrade <package>
```

### Information & Search

```bash
# Search for packages
brew search <term>

# Show package info
brew info <package>

# List installed formulae
brew list --formula

# List installed casks
brew list --cask

# Check for issues
brew doctor

# See what's outdated
brew outdated
```

### Removal & Cleanup

```bash
# Uninstall package
brew uninstall <package>

# Remove old versions
brew cleanup

# Remove specific package versions
brew cleanup <package>

# See what would be cleaned
brew cleanup -n
```

### Services (Daemons)

```bash
# List services
brew services list

# Start service
brew services start <service>

# Stop service
brew services stop <service>

# Restart service
brew services restart <service>
```

### Taps (Third-Party Repositories)

```bash
# Add tap
brew tap <user/repo>

# List taps
brew tap

# Remove tap
brew untap <user/repo>
```

### Advanced

```bash
# Pin package (prevent upgrades)
brew pin <package>

# Unpin package
brew unpin <package>

# Show dependencies
brew deps <package>

# Show dependency tree
brew deps --tree <package>

# Install specific version
brew install <package>@<version>

# Link package (create symlinks)
brew link <package>

# Unlink package
brew unlink <package>
```

---

## Yazi File Manager Dependencies

**Yazi** is a blazing-fast terminal file manager. These tools enhance its functionality:

```bash
# Core dependencies (already installed above)
brew install --cask font-meslo-lg-nerd-font  # ✅ Installed
brew install ffmpeg                           # ✅ Installed (video thumbnails)
brew install p7zip                            # ✅ Installed (archive extraction)
brew install jq                               # ✅ Installed (JSON preview)
brew install poppler                          # ✅ Installed (PDF preview)
brew install fd                               # ✅ Installed (file searching)
brew install ripgrep                          # ✅ Installed (content searching)
brew install fzf                              # ✅ Installed (fuzzy navigation)
brew install zoxide                           # ✅ Installed (directory history)
brew install resvg                            # ✅ Installed (SVG preview)
brew install imagemagick                      # ✅ Installed (image preview)

# Note: Clipboard tools (xclip/wl-clipboard) are Linux-only
# macOS uses pbcopy/pbpaste (built-in)
```

---

## Shell Aliases & Functions

**Add to `~/.zshrc` for convenience:**

```bash
# Modern replacements
alias ls='eza'
alias ll='eza -lah --icons --git'
alias tree='eza --tree'
alias cat='bat'
alias find='fd'
alias grep='rg'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'

# Homebrew shortcuts
alias brewup='brew update && brew upgrade && brew cleanup'
alias brewls='brew list --formula'
alias brewinfo='brew info'

# Fun
alias matrix='cmatrix -b'
alias fish='asciiquarium'
alias quote='fortune | cowsay | lolcat'
```

---

## Recently Installed Tools

Tools installed in November 2024:

- `asciiquarium` - ASCII aquarium screensaver
- `bat` - Modern cat with syntax highlighting
- `boxes` - ASCII text box generator
- `btop` - Beautiful system monitor
- `cmatrix` - Matrix screensaver effect
- `cowsay` - ASCII cow messages
- `direnv` - Directory-specific environment variables
- `eza` - Modern ls replacement
- `fd` - Modern find replacement
- `ffmpeg` - Video/audio processing
- `figlet` - ASCII art text
- `fortune` - Random quotes
- `fzf` - Fuzzy finder
- `gh` - GitHub CLI
- `git-delta` - Better git diff viewer
- `glow` - Terminal markdown viewer
- `gruyere` - AI-powered process manager
- `imagemagick` - Image manipulation
- `jq` - JSON processor
- `lolcat` - Rainbow colorizer
- `p7zip` - 7-Zip for Unix
- `poppler` - PDF utilities
- `resvg` - SVG renderer
- `ripgrep` - Fast grep replacement
- `zoxide` - Smart directory jumper

---

## Quick Reference Card

| Task | Old Command | New Command |
|------|-------------|-------------|
| List files | `ls -la` | `eza -la --icons` |
| View file | `cat file` | `bat file` |
| Find files | `find . -name "*.js"` | `fd -e js` |
| Search text | `grep -r "pattern"` | `rg "pattern"` |
| Change dir | `cd ~/projects/foo` | `z foo` |
| Fuzzy find | N/A | `fzf` or `CTRL+T` |
| Git diff | `git diff` | Uses `delta` automatically |
| JSON | `cat data.json` | `cat data.json \| jq .` |
| PDF info | N/A | `pdfinfo file.pdf` |
| System monitor | `top` | `btop` |

---

## Installation Script

**Install all essential tools at once:**

```bash
#!/bin/bash
# Essential CLI tools installation

brew install \
  bat \
  btop \
  delta \
  direnv \
  eza \
  fd \
  ffmpeg \
  figlet \
  fortune \
  fzf \
  gh \
  glow \
  gruyere \
  imagemagick \
  jq \
  lolcat \
  p7zip \
  poppler \
  resvg \
  ripgrep \
  zoxide

# Fun tools (optional)
brew install \
  asciiquarium \
  boxes \
  cmatrix \
  cowsay

# Nerd Fonts (for terminal icons)
brew install --cask \
  font-hack-nerd-font \
  font-fira-code-nerd-font \
  font-jetbrains-mono-nerd-font \
  font-meslo-lg-nerd-font

echo "✅ Installation complete!"
echo "💡 Add shell configuration to ~/.zshrc (see protocol)"
```

---

## Version History

- **v1.0** (2024-11-21): Initial CLI tools reference created
  - Documented essential modern CLI tools
  - Added Homebrew command reference
  - Included Yazi dependencies
  - Listed recently installed tools (November 2024)

---

## See Also

- **PACKAGE-MANAGER-v1.0** (Package management hierarchy)
- **~/.psa/AGENTS_MASTER.md** (AI agent configurations)
- **~/.zshrc** (Shell configuration)
