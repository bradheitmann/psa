# Agent Performance Analysis (APA) Protocol

**Version:** 1.0
**Date:** 2025-11-17
**Status:** Active
**Purpose:** Universal, model-agnostic performance metrics for AI agents across all harnesses, environments, and tech stacks

---

## Core Principle

**Measure agent effectiveness independent of specific tools, measuring:**
1. **Production** - What they produce (quality × quantity)
2. **Efficiency** - Output per unit input (value per token/dollar)
3. **Cost** - Total resource consumption (tokens, dollars, time)

**Goal:** Compare agents across different models, harnesses, and projects using normalized metrics.

---

## Universal Performance Metrics

### 1. Production Metrics (WHAT was produced)

#### Output Volume (Normalized):
```
Story Points Delivered (SPD)
= (LOC × Quality Factor) / Complexity Factor

Where:
- LOC = Lines of Code (production + test)
- Quality Factor = (Test Coverage % / 100) × (1 - Rejection Rate)
- Complexity Factor = Avg Cyclomatic Complexity / 10

Example:
- 500 LOC, 100% coverage, 0% rejections, complexity 15
- SPD = (500 × 1.0 × 1.0) / 1.5 = 333 adjusted points
```

#### Quality-Adjusted Productivity (QAP):
```
QAP = (Total LOC × Test Coverage %) / (1 + Rejection Count)

Example Story 01:
- 300 LOC, 100% coverage, 1 rejection
- QAP = (300 × 1.0) / 2 = 150

Example Story 03:
- 400 LOC, 100% coverage, 0 rejections
- QAP = (400 × 1.0) / 1 = 400
```

**Higher = Better**

---

### 2. Efficiency Metrics (OUTPUT per INPUT)

#### Token Efficiency Ratio (TER):
```
TER = LOC Delivered / Tokens Used (thousands)

Example:
- 500 LOC, 250K tokens
- TER = 500 / 250 = 2.0 LOC per 1K tokens

Higher = More efficient
```

#### Cost Efficiency (Output per Dollar):
```
LOC per Dollar = Total LOC / Total Cost ($)

Where:
Cost = (Input Tokens × Input Price) + (Output Tokens × Output Price)

Example (GPT-5 pricing):
- Input: 100K tokens × $0.015/1K = $1.50
- Output: 150K tokens × $0.06/1K = $9.00
- Total cost: $10.50
- 500 LOC delivered
- LOC/$ = 500 / 10.50 = 47.6 LOC per dollar
```

#### Time Efficiency:
```
Velocity = LOC / Hour

Example:
- 500 LOC in 120 minutes (2 hours)
- Velocity = 500 / 2 = 250 LOC/hour
```

#### Quality-Adjusted Velocity (QAV):
```
QAV = (LOC × Quality Factor) / Hours

Where Quality Factor = (Coverage % / 100) × (PM Grade / 100)

Example Story 03:
- 400 LOC, 100% coverage, grade 88/100, 1.5 hours
- QAV = (400 × 1.0 × 0.88) / 1.5 = 234.7 quality LOC/hour
```

---

### 3. Cost Metrics (RESOURCES consumed)

#### Total Token Cost:
```
Tokens = Input Tokens + Output Tokens

Track separately:
- Input tokens (what agent reads)
- Output tokens (what agent produces)
- Total tokens
```

#### Dollar Cost (Model-Specific):
```
Cost ($) = (Input × Input Price) + (Output × Output Price)

Pricing tables:
- GPT-5 Codex: $0.015/1K input, $0.06/1K output
- Claude Sonnet 4.5: $0.003/1K input, $0.015/1K output
- Gemini Pro: $0.00125/1K input, $0.005/1K output
- etc.
```

#### Time Cost:
```
Human Time = PM interventions + QA review + Dev time
Agent Time = Story duration (wall clock)
Total Time = Human Time + Agent Time
```

---

