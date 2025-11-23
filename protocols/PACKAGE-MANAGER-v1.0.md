# Package Manager Hierarchy Protocol

**Version:** 1.0
**Date:** 2024-11-17
**Status:** Active
**Purpose:** Enforce consistent, modern package management across all languages and projects

---

## Core Principle

**Install tools at the appropriate level using the best tool for that ecosystem.**

```
Homebrew (System) → Language Package Managers (Global) → Project Package Managers (Local)
```

---

## Decision Tree

```
Need a tool/package?
    ↓
Is it a system program, app, or language runtime?
    ↓ YES → Homebrew
    ↓ NO
    ↓
Is it a global CLI tool?
    ↓ YES → Use language-specific global installer (see below)
    ↓ NO
    ↓
Is it a project dependency?
    ↓ YES → Use project package manager (see below)
```

---

## Language-Specific Rules

### **JavaScript / TypeScript / Node.js**

#### System Level:
```bash
brew install node          # Node.js runtime
brew install bun           # Bun runtime (preferred for new projects)
```

#### Global CLI Tools:
```bash
npx pnpm install -g <package>    # ✅ ALWAYS use pnpm
npm install -g <package>          # ❌ BLOCKED (auto-redirects to pnpm)
bun install -g <package>          # ❌ AVOID (use pnpm for consistency)
```

**Examples:**
```bash
npx pnpm install -g @kilocode/cli
npx pnpm install -g @github/copilot
npx pnpm install -g @biomejs/biome
npx pnpm install -g vercel
npx pnpm install -g typescript
```

#### Project Dependencies:

**For NEW projects:**
```bash
bun init                   # Initialize new Bun project
bun install                # Install dependencies
bun add <package>          # Add package
```

