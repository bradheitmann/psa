---
description: "List PSA protocol tools and their installation status"
---

List all tools from PSA PACKAGE-MANAGER protocol with installation status, current versions, and availability.

Check the following tools defined in ~/.psa/lib/tools-registry.json:

**Critical Tools:**
- git, node, bun, python, pnpm, uv, ripgrep, fzf, fd, gh, claude-code

**Optional Tools:**
- bat, eza, cursor, warp, zoxide, starship, git-delta, glow, pipx

For each tool, show:
- Name
- Description (one line)
- Installed: YES/NO
- Current version (if installed)
- Latest available version (check Homebrew)
- Status: ✅ Up to date | ⚠️ Update available | ❌ Not installed

Format as clean table:
```
Tool         | Installed | Current    | Latest     | Status
------------ | --------- | ---------- | ---------- | ------
git          | YES       | 2.51.2     | 2.51.2     | ✅
ripgrep      | YES       | 15.1.0     | 15.1.0     | ✅
claude-code  | YES       | 2.0.46     | 2.0.50     | ⚠️
bat          | NO        | -          | 0.24.0     | ❌
```

After table, show:
- Total tools: X
- Installed: Y
- Up to date: Z
- Need updates: W
- Not installed: V

Commands available:
- `/psa-tools-install` - Install missing tools
- `/psa-tools-update` - Update outdated tools

Use Bash tool to check:
- `brew list --formula | grep {tool}`
- `brew list --cask | grep {tool}`
- `{tool} --version`
- `brew info {tool}` for latest version