## Universal Agent Performance Score (UAPS)

**Single metric for comparing ANY agent across ANY project:**

```
UAPS = (Production × 0.4) + (Efficiency × 0.4) + (Cost Penalty × 0.2)

Where:
Production = Normalized Quality-Adjusted Productivity
Efficiency = Normalized Token Efficiency Ratio
Cost Penalty = 100 - (Normalized Dollar Cost per Story Point)

Scale: 0-100 (higher = better)
```

### Example Calculation:

**Story 03 (hypothetical numbers):**
```
Production:
- QAP = 400 (from above)
- Normalized to 0-100 scale: 85/100

Efficiency:
- TER = 2.0 LOC per 1K tokens
- Normalized to 0-100 scale: 80/100

Cost:
- $10.50 for story
- Cost per QAP point = $10.50 / 400 = $0.026
- Normalized penalty: 100 - 26 = 74/100

UAPS = (85 × 0.4) + (80 × 0.4) + (74 × 0.2)
     = 34 + 32 + 14.8
     = 80.8/100 (B+ performance)
```

---

## Tracking Template (Per Story)

### Story [ID]: [Name]

**Production:**
- LOC (production): [?]
- LOC (test): [?]
- Test coverage: [?]%
- PM grade: [?]/100
- Rejections: [?]
- QAP: [calculate]

**Efficiency:**
- Input tokens: [?]
- Output tokens: [?]
- Total tokens: [?]
- TER: [calculate LOC/tokens]
- Duration: [?] hours
- Velocity: [calculate LOC/hour]
- QAV: [calculate]

**Cost:**
- Model: [GPT-5 Codex / Claude / etc.]
- Input cost: $[?]
- Output cost: $[?]
- Total cost: $[?]
- LOC per $: [calculate]
- Cost per story point: $[?]

**Derived Metrics:**
- UAPS: [calculate]
- Efficiency rank: [compared to other stories]
- Cost rank: [compared to other stories]

---

## Model-Agnostic Normalization

### Challenge:
Different models have different:
- Token counting (some count higher for same text)
- Pricing structures
- Context window sizes

### Solution: Normalize to "Baseline Units"

**Baseline Model:** GPT-4 (industry standard for comparison)

**Normalization Factors:**
```
GPT-4: 1.0 (baseline)
GPT-5: 1.2 (roughly 20% more efficient)
Claude Sonnet: 1.1 (slightly more efficient)
Gemini Pro: 0.9 (slightly less efficient)

Normalized Tokens = Actual Tokens / Normalization Factor
```

**Example:**
```
Claude uses 200K tokens on story
Normalized = 200K / 1.1 = 182K "GPT-4 equivalent tokens"

Now comparable to GPT-5 agent who used 180K tokens!
```

---

## Cost Tracking (Token → Dollar Conversion)

### Current Pricing (as of 2025-11-17):

| Model | Input (per 1M) | Output (per 1M) | Notes |
|-------|----------------|-----------------|-------|
| GPT-5 Codex | $15.00 | $60.00 | High cost, high capability |
| GPT-4 Turbo | $10.00 | $30.00 | Baseline pricing |
| Claude Sonnet 4.5 | $3.00 | $15.00 | Very cost-effective |
| Claude Opus | $15.00 | $75.00 | Premium tier |
| Gemini Pro 1.5 | $1.25 | $5.00 | Budget option |
| Gemini Ultra | $10.00 | $40.00 | Mid-tier |

**Update pricing:** `psa update-pricing` (when models change prices)

**Calculate cost:**
```bash
# Built into metrics tracker
Cost = (Input_Tokens / 1000000 × Input_Price) + (Output_Tokens / 1000000 × Output_Price)
```

---

## Cross-Agent Comparison

### Scenario: Compare Two Agents

**Agent A (GPT-5 Codex):**
- Story 03: 400 LOC, 250K tokens, $10.50, A- (88)
- TER: 1.6 LOC/1K tokens
- LOC/$: 38.1

