# PSA Marketing Copy

Copy-paste ready marketing text for various channels.

---

## Hero Section (README)

### Value Proposition (Blockquote Style)

```markdown
> **For solo developers who maintain 5+ side projects simultaneously,** PSA creates a unified command center with visual progress tracking and one-keystroke navigation, **so you can context-switch between projects in seconds and know exactly where you left off** instead of spending 10 minutes every morning re-orienting yourself by running `cd`, `git status`, and `ls` across multiple directories.
```

### Alternative: Callout Box Style

```markdown
<table>
<tr>
<td>

### 💡 The Problem

You maintain **5+ coding projects**. Every morning you:
- `cd ~/projects/app1 && git status`
- `cd ~/projects/app2 && git status`
- Try to remember: "Was I at 60% or 65%?"
- Mentally track: "Which one needs tests?"
- **Waste 10+ minutes** just figuring out where you were

</td>
<td>

### ✨ The Solution

**One command. One dashboard. Everything.**

```bash
psa
```

Instantly see:
- All 5 projects with status
- Progress bars (visual)
- Coverage percentages
- Recent git activity
- **Jump to any project in 3 keystrokes**

</td>
</tr>
</table>
```

---

## One-Liners (Social Media)

### Twitter/X (280 characters)

```
Stop losing track of your projects.

PSA = beautiful terminal dashboard showing ALL your codebases with progress, metrics & git activity.

One command. One glance. Everything.

Free & open source.

github.com/bradheitmann/psa
```

### Twitter Thread (Series)

**Tweet 1:**
```
I made a terminal dashboard for developers with multiple projects.

It's called PSA (Project State Agent).

Here's why you might want it 🧵
```

**Tweet 2:**
```
The problem:

You have 5+ side projects.

Every morning = 10 min of:
• cd project1 && git status
• cd project2 && git status
• "Wait, which one needed tests?"
• Mental context-switching overhead

There's a better way.
```

**Tweet 3:**
```
The solution:

One command:
`psa`

Shows:
• All projects with progress bars
• Test coverage %
• Recent commits
• Status (active/paused/done)
• Visual, colorful, instant

Context-switch in 3 keystrokes.
```

**Tweet 4:**
```
Bonus:

If you use Claude Code:
• Token usage tracking
• Cost per project
• Efficiency metrics (tokens/line)
• Agent session analytics

Optimize your AI budget.
```

**Tweet 5:**
```
Features:
• 🎨 Colorful ASCII charts
• ⚡ Works in ANY terminal
• 🔍 Fuzzy search (fzf)
• 📊 Custom metrics
• 🤖 Optional AI tracking
• 🆓 Free & open source (MIT)

github.com/bradheitmann/psa

[Screenshot]
```

---

### LinkedIn Post

```
Managing multiple coding projects? There's a better way.

I've been working on PSA (Project State Agent) - a terminal dashboard that solves a common developer pain point: losing track of what needs attention across multiple repos.

The problem:
As developers, we often maintain 5+ projects simultaneously. Every morning means manually checking each directory, running git status, and trying to remember progress percentages. It's a 10-minute context-switching tax before writing a single line of code.

The solution:
PSA provides a unified dashboard in your terminal:
• Visual progress bars for all projects
• Test coverage percentages
• Git activity tracking
• One-keystroke navigation
• Works with Python, JavaScript, Rust, Go - any language

Bonus for AI-assisted development:
• Token usage tracking (Claude Code integration)
• Cost per project analysis
• Efficiency optimization metrics

It's free, open source (MIT), and works in any terminal (Warp, iTerm2, VS Code, SSH sessions).

Built with beautiful ASCII visualizations, powered by modern CLI tools (fzf, gum, bat), and designed for developers who love the command line.

Check it out: github.com/bradheitmann/psa

[Multiple screenshots in post]

#developer #opensource #terminal #productivity #tools
```

---

### Hacker News Post

**Title:**
```
PSA – Terminal dashboard for managing multiple coding projects
```

**Comment:**
```
Hey HN!

I built PSA (Project State Agent) to solve a personal pain point: I maintain 7+ coding projects and was wasting 10+ minutes every morning just figuring out what needed attention.

PSA is a terminal dashboard that shows:
• All your projects with progress bars
• Test coverage & LOC metrics
• Git activity (commits, branches)
• Status indicators (active/paused/done)
• Fuzzy search navigation

It works with ANY language (Python, JS, Rust, Go, etc.) and ANY terminal.

Bonus: If you use Claude Code, it tracks token usage and calculates efficiency metrics (tokens/line, cost per project).

It's built with bash, uses jq for JSON, and progressively enhances with fzf, gum, bat, etc. Lots of colorful ASCII visualizations.

Free and open source (MIT). Would love feedback!

github.com/bradheitmann/psa
```

---

