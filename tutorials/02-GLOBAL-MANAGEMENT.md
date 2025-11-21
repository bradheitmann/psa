# Tutorial 2: Global Project Management

**Level:** Intermediate
**Time:** 10 minutes
**Prerequisites:** [Tutorial 1: Getting Started](01-GETTING-STARTED.md)

---

## What You'll Learn

- Manage multiple projects globally
- Navigate between projects
- Compare project metrics
- Use advanced dashboard features
- Configure project directories

---

## Global-Level User Flow

### Scenario: You're a developer with 5 active projects

```bash
~/projects/
  ├── personal-website/      (HTML/CSS)
  ├── flask-api/             (Python)
  ├── react-dashboard/       (JavaScript)
  ├── rust-cli/              (Rust)
  └── mobile-app/            (React Native)

~/work/
  ├── company-api/           (Go)
  └── microservice-auth/     (Node.js)
```

**Goal:** See all 7 projects in one dashboard with health metrics.

---

## Step 1: Configure Project Directories

Tell PSA where your projects live:

```bash
psa:config:edit
```

Update `projectDirs`:
```json
{
  "projectDirs": [
    "~/projects",
    "~/work",
    "~/open-source"
  ]
}
```

**Save and close.**

---

## Step 2: Scan All Projects

```bash
psa scan
```

**Output:**
```
🔍 Scanning projects...
  Found: personal-website
  Found: flask-api
  Found: react-dashboard
  Found: rust-cli
  Found: mobile-app
  Found: company-api
  Found: microservice-auth
✅ Registry created: ~/.psa/data/projects-registry.json
   Found 7 projects
```

**Behind the scenes:**
- PSA searches all `projectDirs` for `.git` repositories
- Creates entries in global registry
- Reads `PROJECT.json` if exists (otherwise creates minimal entry)

---

## Step 3: View Global Dashboard

```bash
psa
```

**You'll see:**

```
╔══════════════════════════════════════════════════════════╗
║                  PSA DASHBOARD                            ║
╚══════════════════════════════════════════════════════════╝

  PROJECT OVERVIEW

┌──────────────────────┐ ┌──────────────────────┐ ┌──────────────────────┐
│   Total Projects  7  │ │   Active         5  │ │   Lines of Code 45K │
└──────────────────────┘ └──────────────────────┘ └──────────────────────┘

  PROJECT STATUS

  Active      ████████████████░░░░  71%
  Paused      ████░░░░░░░░░░░░░░░░  14%
  Complete    ███░░░░░░░░░░░░░░░░░  14%

  RECENT ACTIVITY

  Last 12 days: ▁▃▄▅▇█▇▅▄▃▂▁
```

**Press Enter to see project list...**

---

## Step 4: Interactive Project List

**With fzf (if installed):**

Press Enter, you'll see:
```
> personal-website | active | 100% | 1.2K | web
  flask-api | active | 65% | 8.5K | web-app
  react-dashboard | active | 80% | 12K | web-app
  rust-cli | paused | 40% | 3.2K | cli-tool
  mobile-app | active | 50% | 15K | mobile
  company-api | active | 90% | 22K | web-app
  microservice-auth | complete | 100% | 5.5K | service

  7/7 ────────────────────────────────
> _
```

**Type to fuzzy search:**
- Type `fl` → highlights `flask-api`
- Type `rust` → highlights `rust-cli`
- Arrow keys to navigate
- Enter to select

**Live preview pane shows:**
- Full PROJECT.json
- Syntax-highlighted (via bat)
- Real-time filtering

---

## Step 5: Compare Projects

**Quick comparison table:**

```bash
psa list
```

**Output:**
```
┌─────────────────────┬──────────┬──────────┬─────────┬──────────┐
│ Name                │ Status   │ Progress │ LOC     │ Type     │
├─────────────────────┼──────────┼──────────┼─────────┼──────────┤
│ company-api         │ ● ACTIVE │ 90%      │ 22K     │ web-app  │
│ react-dashboard     │ ● ACTIVE │ 80%      │ 12K     │ web-app  │
│ flask-api           │ ● ACTIVE │ 65%      │ 8.5K    │ web-app  │
│ mobile-app          │ ● ACTIVE │ 50%      │ 15K     │ mobile   │
│ rust-cli            │ ⏸ PAUSED │ 40%      │ 3.2K    │ cli-tool │
│ microservice-auth   │ ✓ DONE   │ 100%     │ 5.5K    │ service  │
│ personal-website    │ ✓ DONE   │ 100%     │ 1.2K    │ web      │
└─────────────────────┴──────────┴──────────┴─────────┴──────────┘
```

**Sort by:**
- Status (active first)
- Progress (highest first)
- LOC (largest first)

---

## Step 6: Quick Status Checks

Check any project without opening full dashboard:

```bash
psa:status flask-api
```

**Output:**
```
📦 flask-api
   Status:   active
   Progress: 65%
   LOC:      8500
   Coverage: 78%
```

**Use case:** Quick health check in scripts or CI/CD.

---

## Step 7: Open Project in Editor

Jump straight to any project:

```bash
psa:open flask-api
```