**Agent B (Claude Sonnet):**
- Story 03: 420 LOC, 180K tokens, $3.20, A- (88)
- TER: 2.3 LOC/1K tokens (better!)
- LOC/$: 131.3 (better!)

**Insight:** Claude is more token-efficient AND cost-effective for similar quality.

---

## Aggregate Metrics (Multi-Story)

### Project-Level Performance:

**Total Production:**
```
Total QAP = Sum of all story QAP
Avg QAP per Story = Total QAP / Story Count
```

**Total Efficiency:**
```
Cumulative TER = Total LOC / Total Tokens (in thousands)
Cumulative Velocity = Total LOC / Total Hours
```

**Total Cost:**
```
Project Cost = Sum of all story costs
Cost per Story = Project Cost / Story Count
ROI = Business Value / Project Cost (if measurable)
```

**Trajectory Score:**
```
Improvement Rate = (Last 3 Story Avg - First 3 Story Avg) / First 3 Story Avg

Example:
First 3 stories: 75, 85, 88 → Avg: 82.7
Last 3 stories: 88, 90, 92 → Avg: 90
Improvement = (90 - 82.7) / 82.7 = 8.8% improvement
```

---

## PSA Global Tracking

### New PSA Commands:

```bash
psa track-performance [loadout] [project] [story-id] \
  --loc=500 \
  --tokens=250000 \
  --cost=10.50 \
  --grade=88 \
  --duration=120

# Automatically calculates:
# - TER, LOC/$, Velocity, QAP, UAPS
# - Stores in ~/.psa/performance-data/
# - Updates AGENTS_MASTER.md with metrics
```

```bash
psa analyze-performance [loadout] [project]

# Shows:
# - Story-by-story metrics
# - Trends over time
# - Correlations (tokens vs grade, etc.)
# - Comparisons to other agents
# - Cost analysis
```

```bash
psa compare-agents [loadout1] [loadout2] \
  --metric=TER \
  --project=flo_bot

# Shows:
# - Side-by-side comparison
# - Which is more efficient
# - Cost difference
# - Quality difference
```

---

## Data Storage Structure

```
~/.psa/performance-data/
├── GPT5-CODEX/
│   ├── flo_bot-2025-11-17.json
│   └── other-project-2025-11-20.json
├── CLAUDE-SONNET-45/
│   └── project-2025-11-15.json
└── metrics-summary.json

Format (JSON):
{
  "agent": "GPT-5 Codex CLI",
  "project": "flo_bot",
  "date": "2025-11-17",
  "stories": [
    {
      "id": "01",
      "loc": 300,
      "test_loc": 450,
      "tokens_input": 120000,
      "tokens_output": 130000,
      "cost": 9.30,
      "duration_minutes": 180,
      "grade": 75,
      "rejections": 1,
      "coverage": 100,
      "complexity_avg": 12,
      "tool_calls": 45,
      "context_pct": 15,
      "calculated": {
        "qap": 150,
        "ter": 1.2,
        "velocity": 100,
        "qav": 75,
        "loc_per_dollar": 32.3,
        "uaps": 72.5
      }
    }
  ],
  "aggregate": {
    "total_loc": 1200,
    "total_tokens": 750000,
    "total_cost": 31.50,
    "avg_grade": 82.7,
    "improvement_rate": 0.173
  }
}
```

---

## Normalization for Cross-Agent Comparison

### Challenge:
- GPT-5 story costs $10, Claude story costs $3
- GPT-5 uses 250K tokens, Claude uses 180K tokens
- How to compare fairly?

### Solution: Baseline Normalization

**Define "1 Story Point" as:**
```
Baseline Story (GPT-4 reference):
- 100 LOC production code
- 150 LOC test code
- 100% coverage
- Grade A- (85/100)
- 0 rejections
- Cyclomatic complexity: 10
- Delivered in 2 hours

Baseline Resources:
- 100K tokens
- $4.00 cost (GPT-4 pricing)
- 2 hours time
```

