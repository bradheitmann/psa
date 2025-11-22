---
description: "Update PSA to latest version from GitHub"
---

Update PSA (Project State Agent) system to the latest version.

**Process:**

1. Check current PSA installation:
   ```bash
   cd ~/.psa
   git status
   git log -1 --oneline
   ```

2. If git repo exists, update:
   ```bash
   cd ~/.psa
   bash scripts/update-psa.sh
   ```

   This will:
   - Fetch latest from github.com/bradheitmann/psa
   - Show changelog of updates
   - Ask for confirmation
   - Pull latest changes
   - Re-run installer
   - Update permissions

3. If not a git repo, show reinstall instructions:
   ```
   PSA was not installed via git. To update:

   1. Backup data: cp -r ~/.psa ~/.psa.backup
   2. Remove old: rm -rf ~/.psa
   3. Clone latest: git clone https://github.com/bradheitmann/psa.git ~/.psa
   4. Install: cd ~/.psa && ./install.sh
   5. Restore data: cp ~/.psa.backup/AGENTS_MASTER.md ~/.psa/
   ```

4. After update, reload shell:
   ```bash
   source ~/.zshrc  # or ~/.bashrc
   ```

5. Verify update:
   ```bash
   psa help  # Should show new commands
   cat ~/.psa/VERSION  # Should show latest version
   ```

**New features to check after update:**
- `psa bloat-scan` - Bloat management
- `psa canonicalize` - Extract examples
- `/psa-tools-list` - Tool inventory
- `/psa-tools-update` - Tool updates
- `/psa-shortcuts` - Power shortcuts

**If update fails:**
- Check internet connection
- Verify GitHub access
- Check for local file conflicts
- Try: `cd ~/.psa && git reset --hard origin/main`

Report success or any errors encountered.
