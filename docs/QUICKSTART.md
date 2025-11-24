# PSA Quickstart - 5 Minutes to Productive

Welcome! This guide will get you using PSA in under 5 minutes, even if you've never used a terminal before.

## What is PSA?

PSA (Project State Agent) helps you work smarter with AI coding assistants like Claude Code. Think of it as your personal assistant that:
- Tracks what AI models work best for different tasks
- Keeps your development tools up-to-date
- Organizes all your coding projects in one place
- Helps AI agents understand your projects better

**No technical knowledge required.** Just copy and paste the commands below.

---

## Step 1: Check if PSA is Working (30 seconds)

### Open Your Terminal

**On Mac:**
1. Press `Command + Space` (or click the magnifying glass in top-right corner)
2. Type "Terminal"
3. Press Enter

A window with text will appear. This is your terminal.

### Run Your First Command

Copy this text exactly (click to select, then `Command+C` to copy):

```bash
psa help
```

Then:
1. Click in the terminal window
2. Press `Command+V` to paste
3. Press Enter

**What you should see:** A list of PSA commands with green text.

**If you see an error** saying "command not found":
```bash
~/.psa/install.sh
```

This will install PSA. Follow the prompts, then **close your terminal window completely** and open a new one.

---

## Step 2: See What PSA Can Do (1 minute)

Now that PSA is working, let's see what it offers.

### View Your Environment

```bash
psa context
```

**What this shows:**
- What versions of Node, Python, Bun you have installed
- What development tools are available
- Your system information

This is useful when AI agents help you code - they need to know what tools you have.

### Check for Updates

```bash
psa check-updates
```

**What this shows:**
- Which tools have newer versions available
- What you might want to upgrade

Don't worry - **this only checks**, it doesn't change anything yet.

---

## Step 3: Key Commands You'll Use Daily (3 minutes)

Here are the commands you'll use most often. Try each one!

### Create Your First Project

```bash
psa init-project my-first-app
```

**What just happened?**
PSA created:
- A folder at `~/dev_projects/my-first-app`
- Special files that help AI agents understand your project
- Configuration files with best practices

### Navigate to Your Project

```bash
cd ~/dev_projects/my-first-app
```

**Pro tip:** `cd` means "change directory" - it's like clicking on a folder.

### See What's Inside

```bash
ls -la
```

You should see files like:
- `AGENTS.md` - Tells AI agents how to work on this project
- `CLAUDE.md` - Specific guidance for Claude Code
- Protocol files in `docs/protocols/`

### View Your Project Configuration

```bash
cat AGENTS.md
```

**What this shows:** Instructions that AI agents read to understand how to help you with this project.

### Go Back to Home Directory

```bash
cd ~
```

The `~` symbol is a shortcut for your home folder.

---

## Step 4: Understanding What PSA Does

### Track AI Learnings

As you work with AI agents, you'll notice patterns - "Claude is great at TypeScript" or "This works better for Python."

Report these observations:

```bash
psa report "claude-sonnet-4-5" "Excellent at explaining complex code"
```

**What this does:**
- Records your observation
- Adds timestamp and project name
- Saves it to your global knowledge base

Over time, you build a personal "cheat sheet" of what works best.

### View All Your Learnings

```bash
psa view-master
```

**What this shows:**
- All agent configurations ("loadouts")
- Observations you've recorded
- Best practices that emerged from your work

This is your growing knowledge base about working with AI agents.

### See All Your Projects (Dashboard)

```bash
psa dash
```

**What this shows:**
- All projects PSA is tracking
- Their current state
- Quick stats about each

**Pro tip:** This command opens an interactive dashboard - use arrow keys to navigate, Enter to select, `q` to quit.

---

## Next Steps: What to Learn Next

Now that you've got the basics, here are your next learning paths:

### 1. **Set Up Your Development Environment**
If you want to add more tools or update existing ones:
```bash
psa upgrade-all
```
This updates all your development tools to the latest versions.