**Normalize ALL agents to this baseline:**

```
Efficiency Score = (Your Output / Your Resources) / (Baseline Output / Baseline Resources)

Example (GPT-5 on Story 03):
- Output: 400 LOC × 0.88 quality = 352 quality LOC
- Resources: 250K tokens
- Your ratio: 352 / 250 = 1.41 LOC/1K tokens

- Baseline: 250 LOC / 100K = 2.5 LOC/1K tokens
- Efficiency Score: 1.41 / 2.5 = 0.56 (56% of baseline efficiency)

Lower than baseline, but acceptable if quality is higher!
```

---

## Universal Agent Performance Score (UAPS)

**Single 0-100 metric for ANY agent:**

```
UAPS = (Quality × 0.30) + (Efficiency × 0.40) + (Cost × 0.30)

Where:
Quality = PM Grade (0-100)
Efficiency = (Your TER / Baseline TER) × 100, capped at 100
Cost = (Baseline Cost / Your Cost) × 100, capped at 100

Example (GPT-5 Story 03):
Quality: 88/100
Efficiency: (1.6 / 2.5) × 100 = 64/100
Cost: ($4.00 / $10.50) × 100 = 38/100

UAPS = (88×0.3) + (64×0.4) + (38×0.3)
     = 26.4 + 25.6 + 11.4
     = 63.4/100

Interpretation: High quality, moderate efficiency, expensive
```

---

## Cost Tracking

### Token → Dollar Conversion Table

**Maintained in:** `~/.psa/pricing.json`

```json
{
  "updated": "2025-11-17",
  "models": {
    "gpt-5-codex": {
      "input_per_1m": 15.00,
      "output_per_1m": 60.00,
      "currency": "USD"
    },
    "gpt-4-turbo": {
      "input_per_1m": 10.00,
      "output_per_1m": 30.00,
      "currency": "USD"
    },
    "claude-sonnet-4.5": {
      "input_per_1m": 3.00,
      "output_per_1m": 15.00,
      "currency": "USD"
    },
    "claude-opus": {
      "input_per_1m": 15.00,
      "output_per_1m": 75.00,
      "currency": "USD"
    },
    "gemini-pro-1.5": {
      "input_per_1m": 1.25,
      "output_per_1m": 5.00,
      "currency": "USD"
    }
  },
  "baseline_model": "gpt-4-turbo"
}
```

**Update pricing:**
```bash
psa update-pricing --model=gpt-5-codex --input=15.00 --output=60.00
```

---

## Environment-Agnostic Metrics

### Harness Independence:

**Doesn't matter if agent uses:**
- Codex CLI, Claude Code, Cursor, Zed, VS Code
- Warp, iTerm, Terminal
- With or without MCP servers

**We measure:**
- What got produced (LOC, quality)
- What was consumed (tokens, cost, time)
- How efficient (output/input ratios)

### Tech Stack Independence:

**Normalization by language:**

Different languages have different verbosity:
```
Verbosity Factors:
- Python: 1.0 (baseline)
- TypeScript: 1.3 (more verbose)
- JavaScript: 1.2
- Go: 1.5
- Rust: 1.8
- Java: 2.0

Normalized LOC = Actual LOC / Verbosity Factor

Example:
- 500 LOC TypeScript = 500 / 1.3 = 385 "Python-equivalent LOC"
```

**Now TypeScript and Python agents are comparable!**

---

## PSA Commands (To Be Implemented)

### Track Performance:
```bash
psa track \
  --agent="GPT-5 Codex CLI" \
  --project="flo_bot" \
  --story="03" \
  --loc-prod=300 \
  --loc-test=450 \
  --tokens-in=120000 \
  --tokens-out=130000 \
  --duration-min=90 \
  --grade=88 \
  --rejections=0 \
  --coverage=100 \
  --complexity=12

# Automatically calculates all derived metrics
# Stores in ~/.psa/performance-data/
```

