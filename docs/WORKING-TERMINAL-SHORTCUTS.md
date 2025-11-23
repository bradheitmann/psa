# Terminal Shortcuts - What Actually Works

This guide only includes shortcuts for **tools you have installed** and commands that **actually work**.

---

## 🎯 ESSENTIAL DAILY COMMANDS

### Navigate Files & Directories

```bash
# List files (better than ls)
eza                              # List files with icons
eza -la                          # List all files, long format
eza -la --git                    # Show git status
eza --tree                       # Tree view
eza --tree --level=2             # Tree 2 levels deep

# Change directory
cd ~/projects                    # Go to directory
cd ..                            # Go up one level
cd -                             # Go to previous directory
z projectname                    # Smart jump (if you've been there before)

# Find files (better than find)
fd filename                      # Find by name
fd -e js                         # Find all .js files
fd -e ts src/                    # Find .ts files in src/
fd pattern --type f              # Files only
fd pattern --type d              # Directories only

# View file contents (better than cat)
bat filename.ts                  # View with syntax highlighting
bat -n filename.ts               # With line numbers
bat -r 10:20 file.ts            # Lines 10-20 only
```

---

## 🔍 SEARCH & FIND

### Search Inside Files

```bash
# Search for text (better than grep)
rg "searchterm"                  # Search in current directory
rg "searchterm" path/            # Search in specific path
rg -i "searchterm"               # Case insensitive
rg -l "searchterm"               # Show filenames only
rg -c "searchterm"               # Count matches per file
rg "searchterm" -t typescript    # Search only TypeScript files
rg "searchterm" --glob "*.js"    # Search only .js files
rg "searchterm" -A 3             # Show 3 lines after match
rg "searchterm" -B 3             # Show 3 lines before match
rg "searchterm" -C 3             # Show 3 lines before AND after
```

### Fuzzy Finder (Interactive Search)

```bash
# Fuzzy find files (type to filter, press enter to select)
fzf                              # Search files in current dir
fd -t f | fzf                    # Find files, then fuzzy select
fd -e ts | fzf                   # Find .ts files, then select

# In shell (built-in shortcuts):
CTRL+T                           # Fuzzy find files (paste to command line)
CTRL+R                           # Fuzzy search command history
ALT+C                            # Fuzzy find directories and cd into them
```

---

## 📁 FILE MANAGEMENT

### Copy, Move, Delete

```bash
# Basic operations
cp file.txt newfile.txt          # Copy file
cp -r dir/ newdir/               # Copy directory
mv oldname.txt newname.txt       # Rename/move file
rm file.txt                      # Delete file
rm -r directory/                 # Delete directory
mkdir dirname                    # Create directory
mkdir -p path/to/nested/dir      # Create nested directories

# Browse files interactively
yazi                             # Launch file manager (arrows to navigate, enter to open)
yazi ~/projects                  # Open specific directory
```

---

## 📝 VIEW & EDIT FILES

### View Files

```bash
# Read files
bat file.txt                     # View with syntax highlighting
glow README.md                   # View markdown (formatted)
glow -p file.md                  # View markdown with pager
less file.txt                    # Page through long file (q to quit)
head file.txt                    # First 10 lines
tail file.txt                    # Last 10 lines
tail -f logfile.log              # Watch file (follow as it grows)
```

### Edit Files

```bash
# Open in editor (if you have these installed)
nano file.txt                    # Simple terminal editor
vim file.txt                     # Vim editor (advanced)
code file.txt                    # VS Code (if installed)
```

---

## 🔄 GIT COMMANDS

### Basic Git Workflow

```bash
# Status and viewing
git status                       # See what's changed
git status -s                    # Short status
git log --oneline                # View commit history (one line each)
git log --graph --oneline        # Visual branch graph
git diff                         # See unstaged changes
git diff --staged                # See staged changes
git diff | delta                 # Better diff view

# Making changes
git add .                        # Stage all changes
git add filename.txt             # Stage specific file
git commit -m "message"          # Commit with message
git push                         # Push to remote
git pull                         # Pull from remote

# Branches
git branch                       # List branches
git branch newbranch             # Create branch
git checkout branchname          # Switch branch
git checkout -b newbranch        # Create and switch

# GitHub (using gh CLI)
gh pr list                       # List pull requests
gh pr create                     # Create PR
gh pr view                       # View PR
gh issue list                    # List issues
gh repo view --web               # Open repo in browser
```

---

## 📦 PACKAGE MANAGERS

### Bun (JavaScript - This Project)

```bash
bun install                      # Install dependencies
bun add packagename              # Add package
bun remove packagename           # Remove package
bun run dev                      # Run dev script
bun run build                    # Run build script
bun test                         # Run tests
```

### Homebrew (System Tools)

```bash
brew install toolname            # Install tool
brew uninstall toolname          # Remove tool
brew update                      # Update brew itself
brew upgrade                     # Upgrade all installed tools
brew list                        # List installed tools
brew search keyword              # Search for tools
brew info toolname               # Get info about tool
```

### Python (uv)

