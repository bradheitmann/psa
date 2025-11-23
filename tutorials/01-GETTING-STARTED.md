# Getting Started with PSA

## Tutorial 1: Your First Project

**Time: 5 minutes**

### What You'll Learn:
- Install PSA
- Initialize your first project
- View the dashboard
- Track basic metrics

---

## Step 1: Install PSA

```bash
# Install via Homebrew (recommended)
brew tap bradheitmann/psa
brew install psa

# Or manual install
git clone https://github.com/bradheitmann/psa.git
cd psa
./install.sh
```

**Verify installation:**
```bash
psa version
# Output: PSA (Project State Agent) v2.0.0
```

---

## Step 2: Navigate to Your Project

PSA works with **any** project (Python, JavaScript, Rust, etc.).

```bash
# Example: A Python Flask app
cd ~/projects/my-flask-app
```

**Don't have a project?** Create one:
```bash
mkdir -p ~/projects/demo-app && cd ~/projects/demo-app
echo "# Demo App" > README.md
git init
```

---

## Step 3: Initialize PSA Tracking

```bash
psa:init demo-app
```

**What this does:**
- Creates `PROJECT.json` with metadata
- Creates `PROJECT-METRICS.json` for metrics
- Sets up `docs/evidence/` directory

**View the created file:**
```bash
cat PROJECT.json
```

You'll see:
```json
{
  "meta": {
    "name": "demo-app",
    "displayName": "demo-app",
    "status": "active",
    "type": "web-app",
    "created": "2024-11-21T00:00:00Z"
  },
  "location": {
    "path": "/Users/you/projects/demo-app",
    "github": "",
    "pmSession": ""
  },
  "progress": {
    "percentComplete": 0,
    "currentPhase": "planning"
  }
}
```

---

## Step 4: Customize Your Project

Edit `PROJECT.json` with your project details:

```json
{
  "meta": {
    "displayName": "My Awesome App",
    "description": "A web app that does cool things",
    "status": "active",
    "type": "web-app"
  },
  "progress": {
    "percentComplete": 25,
    "currentPhase": "development"
  },
  "tech": {
    "languages": ["Python", "JavaScript"],
    "frameworks": ["Flask", "React"],
    "runtime": "python",
    "packageManager": "pip"
  }
}
```

---

## Step 5: Scan Projects

Tell PSA to find all your projects:

```bash
psa scan
```

**Output:**
```
🔍 Scanning projects...
  Found: demo-app
  Found: my-other-project
  Found: side-project
✅ Registry created: ~/.psa/data/projects-registry.json
   Found 3 projects
```

---

## Step 6: View the Dashboard

```bash
psa
```

**You'll see:**
- Beautiful ASCII header
- Project overview with stats
- Status indicators (color-coded)
- Progress bars
- Recent activity

**Navigate:**
- Press `Enter` to see project list
- Use arrow keys or `fzf` to select projects
- View detailed project information

---

## Step 7: List All Projects

```bash
psa list
```

**Output:**
```
PSA PROJECT LIST

  demo-app          active    25%    1.2K      web-app
  my-other-project  active    65%    8.5K      cli-tool
  side-project      paused    40%    3.2K      library
```

---

## Step 8: View Project Details

```bash
psa show demo-app
```

**You'll see:**
- Project name & status badge
- File path & GitHub URL
- Progress bar (visual)
- Metrics (LOC, coverage, etc.)
- Quick actions menu

---

## Next Steps

### ✅ You've learned:
- [x] Install PSA
- [x] Initialize a project
- [x] Customize PROJECT.json
- [x] Scan projects
- [x] View dashboard
- [x] List & view projects

### 📚 Continue learning:
- **Tutorial 2:** [Global Project Management](02-GLOBAL-MANAGEMENT.md)
- **Tutorial 3:** [Metrics & Tracking](03-METRICS-TRACKING.md)
- **Tutorial 4:** [Claude Code Integration](04-CLAUDE-CODE.md)

---

## Quick Reference

```bash
# Essential commands
psa                     # Open dashboard
psa scan                # Scan for projects
psa list                # List all projects
psa show <project>      # View project details
psa:init <name>         # Initialize new project

# Configuration
psa:config:show         # Show current config
psa:config:edit         # Edit config file

# Help
psa help                # Full command list
psa version             # Show version
```

---

## Troubleshooting

**Dashboard doesn't show colors?**
- Check terminal supports 24-bit color
- Try: `echo -e "\033[38;2;255;100;0mTEST\033[0m"`

**No projects found?**
- Check `~/.psa/config.json` has correct `projectDirs`
- Run `psa scan` to refresh

**jq not found?**
- Install: `brew install jq`
- jq is required for PSA

---

**🎉 You're now ready to use PSA!**

Next: Learn advanced features in [Tutorial 2: Global Management](02-GLOBAL-MANAGEMENT.md)
