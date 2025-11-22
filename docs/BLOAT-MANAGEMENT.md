# PSA Bloat Management System

**Version:** 1.0.0
**Purpose:** Prevent evidence bloat while preserving gold-standard examples
**Strategy:** Identify → Canonicalize → Move to burn_pile → PM confirms deletion

---

## The Problem

MVC projects accumulate evidence bundles:
- 5-20MB per story
- 20 stories = 100-400MB of evidence
- Most evidence is temporary (debugging/QA)
- Only exceptional examples have lasting value

**Without management:** Evidence folder grows unbounded

---

## The Solution

**Three-stage lifecycle:**

1. **Active** (Stories N, N+1, N+2): Keep all evidence
2. **Review** (Story N+3): Canonicalize if exceptional, else stage for deletion
3. **Burn Pile** (Story N+4+): Move to docs/burn_pile/, PM deletes when ready

**Key innovation:** PSA identifies bloat, PM confirms deletion

---

## Commands

### `psa bloat-scan`

**Scans project for bloat:**

```bash
cd your-project
psa bloat-scan

# Output:
# - Total evidence size
# - Active stories (keep)
# - Canonical candidates (review)
# - Deletable stories (old)
```

**Example output:**
```
Evidence Bundle Analysis:
  ✗ Delete story-01 (0.17MB) - 7 stories old
  ✗ Delete story-02 (0.12MB) - 6 stories old
  ✓ Keep story-07 (0.05MB) - Active sprint
  ⚠ Review story-10 (0.20MB) - Canonical check

Summary:
  Total: 1.19MB
  Keeping: 0.46MB
  Deletable: 0.41MB
  Canonical candidates: 1
```

---

### `psa canonicalize <story-name>`

**Extract gold-standard examples:**

```bash
psa canonicalize story-07-agent-registry

# Process:
# 1. Screen for sensitive data (API keys, tokens)
# 2. Copy to docs/.canonical/ (local)
# 3. Sync to ~/.psa/examples/ (global)
# 4. Register in canonical registry
# 5. Original evidence ready for deletion
```

**Canonical criteria:**
- Grade ≥92/100 (A-range)
- Evidence ≥19/20 (authentic, complete)
- Coverage ≥95% (exceptional)
- Zero rejections (clean first submission)
- Novel pattern or technique

---

## Retention Policy

**Evidence bundles:**
- **Story N, N+1, N+2:** KEEP (active sprint)
- **Story N+3:** REVIEW for canonical
- **Story N+4+:** MOVE to burn_pile

**Example (currently on Story 13):**
```
Keep: Stories 11, 12, 13 (active)
Review: Story 10 (canonical check)
Burn pile: Stories 01-09 (unless canonical)
```

---

## Burn Pile Workflow

**PSA moves bloat to:** `docs/burn_pile/YYYY-MM-DD/`

**PM reviews periodically:**
```bash
ls docs/burn_pile/

# When confident not needed:
rm -rf docs/burn_pile/2025-11-22/

# If need something back:
mv docs/burn_pile/*/story-05/ docs/evidence/
```

**Typical retention:** 30-90 days in burn_pile before PM deletes

---

## Canonical Examples

**Local:** `docs/.canonical/{category}/`
**Global:** `~/.psa/examples/{category}/`

**Categories:**
- evidence-bundles/ - Exemplary evidence bundles
- test-suites/ - Comprehensive test patterns
- implementations/ - Excellent service design
- security/ - Thorough security testing
- anti-patterns/ - Examples of what NOT to do

**Use in agent briefs:**
```
"Reference ~/.psa/examples/evidence-bundles/story-07-agent-registry/
for evidence bundle standards."
```

---

## Sensitive Data Screening

**Automatic redaction before global sync:**
- API keys → `***REDACTED***`
- Tokens → `***TOKEN***`
- Email addresses → `user@example.com`
- Personal paths → `/Users/developer/`

**Patterns screened:**
- sk-ant-* (Anthropic)
- xoxb-*, xoxp-*, xapp-* (Slack)
- Dropbox tokens
- Email addresses
- Personal file paths

---

## Configuration

**Location:** `~/.psa/bloat/config.json`

**Key settings:**
```json
{
  "retention_policy": {
    "evidence_bundles": {
      "active_stories": 3,
      "review_at_story_offset": 3,
      "delete_at_story_offset": 4
    }
  },
  "canonical_thresholds": {
    "min_grade": 92,
    "min_evidence_score": 19,
    "min_coverage": 95
  },
  "burn_pile": {
    "location": "docs/burn_pile/",
    "pm_reviews_before_deletion": true
  }
}
```

---

## Best Practices

**For PM:**
- Run `psa bloat-scan` every 5 stories
- Review canonical candidates (story N+3)
- Check burn_pile monthly
- Delete burn_pile when comfortable (30-90 days)
- Preserve canonical examples forever

**For automatic triggers:**
- Daily bloat check when running `psa` (background)
- Warning if evidence >100MB
- Canonical notification at story N+3

---

## Example Workflow

**Story 15 just completed:**

```bash
# PSA automatically checks (on next psa command):
psa view-master

# Background notification:
"⚠️ Story 12 eligible for canonical review (3 stories ago)"

# PM reviews Story 12:
# - Grade: A (95/100)
# - Evidence: 20/20
# - Coverage: 98%
# → Canonical!

psa canonicalize story-12-feature-x

# Output:
# ✓ Canonical created
# ✓ Synced to ~/.psa/examples/
# Original at docs/evidence/story-12/ ready for burn_pile

# PSA moves old stories to burn_pile:
# Stories 01-11 → docs/burn_pile/2025-11-22/

# PM reviews monthly:
ls docs/burn_pile/

# When confident (30 days later):
rm -rf docs/burn_pile/2025-11-22/
```

---

## Storage Savings

**Typical 20-story project:**

**Without bloat management:**
- 20 stories × 15MB = 300MB permanent

**With bloat management:**
- Active (3 stories): 45MB
- Canonical (3-5 stories): 60MB
- Burn pile (temporary): 100MB
- **Total in repo:** 105MB permanent

**Savings:** 195MB (65%) after burn_pile cleaned

---

## Integration with MVC

**Bloat management works WITH MVC protocol:**
- Evidence still required for every story
- Quality standards unchanged
- Canonicalization rewards excellence
- Burn pile prevents premature deletion

**MVC + Bloat Management = Sustainable quality**

---

**For complete details:** See `lib/bloat/config.json` and scripts in `scripts/bloat-*.sh`
