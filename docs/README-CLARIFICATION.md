# PSA Works with ANY Project

## TL;DR
**PSA is a general-purpose project dashboard that works with ANY codebase. Claude Code integration is optional.**

---

## Core Features (No AI Required)

PSA provides beautiful project management for:

- **Any language**: Python, JavaScript, Rust, Go, Java, etc.
- **Any framework**: React, Django, Rails, etc.
- **Any team size**: Solo dev to large teams
- **Any workflow**: With or without AI coding assistants

### What You Get:

```bash
psa                  # Beautiful terminal dashboard
psa list             # All your projects
psa show my-app      # Project details
psa scan             # Auto-discover projects
```

**Metrics Tracked (Universal):**
- Lines of code
- Test coverage %
- File/module counts
- Git activity
- Project completion %
- Custom metrics (anything in PROJECT.json)

**Visual Features:**
- 🎨 Colorful ASCII charts
- 📊 Progress bars
- ⚡ Sparklines (activity trends)
- 🎯 Status badges
- 📈 Metric cards

---

## Claude Code Integration (Optional)

If you use Claude Code, PSA adds:

### Enhanced Metrics:
- Agent session tracking
- Token usage analysis
- Tokens per line efficiency
- Cost estimation
- Agent-specific breakdowns

### Workflow Tools:
- PM review templates
- Dev handoff templates
- Evidence bundles
- Automated gates

### Commands:
```bash
psa:pm:review <story>
psa:dev:handoff <task>
psa:analyze:tokens
psa:analyze:efficiency
```

**How it works:**
PSA reads `.claude/` session files (`.jsonl`) to calculate token metrics.

**If you don't use Claude Code:**
These features are simply hidden/unavailable. Everything else works perfectly.

---

## Example: Non-AI Project

```bash
# Regular Python project
cd ~/projects/my-flask-app

# Initialize PSA
psa:init my-flask-app

# Edit PROJECT.json
{
  "name": "my-flask-app",
  "status": "active",
  "type": "web-app",
  "progress": 60,
  "tech": {
    "languages": ["Python"],
    "frameworks": ["Flask"],
    "packageManager": "pip"
  }
}

# Scan and view
psa scan
psa

# Dashboard shows:
# - Project name & status
# - 60% progress bar
# - LOC count
# - Git commits
# - Test coverage (if you add it)
```

**No .claude/ directory? No problem!**
The dashboard just won't show token metrics.

---

## Example: Mixed Projects

You can have both AI and non-AI projects:

```bash
~/projects/
  ├── ai-chatbot/          # Uses Claude Code
  │   └── .claude/
  ├── website/             # Regular project
  ├── python-library/      # Regular project
  └── mobile-app/          # Uses Cursor AI

psa scan  # Discovers all 4
psa       # Shows unified dashboard

# Projects with .claude/ show token metrics
# Projects without show standard metrics only
```

---

## Why Use PSA Without AI?

1. **Beautiful Visualization**: Better than plain `git log` or `ls`
2. **Multi-Project Overview**: See all projects at once
3. **Metrics Tracking**: LOC, coverage, progress in one place
4. **Terminal Native**: Fast, keyboard-driven, SSH-friendly
5. **Customizable**: Add your own metrics to PROJECT.json
6. **Portable**: Works everywhere, no GUI needed

---

## Comparison

| Feature | Without Claude Code | With Claude Code |
|---------|-------------------|------------------|
| Dashboard | ✅ | ✅ |
| Project list | ✅ | ✅ |
| LOC tracking | ✅ | ✅ |
| Test coverage | ✅ | ✅ |
| Git integration | ✅ | ✅ |
| Progress tracking | ✅ | ✅ |
| Colorful visualizations | ✅ | ✅ |
| Token metrics | ❌ | ✅ |
| Agent efficiency | ❌ | ✅ |
| PM/Dev templates | ✅ (generic) | ✅ (AI-enhanced) |
| Cost estimation | ❌ | ✅ |

---

## Custom Metrics

PSA reads `PROJECT-METRICS.json` - add anything you want:

```json
{
  "metrics": {
    "codebase": {
      "linesOfCode": 5000,
      "modules": 20
    },
    "custom": {
      "deployments": 12,
      "uptime": 99.9,
      "users": 1500
    }
  }
}
```

Display in dashboard with custom visualizations!

---

## Summary

**PSA is for everyone:**
- ✅ Solo developers
- ✅ Teams
- ✅ Open source projects
- ✅ Enterprise codebases
- ✅ Side projects
- ✅ With or without AI

**Claude Code features are a bonus, not a requirement.**