```bash
uv pip install packagename       # Install Python package
uv pip list                      # List installed packages
python3 script.py                # Run Python script
python3 -m venv .venv            # Create virtual environment
source .venv/bin/activate        # Activate venv
```

---

## 🎨 JSON & DATA

### Working with JSON

```bash
# View and process JSON
cat file.json | jq '.'           # Pretty print JSON
cat file.json | jq '.key'        # Get specific key
cat file.json | jq '.[] | .name' # Map array
cat file.json | jq 'keys'        # Show all keys
echo '{"a":1}' | jq '.a'         # Process string
```

---

## 🖥️  TERMINAL MULTIPLEXING

### tmux (Multiple Terminal Panes)

```bash
# Start/attach
tmux                             # Start new session
tmux new -s name                 # New named session
tmux attach                      # Attach to last session
tmux attach -t name              # Attach to named session
tmux ls                          # List sessions

# Inside tmux (CTRL+B then key):
CTRL+B %                         # Split vertical
CTRL+B "                         # Split horizontal
CTRL+B arrow                     # Navigate panes
CTRL+B d                         # Detach (keep running)
CTRL+B x                         # Close pane
CTRL+B c                         # New window
CTRL+B n                         # Next window
CTRL+B p                         # Previous window
```

---

## 💡 SMART NAVIGATION

### zoxide (Smart cd)

```bash
# After visiting directories, jump back with:
z projectname                    # Jump to directory (fuzzy match)
z -                              # Jump to previous
zi                               # Interactive directory picker
zoxide query -l                  # List all tracked directories
```

---

## 🔗 COMBINING COMMANDS

### Powerful Combinations

```bash
# Search and open
rg "searchterm" -l | fzf | xargs bat
# (Search files, fuzzy select, view with bat)

# Find and edit
fd -e ts | fzf | xargs code
# (Find TypeScript files, select, open in VS Code)

# Git interactive
git log --oneline | fzf
# (Browse commits interactively)

# Find large files
fd -t f -x du -h | sort -rh | head -20
# (Find files, get sizes, sort by size, show top 20)

# Browse markdown docs
fd '.md$' docs/ | fzf | xargs glow
# (Find markdown files, select, view formatted)
```

---

## 🚀 PSA COMMANDS

### Your PSA Tools

```bash
# Main commands
psa help                         # Show all PSA commands
psa dash                         # Global project dashboard
psa init-project name            # Create new project
psa update-self                  # Update PSA from GitHub
psa sync-to-project              # Sync PSA to current project
psa sync-all-projects            # Sync to all projects
psa context                      # Show environment info
psa context --update             # Update CLAUDE.md context

# Check and update tools
psa check-updates                # Check for outdated tools
psa upgrade-all                  # Upgrade everything
```

---

## ⌨️  KEYBOARD SHORTCUTS (Universal)

### In Any Terminal

```bash
CTRL+C                           # Cancel current command
CTRL+D                           # Exit shell / End input
CTRL+L                           # Clear screen
CTRL+A                           # Move cursor to start of line
CTRL+E                           # Move cursor to end of line
CTRL+U                           # Delete from cursor to start
CTRL+K                           # Delete from cursor to end
CTRL+W                           # Delete word before cursor
CTRL+R                           # Search command history (fzf)
CTRL+T                           # Fuzzy find files (fzf)
ALT+C                            # Fuzzy find directories (fzf)
TAB                              # Autocomplete
↑ / ↓                            # Previous/next command
```

---

## 📋 QUICK REFERENCE

### Most Used Commands

```bash
# Navigation
eza -la                          # List files
cd ~/projects                    # Change directory
z projectname                    # Smart jump

# Search
fd filename                      # Find files
rg "text"                        # Search in files
fzf                              # Interactive search

# View
bat file.txt                     # View file
glow README.md                   # View markdown

# Git
git status                       # Check status
git add .                        # Stage changes
git commit -m "msg"              # Commit
git push                         # Push

# PSA
psa help                         # PSA commands
psa dash                         # Dashboard
```

---

## 🛠️  INSTALL MISSING TOOLS

If a command doesn't work, install it:

```bash
# Check what's installed
which bat eza fd fzf rg          # Check specific tools
brew list                        # See all installed

# Install missing tools
brew install bat                 # Better cat
brew install eza                 # Better ls
brew install fd                  # Better find
brew install fzf                 # Fuzzy finder
brew install ripgrep             # Better grep (rg)
brew install jq                  # JSON processor
brew install git-delta           # Better diff (delta)
brew install glow                # Markdown viewer
brew install gh                  # GitHub CLI
brew install zoxide              # Smart cd
brew install yazi                # File manager
brew install tmux                # Terminal multiplexer
```

---

## 💻 OPENING APPLICATIONS

### From Terminal

```bash
# If you have these applications installed:
open .                           # Open current directory in Finder
open filename.pdf                # Open file with default app
code .                           # Open in VS Code
```

---

**Remember:**
- Type the command and press ENTER
- Use TAB to autocomplete
- Use CTRL+C to cancel if stuck
- Use `commandname --help` to see options for any command
