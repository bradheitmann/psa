# Upgrade Management Protocol

**Version:** 1.0
**Date:** 2024-11-17
**Status:** Active
**Purpose:** Smart, safe package upgrades without breaking projects

---

## Core Principle

**Stay current with tools, but never break working projects.**

Balance between:
- ✅ Latest features, performance, security
- ⚠️ Project stability and reliability

---

## The Stability vs. Latest Dilemma

### **The Problem:**

1. **LLMs are outdated** - Training data is months/years old
2. **LLMs don't know the date** - Can't determine "latest" versions
3. **Breaking changes** - Major version upgrades can break code
4. **Developer burden** - Manually checking updates is tedious

### **The Solution:**

**Three-Tier Upgrade Strategy** with automated checking + manual control

---

## Three-Tier Upgrade Strategy

###**Tier 1: System Tools (Homebrew)**

**Risk Level:** MEDIUM
**Scope:** git, ripgrep, node, python, etc.

**Strategy:**
- ✅ Check: Weekly
- ⚠️ Upgrade: Manual approval required
- 🧪 Test: Critical tools after upgrading

**Why manual?**
- System tools affect ALL projects
- git version changes can affect hooks/workflows
- Breaking changes impact multiple projects

**Commands:**
```bash
psa check-updates        # See what's outdated
psa upgrade-system       # Upgrade with confirmation
```

---

### **Tier 2: Global CLI Tools (pnpm)**

**Risk Level:** LOW
**Scope:** kilocode, biome, vercel, etc.

**Strategy:**
- ✅ Check: Daily (auto-check on first PSA command)
- ✅ Upgrade: Manual, but safer than system tools
- 🧪 Test: Individual tool after upgrade

**Why safer?**
- Isolated from projects
- Easy to rollback
- Don't affect system

**Commands:**
```bash
psa check-updates        # See what's outdated
psa upgrade-global       # Upgrade with confirmation
```

---

### **Tier 3: Project Dependencies**

**Risk Level:** HIGH
**Scope:** Packages in package.json, requirements.txt, etc.

**Strategy:**
- ⚠️ Check: On-demand only
- 🚫 Upgrade: NEVER automatic
- ✅ Control: Developer decides timing
- 🧪 Test: Full test suite after ANY upgrade

**Why never automatic?**
- Major versions can break builds
- API changes require code updates
- Need dedicated time to fix issues

**Commands:**
```bash
# JavaScript/TypeScript (Bun)
bun outdated             # Check outdated packages
bun update <package>     # Upgrade specific package

# JavaScript/TypeScript (pnpm)
pnpm outdated            # Check outdated packages
pnpm update <package>    # Upgrade specific package

# Python (uv)
uv pip list --outdated   # Check outdated packages
uv pip install --upgrade <package>  # Upgrade specific
```

---

## Semantic Versioning Guide

Understanding what changes mean:

```
Version: MAJOR.MINOR.PATCH
Example: 2.3.5 → ?

2.3.5 → 2.3.6 (PATCH)
✅ Safe: Bug fixes only
✅ Action: Auto-upgrade OK
✅ Risk: Minimal

2.3.5 → 2.4.0 (MINOR)
⚠️  Moderate: New features, backward compatible
⚠️  Action: Review changelog
⚠️  Risk: Low, but check release notes

2.3.5 → 3.0.0 (MAJOR)
🚫 Breaking: API changes, breaking changes
🚫 Action: Read migration guide
🚫 Risk: HIGH, requires code changes
```

---

## PSA Upgrade Commands

### **Check What's Outdated:**
```bash
psa check-updates        # Shows all outdated packages
```

**Output:**
```
📦 PSA Update Check
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Global CLI Tools (pnpm):
  ✨ @kilocode/cli:   0.4.2 → 0.5.0  (minor, safe)
  🔴 vercel:          48.10.2 → 49.0.0 (major, breaking!)
  ✅ biome:           2.3.6 (latest)

System Tools (Homebrew):
  ✨ git:             2.51.2 → 2.52.0 (patch, safe)
  ✅ ripgrep:         15.1.0 (latest)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### **Upgrade Global Tools:**
```bash
psa upgrade-global       # Upgrade all global CLI tools
```

**Process:**
1. Shows outdated packages
2. Asks for confirmation
3. Upgrades all at once
4. Shows updated versions

### **Upgrade System Tools:**
```bash
psa upgrade-system       # Upgrade Homebrew packages
```

**Process:**
1. Updates Homebrew
2. Shows outdated formulas
3. Warns about system-wide impact
4. Asks for confirmation
5. Upgrades all formulas
6. Cleans up old versions

### **Upgrade Everything:**
```bash
psa upgrade-all          # Upgrade global + system
```

**Use with caution!** Full system upgrade.

---

## Daily Auto-Check

**How it works:**

1. **First PSA command each day** triggers check
2. **Runs in background** (non-blocking, ~2 seconds)
3. **Shows notification** if updates available
4. **You decide** when to upgrade

**Example notification:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📦 Updates available!
  3 global tool(s) outdated
  5 system tool(s) outdated
  Run: psa check-updates to see details
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Disable auto-check:**
```bash
# Edit ~/.psa/scripts/psa
# Comment out: daily_update_check "$COMMAND"
```

---

## LLM Context Management

### **The LLM Outdated Problem:**

LLMs don't know:
- ❌ Current date
- ❌ What packages exist now
- ❌ Current versions
- ❌ Recent API changes

### **Solution: Context Command**

```bash
psa context              # Show current environment
psa context --llm        # Format for LLM prompts
psa context --copy       # Copy to clipboard (macOS)
psa context --update     # Update CLAUDE.md
```

### **Usage in Prompts:**

Before asking LLM for help:

```
Hey Claude, here's my current environment:

[Paste output from: psa context --llm]

Now, can you help me with...
```

### **Project-Level Context:**

Every project CLAUDE.md now includes:

```markdown
## Current Environment Context

Last Updated: 2024-11-17

Language Runtimes:
- Node.js: 25.2.0
- Bun: 1.3.2
- Python: 3.14.0

Global Tools:
- @kilocode/cli: 0.4.2
- biome: 2.3.6

⚠️ LLM: Verify packages exist before suggesting!
```

**Update it:**
```bash
cd project
psa context --update     # Updates CLAUDE.md
```

---

## Project-Level Protocol Distribution

### **Problem:**

Agents working on your project don't have access to `~/.psa/protocols/`!

### **Solution:**

**Copy protocols to each project:**

```
project/
├── CLAUDE.md                   # References protocols
└── docs/
    └── protocols/
        ├── PACKAGE-MANAGER.md  # Copied from ~/.psa/
        └── UPGRADE-MANAGEMENT.md  # This file
```

**In CLAUDE.md:**
```markdown
## Protocol References:
All development protocols are in `docs/protocols/`:
- PACKAGE-MANAGER.md - Package management rules
- UPGRADE-MANAGEMENT.md - Upgrade strategies
```

---

## Upgrade Workflow

### **Weekly Routine:**

```bash
# Monday morning
psa check-updates

# Review what's outdated
# Decide if now is a good time

# If yes:
psa upgrade-global       # Safe, isolated tools
psa upgrade-system       # More careful, system-wide

# Test critical tools
git --version
node --version
bun --version
```

### **Before Starting New Feature:**

```bash
# Check if tools are current
psa check-updates

# Upgrade if outdated (so you don't mix feature work with upgrade issues)
psa upgrade-global

# Update project context
cd project
psa context --update
```

### **Before Major Project Work:**

```bash
# DON'T upgrade system tools before deadline!
# Wait until you have time to fix potential issues

# Only upgrade if critical security fix
```

---

## Rollback Strategy

### **Global Tools (pnpm):**

```bash
# Rollback specific package
npx pnpm install -g @kilocode/cli@0.4.2

# Check versions available
npx pnpm view @kilocode/cli versions
```

### **System Tools (Homebrew):**

```bash
# Downgrade to previous version
brew uninstall git
brew install git@2.51

# Or pin version
brew pin git
```

### **Project Dependencies:**

```bash
# Git revert package.json change
git checkout HEAD~1 package.json
bun install

# Or specify version
bun add <package>@<version>
```

---

## Best Practices

### **✅ DO:**

1. **Check regularly** - Run `psa check-updates` weekly
2. **Upgrade global tools freely** - They're isolated
3. **Read changelogs for major versions**
4. **Update CLAUDE.md context** after upgrades
5. **Test after system tool upgrades**
6. **Upgrade project deps deliberately** - Set aside time

### **❌ DON'T:**

1. **Don't auto-upgrade project dependencies**
2. **Don't upgrade system tools before deadlines**
3. **Don't upgrade without reading major version notes**
4. **Don't assume LLMs know latest packages**
5. **Don't mix feature work with upgrade work**

---

## Security Updates

### **Critical Security Fixes:**

If `psa check-updates` shows security advisory:

```
🚨 git: 2.51.2 → 2.52.0 (SECURITY FIX)
```

**Action:**
1. **Upgrade immediately** - Security takes priority
2. **Test critical workflows**
3. **Update all projects** if needed

**Check for security issues:**
```bash
brew audit --only-vulnerable  # Homebrew security check
npx pnpm audit               # npm registry security check
```

---

## Troubleshooting

### **"Updates break my project"**

**Cause:** Project dependencies upgraded accidentally

**Solution:**
- Never run `bun update` or `pnpm update` without checking
- Use version control (git) to rollback
- Pin critical dependencies in package.json

### **"LLM suggested package that doesn't exist"**

**Cause:** LLM training data is outdated

**Solution:**
1. Always verify: `npx pnpm view <package>`
2. Provide LLM with current context: `psa context --copy`
3. Update CLAUDE.md: `psa context --update`

### **"After upgrade, tool doesn't work"**

**Cause:** Breaking changes in major version

**Solution:**
1. Read changelog/migration guide
2. Rollback to previous version
3. Update usage in your scripts
4. Report to PSA: `psa report "<tool>" "Breaking change in v<X>"`

---

## Integration with PSA

This protocol is part of the PSA system:

- **Auto-checks:** Daily background check
- **Commands:** `psa check-updates`, `psa upgrade-*`
- **Context:** `psa context` for LLMs
- **Protocols:** Copied to `docs/protocols/` in projects

**Location:**
- Global: `~/.psa/protocols/UPGRADE-MANAGEMENT-v1.0.md`
- Projects: `docs/protocols/UPGRADE-MANAGEMENT-v1.0.md`

---

## Version History

- **v1.0** (2024-11-17): Initial protocol
  - Three-tier upgrade strategy
  - Daily auto-check system
  - LLM context management
  - Project-level protocol distribution

---

## See Also

- **PACKAGE-MANAGER-v1.0.md** - Package management hierarchy
- **MVC-METHOD.md** - Minimum Viable Context protocol
- **~/.psa/AGENTS_MASTER.md** - Agent loadouts and capabilities
