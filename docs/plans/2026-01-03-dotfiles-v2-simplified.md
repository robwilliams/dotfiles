# Dotfiles v2 Implementation Plan (Simplified)

> **For Claude:** REQUIRED SUB-SKILL: Use bob:executing-plans to implement this plan task-by-task.

**Goal:** Cross-platform dotfiles with shell parity - fish primary, zsh/bash fallbacks.

**Architecture:** Standard chezmoi setup. Aliases defined once, templated to all shells. Tool guards everywhere. Minimal configs.

**Tech Stack:** chezmoi

---

## Phase 1: Shell Config Foundation

### Task 1.1: Add aliases to chezmoi data

**Files:**
- Modify: `.chezmoi.yaml.tmpl`

**Step 1: Read current file**

```bash
cat .chezmoi.yaml.tmpl
```

**Step 2: Add aliases data section**

Add after existing data:

```yaml
  aliases:
    g: "git status"
    ga: "git add"
    gap: "git add -p"
    gc: "git commit --verbose"
    gd: "git diff"
    gco: "git checkout"
    gcm: "git checkout main"
    gl: "git log"
    gcan: "git commit --amend --no-edit"
    gpull: "git pull"
    gpush: "git push"
    gstash: "git stash"
    gs: "git show"
    ggrep: "git grep"
    ggraph: "git log --graph --oneline --decorate --all"
    glog: "git log --oneline --decorate --all"
    ll: "ls -l"
    la: "ls -a"
    cls: "clear"
    cm: "chezmoi"
    vi: "vim"
```

**Step 3: Commit**

```bash
git add .chezmoi.yaml.tmpl
git commit -m "feat: add aliases to chezmoi data"
```

---

### Task 1.2: Create ~/.profile

**Files:**
- Create: `dot_profile`

**Step 1: Write file**

```sh
# ~/.profile - shared environment for all POSIX shells

# PATH (with deduplication)
add_to_path() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *) export PATH="$1:$PATH" ;;
  esac
}

add_to_path "$HOME/.local/bin"
[ -d "/opt/homebrew/bin" ] && add_to_path "/opt/homebrew/bin"

# Editor
if [ "$TERM_PROGRAM" = "vscode" ]; then
  export EDITOR="code --wait"
else
  export EDITOR="nvim"
fi

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
```

**Step 2: Commit**

```bash
git add dot_profile
git commit -m "feat: add ~/.profile for shared env"
```

---

### Task 1.3: Create ~/.zshenv

**Files:**
- Create: `dot_zshenv`

**Step 1: Write file**

```sh
# ~/.zshenv - sourced for ALL zsh invocations
[ -f "$HOME/.profile" ] && . "$HOME/.profile"
```

**Step 2: Commit**

```bash
git add dot_zshenv
git commit -m "feat: add ~/.zshenv"
```

---

### Task 1.4: Create ~/.bash_profile

**Files:**
- Create: `dot_bash_profile`

**Step 1: Write file**

```sh
# ~/.bash_profile - login shell
[ -f "$HOME/.profile" ] && . "$HOME/.profile"
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
```

**Step 2: Commit**

```bash
git add dot_bash_profile
git commit -m "feat: add ~/.bash_profile"
```

---

### Task 1.5: Create ~/.bashrc with templated aliases

**Files:**
- Create: `dot_bashrc.tmpl`

**Step 1: Write file**

```sh
# ~/.bashrc - interactive bash

# Exit if not interactive
[[ $- != *i* ]] && return

# Aliases
{{ range $name, $cmd := .aliases -}}
alias {{ $name }}='{{ $cmd }}'
{{ end }}

# Functions
wip() { git commit -m "WIP: $*"; }

# Tool init (with guards)
command -v starship >/dev/null && eval "$(starship init bash)"
command -v mise >/dev/null && eval "$(mise activate bash)"
command -v zoxide >/dev/null && eval "$(zoxide init bash)"
command -v fzf >/dev/null && eval "$(fzf --bash)"
```

**Step 2: Commit**

```bash
git add dot_bashrc.tmpl
git commit -m "feat: add ~/.bashrc with templated aliases"
```

---

### Task 1.6: Update ~/.zshrc with templated aliases

**Files:**
- Modify: `dot_zshrc.tmpl`

**Step 1: Rewrite file**

```sh
# ~/.zshrc - interactive zsh

# Aliases
{{ range $name, $cmd := .aliases -}}
alias {{ $name }}='{{ $cmd }}'
{{ end }}

# Functions
wip() { git commit -m "WIP: $*"; }

# Tool init (with guards)
command -v starship >/dev/null && eval "$(starship init zsh)"
command -v mise >/dev/null && eval "$(mise activate zsh)"
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
command -v fzf >/dev/null && eval "$(fzf --zsh)"
```