### Reddit Post (r/commandline)

**Title:**
```
[OC] PSA - A colorful terminal dashboard for managing multiple coding projects
```

**Post:**
```
I built a terminal tool that I've been wanting for years: a dashboard that shows ALL my coding projects in one glance.

**The Problem:**
I maintain 5+ side projects. Every morning:
```bash
cd ~/projects/app1 && git status
cd ~/projects/app2 && git status
cd ~/projects/app3 && git status
# ... you get the idea
```
10 minutes gone just re-orienting myself.

**The Solution:**
```bash
psa
```

Shows all projects with:
• Progress bars (visual completion %)
• Test coverage
• Recent commits
• Status (active/paused/complete)
• Fuzzy search to jump anywhere

**Tech:**
• Bash scripts with visual library
• jq for JSON processing
• fzf for interactive search
• Optional: gum, bat, delta, eza, figlet, lolcat
• Colorful ASCII charts & unicode box-drawing

**Bonus:**
If you use Claude Code for AI-assisted development, PSA tracks:
• Token usage per project
• Tokens per line (efficiency)
• Cost estimation
• Agent session analytics

**Works with ANY language:** Python, JavaScript, Rust, Go, etc.
**Works in ANY terminal:** Warp, iTerm2, VS Code, SSH sessions

Free and open source (MIT).

Screenshots in the repo. Would love to hear thoughts!

github.com/bradheitmann/psa
```

---

## Product Hunt Description

**Tagline:**
```
Beautiful terminal dashboard for managing multiple coding projects
```

**Description:**
```
PSA (Project State Agent) is a terminal-based project management dashboard for developers who maintain multiple codebases.

🎯 Solves:
Stop wasting 10+ minutes every morning running git status across 5+ directories trying to remember which project needs attention.

✨ Features:
• One-command overview of all projects
• Colorful ASCII visualizations (charts, progress bars, sparklines)
• Real-time metrics (LOC, test coverage, git activity)
• Fuzzy search navigation (fzf)
• Terminal-agnostic (works everywhere)
• Optional Claude Code integration (token tracking, AI efficiency metrics)

🚀 Benefits:
• Context-switch in seconds, not minutes
• See project health at a glance
• Track progress visually
• Works with ANY language (Python, JS, Rust, Go, etc.)
• Free & open source (MIT)

Built for terminal enthusiasts. No GUI, no bloat, just beautiful, functional dashboards.
```

**First Comment (Maker):**
```
Hey Product Hunt! 👋

I'm the maker of PSA. Built this to solve my own problem: maintaining 7 coding projects and losing track of what needs attention.

Happy to answer questions about:
• How it works under the hood
• The visual library design
• Claude Code integration
• Why terminal > GUI for this use case

Try it: One command install via Homebrew or npm.

What project management tools do you use? Curious to hear!
```

---

## Email Newsletter Announcement

**Subject:** Introducing PSA - Terminal Dashboard for Multi-Project Developers

**Body:**
```
Hey developers,

If you maintain multiple coding projects, I built something for you.

It's called PSA (Project State Agent) - a terminal dashboard that shows all your projects with metrics, progress, and git activity in one colorful view.

The Problem:
You wake up, open your terminal, and spend 10 minutes:
• cd ~/projects/app1 && git status
• cd ~/projects/app2 && git status
• Try to remember which one was at 60% vs 65%
• Figure out which needs tests
• Context-switch overhead before writing code

The Solution:
```bash
psa
```

Instantly see:
• All projects with visual progress bars
• Test coverage percentages
• Recent git commits
• Status (active/paused/complete)
• Fuzzy search to jump anywhere

Works with ANY language (Python, JS, Rust, Go).
Works in ANY terminal (Warp, iTerm2, VS Code, SSH).

Bonus: If you use Claude Code, track token usage and optimize AI efficiency.

Free and open source (MIT).

Try it: github.com/bradheitmann/psa

[Screenshot]

- Bradley
```

---

## Website Copy (Landing Page)

### Hero Section

**Headline:**
```
Stop Losing Track of Your Projects
```

**Subheadline:**
```
PSA shows all your codebases in one colorful terminal dashboard.
Context-switch in seconds, not minutes.
```

**CTA:**
```
[Install Now - Free]    [View Demo]
```

**Supporting text:**
```
Works with Python • JavaScript • Rust • Go • Any Language
macOS & Linux • Any Terminal • 100% Free & Open Source
```

---

### Problem Section

**Headline:**
```
The 10-Minute Morning Tax
```

**Body:**
```
You maintain 5+ coding projects.

Every morning starts the same way:

  cd ~/projects/app1 && git status
  cd ~/projects/app2 && git status
  cd ~/projects/app3 && git status

  "Wait, which one needed tests?"
  "Was I at 60% or 65% on the API?"
  "Which repo had that bug?"

10 minutes gone. You haven't written a single line of code.

There's a better way.
```

