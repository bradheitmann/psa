---
description: "Update outdated PSA protocol tools to latest versions"
---

Check for updates to PSA protocol tools and upgrade outdated ones via Homebrew.

**Process:**

1. Check installed tools against latest versions:
   ```bash
   brew outdated --formula
   brew outdated --cask
   ```

2. Filter for PSA tools only (from ~/.psa/lib/tools-registry.json)

3. Color-code display:
   - 🟢 Green: Up to date
   - 🟡 Yellow: Minor update available (patch/minor)
   - 🔴 **BRIGHT PINK/Magenta**: Major update available

   ```
   PSA Tools Update Status:

   🟢 git: 2.51.2 (latest)
   🟢 ripgrep: 15.1.0 (latest)
   🟡 node: 25.2.0 → 25.3.0 (minor update)
   🔴 claude-code: 2.0.46 → 2.1.0 (major update available!)
   🟡 fzf: 0.66.1 → 0.67.0 (minor update)

   Summary:
   - Up to date: 15 tools
   - Minor updates: 2 tools
   - Major updates: 1 tool (review changelog!)
   ```

4. Ask user:
   ```
   Update outdated tools? This will run:
   brew upgrade node fzf
   brew upgrade --cask claude-code

   ⚠️  Major update detected for claude-code
   Review changelog: https://github.com/anthropics/claude-code/releases

   Continue? (Y/n)
   ```

5. If user confirms, execute:
   ```bash
   brew upgrade node fzf
   brew upgrade --cask claude-code
   ```

6. Report results:
   ```
   ✅ Updated: node 25.2.0 → 25.3.0
   ✅ Updated: fzf 0.66.1 → 0.67.0
   ✅ Updated: claude-code 2.0.46 → 2.1.0

   ⚠️  Restart required:
   - claude-code: Restart Claude Code to use new version

   Summary:
   - Updated: 3/3
   - All PSA tools current!
   ```

Use semantic versioning to detect major updates:
- X.0.0 → (X+1).0.0 = MAJOR (breaking changes possible)
- 0.X.0 → 0.(X+1).0 = MINOR (new features)
- 0.0.X → 0.0.(X+1) = PATCH (bug fixes)

Mark major updates in BRIGHT PINK/magenta to warn user.
