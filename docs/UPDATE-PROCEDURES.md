# PSA Update & Sync Procedures

Complete guide for updating PSA and syncing changes across all projects while preserving customizations.

---

## Overview

PSA has three levels of updates:

1. **Global PSA Update** (`psa update-self`) - Update PSA system files from GitHub
2. **Project Sync** (`psa sync-to-project`) - Sync PSA changes to a single project
3. **All Projects Sync** (`psa sync-all-projects`) - Sync PSA changes to all tracked projects

---

## 🔄 Update Workflow

### **Full Update & Sync** (Recommended)

```bash
# 1. Update PSA itself from GitHub
psa update-self

# 2. Sync to all tracked projects
psa sync-all-projects

# 3. Review changes in each project
cd ~/projects/my-project
git diff

# 4. Commit if satisfied
git add .
git commit -m "chore: sync PSA updates"
```

### **Single Project Sync**

```bash
# Sync PSA to current project only
cd ~/projects/my-project
psa sync-to-project

# Or specify path
psa sync-to-project ~/projects/other-project
```

---

## 📋 Command Reference

### **psa update-self**

**Environment:** Terminal
**Purpose:** Update PSA from GitHub while preserving local customizations

**What it does:**
1. Checks if PSA is a git repository
2. Checks for git remote (GitHub)
3. Stashes any uncommitted local changes
4. Pulls latest updates from GitHub
5. Restores stashed changes (auto-merge if possible)
6. Updates global Claude Code slash commands (~/.claude/commands/)
7. Shows what changed

**Requirements:**
- PSA must be a git repository
- Git remote must be configured (optional but recommended)

**Example:**
```bash
psa update-self
```

**Troubleshooting:**
- If PSA is not a git repo: See "Setting Up Git Remote" below
- If no remote configured: Updates skip GitHub pull (local only)
- If stash conflicts: Manually resolve conflicts in ~/.psa/

---

### **psa sync-to-project**

**Environment:** Terminal
**Purpose:** Sync PSA protocols and commands to a project

**What it does:**
1. Checks if project has PSA initialized (CLAUDE.md or AGENTS.md exists)
2. Syncs protocols from ~/.psa/protocols/ to ./docs/protocols/
3. Syncs slash commands from ~/.psa/examples/commands/ to ./.claude/commands/
4. Backs up any files that differ (saves as *.backup)
5. Updates CLAUDE.md environment context (via `psa context --update`)
6. Shows git diff of changes

**Preserves customizations:**
- ✅ Custom sections in CLAUDE.md and AGENTS.md
- ✅ Project-specific slash commands (launch-dev, etc.)
- ✅ Modified protocols (creates .backup files)

**Example:**
```bash
# Sync to current project
cd ~/projects/my-app
psa sync-to-project

# Sync to specific project
psa sync-to-project ~/projects/other-app
```

**What gets synced:**
- `~/.psa/protocols/*.md` → `./docs/protocols/*.md`
- `~/.psa/examples/commands/psa*.md` → `./.claude/commands/psa*.md`
- Environment context in CLAUDE.md

**What DOESN'T get synced:**
- Project-specific commands (launch-dev.md, warp-windows.md, etc.)
- Custom sections in CLAUDE.md/AGENTS.md
- .env files, secrets, or local configurations

---

### **psa sync-all-projects**

**Environment:** Terminal
**Purpose:** Sync PSA updates to all tracked projects

**What it does:**
1. Reads project registry (~/.psa/data/projects-registry.json)
2. Runs `psa sync-to-project` for each non-archived project
3. Skips archived projects automatically
4. Shows summary report (synced, skipped, errors)
5. Creates error log at /tmp/psa-sync-errors.log if issues occur

**Example:**
```bash
psa sync-all-projects
```

**Output:**
```
Found 15 project(s) in registry

Sync PSA updates to all projects? (y/N) y

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
o_bot (/Users/me/projects/o_bot)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📄 Syncing Protocols
  ✓ PACKAGE-MANAGER-v1.0.md
  ✓ MVC-METHOD-v1.0.md
  ...

🤖 Syncing Claude Code Slash Commands
  ✓ psa-help.md (new)
  ⚠  psa-shortcuts.md (differs - backed up)
  ...

✅ Sync complete!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Summary
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  ✓ Synced:  14
  ⏭ Skipped: 1
  ✗ Errors:  0
```

---

## 🔒 Customization Preservation

### **How PSA Preserves Customizations**

#### **Protocols**
- If protocol file is identical: Overwrites (no backup needed)
- If protocol file differs: Creates `.backup` file before overwriting
- Manual merge required if you customized protocols

#### **Slash Commands**
- PSA commands (`psa*.md`): Updated automatically
- Project commands (`launch-dev.md`, etc.): Never touched
- Modified PSA commands: Backed up as `*.backup` before update

