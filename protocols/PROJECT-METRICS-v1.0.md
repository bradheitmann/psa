# Project Metrics & Data Collection Protocol

**Version:** 1.0
**Date:** 2024-11-21
**Status:** Active
**Purpose:** Standardize project tracking, metrics collection, and dashboard data across all projects

---

## Core Philosophy

**Every project should be auditable, measurable, and comparable through standardized metrics collection.**

All projects collect the same core metrics, enabling:
- Global project dashboard
- Cross-project comparison
- Agent efficiency analysis
- Resource allocation decisions
- Historical trend analysis

---

## Data Collection Framework

### Level 1: Project Metadata (REQUIRED)

Every project MUST have a `PROJECT.json` file in its root:

```json
{
  "meta": {
    "name": "project-name",
    "displayName": "Human-Readable Project Name",
    "description": "Brief project description",
    "status": "active|planning|paused|archived|complete",
    "type": "web-app|cli-tool|library|infrastructure|research",
    "created": "2024-11-01T00:00:00Z",
    "updated": "2024-11-21T00:00:00Z"
  },
  "location": {
    "path": "/Users/user/projects/project-name",
    "github": "https://github.com/user/project-name",
    "pmSession": "path/to/claude-code-session.jsonl"
  },
  "progress": {
    "percentComplete": 65,
    "currentPhase": "development|planning|testing|deployment",
    "milestones": {
      "total": 10,
      "completed": 6,
      "current": "Milestone Name"
    }
  },
  "tech": {
    "languages": ["TypeScript", "Python"],
    "frameworks": ["React", "FastAPI"],
    "runtime": "bun|node|python|rust",
    "packageManager": "bun|pnpm|uv|cargo"
  }
}
```

**Location:** `<project-root>/PROJECT.json`

**Update Frequency:** Every story/milestone completion, or weekly minimum

---

### Level 2: Agent & Development Metrics (REQUIRED)

Track agent activity and code efficiency in `PROJECT-METRICS.json`:

```json
{
  "metrics": {
    "updatedAt": "2024-11-21T00:00:00Z",
    "codebase": {
      "linesOfCode": 12500,
      "files": 145,
      "modules": 28,
      "tests": {
        "total": 342,
        "coverage": 86.5
      }
    },
    "agents": {
      "sessions": 45,
      "totalTokens": 8500000,
      "byAgent": {
        "PM": {
          "sessions": 12,
          "tokens": 1200000,
          "avgPerSession": 100000
        },
        "Dev": {
          "sessions": 28,
          "tokens": 6500000,
          "avgPerSession": 232143
        },
        "QA": {
          "sessions": 5,
          "tokens": 800000,
          "avgPerSession": 160000
        }
      }
    },
    "efficiency": {
      "tokensPerLine": 680,
      "linesPerMillionTokens": 1470,
      "avgSessionTokens": 188889,
      "costEstimate": {
        "total": 850.00,
        "perLine": 0.068,
        "currency": "USD"
      }
    },
    "velocity": {
      "storiesCompleted": 8,
      "avgStoryDuration": "3.5 days",
      "avgLinesPerStory": 1562,
      "avgTokensPerStory": 1062500
    }
  }
}
```

**Location:** `<project-root>/PROJECT-METRICS.json`

**Update Frequency:** After each story/task completion

---

### Level 3: Evidence System (RECOMMENDED)

Based on flo_bot's proven approach:

**Structure:**
```
docs/
├── evidence/
│   ├── story-01-foundation/
│   │   ├── Summary.md           # Human-readable deliverables
│   │   ├── gates.json           # Automated verification results
│   │   ├── before/              # Pre-implementation artifacts
│   │   ├── after/               # Post-implementation artifacts
│   │   └── manual/              # Manual testing logs
│   ├── story-02-feature-x/
│   │   └── ...
```

