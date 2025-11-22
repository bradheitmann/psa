---
description: "Install missing PSA protocol tools via Homebrew"
---

Install all missing PSA protocol tools defined in ~/.psa/lib/tools-registry.json

**Process:**

1. Check which tools are NOT installed:
   ```bash
   brew list --formula | grep {tool}
   brew list --cask | grep {tool}
   ```

2. Show list of missing tools with one-line descriptions:
   ```
   Missing PSA Tools:

   Critical (Required):
   - ripgrep: Fast grep alternative for code search
   - fzf: Fuzzy finder for interactive selection
   - fd: Fast find alternative
   - gh: GitHub CLI for PR management

   Optional (Recommended):
   - bat: Cat with syntax highlighting
   - eza: Modern ls replacement
   - zoxide: Smart directory jumper

   Total: 7 missing tools
   ```

3. Ask user:
   ```
   Install missing tools? This will run:
   brew install ripgrep fzf fd gh bat eza zoxide

   Continue? (Y/n)
   ```

4. If user confirms, execute:
   ```bash
   brew install ripgrep fzf fd gh
   brew install bat eza zoxide glow
   brew install --cask claude-code cursor warp
   ```

5. Verify installations:
   ```bash
   {tool} --version
   ```

6. Report results:
   ```
   ✅ Installed: ripgrep 15.1.0
   ✅ Installed: fzf 0.67.0
   ✅ Installed: fd 10.3.0
   ❌ Failed: {tool} (error message)

   Summary:
   - Successful: 6/7
   - Failed: 1/7
   ```

Use the install order from tools-registry.json to ensure dependencies are met.

Follow PSA PACKAGE-MANAGER protocol for tool installation.
