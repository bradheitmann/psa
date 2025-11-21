# Minimum Viable Context (MVC) Method

**Purpose:** Provide a lightweight intervention to keep specialized agents aligned on high-risk tasks without flooding them with the entire project history.

This protocol was born from repeated failures on complex stories (Convex auth, AI spec) where agents either (a) went off-course in the codebase or (b) deleted unrelated files (the PROVE-FIRST incident). "MVC" gives us a scaffolding that makes narrowly scoped, high-value tasks solvable by a fresh agent while protecting the rest of the power plant.

**Key Idea:** Deliver the minimum context required for the next slice and nothing more, enforce strict guardrails, and encode verification expectations up front. The agent never holds the entire project in working memory—just the relevant files, doc references, and success criteria.

## When to Use

- Critical hot spots where work keeps regressing (auth, billing, AI schema).
- High-risk collaborators (new agents, different models) who don't know our repo/standards.
- Incremental story progressions that can be solved in isolated chunks.

## Summary

1. Context only for the current slice.
2. Guardrails locking file scope + forbidden commands.
3. Explicit instructions (step-by-step) with references.
4. Acceptance criteria tied to tests, lint, evidence logs.
5. Mandatory post-task verification by PM3.

"Minimum viable context" keeps the agent focused and prevents collateral damage.

---

# MVC Method Protocol

## 1. Identify the Slice

- Break the backlog item into a standalone unit (e.g. "Eliminate TODOs in `convex/tests/orgGuards.spec.ts`").
- Confirm it can be solved without touching unrelated directories.
- Document prerequisites: which planning doc sections & files are necessary.

## 2. Craft the Brief

Every brief must include:

### a. Short Background
- Two or three sentences: What broke, why we care.

### b. Reading List
- Bullet list of required docs/code (paths + sections). No giant context dumps.

### c. Guardrails
- "You may edit only...", "Do not...", "No TODOs left behind."
- Explicitly forbid `rm`, `git clean`, `git add .`, etc. unless task requires.

### d. Task Breakdown
- Step-by-step instructions tied to acceptance criteria.
- Include verification commands they must run (e.g. `pnpm --filter ... test`).

### e. Acceptance Criteria
- Each bullet is a binary pass/fail check (tests green, coverage ≥ threshold, docs updated). If tests fail, the task is not complete.

## 3. Deliver & Monitor

1. Send the brief to the agent.
2. Require them to acknowledge guardrails before touching files.
3. Track command outputs—they must show actual commands ran, not summaries.

## 4. Post-task Verification

- PM3 reruns listed commands (tests/lint/typecheck) to confirm.
- Inspect `git status` to ensure only scoped files changed.
- If drift is detected (extra files, wrong paths), reject and restate guardrails.

## 5. Reset Context

- Merge/commit the finished slice or stash it immediately.
- Remove the brief from the context so the next slice starts fresh.

## 6. Repeat

- Move to the next backlog slice, updating the Guardrails/Task Breakdown/Acceptance Criteria for the new scope.
- When story is complete, perform a final holistic verification that passes every Evidence Gate.

---

## Appendix A – Templates

### MVC Brief Template

```
Background: <why this slice exists>

Reading List:
1. docs/... (section)
2. <etc>

Guardrails:
- Only touch <files>
- Do NOT run <commands>
- No TODO/skip left

Task Breakdown:
1. ...
2. ...

Verification:
- pnpm --filter ... test -- --coverage
- pnpm -r lint
- pnpm -r typecheck

Acceptance Criteria:
- Test suites pass
- Coverage ≥ thresholds
- Scope files only
```

### Guardrail Reminder (send before each task)

```
You must:
- Stay within scoped files
- Ask before deleting anything
- Report command outputs
- Stop immediately if you need new context
```

---

## Appendix B – Lessons from PROVE-FIRST Incident

- Never assume `git clean` or `rm` is safe without PM approval.
- Guardrails need to spell out prohibited commands explicitly.
- Commit completed doc bundles (PROVE-FIRST) before starting risky work.

## Appendix C – Maintenance

- Keep this protocol in `rad/protocols/MVC-METHOD/README.md`.
- Update when new edge cases arise (e.g. multi-repo work, CI changes).
- Combine with PROVE-FIRST™ verification to prevent false "DONE" claims.

---

## Appendix D – MVC Gate Templates (Reusable)

Use these in any project. Copy the relevant gate and fill in the slice ID, paths, and thresholds.

### Core Slice Gate (per‑slice)

- [ ] Evidence Bundle exists at `docs/test-reports/EVIDENCE-YYYY-MM-DD/<SLICE_ID>/`
- [ ] Structure complete: `before/`, `after/`, `verify.log`, `Summary.md` (≤10 lines), `coverage/` (if required)
- [ ] Files modified match write‑allowed whitelist only
- [ ] Verification commands present in `verify.log` with outputs
- [ ] Tests PASS (scope/package): (attach summary line)
- [ ] Typecheck PASS (scope/package)
- [ ] Coverage ≥ threshold: (e.g., ≥90% file / ≥95% package) with `coverage-summary.json` attached
- [ ] Guardrails respected (no network, no forbidden file writes, etc.)

Decision: PASS | FAIL
Notes:

### 3‑Slice CI Validation Gate (e.g., G0, G1, …)