#### **CLAUDE.md & AGENTS.md**
- Only environment context section is updated
- All custom sections are preserved
- Uses `psa context --update` which intelligently merges

#### **Example:**
```markdown
# CLAUDE.md (before sync)

## My Custom Project Rules
- Custom rule 1
- Custom rule 2

## Current Environment Context  ← PSA updates THIS section
...

## More Custom Stuff
- Custom thing 3
```

After sync, "My Custom Project Rules" and "More Custom Stuff" remain intact.

---

## 🚀 Setting Up Git Remote

If PSA is not tracking a GitHub repository:

```bash
cd ~/.psa

# Initialize git (if not already done)
git init
git add .
git commit -m "Initial PSA setup"

# Add GitHub remote (replace with your repo)
git remote add origin https://github.com/yourusername/psa.git

# Push to GitHub
git branch -M main
git push -u origin main
```

Once remote is configured, `psa update-self` will pull updates from GitHub.

---

## 🧪 Testing Updates

### **Before Syncing to All Projects:**

1. Test on a single project first:
   ```bash
   cd ~/projects/test-project
   psa sync-to-project
   git diff  # Review changes
   ```

2. Verify new commands work:
   ```bash
   /psa-help         # In Claude Code
   /psa-shortcuts    # In Claude Code
   psa dash          # In terminal
   ```

3. Check for conflicts:
   ```bash
   ls .claude/commands/*.backup  # Any backup files?
   ```

4. If satisfied, sync to all projects:
   ```bash
   psa sync-all-projects
   ```

---

## 🔍 Command Consistency

All PSA commands use consistent naming:

### **Terminal Commands:**
```
psa <command>           # Single word command
psa <command>-<word>    # Hyphenated command
```

Examples:
- ✅ `psa dash`
- ✅ `psa sync-to-project`
- ✅ `psa update-self`
- ❌ `psa_dash` (no underscores)
- ❌ `psa syncToProject` (no camelCase)

### **Claude Code Commands:**
```
/psa-<command>          # Always prefixed with psa-
```

Examples:
- ✅ `/psa-help`
- ✅ `/psa-shortcuts`
- ✅ `/psa-report`
- ❌ `/psaHelp` (no camelCase)
- ❌ `/psa_help` (no underscores)

### **Exception: Non-PSA Commands**
```
/init-new-project       # Not PSA-specific
/launch-dev             # Project-specific
/warp-windows           # Warp-specific
```

---

## ⚠️  Important Notes

### **npm is Blocked**
- npm commands are blocked system-wide (redirect to pnpm)
- `init-project.sh` no longer suggests npm
- All templates use Bun, pnpm, Python, Go, or Rust

### **Git Required**
- `psa update-self` requires PSA to be a git repository
- Projects should use git to track PSA sync changes
- Use git diff to review before committing

### **Backwards Compatibility**
- Old command aliases still work (e.g., `psa report` = `psa report-terminal`)
- Existing projects won't break from sync
- Backup files created for safety

---

## 📝 Troubleshooting

### **"PSA is not a git repository"**
```bash
cd ~/.psa
git init
git add .
git commit -m "Initialize PSA"
```

### **"No project registry found"**
```bash
# Scan projects to create registry
psa scan-projects
```

### **Sync conflicts in CLAUDE.md**
```bash
# View conflicts
git diff CLAUDE.md

# Keep your version
git checkout --ours CLAUDE.md

# Keep PSA version
git checkout --theirs CLAUDE.md

# Or manually merge
code CLAUDE.md
```

### **Command not found after sync**
```bash
# Verify slash commands are in place
ls ~/.claude/commands/psa*.md

# Restart Claude Code to reload commands
```

---

## 🎯 Best Practices

1. **Always review before committing:**
   ```bash
   git diff
   git status
   ```

2. **Test new commands after sync:**
   - `/psa-help` in Claude Code
   - `psa help` in terminal

3. **Keep PSA updated regularly:**
   ```bash
   # Weekly or monthly
   psa update-self
   psa sync-all-projects
   ```

4. **Backup before major updates:**
   ```bash
   cp ~/.psa ~/.psa.backup -r
   ```

5. **Document project-specific customizations:**
   - Add comments in CLAUDE.md
   - Use git commits to track changes
   - Keep README updated

---

## 📚 Related Commands

```bash
psa help                    # Show all PSA commands
psa dash                    # View all projects
psa context --update        # Update environment context
psa check-updates           # Check for package updates
/psa-help                   # Claude Code help
/psa-shortcuts              # Comprehensive shortcuts
```

---

**Last Updated:** 2025-11-22
**PSA Version:** 1.1.0+