**Summary.md Format:**
```markdown
1. [Deliverable description with evidence reference]
2. [Coverage metrics: X% lines / Y% functions (test command)]
3. [Gate verification results with JSON reference]
4. [Manual test results with log reference]
5. [Deployment/configuration updates]
```

**gates.json Format:**
```json
{
  "generatedAt": "2024-11-21T00:00:00Z",
  "story": "story-01-foundation",
  "totalGates": 16,
  "passCount": 16,
  "failCount": 0,
  "results": [
    {
      "id": 1,
      "title": "Gate title",
      "description": "What this gate verifies",
      "status": "PASS|FAIL",
      "notes": "Evidence reference or explanation",
      "timestamp": "2024-11-21T00:00:00Z"
    }
  ]
}
```

---

### Level 4: PM Reviews & Dev Handoffs (ADVANCED)

For projects using multi-agent workflows (MVC Protocol):

**PM Review Format** (`docs/pm/PM_REVIEW_<story>.md`):

```markdown
# PM Review: Story X (Feature Name)

**Date**: 2024-11-21
**Reviewer**: Agent/Human Name
**Status**: PLANNING|IN_PROGRESS|REVIEW|COMPLETE

## 1. Current State Analysis
- Completed items list
- Pending items list
- Blockers/risks

## 2. Protocol Adherence Check
- MVC Method compliance
- Slice isolation verification
- Evidence gates status

## 3. Tasking Strategy
### Task N: Task Name
- **Goal**: What this accomplishes
- **Why**: Strategic rationale
- **Risk**: Potential issues
- **Mitigation**: Risk mitigation approach

## 4. Next Steps (Recommendation)
1. Action item 1
2. Action item 2

## 5. Self-Correction Log
- **Error**: What went wrong
- **Correction**: How it was fixed
```

**Dev Handoff Format** (`docs/dev/DEV_HANDOFF_<task>.md`):

```markdown
# Dev Handoff: Task X

**Task**: Task name
**Story**: Parent story reference
**Status**: READY|IN_PROGRESS|BLOCKED|COMPLETE

## Context
[Brief background and why this task exists]

## Requirements
- [ ] Requirement 1
- [ ] Requirement 2

## Evidence Gates
| Gate | Type | Requirement |
|------|------|-------------|
| 1 | Runtime | Service starts without errors |
| 2 | Lint | No linting errors |
| 3 | Test | All tests pass, coverage >80% |
| 4 | Scope | Only specified files modified |

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## Risk & Mitigation
**Risk**: [What could go wrong]
**Mitigation**: [How to prevent/handle it]

## Evidence Bundle Checklist
- [ ] Summary.md created
- [ ] gates.json generated
- [ ] Test coverage report
- [ ] Manual test logs (if applicable)
```

---

## Metrics Calculation

### Automated Collection

Projects should include a metrics script: `scripts/collect-metrics.sh`