**Step 2: Commit**

```bash
git add dot_zshrc.tmpl
git commit -m "feat: rewrite ~/.zshrc with templated aliases"
```

---

## Phase 2: Fish Config Updates

### Task 2.1: Template fish aliases

**Files:**
- Rename & modify: `dot_config/private_fish/conf.d/aliases.fish` → `aliases.fish.tmpl`

**Step 1: Rename and rewrite**

```bash
git mv dot_config/private_fish/conf.d/aliases.fish dot_config/private_fish/conf.d/aliases.fish.tmpl
```

**Step 2: Write templated content**

```fish
# Aliases (from chezmoi data)
{{ range $name, $cmd := .aliases -}}
alias {{ $name }} '{{ $cmd }}'
{{ end }}

# Functions
function wip; git commit -m "WIP: $argv"; end
```

**Step 3: Commit**

```bash
git add dot_config/private_fish/conf.d/aliases.fish.tmpl
git commit -m "feat: template fish aliases from chezmoi data"
```

---

### Task 2.2: Add guards to fish conf.d

**Files:**
- Modify: `dot_config/private_fish/conf.d/mise.fish`
- Modify: `dot_config/private_fish/conf.d/starship.fish`
- Modify: `dot_config/private_fish/conf.d/zoxide.fish`

**Step 1: Update mise.fish**

```fish
command -q mise && mise activate fish | source
```

**Step 2: Update starship.fish**

```fish
command -q starship && starship init fish | source
```

**Step 3: Update zoxide.fish**

```fish
command -q zoxide && zoxide init fish | source
```

**Step 4: Commit**

```bash
git add dot_config/private_fish/conf.d/
git commit -m "feat: add guards to fish tool init"
```

---

### Task 2.3: Fix fish EDITOR logic

**Files:**
- Modify: `dot_config/private_fish/conf.d/vscode.fish`

**Step 1: Rewrite with conditional EDITOR**

```fish
if test "$TERM_PROGRAM" = "vscode"
    and type -q code
    . (code --locate-shell-integration-path fish)
    set -gx EDITOR "code --wait"
else
    set -gx EDITOR nvim
end
```

**Step 2: Commit**

```bash
git add dot_config/private_fish/conf.d/vscode.fish
git commit -m "feat: conditional EDITOR in fish (nvim default, code in vscode)"
```

---

### Task 2.4: Add fzf to fish config

**Files:**
- Create: `dot_config/private_fish/conf.d/fzf.fish`

**Step 1: Write file**

```fish
command -q fzf && fzf --fish | source
```

**Step 2: Commit**

```bash
git add dot_config/private_fish/conf.d/fzf.fish
git commit -m "feat: add fzf init to fish"
```

---

### Task 2.5: Clean up unused fish functions

**Files:**
- Delete unused functions

**Step 1: Remove unused**

```bash
rm -f dot_config/private_fish/functions/{gad,gp,gpf,zoxide}.fish
rm -f dot_config/private_fish/functions/worktree-*.fish
rm -f dot_config/private_fish/functions/{wta,wtrm}.fish
rm -f dot_config/private_fish/functions/ytb*.fish
```

**Step 2: Commit**

```bash
git add dot_config/private_fish/functions/
git commit -m "chore: remove unused fish functions"
```

---

## Phase 3: Git & Editor Config

### Task 3.1: Template git config

**Files:**
- Rename: `dot_config/git/private_config` → `private_config.tmpl`

**Step 1: Rename**

```bash
git mv dot_config/git/private_config dot_config/git/private_config.tmpl
```

**Step 2: Template the path and fix pager**

Change:
```
template = /Users/rob/.config/git/template
```
To:
```
template = {{ .chezmoi.homeDir }}/.config/git/template
```

Change pager from diff-so-fancy to plain (or delta if installed):
```
pager = less -FRX
```

Change editor from nvim to respect system:
```
editor = $EDITOR
```

**Step 3: Commit**

```bash
git add dot_config/git/private_config.tmpl
git commit -m "feat: template git config paths"
```

---

### Task 3.2: Simplify nvim config

**Files:**
- Modify: `dot_config/nvim/init.lua`
- Delete: `dot_config/nvim/lua/` directory

**Step 1: Archive lua directory**

```bash
mkdir -p archive
mv dot_config/nvim/lua archive/nvim-lua
```

**Step 2: Rewrite init.lua (minimal)**