---

### Solution Section

**Headline:**
```
One Command. Everything.
```

**Body:**
```
  psa

That's it.

Instantly see:
✓ All projects with visual progress
✓ Test coverage percentages
✓ Recent git activity
✓ What needs attention (color-coded)
✓ Fuzzy search to jump anywhere

3 keystrokes to context-switch.
Beautiful ASCII visualizations.
Works in any terminal.
```

[Screenshot]

---

### Features Section (3-Column)

**Column 1:**
```
🎨 Beautiful
• Colorful ASCII charts
• Progress bars
• Sparklines
• Unicode box-drawing
• 3 color schemes
```

**Column 2:**
```
⚡ Fast
• One command to see all
• Fuzzy search (fzf)
• Keyboard-driven
• No GUI overhead
• Terminal-native
```

**Column 3:**
```
📊 Insightful
• LOC tracking
• Test coverage
• Git activity
• Custom metrics
• Optional AI tracking
```

---

### Testimonials Section (Placeholder)

```
"PSA saved me 2+ hours per week just in context-switching time."
— Developer, Indie Hacker

"Finally, a project dashboard that works in my terminal. No GUI needed."
— Developer, Remote Team

"The token tracking for Claude Code alone pays for itself."
— AI-Assisted Developer
```

---

### CTA Section

**Headline:**
```
Try PSA Today
```

**Body:**
```
Free forever. Open source. Works in 2 minutes.

  brew install psa
  psa scan
  psa

That's it. See all your projects.
```

**Buttons:**
```
[Install Now]    [View on GitHub]    [Read Docs]
```

---

## Comparison Table

### PSA vs. Alternatives

| Feature | PSA | GitHub Desktop | VSCode | Terminal |
|---------|-----|----------------|--------|----------|
| **Multi-project view** | ✅ One dashboard | ❌ One at a time | ❌ Switch workspaces | ❌ Manual cd |
| **Progress tracking** | ✅ Visual bars | ❌ None | ❌ None | ❌ Mental notes |
| **Test coverage** | ✅ Shown inline | ❌ None | ⚠️ Extensions | ❌ Run manually |
| **Token tracking (AI)** | ✅ Built-in | ❌ None | ❌ None | ❌ None |
| **Terminal-native** | ✅ Yes | ❌ GUI app | ⚠️ Integrated | ✅ Yes |
| **SSH-friendly** | ✅ Yes | ❌ No | ⚠️ Limited | ✅ Yes |
| **Keyboard-only** | ✅ Yes | ❌ Needs mouse | ⚠️ Mixed | ✅ Yes |
| **Setup time** | ✅ 2 min | ⚠️ 10 min | ⚠️ Per workspace | ✅ N/A |

---

## Objection Handling

### "Why not just use git status?"

**Response:**
```
git status works for ONE project.

PSA shows ALL projects at once.

Instead of:
  cd proj1 && git status  # 10 seconds
  cd proj2 && git status  # 10 seconds
  cd proj3 && git status  # 10 seconds
  # Mental tracking...

Do:
  psa  # 2 seconds, see everything

It's the difference between:
  "Let me check 5 terminals"
vs.
  "I can see my entire portfolio"
```

---

### "Why not use GitHub's project boards?"

**Response:**
```
GitHub is great for issues/PRs.

PSA is for LOCAL project state:
• What's on YOUR machine
• What YOU'RE working on
• YOUR local metrics (LOC, coverage)
• YOUR terminal workflow

Plus:
• Works offline
• No web browser needed
• Faster (terminal vs web)
• Custom metrics (GitHub doesn't track tokens/line)
```

---

### "Why terminal? Why not a GUI?"

**Response:**
```
Because you're ALREADY in the terminal.

As a developer, you:
• Write code in terminal/editor
• Run git commands in terminal
• Execute tests in terminal
• SSH to servers in terminal

Why switch to a GUI for project management?

PSA meets you where you work:
• Instant access (no app switching)
• Keyboard-driven (faster)
• SSH-friendly (works remotely)
• Resource-light (no Electron)
• Scriptable (automation-friendly)

Terminal-native = 0 context switches.
```

---

### "I only have 2 projects. Do I need this?"

**Response:**
```
If you have 2 projects and always remember their state, probably not.

PSA shines when:
• 3+ active projects
• Projects you don't touch daily
• Team collaboration (handoffs, evidence)
• AI-assisted development (cost tracking)

Try it anyway! It's free and installs in 2 min.

Worst case: You have a pretty `git status`.
Best case: You wonder how you lived without it.
```

---

## Before/After Visuals

### Before PSA (Text)

