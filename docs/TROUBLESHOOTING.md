# PSA Troubleshooting Guide

Complete troubleshooting guide covering all common issues and their fixes.

---

## Quick Fixes

| Symptom | Cause | Fix |
|---------|-------|-----|
| ERR_PNPM_NO_GLOBAL_BIN_DIR | ~/.zshenv not configured | `psa init-env` then restart terminal |
| psa: command not found | PSA bin not in PATH | `psa init-env` then `exec zsh` |
| pnpm: command not found | pnpm not installed | `brew install pnpm` |
| glow ~/.warp/AGENTS.md fails | Outdated path reference | Use `psa view-master` instead |
| Docker requires password | sudo needed for installation | Install manually or skip |
| psa_dash: command not found | Underscore vs dash naming | Use `psa dash` (with dash) |
| npm blocks/redirects | npm is blocked system-wide | Use `bun` or `pnpm` instead |
| Command works in terminal but not Claude Code | Environment vars not in ~/.zshenv | `psa init-env` then restart Claude Code |
| /psa-help: command not found | Slash commands not synced | `psa sync-to-project` |
| Protocol file missing | Not synced to project | `psa sync-to-project` |
| psa update-self fails | PSA not a git repository | See "PSA Git Setup" section |
| Global pnpm packages not accessible | PNPM_HOME not in PATH | `psa init-env` then restart terminal |
| Tool version differs from docs | Environment context outdated | `psa context --update` |
| bun/pnpm not in PATH | Shell config incomplete | `psa init-env` |
| Projects not appearing in dashboard | No project registry | `psa scan-projects` |

---

## Detailed Troubleshooting

### 1. Environment Configuration Issues

#### Problem: ERR_PNPM_NO_GLOBAL_BIN_DIR

**Symptom:**
```
ERROR  ERR_PNPM_NO_GLOBAL_BIN_DIR  Unable to find the global bin directory
Run "pnpm setup" to create it automatically, or set the global-bin-dir setting, or the PNPM_HOME env variable.
```