```lua
-- Minimal nvim config

vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.wrap = true
vim.o.clipboard = ""
vim.opt.iskeyword:append("-")

vim.keymap.set("n", "Q", "<nop>")

vim.cmd([[
  cnoreabbrev W! w!
  cnoreabbrev W1 w!
  cnoreabbrev w1 w!
  cnoreabbrev Q! q!
  cnoreabbrev Q1 q!
  cnoreabbrev q1 q!
  cnoreabbrev Wq wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Q q
]])
```

**Step 3: Remove other nvim files**

```bash
rm -f dot_config/nvim/{LICENSE,README.md,stylua.toml,dot_gitignore,dot_neoconf.json}
rm -rf dot_config/nvim/lua
```

**Step 4: Commit**

```bash
git add dot_config/nvim/
git add archive/nvim-lua/
git commit -m "feat: simplify nvim to minimal config"
```

---

### Task 3.3: Simplify tmux config

**Files:**
- Modify: `dot_tmux.conf`

**Step 1: Remove vim-tmux-navigator lines**

Remove:
```tmux
is_vim='echo "#{pane_current_command}" | grep -iqE "(^|\/)g?(view|n?vim?x?)(diff)?$"'
bind -n C-h if-shell "$is_vim" "send-keys C-h" "select-pane -L"
bind -n C-j if-shell "$is_vim" "send-keys C-j" "select-pane -D"
bind -n C-k if-shell "$is_vim" "send-keys C-k" "select-pane -U"
bind -n C-l if-shell "$is_vim" "send-keys C-l" "select-pane -R"
```

Keep plain vim-style nav:
```tmux
bind k select-pane -U
bind j select-pane -D
bind h select-pane -L
bind l select-pane -R
```

**Step 2: Commit**

```bash
git add dot_tmux.conf
git commit -m "feat: remove vim-tmux-navigator from tmux config"
```

---

## Phase 4: Cleanup

### Task 4.1: Remove old install scripts

**Files:**
- Delete: `run_onchange_*.tmpl`

**Step 1: Archive and remove**

```bash
mkdir -p archive/old-scripts
mv run_onchange_*.tmpl archive/old-scripts/
```

**Step 2: Commit**

```bash
git add archive/old-scripts/
git rm run_onchange_*.tmpl
git commit -m "chore: archive old install scripts"
```

---

### Task 4.2: Update .chezmoiignore

**Files:**
- Modify: `.chezmoiignore`

**Step 1: Add archive and docs to ignore**

```
archive/
docs/
README.md
LICENSE
Makefile
```

**Step 2: Commit**

```bash
git add .chezmoiignore
git commit -m "chore: ignore archive and docs in chezmoi"
```

---

### Task 4.3: Test chezmoi apply

**Step 1: Check diff**

```bash
chezmoi diff
```

**Step 2: Dry run**

```bash
chezmoi apply --dry-run --verbose
```

**Step 3: Apply if looks good**

```bash
chezmoi apply
```

**Step 4: Test each shell**

```bash
# Test bash
bash -l -c 'echo $EDITOR; type g'

# Test zsh
zsh -l -c 'echo $EDITOR; type g'

# Test fish
fish -c 'echo $EDITOR; type g'
```

---

### Task 4.4: Final commit and tag

**Step 1: Commit any remaining changes**

```bash
git status
git add -A
git commit -m "chore: dotfiles v2 complete"
```

**Step 2: Tag release**

```bash
git tag v2.0.0
git push origin main --tags
```

---

## Summary

**Install (unchanged):**
```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply robwilliams
```

**What changed:**
- Aliases defined once in `.chezmoi.yaml.tmpl`, templated to all shells
- `~/.profile` for shared PATH/EDITOR/LANG
- Shell layering: zshenv/bash_profile source profile
- Tool guards everywhere (no errors if tools missing)
- Minimal nvim (no plugins)
- Minimal tmux (no vim-tmux-navigator)
- Clean git config (templated paths)

**External tools (install separately when needed):**
- `brew install starship mise zoxide fzf` (macOS)
- `apt install ...` (Linux)

Works without them - guards prevent errors.

---

## Execution Options

Plan saved to `docs/plans/2026-01-03-dotfiles-v2-simplified.md`

```
┌─────────────────────────────────────────────────────────────────────┐
│ COPY-PASTE COMMANDS                                                 │
├─────────────────────────────────────────────────────────────────────┤
│ Parallel Session:                                                   │
│ claude "Use bob:executing-plans on                                  │
│   docs/plans/2026-01-03-dotfiles-v2-simplified.md"                  │
│                                                                     │
│ Claude Code Web (after push):                                       │
│ Execute the implementation plan at                                  │
│ `docs/plans/2026-01-03-dotfiles-v2-simplified.md`.                  │
│ Start from first pending task, work through sequentially.           │
└─────────────────────────────────────────────────────────────────────┘
```