- [ ] Gate Evidence Bundle exists at `docs/test-reports/EVIDENCE-YYYY-MM-DD/GATE-<ID>/`
- [ ] Contains: `run.id`, `ci.log`, `steps.txt`, `assertions.txt`, `Summary.md`
- [ ] CI steps: Lint PASS | Build PASS | Typecheck PASS | Test PASS
- [ ] No regressions introduced by last 3 slices
- [ ] If CI is red, failure linked to slice(s) and corrected (attach commit)

Decision: PASS | FAIL
Notes:

### Mutation Testing Gate (security‑critical only)

- [ ] Mutation report present (HTML/JSON)
- [ ] Mutation score ≥ threshold (e.g., ≥80%) or justified exception
- [ ] No critical mutants survive in critical paths (list files)
- [ ] `verify.log` includes mutation command and result
- [ ] Survivors remediation plan (if any)

Decision: PASS | FAIL
Notes:

### Contract Test Gate (adapters / SDK boundaries)

- [ ] Contract tests present under `tests/contracts/`
- [ ] Golden fixtures present and used (`tests/fixtures/contracts/`)
- [ ] Invariants asserted (required fields, strictness, error mapping)
- [ ] `verify.log` includes contract test run and PASS result

Decision: PASS | FAIL
Notes:

### Golden‑Path E2E Gate (integration)

- [ ] E2E tests run real handlers; network mocked only at external boundary
- [ ] Seeded data present; DB/Convex assertions included
- [ ] Flow validated end‑to‑end (list endpoints/calls)
- [ ] `verify.log` shows E2E PASS and key assertions

Decision: PASS | FAIL
Notes:

### Negative Test Gate (IDOR / MT isolation / Budget & Circuit)

- [ ] IDOR: cross‑org returns 404, no sensitive leakage
- [ ] Multi‑Tenant: 3‑org isolation tests
- [ ] Budget/Circuit: preflight deny prevents provider call; open circuit blocks
- [ ] `verify.log` includes targeted negative test run and PASS result

Decision: PASS | FAIL
Notes:

### Strict Write‑Scope Declaration (copy into every slice)

- WRITE‑ALLOWED ONLY:
  - <list exact files>
  - `docs/test-reports/EVIDENCE-YYYY-MM-DD/<SLICE_ID>/**` (evidence only)
- All other files are READ‑ONLY.
- If a dependency/config change appears necessary: STOP and PAUSE; request a micro‑slice to modify those files.

### Evidence Bundle Standard (copy into every slice)

- Path: `docs/test-reports/EVIDENCE-YYYY-MM-DD/<SLICE_ID>/`
- Must include:
  - `before/` (git show snapshots) or NO_PREV notes
  - `after/` (git diff of changed files)
  - `verify.log` (exact commands + outputs)
  - `coverage/` (when coverage required; attach `coverage-summary.json`)
  - `Summary.md` (≤10 lines: aim, commands, result, thresholds)
  - Optional: `work/trace.log` for step timing and traceability

### Decision Protocol (Gatekeeper)

- PASS only if all required boxes checked AND artifacts exist and are readable.
- Any missing artifact, incomplete logs, scope violation, or threshold miss ⇒ FAIL with precise fix instructions.
- If this slice completes a 3‑slice group, instruct to run the CI Validation Gate next.

---

## Appendix E – GLM Gatekeeper Addendum (Advanced Verification)

Apply these STRICT checks when slices include the following advanced categories.

### A) Mutation Testing (security‑critical: policy, auth)

Expected Artifacts:
- `mutation/` reports directory (HTML/JSON)
- mutation command log in `verify.log`
- killed/missed mutation summary

Acceptance:
- [ ] Mutation score ≥ threshold (e.g., ≥80%) OR justified exceptions documented
- [ ] No critical mutants survive in PII redaction paths, toolEnforcer policies, or requireAuth logic

### B) Contract Tests (external SDK boundaries / adapter invariants)

Expected Artifacts:
- `tests/contracts/*.spec.ts`
- fixtures under `tests/fixtures/contracts/`

Acceptance:
- [ ] Invariants assert exact structure/required fields, strictness, and error mapping
- [ ] `verify.log` shows contracts-only run and PASS

### C) Golden‑Path E2E (real integration; mock network only at boundary)

Expected Artifacts:
- `e2e/` tests running real handlers (Next/Convex)
- Seeded org data and DB assertions

Acceptance:
- [ ] End‑to‑end flow passes; PII redacted before persistence; costs/audit recorded
- [ ] Only the external provider is mocked

### D) Negative Tests (IDOR / Multi‑Tenant / Budget & Circuit failures)

Acceptance:
- [ ] IDOR returns 404 with no leakage
- [ ] 3‑org isolation verified for queries/mutations
- [ ] Budget preflight deny prevents external call; open circuit blocks

### Evidence Requirements (All Advanced Slices)

- Path: `docs/test-reports/EVIDENCE-YYYY-MM-DD/<SLICE_ID>/`
- Must include `verify.log`, `coverage/` (if applicable), fixtures or DB assertion artifacts, and `Summary.md` (≤10 lines).
- Decision is PASS only if ALL acceptance items are evidenced. Any missing artifact ⇒ FAIL.

---

**Notes for Implementation:**
- This protocol is designed to prevent scope creep and ensure focused work
- Evidence bundles provide audit trails for quality assurance
- Gatekeepers enforce quality standards before work is considered complete
- Always customize the templates to match your specific project structure and tooling