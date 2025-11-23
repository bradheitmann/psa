Display project status with TASKS FIRST, then summary, then team status.

Read docs/PROJECT_STATE.md and current context, then format as beautiful markdown with ASCII box characters.

**Format Requirements (Protocol v2.0):**
1. TASKS come FIRST (most important!)
2. Use ASCII box drawing characters (┌─┐│└┘├┤┬┴┼ ┏━┓┃┗┛)
3. Use tree characters (├─ └─) for task lists
4. Progress bars with █ and ░ characters
5. Emoji indicators (🔵 ⚪ ✅ 🔴 🟢 🟡)

---

# ╔═══════════════════════════════════════════════════════╗
# ║  EXAMPLE PROJECT PLATFORM - PROJECT STATUS           ║
# ╚═══════════════════════════════════════════════════════╝

**📅 Date:** [current timestamp]
**🏗️ Phase:** Week 0 - Planning
**⏱️ Timeline:** 4 weeks (~76 hours)

---

## ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
## ┃  📋 TASK LIST                        ┃
## ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

### 🔵 IN PROGRESS (2)

```
├─ TASK-001 │ Overall Timeline Mgmt       │ PSA   │ ████████░░ 80%
└─ TASK-002 │ Phase 1 Status Tracking     │ PSA   │ ████████░░ 80%
```

---

### ⚪ PENDING - PHASE 1: SECURITY (4 tasks - 18-20h) 🔴 CRITICAL

```
├─ TASK-007 │ Credential Security         │ UNASSIGNED │ 4h   │ 🔴 CVSS 9.8
├─ TASK-008 │ Admin Auth - Clerk          │ UNASSIGNED │ 4h   │ 🔴 CRITICAL
├─ TASK-009 │ Build Quality Checks        │ UNASSIGNED │ 2-4h │ 🟡 HIGH
└─ TASK-010 │ Form Simplification         │ UNASSIGNED │ 8h   │ 🟡 HIGH
```

**⚠️ BLOCKER:** All Phase 1 tasks unassigned. Cannot proceed until agents assigned.

---

### ⚪ PENDING - PHASE 2: PATTERNS & TESTING (6 tasks - 40h)

<details>
<summary>Expand Phase 2 tasks (blocked by Gate 1)</summary>

```
├─ TASK-011 │ State Machine               │ UNASSIGNED │ 4h   │ Blocked: Gate 1
├─ TASK-012 │ Integration Retry Logic     │ UNASSIGNED │ 8h   │ Blocked: Gate 1
├─ TASK-013 │ Zod Validation              │ UNASSIGNED │ 6h   │ Blocked: Gate 1
├─ TASK-014 │ Test Infrastructure         │ UNASSIGNED │ 2h   │ Blocked: Gate 1
├─ TASK-015 │ Write Core Tests            │ UNASSIGNED │ 12h  │ Blocked: Gate 1
└─ TASK-016 │ Structured Logging          │ UNASSIGNED │ 8h   │ Blocked: Gate 1
```

</details>

---

### ⚪ PENDING - PHASE 3: ENHANCEMENTS (4 tasks - 18h)

<details>
<summary>Expand Phase 3 tasks (blocked by Gate 2)</summary>

```
├─ TASK-017 │ Remove Unused Features      │ UNASSIGNED │ 8h   │ Blocked: Gate 2
├─ TASK-018 │ DB Optimization             │ UNASSIGNED │ 2h   │ Blocked: Gate 2
├─ TASK-019 │ Pagination                  │ UNASSIGNED │ 4h   │ Blocked: Gate 2
└─ TASK-020 │ Sentry Integration          │ UNASSIGNED │ 4h   │ Blocked: Gate 2
```

</details>

---

### ✅ COMPLETED (0)

```
└─ (none yet)
```

---

## ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
## ┃  📊 SUMMARY                          ┃
## ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

**Task Status:**
- ⚪ Pending:     18 (90%)
- 🔵 In Progress:  2 (10%)
- ✅ Completed:    0 (0%)
- 🔴 Blocked:      0 (0%)

**Overall Progress:** 0/20 tasks `[░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░]` 0%

**Key Metrics:**

| Metric | Current | Target | Deadline |
|--------|---------|--------|----------|
| Security Score | 3/10 | 7/10 | Week 1 |
| Lines of Code | 5,000 | 1,200 | Week 4 |
| Test Coverage | 0% | 60% | Week 3 |
| Form Component | 1,380 lines | 150 lines | Week 1 |

**Time Tracking:**
- Estimated Remaining: 76 hours
- Required Velocity: ~5 tasks/week
- Current Velocity: 0 tasks/week (not started)

---

## ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
## ┃  👥 TEAM STATUS                      ┃
## ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

### 🟢 ACTIVE (3)

| Agent | Model | IDE | Current Work |
|-------|-------|-----|--------------|
| **PM** | Human | Terminal | Management, approvals |
| **PSA** | sonnet-4-5 | Claude Code CLI | State tracking, monitoring |
| **Codex** | claude-4 | Cursor IDE | Analysis, scoping fixes, proposing path forward |

### ⚪ AVAILABLE (4)

```
┌─ Dev1    │ Slot open
├─ Dev2    │ Slot open
├─ Dev3    │ Slot open
└─ QA      │ Slot open
```

**Capacity:** 3 active / 7 total = **43% utilized**

---

## ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
## ┃  🚨 BLOCKERS & NEXT ACTIONS          ┃
## ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

### 🔴 CRITICAL

1. **Assign Dev agents to Phase 1** (TASK-007, 008, 009, 010)
   - Impact: Unblocks entire project
   - Timeline: Cannot start Week 1 without assignments

2. **Approve credential rotation** (TASK-007)
   - Impact: Security vulnerability CVSS 9.8 remains
   - Timeline: Week 1 completion required

### 🟡 HIGH

3. **Set project kickoff date**
   - Impact: Team cannot plan schedules
   - Timeline: Needed immediately

4. **Set up Clerk account**
   - Impact: Blocks TASK-008
   - Timeline: Can be done in parallel

5. **Await Codex's analysis completion**
   - Impact: May inform Phase 1 approach
   - Timeline: In progress

### 🟢 MEDIUM

6. **Review Phase 1 plan with stakeholders**
   - Impact: Ensures alignment
   - Timeline: Before kickoff

---

## 📊 AGENT COORDINATION

**Multi-Agent Work:**
- **Codex (Cursor):** Analyzing codebase, combining findings, scoping fixes
- **PSA (Claude CLI):** Tracking Codex's work, maintaining state
- **Handoff:** Codex will propose path → PSA will integrate into tasks

**No Conflicts:** Clear ownership - Codex analyzes, PSA tracks

---

**🚀 PSA-PROJ-001 │ Protocol v2.0 │ 3 agents active │ Codex analyzing in Cursor**