**For EXISTING projects (yours or others'):**
```bash
pnpm install               # Install dependencies
pnpm add <package>         # Add package
```

**NEVER:**
```bash
npm install                # ❌ Blocked, redirects to pnpm
```

---

### **Python**

#### System Level:
```bash
brew install python@3.13   # Python runtime
brew install pyenv         # Version manager (if needed)
brew install uv            # Modern package manager
```

#### Global CLI Tools:
```bash
pipx install <tool>        # ✅ Isolated global tools
```

**Examples:**
```bash
pipx install black         # Code formatter
pipx install ruff          # Linter
pipx install poetry        # Legacy project manager (if needed)
```

**NEVER:**
```bash
pip install <package>      # ❌ Pollutes system Python
```

#### Project Dependencies:

**For NEW projects:**
```bash
uv init                    # Initialize new project
uv pip install <package>   # Add package
uv venv                    # Create virtual environment
```

**For EXISTING projects:**
```bash
# If using uv
uv pip sync                # Install from requirements

# If using poetry (legacy)
poetry install

# If using venv (manual)
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

---

### **Rust**

#### System Level:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

#### Global CLI Tools:
```bash
cargo install <crate>      # ✅ Rust's package manager
```

**Examples:**
```bash
cargo install tokei        # Code counter
cargo install cargo-watch  # Auto-rebuild
```

**Note:** Some Rust tools available via Homebrew:
```bash
brew install ripgrep       # Faster than cargo install
brew install bat
brew install fd
```

#### Project Dependencies:
```bash
cargo add <crate>          # Add dependency
cargo build                # Build project
```

---

### **Go**

#### System Level:
```bash
brew install go            # Go runtime
```

#### Global CLI Tools:
```bash
go install <package>       # ✅ Go's installer
```

**Examples:**
```bash
go install github.com/user/tool@latest
```

#### Project Dependencies:
```bash
go mod init <module>       # Initialize module
go get <package>           # Add dependency
```

---

### **Swift**

#### System Level:
```bash
# Comes with Xcode
xcode-select --install
```

#### Project Dependencies:
```bash
# Swift Package Manager (built-in)
# Add dependencies via Xcode or Package.swift
```

---

### **Databases**

#### System Level:
```bash
brew install postgresql@16 # PostgreSQL
brew install mysql         # MySQL
brew install sqlite        # SQLite
brew install neo4j         # Neo4j graph database
```

---

### **React / Svelte / TanStack (JavaScript Frameworks)**

**These are JavaScript libraries, use JS rules above:**
```bash
# New projects
bun add react
bun add @tanstack/react-query
bun add svelte

# Existing projects
pnpm add react
pnpm add @tanstack/react-query
pnpm add svelte
```

---

### **CSS / HTML / Markdown / TOML / XML (File Formats)**

**Tools for these:**
```bash
# Via Homebrew
brew install pandoc        # Markdown converter
brew install glow          # Markdown viewer

# Via pnpm (JS ecosystem)
npx pnpm install -g tailwindcss   # CSS framework
npx pnpm install -g postcss       # CSS processor

# Via language-specific (Python, Rust, etc.)
pipx install markdown      # Python markdown tools
```

---

## Summary Table

| Language/Tool | System | Global CLI | Project |
|---------------|--------|------------|---------|
| **JavaScript/TS** | brew (node/bun) | pnpm -g | bun (new) / pnpm (existing) |
| **Python** | brew (python/uv) | pipx | uv (new) / poetry (legacy) |
| **Rust** | rustup | cargo install | cargo |
| **Go** | brew | go install | go mod |
| **Swift** | Xcode | N/A | SPM |
| **Databases** | brew | N/A | N/A |

---

## Enforcement

### **npm Blocking (JavaScript/TypeScript)**

**In `~/.zshrc`:**
```bash
npm() {
  echo "🚫 npm is disabled. Using pnpm instead..."
  echo "💡 Command translated: npm $@ → pnpm $@"
  command npx pnpm "$@"
}
```

**Result:** All `npm` commands automatically redirect to `pnpm`.

---

## For AI Agents

**Add to project CLAUDE.md:**

```markdown
## Package Management Rules

**CRITICAL:** Follow these rules strictly:

1. **JavaScript/TypeScript:**
   - System tools: `brew install`
   - Global CLIs: `npx pnpm install -g <package>`
   - Project (new): `bun add <package>`
   - Project (existing): `pnpm add <package>`
   - **NEVER use npm** (it's blocked)

2. **Python:**
   - System tools: `brew install`
   - Global CLIs: `pipx install <tool>`
   - Projects: `uv pip install <package>`

3. **Rust:**
   - Global tools: `cargo install <crate>`
   - Projects: `cargo add <crate>`

4. **Go:**
   - Global tools: `go install <package>`
   - Projects: `go get <package>`

**When in doubt:** Check ~/.psa/protocols/PACKAGE-MANAGER-v1.0.md
```

---

## Verification Commands

**Check what's installed where:**
```bash
# Homebrew
brew list --formula | grep <tool>
brew list --cask | grep <tool>

# pnpm global
npx pnpm list -g --depth=0

# Python pipx
pipx list

# Rust cargo
cargo install --list

# Go
ls $GOPATH/bin
```

---

## Migration Path (When Switching to This Protocol)

1. **Audit existing packages:**
   ```bash
   npm list -g --depth=0        # See npm global packages
   pip list --user              # See user-level Python packages
   ```

2. **Remove old versions:**
   ```bash
   npm uninstall -g <package>   # Remove from npm
   pip uninstall <package>      # Remove from Python
   ```

3. **Reinstall correctly:**
   ```bash
   npx pnpm install -g <package>  # For JS tools
   pipx install <tool>             # For Python tools
   ```

---

## Benefits

1. **Consistency:** Same pattern across all projects
2. **Speed:** Modern tools (pnpm, uv, Bun) are 10-100x faster
3. **Isolation:** Project dependencies don't conflict
4. **AI-Friendly:** Clear rules for agents to follow
5. **Maintainability:** Easy to update and audit packages

---

## Version History

- **v1.0** (2024-11-17): Initial protocol created
  - Established Homebrew → Language PM → Project PM hierarchy
  - Enforced pnpm for JavaScript (blocked npm)
  - Adopted uv for Python
  - Documented multi-language support

---

## See Also

- **MVC Protocol** (Minimum Viable Context)
- **RAD Protocol** (Rehydrating Agentic Development)
- **~/.psa/AGENTS_MASTER.md** (Loadout configurations)
