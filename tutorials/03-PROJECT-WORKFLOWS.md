# Tutorial 3: Project-Level Workflows

**Level:** Intermediate
**Time:** 15 minutes
**Prerequisites:** [Tutorial 1](01-GETTING-STARTED.md), [Tutorial 2](02-GLOBAL-MANAGEMENT.md)

---

## What You'll Learn

- Project-level daily workflows
- Metrics tracking and updates
- Progress management
- Evidence collection (for teams)
- Git integration workflows

---

## Project-Level User Flow

### Scenario: Working on a Single Project (flask-api)

You're actively developing `flask-api` and want to:
- Track development progress
- Monitor code metrics
- Document milestones
- Maintain project health

---

## Workflow 1: Morning Check-in

### Start Your Day

```bash
# Jump to project (using z/zoxide)
z flask-api

# Or traditional cd
cd ~/projects/flask-api

# Quick status check
psa:status flask-api
```

**Output:**
```
📦 flask-api
   Status:   active
   Progress: 65%
   LOC:      8,500
   Coverage: 78%
   Last commit: 2 hours ago
```

**Interpretation:**
- ✅ Project is active
- ✅ 65% complete
- ⚠️  Coverage at 78% (target: 80%+)
- ✅ Recent activity

**Action:** Focus on adding tests today.

---

## Workflow 2: Development Session

### During Active Development

```bash
# Work on features
vim src/new_feature.py

# Run tests
pytest --cov

# Make commits
git add .
git commit -m "feat: add new feature"

# Update project progress
vim PROJECT.json
```

**Update progress as you go:**
```json
{
  "progress": {
    "percentComplete": 70,  // Was 65%
    "currentPhase": "development",
    "milestones": {
      "completed": 7,  // Was 6
      "current": "Add user authentication"
    }
  }
}
```

---

### Auto-Update Metrics (Optional)

Add git hook to auto-update:

```bash
# .git/hooks/post-commit
#!/bin/bash
psa:metrics flask-api
psa:sync
```

**Make executable:**
```bash
chmod +x .git/hooks/post-commit
```

**Now every commit:**
1. Recalculates LOC
2. Updates PROJECT-METRICS.json
3. Syncs to global registry

---

## Workflow 3: End of Day Review

### Check Your Progress

```bash
# View detailed project info
psa show flask-api
```

**You'll see:**
```
  flask-api - Flask REST API

  ● ACTIVE

   Path:    ~/projects/flask-api
   GitHub:  https://github.com/you/flask-api
   Type:    web-app

  PROGRESS
  Completion    ██████████████░░░░░░  70%  ▲ +5%

  METRICS
   Lines of Code:   9,200  ▲ +700
   Test Coverage:   82%    ▲ +4%
   Git Commits:     156    ▲ +8 today
   Last Updated:    2 min ago

  ACTIONS
  ➜ 1. Open in editor
  ➜ 2. Browse files
  ➜ 3. Show git status
  ➜ 4. View recent commits
  ➜ 5. Open GitHub
```

**Quick insights:**
- Added 700 LOC today
- Coverage improved to 82% (above target!)
- 8 commits made
- Progress up from 65% → 70%

---

## Workflow 4: Milestone Completion

### Mark Major Progress

When you complete a significant milestone:

```bash
cd ~/projects/flask-api

# Update PROJECT.json
{
  "progress": {
    "percentComplete": 75,
    "milestones": {
      "total": 10,
      "completed": 8,  // +1
      "current": "Add payment integration"
    }
  },
  "meta": {
    "updated": "2024-11-21T14:30:00Z"
  }
}

# Optional: Create evidence (for teams)
psa:evidence milestone-08-auth

# Sync
psa:sync
```

---

## Workflow 5: Evidence Collection (Teams/Formal Projects)

### When to Create Evidence

- ✅ Major feature completion
- ✅ Milestone reached
- ✅ Sprint end
- ✅ Before deployment
- ✅ For code review

### Create Evidence Bundle

```bash
psa:evidence story-15-user-auth
```

**Creates:**
```
docs/evidence/story-15-user-auth/
├── Summary.md
├── gates.json
├── before/
├── after/
└── manual/
```

### Fill in Summary.md

```markdown
# Evidence Bundle: story-15-user-auth

**Date**: 2024-11-21
**Status**: COMPLETE

## Deliverables
1. User authentication with JWT tokens
2. Password hashing with bcrypt
3. Login/logout endpoints
4. Session management

## Test Coverage
- Coverage: 92% lines / 89% functions
- Command: `pytest --cov`

## Gate Verification
- All 12 gates passed
- See: gates.json

## Manual Testing
- Test log: manual/test-log.md
- Screenshots: after/screenshots/
```

### Automated Gates

Create `scripts/verify-gates.js`:

```javascript
// Check that all requirements are met
const gates = [
  { id: 1, title: "Runtime", check: () => checkServiceStarts() },
  { id: 2, title: "Lint", check: () => runLinter() },
  { id: 3, title: "Tests", check: () => runTests() },
  { id: 4, title: "Coverage", check: () => checkCoverage(80) }
];

// Run and generate gates.json
```

---

## Workflow 6: Git Integration

### View Recent Activity

```bash
psa show flask-api
# Select: "4. View recent commits"
```

**With delta (if installed):**
```
  commit abc123 feat: add auth
  commit def456 fix: validation bug
  commit ghi789 test: add unit tests

  ▼ Showing diffs with syntax highlighting
```

### Project Git Status

```bash
psa show flask-api
# Select: "3. Show git status"
```

**Output:**
```
On branch main
Your branch is ahead of 'origin/main' by 3 commits.

Changes not staged:
  modified: src/auth.py
  modified: tests/test_auth.py

Untracked files:
  docs/api-spec.md
```

---

## Workflow 7: Custom Metrics

### Add Project-Specific Metrics

Edit `PROJECT-METRICS.json`:

```json
{
  "metrics": {
    "codebase": {
      "linesOfCode": 9200,
      "modules": 28,
      "tests": {
        "total": 156,
        "coverage": 82
      }
    },
    "custom": {
      "apiEndpoints": 24,
      "databaseTables": 12,
      "deployments": 15,
      "uptime": 99.8,
      "activeUsers": 1250
    }
  }
}
```

**Display in dashboard:**
Custom metrics show in project detail view!

---

## Workflow 8: Team Handoffs

### PM → Dev Workflow

**PM creates task:**
```bash
psa:pm:handoff task-auth-endpoints
```

Generates `docs/dev/DEV_HANDOFF_task-auth-endpoints.md`:
```markdown
# Dev Handoff: Auth Endpoints

**Task**: Implement authentication endpoints
**Story**: User authentication system
**Status**: READY

## Requirements
- [ ] POST /login endpoint
- [ ] POST /logout endpoint
- [ ] GET /verify endpoint

## Evidence Gates
| Gate | Type | Requirement |
|------|------|-------------|
| 1 | Runtime | Service starts |
| 2 | Lint | No errors |
| 3 | Test | All pass, coverage >80% |
```

**Dev completes and fills evidence.**

---

## Workflow 9: Progress Tracking Over Time

### Track Development Velocity

```bash
# Week 1
psa:status flask-api  # 40% complete

# Week 2
psa:status flask-api  # 55% complete (+15%)

# Week 3
psa:status flask-api  # 70% complete (+15%)
```

**Velocity:** ~15% per week

**Estimate completion:**
```
Remaining: 30%
Velocity: 15%/week
Time to completion: ~2 weeks
```

---

## Workflow 10: Project Completion

### When Project is Done

```bash
cd ~/projects/flask-api

# Update status
{
  "meta": {
    "status": "complete"
  },
  "progress": {
    "percentComplete": 100,
    "currentPhase": "deployed"
  }
}

psa:sync

# View in dashboard
psa list
```

**Output:**
```
flask-api    ✓ COMPLETE    100%    9.2K    web-app
```

**Options:**
- `status: "complete"` - Finished, may get updates
- `status: "archived"` - Fully done, no more changes

---

## Real-World Example: Full Day

```bash
# 9:00 AM - Start day
psa
# See: flask-api at 65%, needs testing

# 9:05 AM - Jump to project
psa:open flask-api

# 9:05 AM - 12:00 PM - Code
# Write features, make commits

# 12:00 PM - Lunch check
psa:status flask-api
# Now at 68%

# 1:00 PM - 5:00 PM - More coding
# Reach milestone, add tests

# 5:00 PM - End of day
psa show flask-api
# Progress: 75%
# Coverage: 85%
# Commits today: 12

# Update PROJECT.json, sync
vim PROJECT.json  # Set 75%
psa:sync

# Check global dashboard
psa
# See progress across all projects
```

---

## Summary

### Project-Level Workflows:
1. ✅ **Morning check-in** - Quick status
2. ✅ **Active development** - Track as you code
3. ✅ **End of day** - Review progress
4. ✅ **Milestone completion** - Document evidence
5. ✅ **Git integration** - View commits/diffs
6. ✅ **Custom metrics** - Track anything
7. ✅ **Team handoffs** - PM/Dev workflows
8. ✅ **Progress tracking** - Velocity analysis
9. ✅ **Completion** - Mark done
10. ✅ **Full day example** - Real workflow

### Key Commands:
```bash
psa:status <project>      # Quick check
psa show <project>        # Full details
psa:open <project>        # Jump & open
psa:evidence <milestone>  # Document work
psa:sync                  # Update global
```

---

## Next Tutorial

**Tutorial 4:** [Claude Code Integration](04-CLAUDE-CODE.md)

Learn to track AI metrics, tokens, and agent efficiency!

---

[← Tutorial 2](02-GLOBAL-MANAGEMENT.md) | [Tutorial 4 →](04-CLAUDE-CODE.md)