### Analyze Performance:
```bash
psa analyze "GPT-5 Codex CLI" --project=flo_bot

# Shows:
# - Story-by-story trends
# - Correlations (tokens vs grade, LOC vs time, etc.)
# - Efficiency over time
# - Cost analysis
# - Comparison to baseline
```

### Compare Agents:
```bash
psa compare \
  "GPT-5 Codex CLI" \
  "Claude Sonnet 4.5 + Warp" \
  --metric=UAPS \
  --project=flo_bot

# Shows side-by-side UAPS scores
```

### Predict Performance:
```bash
psa predict "GPT-5 Codex CLI" \
  --project=flo_bot \
  --story=04 \
  --based-on=trajectory

# Output:
# Based on Stories 01-03 trajectory:
# Predicted grade: A- to A (88-92)
# Predicted tokens: 220K-240K
# Predicted cost: $9.50-$10.50
# Confidence: High (R²=0.95)
```

---

## Correlation Analysis

### Automatically Detect Patterns:

**After 3+ stories, PSA analyzes:**

1. **Token Use vs Quality:**
   ```
   Correlation: tokens ↔ PM grade
   If negative: More tokens = lower quality (inefficient struggle)
   If positive: More tokens = higher quality (thorough work)
   If none: Tokens don't predict quality
   ```

2. **Tool Calls vs Evidence Quality:**
   ```
   More Read operations = better evidence?
   More Bash commands = more thorough verification?
   ```

3. **Context Window % vs Performance:**
   ```
   High context (>30%) = struggling?
   Low context (<10%) = efficient?
   Optimal range: 15-25%?
   ```

4. **Complexity vs Time:**
   ```
   Does higher complexity linearly increase time?
   Or exponentially?
   Helps estimate future stories.
   ```

5. **Rejection Rate vs Improvement:**
   ```
   Do rejected stories lead to faster learning?
   Or do clean stories indicate better protocol understanding?
   ```

---

## Future Agent Seeding

### How to Use Learnings:

**Scenario:** Starting new Bun/TypeScript project, need MVC Dev

```bash
psa seed-agent "GPT-5 Codex CLI" --role="MVC Dev" --tech="Bun TypeScript"

# PSA searches for:
# - Agents with same loadout
# - In same role (MVC Dev)
# - On similar tech stack (Bun/TS)
# - Extracts learnings

# Generates briefing:
"""
Seeded Learnings for GPT-5 Codex CLI (MVC Dev on Bun/TS):

Based on flo_bot project performance (2025-11-17):

Expected Learning Curve:
- Story 01: Expect C+ to B- (75-80) - evidence standards learning
- Story 02: Expect B+ (85) - applying lessons
- Story 03+: Expect A- to A (88-95) - protocol mastery

Common Pitfalls (from flo_bot agent):
1. Don't fabricate verify.log - run actual commands, copy outputs
2. Don't obsess over guardrail scripts - stay focused on story
3. Git-diff files need actual output, not empty files

Success Patterns (from flo_bot agent):
1. Use [CHECK-IN] when uncertain
2. Follow TDD strictly (tests first)
3. Evidence quality improves with each story
4. 40% faster than estimates is achievable

Optimal Metrics (from flo_bot agent):
- Target: 2.0+ LOC per 1K tokens
- Target: <$12 per story (this stack)
- Target: 200-250 LOC/hour
- Keep context under 25%

MVC Dev Role Fit: Excellent (A-) with PM oversight
"""

# Paste this into new agent's initial context!
```

---

## PSA Data Files

### Performance Data:
```
~/.psa/performance-data/
├── GPT5-CODEX/
│   └── flo_bot-2025-11-17.json        # Raw metrics
├── CLAUDE-SONNET-45/
│   └── [future projects]
└── analysis/
    ├── correlations.json             # Detected patterns
    ├── predictions.json              # Performance predictions
    └── comparisons.json              # Agent comparisons
```