```bash
#!/bin/bash
# Collect project metrics

PROJECT_ROOT=$(git rev-parse --show-toplevel)
METRICS_FILE="$PROJECT_ROOT/PROJECT-METRICS.json"

# Count lines of code (excluding tests, node_modules, build)
LOC=$(find . -type f \( -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" -o -name "*.py" \) \
  -not -path "*/node_modules/*" \
  -not -path "*/dist/*" \
  -not -path "*/build/*" \
  -not -path "*/tests/*" \
  -not -path "*/test/*" \
  | xargs wc -l 2>/dev/null | tail -1 | awk '{print $1}')

# Count files
FILES=$(find . -type f \( -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" -o -name "*.py" \) \
  -not -path "*/node_modules/*" \
  -not -path "*/dist/*" \
  -not -path "*/build/*" \
  | wc -l | tr -d ' ')

# Count tests
TESTS=$(find . -type f \( -name "*.test.*" -o -name "*.spec.*" \) | wc -l | tr -d ' ')

# Get test coverage if available
COVERAGE=0
if [ -f "coverage/coverage-summary.json" ]; then
  COVERAGE=$(cat coverage/coverage-summary.json | jq '.total.lines.pct')
fi

# Count Claude Code sessions
SESSIONS=$(find .claude -name "*.jsonl" 2>/dev/null | wc -l | tr -d ' ')

# Calculate total tokens (requires parsing session files)
TOTAL_TOKENS=$(find .claude -name "*.jsonl" 2>/dev/null -exec grep -oh '"input_tokens":[0-9]*' {} \; | awk -F: '{sum+=$2} END {print sum}')

# Generate metrics JSON
cat > "$METRICS_FILE" <<EOF
{
  "metrics": {
    "updatedAt": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
    "codebase": {
      "linesOfCode": $LOC,
      "files": $FILES,
      "tests": {
        "total": $TESTS,
        "coverage": $COVERAGE
      }
    },
    "agents": {
      "sessions": $SESSIONS,
      "totalTokens": $TOTAL_TOKENS
    },
    "efficiency": {
      "tokensPerLine": $(echo "scale=2; $TOTAL_TOKENS / $LOC" | bc),
      "linesPerMillionTokens": $(echo "scale=0; $LOC * 1000000 / $TOTAL_TOKENS" | bc)
    }
  }
}
EOF

echo "✅ Metrics collected: $METRICS_FILE"
```

---

## Dashboard Data Format

The global dashboard reads from `~/.psa/projects-registry.json`:

```json
{
  "lastUpdated": "2024-11-21T00:00:00Z",
  "projects": [
    {
      "name": "slack-bot",
      "displayName": "Slack AI Bot",
      "path": "/Users/user/projects/slack-bot",
      "github": "https://github.com/user/slack-bot",
      "status": "active",
      "type": "web-app",
      "progress": 65,
      "currentPhase": "development",
      "metrics": {
        "loc": 12500,
        "coverage": 86.5,
        "sessions": 45,
        "tokens": 8500000,
        "tokensPerLine": 680,
        "linesPerMillionTokens": 1470
      },
      "lastCommit": "2024-11-21T00:00:00Z",
      "pmSession": ".claude/sessions/latest.jsonl"
    }
  ]
}
```

**Update Strategy:**
- Projects update their local `PROJECT.json` and `PROJECT-METRICS.json`
- Global sync command aggregates into `projects-registry.json`
- Dashboard reads from registry (fast, no project scanning needed)

---

## Integration with PSA

### Commands

```bash
# Initialize project with metrics tracking
psa init <project-name>

# Update project metrics
psa metrics update

# Sync all projects to global registry
psa projects sync

# View global dashboard
projects
# or
psa dashboard

# View single project details
psa project show <name>

# Generate PM review template
psa pm review <story>

# Generate Dev handoff template
psa dev handoff <task>

# Verify evidence bundle
psa verify evidence <story>
```

### Automation

**Git Hooks:**
Projects can install a post-commit hook to auto-update metrics:

```bash
#!/bin/bash
# .git/hooks/post-commit

# Update metrics after each commit
~/psa/scripts/collect-metrics.sh

# Update PROJECT.json timestamp
jq '.meta.updated = now | todate' PROJECT.json > PROJECT.json.tmp
mv PROJECT.json.tmp PROJECT.json
```

**Claude Code Integration:**
Add to project's `CLAUDE.md`:

```markdown
## After Completing Work

1. Update PROJECT.json progress percentage
2. Run `psa metrics update` to collect current metrics
3. Create evidence bundle in `docs/evidence/story-XX/`
4. Generate Summary.md with deliverables
5. Run `psa projects sync` to update global registry
```

---

## Key Metrics Definitions

### Lines of Code (LOC)
- **Definition**: Non-comment, non-blank lines in source files
- **Scope**: Excludes tests, build artifacts, node_modules
- **Purpose**: Measure codebase size and growth