```
$ cd ~/projects/app1 && git status
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean

$ cd ~/projects/app2 && git status
On branch develop
Your branch is ahead of 'origin/develop' by 3 commits.

Changes not staged for commit:
  modified:   src/api.py

$ cd ~/projects/app3 && git status
...

[10 minutes later]

"Okay, so app1 is done, app2 needs a commit, app3 needs tests..."
```

**Time:** 10+ minutes
**Cognitive load:** HIGH
**Errors:** Forgot to check app4 and app5

---

### After PSA (Text)

```
$ psa

╔══════════════════════════════════════════════╗
║           PSA DASHBOARD                       ║
╚══════════════════════════════════════════════╝

  5 ACTIVE PROJECTS

┌──────────────────┬─────────┬──────────┬─────────┐
│ app1             │ ✓ DONE  │ 100%     │ Clean   │
│ app2             │ ● WORK  │  85%     │ 3 ahead │
│ app3             │ ⚠️  TEST │  70%     │ 78% cov │
│ app4             │ ● WORK  │  60%     │ Active  │
│ app5             │ ⏸ PAUSE │  30%     │ Blocked │
└──────────────────┴─────────┴──────────┴─────────┘

Press Enter to select project...
```

**Time:** 5 seconds
**Cognitive load:** ZERO
**Errors:** None, saw all 5 projects

---

## Feature Highlights (Copy-Paste)

### Highlight 1: Visual Progress Tracking

```
Track progress visually, not mentally.

Before:
  "I think I'm about 60% done with the API... or was it 70%?"

After:
  Progress: ████████████░░░░░░░  65%

No guessing. Just visual truth.
```

---

### Highlight 2: Multi-Project at a Glance

```
See everything without context-switching.

One command replaces:
  cd proj1 && git status
  cd proj2 && git status
  cd proj3 && git status
  cd proj4 && git status
  cd proj5 && git status

With:
  psa

5 commands → 1 command
50 seconds → 5 seconds
```

---

### Highlight 3: Beautiful Terminal UI

```
Who says terminals can't be beautiful?

PSA uses:
• 24-bit RGB colors (Catppuccin, Gruvbox, Tokyo Night)
• Unicode box-drawing
• Nerd Font icons
• ASCII bar charts & sparklines
• Gradient progress bars

It's functional AND gorgeous.
```

---

### Highlight 4: Works Everywhere

```
One tool. Any terminal.

• Warp
• iTerm2
• Terminal.app
• VS Code integrated terminal
• tmux
• SSH sessions
• Any Linux terminal

Install once. Works everywhere.
```

---

## Call to Action Variations

### Soft CTA
```
Curious? Check it out: github.com/bradheitmann/psa
```

### Medium CTA
```
Ready to stop losing track of your projects?

Install PSA:
  brew install psa

Free and open source.
```

### Strong CTA
```
Stop wasting 10 minutes every morning.

Install PSA now:
  brew install psa
  psa scan
  psa

See all your projects in one glance.
Free forever. 2-minute setup.

github.com/bradheitmann/psa
```

---

## Video Script (60 seconds)

```
[0:00] SCREEN: Multiple terminal tabs, developer frantically typing cd commands

[0:03] VOICEOVER: "If you're like me, you maintain multiple coding projects."

[0:06] SCREEN: git status outputs flying by, developer looking confused

[0:08] VO: "And every morning starts with a 10-minute ritual..."

[0:10] TEXT ON SCREEN:
  cd ~/projects/app1 && git status
  cd ~/projects/app2 && git status
  ...

[0:13] VO: "...just figuring out what you were working on."

[0:16] SCREEN: Tired developer, coffee, frustrated

[0:18] VO: "There's a better way."

[0:20] SCREEN: Terminal clears, types "psa", dashboard appears

[0:22] VO: "PSA - Project State Agent."

[0:24] SCREEN: Colorful dashboard with all projects, progress bars

[0:26] VO: "One command. All your projects. Beautiful visualizations."

[0:30] SCREEN: Fuzzy search, typing "api", selecting, jumping to project

[0:32] VO: "Jump to any project in 3 keystrokes."

[0:35] SCREEN: Shows metrics - LOC, coverage, commits

[0:37] VO: "See metrics that matter. Test coverage. Git activity. Progress."

[0:41] SCREEN: Shows Claude Code token tracking

[0:43] VO: "Bonus: Track AI token usage if you use Claude Code."

[0:46] SCREEN: Works in different terminals - Warp, iTerm2, VS Code

[0:48] VO: "Works in any terminal. macOS. Linux. SSH sessions."

[0:52] SCREEN: Installation command: brew install psa

[0:54] VO: "Free and open source. Install in 2 minutes."

[0:57] SCREEN: Logo + github.com/bradheitmann/psa

[1:00] VO: "PSA. Stop losing track."
```

---

**Created for PSA v2.0.0 Marketing Campaign**