### Pricing Data:
```
~/.psa/pricing.json                   # Current model pricing
```

### Seeding Data:
```
~/.psa/seeds/
└── GPT5-CODEX-MVC-DEV-BUN-TS.md     # Learnings for this config
```

---

## Implementation Phases

### Phase 1: Manual Tracking (NOW)
- ✅ Dev fills out metrics tracker manually
- ✅ PM provides ratings
- ✅ Store in project performance-reviews/
- ✅ Manual correlation analysis

### Phase 2: Automated Collection (FUTURE)
- [ ] `psa track` command captures metrics
- [ ] Automatic token counting from logs
- [ ] Automatic LOC calculation
- [ ] Auto-populate metrics tracker

### Phase 3: Analysis & Prediction (FUTURE)
- [ ] `psa analyze` shows correlations
- [ ] `psa predict` forecasts performance
- [ ] `psa compare` benchmarks agents
- [ ] ML-based pattern detection

### Phase 4: Seeding System (FUTURE)
- [ ] `psa seed-agent` generates briefings
- [ ] Automatic learning extraction
- [ ] Context-aware seeding
- [ ] Performance improvement verification

---

## Usage Example (Current Manual Phase)

**After Story 03, Dev runs:**

1. **Collect metrics:**
   ```bash
   # Count LOC
   cloc src/ --by-file

   # Get token counts from Codex logs
   [Check Codex CLI output for token usage]

   # Calculate cost
   # Input: 120K × $0.015 = $1.80
   # Output: 130K × $0.060 = $7.80
   # Total: $9.60
   ```

2. **Fill out tracker:**
   ```
   Edit: docs/performance-reviews/DEV-METRICS-TRACKER.md
   Add Story 03 data
   ```

3. **Self-assessment:**
   ```
   Fill: docs/performance-reviews/DEV-SELF-ASSESSMENT-TEMPLATE.md
   ```

4. **PM analyzes:**
   ```
   Review correlations manually
   Update PM-RATING-METHODOLOGY with insights
   ```

5. **Report to PSA:**
   ```bash
   psa report "GPT-5 Codex + OpenAI CLI" \
     "[flo_bot - MVC Dev] Story 03: UAPS 80.8, TER 1.6, Cost $9.60, improving"
   ```

---

## Success Metrics for PSA System

**PSA is successful when:**
- ✅ Can predict agent performance on new projects (±10% accuracy)
- ✅ Can recommend optimal agent for given task/stack
- ✅ Can identify cost vs quality tradeoffs
- ✅ Can seed new agents with relevant learnings
- ✅ Performance improvements are measurable over time

**Current Status:**
- ✅ Templates created (manual phase)
- ⏳ Data collection starting (Story 01-03 baseline)
- ⏳ Correlation analysis pending (need Story 04-07 data)
- ⏳ Automation pending (Phase 2-4)

---

## Version History

- **v1.0** (2025-11-17): Initial APA protocol
  - Universal metrics (QAP, TER, UAPS)
  - Model-agnostic normalization
  - Cost tracking (tokens → dollars)
  - Correlation framework
  - Future seeding design
  - Manual phase templates

---

## See Also

- **PACKAGE-MANAGER-v1.0.md** - Package management rules
- **UPGRADE-MANAGEMENT-v1.0.md** - Upgrade strategies
- **MVC-METHOD-v1.0.md** - Multi-agent coordination
- **~/.psa/AGENTS_MASTER.md** - Loadout configurations
- **DEV-SELF-ASSESSMENT-TEMPLATE.md** - Self-assessment template
- **DEV-METRICS-TRACKER.md** - Metrics collection template
- **PM-RATING-METHODOLOGY-INQUIRY.md** - PM rating heuristics
