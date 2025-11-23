---
description: "PSA power shortcuts and command combos reference"
---

PSA Protocol Power Shortcuts - Quick inline reference for terminal productivity.

Output as a compact cheat sheet with categories. One line per shortcut. No explanations unless essential.

Format:
```
Action: command
```

Categories to include:

**🔍 SEARCH & FILTER COMBOS**
```
Find TODOs, select, view:           rg -l "TODO" | fzf | xargs bat
Search code, select, edit:          rg -l "pattern" | fzf | xargs code
Find TS files, fuzzy select:        fd -e ts | fzf
Find files, select multiple, copy:  fd pattern | fzf -m | xargs -I {} cp {} dest/
Browse all markdown docs:           fd '.md$' | fzf | xargs glow
Search with context, less:          rg "pattern" -A 5 -B 2 --color always | less -R
```

**⚡ GIT SHORTCUTS**
```
Interactive git add:                git status -s | fzf -m | awk '{print $2}' | xargs git add
Browse commits, select:             git log --oneline | fzf
Checkout branch interactively:     git branch | fzf | xargs git checkout
Browse PRs:                         gh pr list | fzf
Show changed files only:            git diff --name-only
Undo last commit (keep changes):   git reset --soft HEAD~1
```

**🚀 PROJECT/PSA SHORTCUTS**
```
Jump to project:                    z project-name
Jump to project, show state:       z project && psa
View state across projects:         glow ~/.warp/AGENTS.md
Launch full dev environment:        ./scripts/warp-launch.sh
Find and view project docs:         fd '.md$' docs/ | fzf | xargs glow
```

**📦 PNPM (NOT NPM!) SHORTCUTS**
```
Install dependencies:               pnpm install
Run dev server:                     pnpm dev
Run tests in watch mode:            pnpm test --watch
Run specific script:                pnpm <script-name>
Add dependency:                     pnpm add <package>
Remove dependency:                  pnpm remove <package>
Update all:                         pnpm update
```

**🎨 FILE OPERATIONS**
```
Better ls with git status:          eza -la --git --icons
Tree view (2 levels):               eza --tree --level=2 --icons
Find and view files:                fd pattern | xargs bat
Find large files:                   fd -t f -x du -h | sort -rh | head -20
Count files by type:                fd -e ts | wc -l
Find recently modified:             fd -t f --changed-within 1d
```

**🔧 TEXT PROCESSING**
```
Find and replace in files:          rg -l "old" | xargs sed -i '' 's/old/new/g'
Count occurrences:                  rg "pattern" --count
Search case-insensitive:            rg -i "pattern"
Search only in TypeScript:          rg "pattern" -t typescript
Exclude node_modules:               rg "pattern" --glob '!node_modules'
```

**⌨️  KEYBOARD SHORTCUTS**
```
FZF file search:                    CTRL+T
FZF command history:                CTRL+R
FZF directory jump:                 ALT+C
Toggle FZF preview:                 CTRL+/
Tmux vertical split:                CTRL+B %
Tmux horizontal split:              CTRL+B "
Tmux navigate panes:                CTRL+B <arrows>
Tmux detach:                        CTRL+B D
```

**🪟 WARP COMBOS**
```
New Warp window:                    CMD+T
Split pane:                         CMD+D
Command palette:                    CMD+K
Copy block:                         CMD+Shift+C
```

**💡 SMART NAVIGATION**
```
Jump to frequent dir:               z project
Jump to previous dir:               z -
Interactive dir picker:             zi
List zoxide database:               zoxide query -l
```

**🎯 ONE-LINER POWER MOVES**
```
Interactive kill process:           ps aux | fzf | awk '{print $2}' | xargs kill
Find env vars:                      env | fzf
Find running ports:                 lsof -i -P | grep LISTEN | fzf
Git log with file changes:          git log --stat | bat
Show file with line numbers:        bat -n file.ts
JSON pretty print:                  cat file.json | jq '.' | bat -l json
```

**🤖 CLAUDE CODE COMMANDS**
```
This cheat sheet:                   /cutme
Launch dev environment:             /launch-dev
Show project state:                 /psa-status
Generate Warp windows:              /warp-windows
Initialize new project:             /init-new-project
```

**📝 ALIASES TO REMEMBER**
```
psa                                 PSA dashboard
psai                                PSA interactive
new-project                         Init project with PSA
agents                              View agent registry
master-guide                        View complete guide
```

**🔥 COMBO CHAINS (ADVANCED)**
```
Find → Select → View → Edit:        fd -e ts | fzf | xargs bat && code $_
Search → Count → Sort:               rg "import" -c | sort -rn | head -10
Git diff → Select file → View:      git diff --name-only | fzf | xargs git diff
Find todos → Create issues:         rg "TODO:" | gum filter | xargs -I {} gh issue create --title {}
```

Present as a dense, scannable reference. No verbose explanations. Maximum information density.