**Why this happens:**
- Environment variables (PNPM_HOME) not configured for non-interactive shells
- Claude Code and scripts use non-interactive shells (they don't load ~/.zshrc)
- ~/.zshenv is required but missing or incomplete

**Fix:**
```bash
# 1. Run PSA environment initializer
psa init-env

# 2. Restart your shell
exec zsh

# 3. Verify it worked
echo $PNPM_HOME    # Should show: /Users/yourusername/Library/pnpm
pnpm --version     # Should show version number

# 4. For Claude Code sessions
# Exit Claude Code completely and start a new session
```

**Verify it worked:**
```bash
# Check configuration
psa doctor

# Should show all green checkmarks (✓)
```

**Manual fix (if psa init-env doesn't exist):**
```bash
# Create/edit ~/.zshenv
nano ~/.zshenv

# Add these lines:
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Save and restart terminal
```

---

#### Problem: psa: command not found

**Symptom:**
```bash
psa help
# zsh: command not found: psa
```

**Why this happens:**
- PSA bin directory not in PATH
- ~/.zshenv not configured
- Terminal needs restart after configuration

**Fix:**
```bash
# 1. Initialize environment
psa init-env   # Or: ~/.psa/scripts/init-env.sh

# 2. Restart shell
exec zsh

# 3. Verify
which psa      # Should show: /Users/yourusername/.psa/bin/psa
psa help       # Should show PSA help menu
```

**Alternative: Add to PATH manually**
```bash
# Edit ~/.zshenv
nano ~/.zshenv

# Add:
export PSA_HOME="$HOME/.psa"
export PATH="$PSA_HOME/bin:$PATH"

# Save, then:
source ~/.zshenv
```

---

#### Problem: Commands work in terminal but not in Claude Code

**Symptom:**
- `psa help` works in Terminal.app or iTerm
- Same command fails in Claude Code with "command not found"

**Why this happens:**
- Terminal apps load ~/.zshrc (interactive)
- Claude Code uses non-interactive shells (only loads ~/.zshenv)
- Environment variables in wrong file

**Fix:**
```bash
# 1. Move environment variables to ~/.zshenv
psa init-env

# 2. Exit Claude Code COMPLETELY
# (Don't just close the window - quit the application)

# 3. Start new Claude Code session

# 4. Test
echo $PNPM_HOME    # Should work now
```

**Verify configuration:**
```bash
# Test non-interactive shell (like Claude Code uses)
zsh -c 'echo $PNPM_HOME'   # Should show path, not empty

# Test interactive shell (like Terminal uses)
echo $PNPM_HOME            # Should show same path
```

---

### 2. Package Manager Errors

#### Problem: npm commands are blocked

**Symptom:**
```bash
npm install
# This command automatically redirects to: pnpm install
```

**Why this happens:**
- npm is blocked system-wide (by design)
- All npm commands redirect to pnpm
- This ensures consistency across projects

**Fix:**
```bash
# Use the correct package manager instead:

# For global tools
npx pnpm install -g <package>    # ✅ Correct

# For project dependencies (new projects)
bun install                      # ✅ Preferred
bun add <package>

# For project dependencies (existing projects)
pnpm install                     # ✅ Fallback
pnpm add <package>

# NEVER use
npm install                      # ❌ Blocked
npm install -g <package>         # ❌ Blocked
```

**Tell agents about this:**
```bash
# When working with AI agents, instruct them:
"Read protocols/PACKAGE-MANAGER-v1.0.md first before installing packages"
```

**Reference:**
See `/Users/yourusername/.psa/protocols/PACKAGE-MANAGER-v1.0.md` for complete rules

---

#### Problem: Global pnpm packages not accessible

**Symptom:**
```bash
npx pnpm install -g @kilocode/cli
# Installs successfully

kilocode
# zsh: command not found: kilocode
```

**Why this happens:**
- PNPM_HOME not in PATH
- Global bin directory not configured

**Fix:**
```bash
# 1. Initialize environment
psa init-env

# 2. Restart terminal
exec zsh

# 3. Verify
pnpm bin -g               # Should show: /Users/yourusername/Library/pnpm
echo $PATH | grep pnpm    # Should show pnpm in PATH

# 4. Test global command
kilocode                  # Should work now
```

---

### 3. PSA Command Issues

#### Problem: psa_dash vs psa dash

**Symptom:**
```bash
psa_dash
# zsh: command not found: psa_dash
```

**Why this happens:**
- PSA uses hyphens (dash) not underscores
- Consistent naming: `psa <command>` with hyphens

**Fix:**
```bash
# Use correct command name:
psa dash                  # ✅ Correct
psa sync-to-project       # ✅ Correct
psa update-self           # ✅ Correct

# Not:
psa_dash                  # ❌ Wrong
psa_sync_to_project       # ❌ Wrong
```

**Complete list:**
```bash
psa help                  # Show all commands
psa dash                  # Project dashboard
psa sync-to-project       # Sync to current project
psa sync-all-projects     # Sync to all projects
psa update-self           # Update PSA from GitHub
psa context               # Show environment
psa context --update      # Update context
psa init-project          # Create new project
psa doctor                # Check environment
psa check-updates         # Check for outdated packages
```

---

#### Problem: /psa-help command not found (Claude Code)

**Symptom:**
In Claude Code:
```
/psa-help
# Error: Unknown command /psa-help
```

**Why this happens:**
- Slash commands not synced to project
- .claude/commands/ directory missing PSA commands
- Need to sync from ~/.psa/examples/commands/

**Fix:**
```bash
# In your project directory
cd ~/projects/your-project

# Sync PSA slash commands
psa sync-to-project

# Verify
ls .claude/commands/psa*.md

# Should show:
# psa-help.md
# psa-shortcuts.md
# psa-tools-install.md
# psa-tools-list.md
# psa-tools-update.md
# psa-update.md
```

**Then in Claude Code:**
```
# Restart Claude Code session
# Now these should work:
/psa-help
/psa-shortcuts
```

---

#### Problem: psa update-self fails

**Symptom:**
```bash
psa update-self
# Error: PSA is not a git repository
```

**Why this happens:**
- PSA directory not initialized as git repo
- No git remote configured

**Fix:**
```bash
# Option 1: Initialize PSA as git repo
cd ~/.psa
git init
git add .
git commit -m "Initial PSA setup"

# Option 2: Clone PSA from GitHub (if exists)
cd ~
mv .psa .psa.backup
git clone https://github.com/yourusername/psa.git .psa

# Verify
cd ~/.psa
git status
git remote -v    # Should show GitHub remote
```

**After setup:**
```bash
psa update-self
# Should work now - pulls from GitHub
```

---

### 4. File and Path Issues

#### Problem: glow ~/.warp/AGENTS.md fails

**Symptom:**
```bash
glow ~/.warp/AGENTS.md
# Error: File not found
```

**Why this happens:**
- Outdated path reference in shortcuts
- AGENTS.md moved to different location
- PSA provides canonical viewing command

**Fix:**
```bash
# Use PSA canonical command instead:
psa view-master            # Views AGENTS.md with glow

# Or find current location:
fd AGENTS.md ~

# If found in ~/.psa/:
glow ~/.psa/AGENTS.md

# If found in project:
glow ./AGENTS.md
```

---

#### Problem: Protocol file missing in project

**Symptom:**
Agent says: "Cannot find docs/protocols/PACKAGE-MANAGER-v1.0.md"

**Why this happens:**
- Protocols not synced from ~/.psa/protocols/
- Project initialized before protocols existed
- Need manual sync

**Fix:**
```bash
# In your project directory
cd ~/projects/your-project

# Sync all protocols from PSA
psa sync-to-project

# Verify
ls docs/protocols/

# Should show:
# PACKAGE-MANAGER-v1.0.md
# MVC-METHOD-v1.0.md
# UPGRADE-MANAGEMENT-v1.0.md
# etc.
```

**Check what will sync:**
```bash
# View available protocols
ls ~/.psa/protocols/

# Sync preserves customizations:
# - Creates .backup files for modified protocols
# - Never overwrites project-specific content
```

---

### 5. Tool Installation Issues

#### Problem: Docker installation requires password

**Symptom:**
During PSA setup or tool installation:
```
Installing Docker...
[sudo] password for username:
```

**Why this happens:**
- Docker Desktop requires sudo for installation
- PSA can't provide password automatically
- Manual installation preferred

**Fix:**

**Option 1: Install manually (recommended)**
```bash
# Download from Docker website
open https://www.docker.com/products/docker-desktop

# Or via Homebrew
brew install --cask docker

# Start Docker Desktop app manually
open -a Docker
```

**Option 2: Skip Docker**
```bash
# Docker is optional
# PSA works without it
# Skip if you don't need containers
```

---

#### Problem: Tool version differs from documentation

**Symptom:**
Documentation says Node.js 25.2.0, but you have 24.x

**Why this happens:**
- Environment context in CLAUDE.md is outdated
- Tools were upgraded
- Context needs refresh

**Fix:**
```bash
# Update environment context
cd ~/projects/your-project
psa context --update

# This updates the "Current Environment Context" section in CLAUDE.md
# Shows actual installed versions
```

**Verify:**
```bash
# Check what's actually installed
node --version
bun --version
python3 --version

# Check what CLAUDE.md says
grep -A 20 "Installed Tools" CLAUDE.md
```

---

### 6. Dashboard and Project Registry Issues

#### Problem: Projects not appearing in dashboard

**Symptom:**
```bash
psa dash
# Shows empty or incomplete list
```

**Why this happens:**
- Project registry not initialized
- New projects not scanned
- Registry file missing

**Fix:**
```bash
# Scan all projects to rebuild registry
psa scan-projects

# Or add project manually
cd ~/projects/new-project
psa register-project

# Verify
psa dash
# Should show all projects now
```

**Registry location:**
```bash
# View registry directly
cat ~/.psa/data/projects-registry.json

# Should contain all your projects
```

---

### 7. Git and Sync Issues

#### Problem: Sync conflicts in CLAUDE.md

**Symptom:**
```bash
psa sync-to-project
# ...later in git...
git status
# Shows merge conflicts in CLAUDE.md
```

**Why this happens:**
- Both you and PSA edited CLAUDE.md
- Environment context section conflicts
- Manual merge needed

**Fix:**
```bash
# View conflicts
git diff CLAUDE.md

# Option 1: Keep your version
git checkout --ours CLAUDE.md

# Option 2: Keep PSA version
git checkout --theirs CLAUDE.md

# Option 3: Manual merge
code CLAUDE.md
# Edit to combine both versions
git add CLAUDE.md
git commit -m "chore: merge PSA sync"
```

**Prevention:**
```bash
# Review before committing sync
psa sync-to-project
git diff           # Review changes
git add .
git commit -m "chore: sync PSA updates"
```

---

### 8. Claude Code Specific Issues

#### Problem: Slash commands not reloading

**Symptom:**
- Added new slash commands to .claude/commands/
- Commands still not available in Claude Code

**Why this happens:**
- Claude Code caches commands
- Needs restart to reload

**Fix:**
```bash
# 1. Verify commands exist
ls .claude/commands/*.md

# 2. Exit Claude Code COMPLETELY
# (Quit application, not just close window)

# 3. Start new Claude Code session

# 4. Test commands
/psa-help
/psa-shortcuts
```

---

#### Problem: Agent violates package manager rules

**Symptom:**
Agent tries to run:
```bash
npm install <package>
```

**Why this happens:**
- Agent not aware of package manager protocol
- Training data suggests npm
- Needs explicit instruction

**Fix:**

**Prevention (before starting work):**
```
"Before installing any packages, read docs/protocols/PACKAGE-MANAGER-v1.0.md"
```

**Correction (when it happens):**
```
"Stop. npm is blocked system-wide. Use bun for this project (new) or pnpm (existing).
Check PACKAGE-MANAGER-v1.0.md protocol first."
```

---

### 9. Performance and Optimization Issues

#### Problem: psa commands are slow

**Symptom:**
```bash
psa dash
# Takes 10+ seconds to load
```

**Why this happens:**
- Large number of projects
- Project registry needs optimization
- Heavy git operations

**Fix:**
```bash
# Archive completed projects
cd ~/projects/completed-project
psa archive-project

# Remove from dashboard without deleting
psa unregister-project

# Clean up registry
psa scan-projects --clean
```

---

### 10. Permission and Access Issues

#### Problem: Permission denied errors

**Symptom:**
```bash
psa init-env
# Permission denied: ~/.zshenv
```

**Why this happens:**
- File permissions incorrect
- Owned by different user
- System protection

**Fix:**
```bash
# Check ownership
ls -la ~/.zshenv

# Fix ownership
sudo chown $USER:staff ~/.zshenv

# Fix permissions
chmod 644 ~/.zshenv

# Try again
psa init-env
```

---

## Prevention and Best Practices

### Daily Health Check

```bash
# Run before each session
psa doctor

# Should show all green ✓
# Fix any red ✗ or yellow ⚠ warnings
```

### Weekly Maintenance

```bash
# Update PSA
psa update-self

# Sync to all projects
psa sync-all-projects

# Check for outdated tools
psa check-updates

# Update environment context
cd ~/projects/active-project
psa context --update
```

### Before Working with AI Agents

```bash
# 1. Check environment
psa doctor

# 2. Update project context
psa context --update

# 3. Sync latest protocols
psa sync-to-project

# 4. In Claude Code, verify commands work:
/psa-help
```

### After Installing New Tools

```bash
# Update environment context
cd ~/projects/your-project
psa context --update

# Verify in shell
psa doctor

# Commit changes
git add CLAUDE.md
git commit -m "chore: update environment context"
```

---

## Getting Help

### Check Documentation

```bash
# PSA help
psa help

# View specific protocol
glow ~/.psa/protocols/PACKAGE-MANAGER-v1.0.md

# View all shortcuts
/psa-shortcuts    # In Claude Code
psa view-master   # AGENTS.md in terminal
```

### Run Diagnostics

```bash
# Full environment check
psa doctor

# Context information
psa context

# Check versions
node --version
bun --version
pnpm --version
python3 --version
```

### Common Diagnostic Commands

```bash
# Check PATH
echo $PATH | tr ':' '\n'

# Check environment variables
env | grep -E '(PNPM|PSA|BUN|NODE)'

# Check shell files
cat ~/.zshenv
cat ~/.zshrc

# Check PSA installation
ls -la ~/.psa/
ls -la ~/.psa/bin/
ls -la ~/.psa/protocols/

# Check project PSA integration
ls -la .claude/commands/psa*.md
ls -la docs/protocols/
```

---

## Emergency Fixes

### Nuclear Option: Complete Reset

**WARNING: Only use if everything is broken**

```bash
# 1. Backup current PSA
cp -r ~/.psa ~/.psa.backup.$(date +%Y%m%d)

# 2. Backup shell configs
cp ~/.zshenv ~/.zshenv.backup.$(date +%Y%m%d)
cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d)

# 3. Remove PSA
rm -rf ~/.psa

# 4. Reinstall PSA
cd ~
git clone https://github.com/yourusername/psa.git .psa

# 5. Initialize
~/.psa/scripts/init-env.sh

# 6. Restart terminal
exec zsh

# 7. Verify
psa doctor
```

### Restore from Backup

```bash
# If you need to rollback
rm -rf ~/.psa
cp -r ~/.psa.backup.YYYYMMDD ~/.psa

# Restore shell configs
cp ~/.zshenv.backup.YYYYMMDD ~/.zshenv
cp ~/.zshrc.backup.YYYYMMDD ~/.zshrc

# Restart
exec zsh
```

---

## Verification Checklist

After fixing issues, verify everything works:

```bash
# ✓ Environment configured
psa doctor                          # Should show all green

# ✓ Commands accessible
psa help                            # Should show help
psa dash                            # Should show projects

# ✓ Package managers work
pnpm --version                      # Should show version
bun --version                       # Should show version

# ✓ Environment variables set
echo $PNPM_HOME                     # Should show path
echo $PSA_HOME                      # Should show ~/.psa

# ✓ Protocols synced
ls docs/protocols/*.md              # Should show protocol files

# ✓ Claude Code integration
ls .claude/commands/psa*.md         # Should show slash commands

# ✓ Non-interactive shells work (like Claude Code)
zsh -c 'echo $PNPM_HOME'           # Should show path

# ✓ Git status clean
git status                          # Check for uncommitted PSA changes
```

---

## Quick Reference: Common Commands

```bash
# Initialization and Setup
psa init-env                        # Configure environment
psa doctor                          # Check environment health

# Updates and Syncing
psa update-self                     # Update PSA from GitHub
psa sync-to-project                 # Sync PSA to current project
psa sync-all-projects               # Sync to all projects

# Project Management
psa dash                            # View all projects
psa init-project <name>             # Create new project
psa context --update                # Update environment context

# Troubleshooting
psa doctor                          # Full diagnostics
psa help                            # Show all commands
/psa-help                          # Claude Code help (in Claude)
/psa-shortcuts                     # All shortcuts (in Claude)
```

---

**Last Updated:** 2025-11-23
**PSA Version:** 1.1.0+
**Maintainer:** PSA Core Team

For additional help, see:
- `/Users/yourusername/.psa/protocols/` - Protocol documentation
- `psa help` - Command reference
- `psa doctor` - Environment diagnostics
