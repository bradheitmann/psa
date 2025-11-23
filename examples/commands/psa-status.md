Show comprehensive PSA project status.

Generate a detailed project state report including:

1. **Agent Roster:**
   - Parse docs/AGENTS.md or docs/PROJECT_STATE.md
   - Show active agents and their assignments
   - Highlight available agent slots

2. **Task Summary:**
   - Parse docs/PROJECT_STATE.md
   - Count tasks by status (pending, in_progress, completed, blocked)
   - Show task breakdown by phase
   - List next 5 highest priority tasks

3. **Metrics Dashboard:**
   - Extract current metrics from PROJECT_STATE.md
   - Show progress toward targets
   - Calculate percentage complete

4. **Blockers & Risks:**
   - List all active blockers
   - Show HIGH/MEDIUM/LOW risks
   - Suggest mitigation actions

5. **Decision Gates:**
   - Show upcoming decision gates
   - Display gate criteria and status
   - Recommend Go/No-Go based on current state

6. **Recent Activity:**
   - Check git log for recent commits
   - Show files changed in last 24 hours
   - Summarize recent progress

7. **Next Actions:**
   - Recommend next tasks to work on
   - Suggest agent assignments
   - Identify bottlenecks

Present this as a beautiful, formatted report using markdown tables and clear sections.