**What happens:**
1. PSA looks up project path from registry
2. Changes directory: `cd ~/projects/flask-api`
3. Opens in editor: `code .` (or your configured editor)

**Configure default editor:**
```json
{
  "defaultEditor": "vim"  // or "code", "sublime", etc.
}
```

---

## Step 8: Navigate with Keyboard

**Global dashboard hotkeys:**

| Key | Action |
|-----|--------|
| `Enter` | Open project list |
| `1-7` | Quick actions |
| `q` | Quit |
| `r` | Refresh |
| `h` | Help |

**Project list (fzf):**
| Key | Action |
|-----|--------|
| `↑↓` | Navigate |
| `Enter` | Select project |
| `Esc` | Back to overview |
| Type | Fuzzy search |

---

## Step 9: Update Project Status

As projects evolve, update their status:

```bash
cd ~/projects/rust-cli

# Edit PROJECT.json
{
  "meta": {
    "status": "active",  // Changed from "paused"
    "updated": "2024-11-21T..."
  },
  "progress": {
    "percentComplete": 60  // Was 40%
  }
}

# Sync to global registry
psa:sync
```

**View changes:**
```bash
psa list
# rust-cli now shows: ● ACTIVE  60%
```

---

## Step 10: Archive Completed Projects

```bash
# Edit completed project
cd ~/projects/microservice-auth

vim PROJECT.json
# Change: "status": "archived"

psa:sync
```

**Archived projects:**
- Still show in `psa list` (greyed out)
- Don't count toward "active" metrics
- Can be filtered/hidden in dashboard

---

## Advanced: Multi-Workspace Support

**Scenario:** Separate personal vs. work projects

### Option 1: Multiple Registries

```bash
# Personal projects
PSA_DATA=~/.psa/personal psa scan --dirs ~/projects

# Work projects
PSA_DATA=~/.psa/work psa scan --dirs ~/work

# View separate dashboards
PSA_DATA=~/.psa/personal psa
PSA_DATA=~/.psa/work psa
```

### Option 2: Filtered Views (Coming Soon)

```bash
psa --filter work      # Only work projects
psa --filter personal  # Only personal projects
psa --filter active    # Only active projects
```

---

## Global Metrics

### Total Overview

```bash
psa
```

**Aggregate metrics:**
- Total projects: 7
- Total LOC: 67,400
- Average completion: 76%
- Active projects: 5
- Total git commits (last month): 342

### Per-Project Breakdown

Use `psa list` to see individual metrics side-by-side.

### Trends (Coming Soon)

```bash
psa:analyze:velocity
```

Shows:
- LOC growth over time
- Completion rates
- Most active projects

---

## Tips & Tricks

### 1. Quick Project Jump

Add shell function:
```bash
# ~/.zshrc
pj() {
  local project=$(jq -r '.projects[].name' ~/.psa/data/projects-registry.json | fzf)
  local path=$(jq -r ".projects[] | select(.name==\"$project\") | .path" ~/.psa/data/projects-registry.json)
  cd "$path"
}

# Usage
pj  # Fuzzy search, select, jump
```

### 2. Auto-Scan on Shell Startup

```bash
# ~/.zshrc
if command -v psa &> /dev/null; then
  # Scan once per day
  if [ ! -f ~/.psa/.scan-today ] || [ "$(date +%Y-%m-%d)" != "$(cat ~/.psa/.scan-today)" ]; then
    psa scan > /dev/null 2>&1
    date +%Y-%m-%d > ~/.psa/.scan-today
  fi
fi
```

### 3. Project Status in Prompt

```bash
# Use with starship
# ~/.config/starship.toml
[custom.psa]
command = "psa:status $(basename $PWD) 2>/dev/null | grep Progress | awk '{print $2}'"
when = "[ -f PROJECT.json ]"
```

Shows: `[65%]` in prompt when in PSA-tracked project.

---

## Real-World Workflow

### Morning Routine

```bash
# Start day
psa

# See all projects at a glance
# - Which need attention? (low progress)
# - Which had recent activity? (sparkline)
# - Any blockers? (paused status)

# Jump to highest priority
psa:open flask-api

# Work, commit, repeat
```

### Weekly Review

```bash
# Check all project health
psa list | grep "ACTIVE"

# See progress this week
psa:analyze:velocity

# Update any stale statuses
cd ~/projects/xyz
vim PROJECT.json  # Update progress
psa:sync
```

---

## Next Steps

✅ **You've learned:**
- [x] Configure project directories
- [x] Scan multiple projects
- [x] Navigate global dashboard
- [x] Compare projects
- [x] Quick status checks
- [x] Multi-workspace support

📚 **Continue to:**
- **Tutorial 3:** [Metrics & Tracking](03-METRICS-TRACKING.md)
- **Tutorial 4:** [Claude Code Integration](04-CLAUDE-CODE.md)

---

## Summary

PSA shines when managing **multiple projects**:
- One command (`psa`) to see everything
- Fuzzy search to jump anywhere
- Status at a glance
- No context switching needed

**The more projects you have, the more valuable PSA becomes.**

---

[← Back to Tutorial 1](01-GETTING-STARTED.md) | [Continue to Tutorial 3 →](03-METRICS-TRACKING.md)
