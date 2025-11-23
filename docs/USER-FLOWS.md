# PSA User Flows

Complete guide to project-level and global-level workflows.

---

## Table of Contents

1. [Project-Level Flows](#project-level-flows)
2. [Global-Level Flows](#global-level-flows)
3. [Visual Flow Diagrams](#visual-flow-diagrams)
4. [Common Patterns](#common-patterns)

---

## Project-Level Flows

Workflows focused on a **single project**.

### Flow 1: New Project Setup

**Goal:** Initialize PSA tracking for a new project

```
Start → Navigate to project → Initialize PSA → Configure → Scan → Done
```

**Commands:**
```bash
# 1. Navigate
cd ~/projects/my-new-app

# 2. Initialize
psa:init my-new-app

# 3. Configure (edit PROJECT.json)
{
  "name": "my-new-app",
  "type": "web-app",
  "progress": 0
}

# 4. Scan
psa scan

# 5. Verify
psa show my-new-app
```

**Time:** ~2 minutes

---

### Flow 2: Daily Development

**Goal:** Track progress during active development

```
Morning Check → Code → Test → Commit → Update Progress → Evening Review
```

**Commands:**
```bash
# Morning
psa:status my-app        # Quick check

# During development
# ... code, test, commit ...

# Update progress (after milestone)
vim PROJECT.json         # Bump progress: 65% → 70%

# Evening
psa show my-app          # See today's metrics
psa:sync                 # Update global registry
```

**Frequency:** Daily

---

### Flow 3: Feature Completion

**Goal:** Document completed work with evidence

```
Complete Feature → Create Evidence → Run Gates → Document → Sync
```

**Commands:**
```bash
# 1. Create evidence structure
psa:evidence feature-user-auth

# 2. Document in Summary.md
docs/evidence/feature-user-auth/Summary.md

# 3. Run automated gates
./scripts/verify-gates.js > docs/evidence/feature-user-auth/gates.json

# 4. Update PROJECT.json
{
  "progress": {
    "percentComplete": 80,  # +15%
    "milestones": {
      "completed": 8  # +1
    }
  }
}

# 5. Sync
psa:sync
```

**Frequency:** Per feature/milestone

---

### Flow 4: Team Handoff (PM → Dev)

**Goal:** Create formal task brief for dev team

```
PM Planning → Create Handoff → Dev Accepts → Dev Executes → Submit Evidence
```

**Commands:**
```bash
# PM creates task
psa:pm:handoff task-payment-integration

# Generates: docs/dev/DEV_HANDOFF_task-payment-integration.md
# PM fills in requirements, gates, acceptance criteria

# Dev reads brief
cat docs/dev/DEV_HANDOFF_task-payment-integration.md

# Dev executes
# ... implements feature ...

# Dev submits evidence
psa:evidence task-payment-integration
# Fills in Summary.md, gates.json

# PM reviews evidence
psa show my-app  # Check updated metrics
```

**Frequency:** Per task assignment

---

### Flow 5: Pre-Deployment Check

**Goal:** Verify project health before deploying

```
Check Status → Review Metrics → Run Tests → Verify Gates → Deploy
```

**Commands:**
```bash
# 1. Status check
psa:status my-app

# 2. Full review
psa show my-app
# Check:
# - Progress: 100%?
# - Coverage: >80%?
# - Recent commits: Clean?
# - No blockers?

# 3. Run tests
npm test  # or pytest, cargo test, etc.

# 4. Verify gates
./scripts/verify-gates.js

# 5. If all pass → deploy
# If not → fix issues, repeat
```

**Frequency:** Before each deployment

---

## Global-Level Flows

Workflows spanning **multiple projects**.

### Flow 1: Morning Overview

**Goal:** See health of all projects at start of day

```
Open Dashboard → Review Overview → Select Priority Project → Work
```

**Commands:**
```bash
# 1. Open dashboard
psa

# Shows:
# - Total projects: 7
# - Active: 5
# - Total LOC: 67K
# - Recent activity sparkline

# 2. Press Enter for project list

# 3. Fuzzy search for project needing attention
# Type "api" → selects flask-api

# 4. View details
# Shows: 65% complete, coverage 78%

# 5. Jump to project
psa:open flask-api
```

**Time:** 30 seconds to see everything

**Frequency:** Daily (morning routine)

---

### Flow 2: Weekly Review

**Goal:** Review progress across all projects

```
Generate Report → Analyze Velocity → Identify Blockers → Plan Week
```

**Commands:**
```bash
# 1. View all projects
psa list

# 2. Check velocity (coming soon)
psa:analyze:velocity

# Shows:
# - Stories completed: 12
# - Avg story duration: 3.5 days
# - Trend: ▲ improving

# 3. Identify stalled projects
psa list | grep "PAUSED"

# 4. Review each
for project in stalled_projects; do
  psa show $project
  # Decide: resume, archive, or continue pausing
done
```

**Frequency:** Weekly

---

### Flow 3: Resource Allocation (Team Lead)

**Goal:** Decide which projects need attention

```
View Dashboard → Sort by Progress → Identify Low Progress → Allocate Resources
```

**Commands:**
```bash
# 1. View all
psa

# 2. List sorted
psa list

# Output:
# project-a  ● ACTIVE  95%  22K
# project-b  ● ACTIVE  85%  18K
# project-c  ● ACTIVE  45%  12K  ⚠️ Needs attention
# project-d  ⏸ PAUSED  30%  8K   ⚠️ Blocked

# 3. Check low-progress projects
psa show project-c
psa show project-d

# 4. Decision:
# - project-c: Assign more devs
# - project-d: Unblock dependencies first
```

**Frequency:** Weekly/Sprint planning

---

### Flow 4: Cross-Project Metrics

**Goal:** Compare efficiency across projects

```
Open Dashboard → View Metrics → Compare → Identify Patterns
```

**Commands:**
```bash
# 1. Token usage across projects (Claude Code)
psa:analyze:tokens

# Output:
# ┌─────────────────┬───────────┬────────────┐
# │ Project         │ Tokens    │ Efficiency │
# ├─────────────────┼───────────┼────────────┤
# │ flask-api       │ 8.5M      │ 680 T/L    │
# │ react-dashboard │ 5.2M      │ 520 T/L    │ ⭐ Best
# │ rust-cli        │ 2.1M      │ 850 T/L    │
# └─────────────────┴───────────┴────────────┘

# 2. Cost analysis
psa:analyze:costs

# Shows:
# - Total: $1,200
# - Most expensive: flask-api ($850)
# - Most efficient: react-dashboard ($420)

# 3. Insight:
# React project is most token-efficient
# Apply learnings to other projects
```

**Frequency:** Monthly/Quarterly

---

### Flow 5: Project Portfolio Management

**Goal:** Maintain healthy project portfolio

```
Review All → Archive Complete → Resume Paused → Start New → Balance Load
```

**Commands:**
```bash
# 1. Current state
psa

# Shows:
# Active: 8 projects
# Avg progress: 62%
# Total LOC: 85K

# 2. Archive completed
cd ~/projects/old-project
vim PROJECT.json  # status: "archived"
psa:sync

# 3. Resume paused project
cd ~/projects/paused-project
vim PROJECT.json  # status: "active"
psa:sync

# 4. Start new project
mkdir ~/projects/new-project
cd ~/projects/new-project
psa:init new-project

# 5. Check balance
psa list

# Ensure:
# - Not too many active (context switching)
# - Progress distributed evenly
# - Clear priorities
```

**Frequency:** Monthly

---

### Flow 6: Onboarding New Team Member

**Goal:** Share project portfolio with new developer

```
Export Registry → Share → New Dev Installs → Scans → Syncs
```

**Commands:**
```bash
# Team lead exports
cp ~/.psa/data/projects-registry.json team-projects.json

# Sanitize (remove personal paths if needed)
# Share team-projects.json

# New dev:
# 1. Install PSA
brew install psa

# 2. Import team registry (optional)
cp team-projects.json ~/.psa/data/projects-registry.json

# 3. Or scan from scratch
psa scan --dirs ~/work

# 4. View team projects
psa
```

**Frequency:** Per new team member

---

## Visual Flow Diagrams

### Project-Level Flow (ASCII)

```
┌─────────────────────────────────────────────────────────┐
│              PROJECT-LEVEL WORKFLOW                      │
└─────────────────────────────────────────────────────────┘

   Start Day
       │
       ▼
   ┌────────────────┐
   │ psa:status     │  Quick check
   │  my-project    │
   └────────┬───────┘
            │
            ▼
   ┌────────────────┐
   │ psa:open       │  Jump to project
   │  my-project    │
   └────────┬───────┘
            │
            ▼
   ┌────────────────┐
   │ Code, test,    │  Active development
   │ commit         │
   └────────┬───────┘
            │
            ▼
   ┌────────────────┐
   │ Update         │  Track progress
   │ PROJECT.json   │
   └────────┬───────┘
            │
            ▼
   ┌────────────────┐
   │ psa:sync       │  Update global
   └────────┬───────┘
            │
            ▼
   ┌────────────────┐
   │ psa show       │  Review progress
   │  my-project    │
   └────────────────┘
```

---

### Global-Level Flow (ASCII)

```
┌─────────────────────────────────────────────────────────┐
│               GLOBAL-LEVEL WORKFLOW                      │
└─────────────────────────────────────────────────────────┘

   Start Day
       │
       ▼
   ┌────────────────┐
   │ psa            │  View all projects
   └────────┬───────┘
            │
            ▼
   ┌────────────────┐
   │ Dashboard      │  • 7 projects
   │ Overview       │  • 5 active
   │                │  • 67K LOC
   └────────┬───────┘
            │
            ▼
   ┌────────────────┐
   │ Press Enter    │  Open project list
   └────────┬───────┘
            │
            ▼
   ┌────────────────┐
   │ fzf Search     │  Type project name
   │ "flask"        │  → flask-api
   └────────┬───────┘
            │
            ▼
   ┌────────────────┐
   │ Project Detail │  65% complete
   │ View           │  8.5K LOC
   │                │  78% coverage
   └────────┬───────┘
            │
            ▼
   ┌────────────────┐
   │ Select Action  │  1. Open in editor
   │                │  2. Browse files
   │                │  3. Git status
   └────────┬───────┘
            │
            ▼
   ┌────────────────┐
   │ Jump to        │  Opens VS Code
   │ Project        │  at project root
   └────────────────┘
```

---

## Common Patterns

### Pattern 1: The 10-Second Health Check

```bash
psa list | head -5
```

**See immediately:**
- Which projects are active
- Progress percentages
- Health indicators

**Use when:** Quick check between meetings

---

### Pattern 2: The Deep Dive

```bash
psa show <project>
# Select option 4: View recent commits
# See what changed in last week
```

**Use when:** Need to understand project state before working on it

---

### Pattern 3: The Multi-Project Sweep

```bash
# Check all active projects
for project in $(psa list | grep ACTIVE | awk '{print $1}'); do
  echo "Checking $project..."
  psa:status $project
done
```

**Use when:** Weekly review or team sync

---

### Pattern 4: The Priority Sort

```bash
# Projects by progress (lowest first = needs attention)
psa list | sort -k3 -n
```

**Use when:** Deciding what to work on next

---

## Time Investment vs. Value

| Task | Time | Value | Frequency |
|------|------|-------|-----------|
| `psa` (quick look) | 10 sec | High | Multiple times daily |
| `psa list` | 5 sec | High | Daily |
| `psa show <project>` | 30 sec | High | Before starting work |
| `psa:init` | 2 min | High | Once per project |
| `psa scan` | 10 sec | Medium | Weekly or after adding projects |
| `psa:sync` | 5 sec | Medium | After updates |
| `psa:evidence` | 5-15 min | High | Per milestone |

**ROI:**
- Setup: ~10 min total
- Daily use: ~2 min
- Value: Instant visibility into all projects

---

## Decision Trees

### "Which Command Should I Use?"

```
Need to...
│
├─ See ALL projects?
│  └─ psa
│
├─ See ONE project?
│  └─ psa show <name>
│
├─ Quick status check?
│  └─ psa:status <name>
│
├─ Jump to project?
│  └─ psa:open <name>
│
├─ Initialize new project?
│  └─ psa:init <name>
│
├─ Update project info?
│  ├─ Edit PROJECT.json
│  └─ psa:sync
│
└─ Document milestone?
   └─ psa:evidence <milestone>
```

---

### "When Should I Sync?"

```
When to run psa:sync
│
├─ After editing PROJECT.json
│  └─ YES, sync immediately
│
├─ After adding new project
│  └─ YES, or use psa scan
│
├─ After daily commits?
│  └─ Optional (can use git hook)
│
├─ Before viewing dashboard?
│  └─ NO, dashboard auto-refreshes
│
└─ Before weekly review?
   └─ YES, get latest data
```

---

## Integration Workflows

### With Git

```bash
# In .git/hooks/post-commit
#!/bin/bash
psa:metrics $(basename $(git rev-parse --show-toplevel))
psa:sync
```

**Benefit:** Auto-update metrics after every commit

---

### With CI/CD

```yaml
# .github/workflows/metrics.yml
name: Update PSA Metrics

on:
  push:
    branches: [main]

jobs:
  metrics:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Update metrics
        run: |
          # Calculate LOC, coverage, etc.
          # Update PROJECT-METRICS.json
          git commit -am "chore: update metrics"
          git push
```

**Benefit:** Always-current metrics

---

### With VS Code

**tasks.json:**
```json
{
  "tasks": [
    {
      "label": "PSA: View Project",
      "type": "shell",
      "command": "psa show ${workspaceFolderBasename}",
      "presentation": {
        "reveal": "always",
        "panel": "new"
      }
    }
  ]
}
```

**Keyboard shortcut:** `Cmd+Shift+P` → "PSA: View Project"

---

## Real-World Scenarios

### Scenario 1: Solo Developer with Side Projects

**Setup:**
- 3 active projects
- Work on different ones each day
- Want to remember where you left off

**Workflow:**
```bash
# Monday morning
psa

# See:
# - blog: 80% complete
# - cli-tool: 40% complete
# - website: 95% complete

# Decision: Finish website (close to done)
psa:open website

# End of day
# website: 100% complete!
```

---

### Scenario 2: Team Lead with Microservices

**Setup:**
- 6 microservices
- 3 developers
- Need to monitor all services

**Workflow:**
```bash
# Daily standup
psa list

# Quick overview:
# api-gateway:   85% ● ACTIVE
# auth-service:  92% ● ACTIVE
# payment:       45% ⚠️  Blocked
# notif:         78% ● ACTIVE
# analytics:     30% ⏸ PAUSED
# search:        88% ● ACTIVE

# Action: Investigate payment service
psa show payment
# See: No commits in 3 days, coverage dropped

# Decision: Unblock payment team
```

---

### Scenario 3: Freelancer with Client Projects

**Setup:**
- 5 client projects
- Different billing rates
- Track time/costs

**Workflow:**
```bash
# Add cost tracking to PROJECT-METRICS.json
{
  "custom": {
    "hourlyRate": 150,
    "hoursWorked": 42,
    "totalCost": 6300
  }
}

# Weekly invoice
psa list
# Calculate billable hours across projects

# With Claude Code integration
psa:analyze:costs
# See AI token costs per project
# Factor into client billing
```

---

## Tips for Effective Usage

### 1. **Keep PROJECT.json Current**
- Update progress weekly (minimum)
- Update after milestones
- Keep description accurate

### 2. **Use Status Effectively**
- `active` - Currently working on it
- `paused` - Temporarily blocked/on hold
- `complete` - Done, may need maintenance
- `archived` - Fully done, no more changes

### 3. **Track What Matters**
- Don't obsess over exact percentages
- Focus on trends (▲ or ▼)
- Use custom metrics for project-specific KPIs

### 4. **Leverage Interactive Features**
- Use fzf for quick navigation
- Use `psa:open` to jump directly
- Keep dashboard open in dedicated terminal tab

---

## Summary

### Project-Level (Single Project Focus):
1. **New project** → `psa:init`
2. **Daily dev** → `psa:status`, update progress
3. **Feature done** → `psa:evidence`
4. **Team handoff** → `psa:pm:handoff`
5. **Pre-deploy** → Full health check

### Global-Level (All Projects):
1. **Morning** → `psa` (overview)
2. **Weekly** → `psa list`, velocity analysis
3. **Resource allocation** → Sort by progress
4. **Cross-project** → Compare metrics
5. **Portfolio** → Archive/resume/start

### Key Principle:
**PSA adapts to your workflow, not the other way around.**

Use it as much or as little as you want:
- Minimal: Just `psa` for quick checks
- Moderate: Daily status updates
- Full: Complete evidence-based workflow

---

[← Tutorial 2](../tutorials/02-GLOBAL-MANAGEMENT.md) | [Tutorial 4 →](../tutorials/04-CLAUDE-CODE.md)