### 2. **Learn Project Management**
Read the detailed user flows:
```bash
cat ~/.psa/docs/USER-FLOWS.md
```
(This is a big file - you'll see lots of examples!)

### 3. **Sync Protocols to Existing Projects**
If you have existing projects, add PSA to them:
```bash
cd ~/path/to/existing-project
psa sync-to-project
```

### 4. **Keep PSA Updated**
Get the latest PSA features:
```bash
psa update-self
```

### 5. **Understand the Protocols**
PSA includes best-practice protocols like MVC (Minimum Viable Context):
```bash
ls ~/.psa/protocols/
```

### 6. **Track Terminal Learnings**
When you learn useful terminal commands:
```bash
psa report-terminal git "Using --fixup makes cleaner commit history"
```

---

## Common Questions

### "What's the difference between `psa help` and `psa --help`?"
They do the same thing! Use whichever you remember.

### "Can I delete a project from PSA?"
Yes - just delete the folder, and PSA will stop tracking it on next scan.

### "Will PSA change my existing projects?"
No! PSA only adds configuration files (AGENTS.md, protocols). It never modifies your code.

### "What if I make a mistake?"
Almost all PSA commands are safe - they either read information or create new files. The only commands that change things are:
- `psa upgrade-*` (updates tools)
- `psa update-self` (updates PSA itself)

And even those ask for confirmation first.

### "Do I need to be online?"
Most commands work offline. Only updates and upgrades need internet.

---

## Common Issues & Fixes

### Problem: `psa: command not found`

**Solution:**
```bash
~/.psa/install.sh
```

Then **close your terminal completely** and open a new one.

### Problem: `Permission denied`

**Solution:**
```bash
chmod +x ~/.psa/scripts/*.sh ~/.psa/scripts/psa
```

This makes PSA scripts executable.

### Problem: Can't find `.psa` folder

**What happened:** The `.psa` folder is hidden (starts with a dot).

**To see it:**
```bash
ls -la ~/ | grep psa
```

**To open it in Finder:**
```bash
open ~/.psa
```

### Problem: `pnpm: command not found` when upgrading

**What happened:** You need pnpm installed for global tool management.

**Solution:**
```bash
curl -fsSL https://get.pnpm.io/install.sh | sh -
```

Then close and reopen your terminal.

### Problem: Nothing happens when I paste commands

**Check:**
1. Did you press Enter after pasting?
2. Is your cursor in the terminal window?
3. Try typing the command manually instead of pasting

### Stuck? Need Help?

Run the diagnostic:
```bash
psa context
```

This shows your system state - share this with support/colleagues if you need help.

---

## Terminal Tips for Beginners

### Copy & Paste in Terminal
- **Copy:** Select text, then `Command+C`
- **Paste:** `Command+V`
- **Special paste:** `Command+Shift+V` (sometimes needed)

### Navigation
- `cd foldername` - Go into a folder
- `cd ..` - Go up one level
- `cd ~` - Go to home directory
- `pwd` - Show current location

### Viewing Files
- `ls` - List files in current folder
- `ls -la` - List all files (including hidden ones)
- `cat filename` - Show contents of a file
- `less filename` - View file with scrolling (press `q` to quit)

### Getting Help
- Most commands: `commandname --help`
- PSA specifically: `psa help`
- Stuck in a command? Press `Ctrl+C` to cancel

### Terminal is Frozen?
Press `Ctrl+C` to stop current command.

---

## What's Next?

Congratulations! You've completed the quickstart. You now know how to:
- ✅ Run PSA commands
- ✅ Create new projects with best practices
- ✅ Track AI agent learnings
- ✅ Check your environment
- ✅ Navigate the terminal basics

### Recommended Learning Path:

**Week 1:** Just use the basics
- `psa init-project` when starting new projects
- `psa report` when you notice patterns
- `psa help` when you forget commands

**Week 2:** Explore more
- `psa dash` to see all projects
- `psa view-master` to review learnings
- `psa context` before asking AI agents for help

**Week 3:** Go deeper
- Read `USER-FLOWS.md` for detailed workflows
- Explore protocols in `~/.psa/protocols/`
- Customize your `AGENTS.md` files

**Month 2+:** Advanced features
- Set up automatic updates
- Create custom loadout configurations
- Build your canonical examples library

---

## Quick Reference Card

Copy this and keep it handy:

```bash
# Essential Commands
psa help                    # Show all commands
psa context                 # Show system info
psa init-project <name>     # Create new project
psa dash                    # View all projects

# Learning & Tracking
psa report <model> <note>   # Record observation
psa view-master             # See all learnings

# Maintenance
psa check-updates           # Check for updates
psa upgrade-all             # Update everything
psa update-self             # Update PSA itself

# Project Sync
psa sync-to-project         # Add PSA to current project
psa sync-protocols          # Update protocols in project
```

---

## Learn More

- **Full Documentation:** `~/.psa/README.md`
- **User Flows:** `~/.psa/docs/USER-FLOWS.md`
- **Protocols:** `~/.psa/protocols/`
- **Examples:** `~/.psa/examples/`
- **Your Knowledge Base:** `~/.psa/AGENTS_MASTER.md`

---

## Final Encouragement

You don't need to understand everything at once. PSA is designed to grow with you:

- **Today:** Just use `psa init-project` and `psa help`
- **This Week:** Add `psa report` when you notice patterns
- **This Month:** Explore the dashboard and view-master
- **Over Time:** Build deep knowledge about AI agents

**The system learns as you learn.**

Welcome to PSA - happy coding!

---

**Estimated reading time:** 4 minutes
**Hands-on practice time:** 5-10 minutes
**Time to productivity:** Immediate

*Last updated: 2025-11-23*