### Tokens Per Line (TPL)
- **Definition**: Total agent tokens / Lines of Code
- **Target**: <1000 tokens/line (lower is better)
- **Purpose**: Measure agent efficiency in code generation

### Lines Per Million Tokens (LPMT)
- **Definition**: (LOC * 1,000,000) / Total Tokens
- **Target**: >1000 lines/million tokens (higher is better)
- **Purpose**: Inverse of TPL, shows code output per token spent

### Session Efficiency
- **Definition**: Average tokens per session
- **Benchmark**:
  - PM: 100K-150K tokens/session
  - Dev: 200K-300K tokens/session
  - QA: 150K-200K tokens/session

### Story Velocity
- **Definition**: Average story completion time
- **Calculation**: Total days / Stories completed
- **Purpose**: Predict project timeline

### Cost Per Line
- **Definition**: (Total tokens * rate per token) / LOC
- **Rate**: ~$0.01 per 1K tokens (Claude Sonnet)
- **Purpose**: Track development cost efficiency

---

## Templates

### PROJECT.json Template

```bash
psa init-project
# Creates PROJECT.json with sensible defaults
```

### Evidence Bundle Template

```bash
psa create-evidence <story-name>
# Creates docs/evidence/<story-name>/ structure
```

### Metrics Collection

```bash
psa metrics collect
# Scans codebase, sessions, generates PROJECT-METRICS.json
```

---

## Migration Guide

### Existing Projects

1. **Create PROJECT.json:**
   ```bash
   cd <project-root>
   psa init-project
   # Edit generated PROJECT.json with actual values
   ```

2. **Add metrics collection:**
   ```bash
   # Copy metrics script
   cp ~/.psa/scripts/collect-metrics.sh scripts/

   # Run initial collection
   ./scripts/collect-metrics.sh
   ```

3. **Sync to global registry:**
   ```bash
   psa projects sync
   ```

4. **Add to CLAUDE.md:**
   ```markdown
   ## Metrics Collection
   After significant changes, run:
   ```bash
   psa metrics update
   psa projects sync
   ```
   ```

### New Projects

```bash
# Initialize with PSA
psa create <project-name> --type web-app --lang typescript

# Sets up:
# - PROJECT.json
# - PROJECT-METRICS.json (initial)
# - scripts/collect-metrics.sh
# - docs/evidence/ structure
# - .git/hooks/post-commit (optional)
# - CLAUDE.md with metrics guidance
```

---

## Dashboard Requirements

The global dashboard should display:

### Overview Screen
- Total projects count
- Active/Paused/Complete breakdown
- Total LOC across all projects
- Total tokens spent
- Average efficiency metrics
- Recent activity timeline

### Project List (Sortable/Filterable)
| Project | Status | Progress | LOC | Coverage | Efficiency | Last Updated |
|---------|--------|----------|-----|----------|------------|--------------|
| web-app | 🟢 Active | 65% | 12.5K | 86% | 1470 L/MT | 2h ago |
| api-service | 🟢 Active | 42% | 8.2K | 74% | 1250 L/MT | 1d ago |

### Project Detail View
- Full PROJECT.json data
- Metrics trends (chart)
- Recent sessions list
- Git activity
- Quick actions (open in editor, open GitHub, view PM session)

### Agent Efficiency View
- Tokens per agent type
- Cost breakdown
- Session statistics
- Comparative efficiency

---

## Version History

- **v1.0** (2024-11-21): Initial project metrics protocol
  - Defined 4-level data collection framework
  - Established standard metrics (LOC, TPL, LPMT, etc.)
  - Created PROJECT.json and PROJECT-METRICS.json schemas
  - Documented evidence system from flo_bot
  - Designed global registry format

---

## See Also

- **MVC-METHOD-v1.0** (Multi-agent coordination)
- **PACKAGE-MANAGER-v1.0** (Package management)
- **~/.psa/AGENTS_MASTER.md** (Agent configurations)
- **~/.psa/projects-registry.json** (Global project index)
