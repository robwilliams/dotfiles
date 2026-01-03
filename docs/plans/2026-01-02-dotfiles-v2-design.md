# Dotfiles v2 Design

## Goal

Reliable, fast, simple dotfiles that work across macOS, Linux, WSL, and devcontainers. No IDE setup - just shell environment.

## Principles

1. **Zero external dependencies** - Package contains everything needed (core tools)
2. **Portable binaries** - Static linking, works behind firewalls
3. **Shell parity** - fish primary, zsh/bash fallbacks with same experience
4. **Minimal** - No plugins, no IDE features, just essentials

## Architecture

### Release Package

CI builds platform-specific release artifacts (via goreleaser):

```
dotfiles-darwin-arm64.tar.gz
dotfiles-darwin-amd64.tar.gz
dotfiles-linux-amd64.tar.gz
dotfiles-linux-arm64.tar.gz
```

Each contains:

```
bin/
├── chezmoi          # dotfile manager
├── starship         # prompt
├── ripgrep          # search
├── fd               # find
├── zoxide           # smart cd
├── mise             # version manager (for project-specific languages)
├── delta            # git diff
├── fzf              # fuzzy finder
├── g-               # git checkout - (custom Go, to be developed)
├── grim             # git rebase -i main (custom Go, to be developed)
├── grbm             # fetch/stash/rebase/pop (custom Go, to be developed)
└── cb               # clipboard wrapper (custom Go, to be developed)
dotfiles/            # chezmoi source state
install.sh           # extracts, applies, warns about missing system deps
```

**Not bundled (rely on system):**
- tmux - widely available, `apt install tmux`
- nvim/vim - vim almost always present, nvim common

**Note on mise:** Core shell environment is zero-dependency. mise is included for project-specific language version management (node, ruby, python per project), not for installing the bundled tools.

### CI Build Requirements

- Go tools: `CGO_ENABLED=0` for static linking
- Rust tools: use musl builds where available
- macOS install.sh: `xattr -dr com.apple.quarantine ./bin/* 2>/dev/null || true`

### Shell Strategy

**Fish** (primary):
- Full experience
- `fish_user_paths` for PATH (auto-dedupes)
- `set -gx` for env vars

**Zsh** (fallback):
- Parity with fish
- Sources `~/.profile` from `~/.zshenv` (always runs, even non-interactive)

**Bash** (fallback):
- Parity with fish
- Sources `~/.profile` from `~/.bash_profile`
- `~/.bashrc` has interactive guard

### Config Layering

```
~/.profile              # PATH, EDITOR, LANG (POSIX, sourced by login shells)
~/.zshenv               # sources .profile (all zsh invocations)
~/.bash_profile         # sources .profile + .bashrc
~/.bashrc               # interactive guard + aliases + tool inits
~/.zshrc                # aliases + tool inits
~/.config/fish/         # fish_user_paths, env vars, aliases, tool inits
```

### ~/.profile (shared foundation)

```sh
# PATH deduplication (avoids bloat if sourced multiple times)
add_to_path() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *) export PATH="$1:$PATH" ;;
  esac
}
add_to_path "$HOME/.local/bin"

# Editor
if [ "$TERM_PROGRAM" = "vscode" ]; then
  export EDITOR="code --wait"
else
  export EDITOR="nvim"
fi

# Locale (prevents crashes on minimal containers)
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
```

### Aliases

Defined once in chezmoi data:

```yaml
# .chezmoi.yaml
data:
  aliases:
    g: "git status"
    ga: "git add"
    gc: "git commit --verbose"
    gd: "git diff"
    gl: "git log"
    gco: "git checkout"
    gcm: "git checkout main"
    # ...
```

Templated to each shell syntax at apply time:

```
# bash/zsh (dot_zshrc.tmpl, dot_bashrc.tmpl)
{{ range $name, $cmd := .aliases -}}
alias {{ $name }}='{{ $cmd }}'
{{ end }}

# fish (conf.d/aliases.fish.tmpl)
{{ range $name, $cmd := .aliases -}}
alias {{ $name }} '{{ $cmd }}'
{{ end }}
```

### Tool Initialization (all shells)

With guards for missing tools:

**bash/zsh:**
```sh
command -v starship >/dev/null && eval "$(starship init bash)"  # or zsh
command -v mise >/dev/null && eval "$(mise activate bash)"
command -v zoxide >/dev/null && eval "$(zoxide init bash)"
command -v fzf >/dev/null && eval "$(fzf --bash)"
```

**fish:**
```fish
command -q starship && starship init fish | source
command -q mise && mise activate fish | source
command -q zoxide && zoxide init fish | source
command -q fzf && fzf --fish | source
```

### Git Config

Templated paths (not hardcoded):

```ini
[user]
  name = Robert Williams
  email = rob@r-williams.com
[core]
  editor = nvim
  pager = delta
[commit]
  template = {{ .chezmoi.homeDir }}/.config/git/template
[init]
  defaultBranch = main
[pull]
  rebase = true
[push]
  default = current
[delta]
  navigate = true
  light = false
```

### nvim Config

Minimal - options and keymaps only:

```lua
-- Options
vim.g.mapleader = ";"
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.wrap = true
vim.o.clipboard = ""
vim.opt.iskeyword:append("-")

-- Keymaps
vim.keymap.set("n", "Q", "<nop>")  -- disable Ex mode

-- Typo fixes
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

NO plugins. NO LazyVim. Just the essentials.

### tmux Config

```tmux
set -g mouse on
set -g default-terminal "xterm-256color"
set-option -ga terminal-overrides ",xterm-256color:Tc"
set -sg escape-time 0

# vim-style navigation
bind k select-pane -U
bind j select-pane -D
bind h select-pane -L
bind l select-pane -R

# vi copy mode
setw -g mode-keys vi
bind Escape copy-mode

# Windows/panes start at 1
set -g base-index 1
setw -g pane-base-index 1

# Simple status
set -g status-style fg=white,bg=default
set -g status-left "#[fg=green]#S "
set -g status-right "#[fg=red]#h #[fg=yellow]%d %b %R"

# History
set-option -g history-limit 100000
```

NO vim-tmux-navigator (no vim plugin to pair with).

### Clipboard Wrapper (cb)

Custom Go binary that detects platform:

```go
// Detects environment and routes to appropriate clipboard
// - macOS: pbcopy/pbpaste
// - WSL: clip.exe / powershell Get-Clipboard
// - Linux: xclip or wl-copy/wl-paste
```

Usage: `echo "text" | cb` or `cb` to paste.

### WSL Considerations

The `cb` wrapper handles this, but shell config also detects WSL:

```sh
if grep -q Microsoft /proc/version 2>/dev/null; then
  # WSL-specific adjustments if needed
fi
```

## Bootstrap

### From Local Machine (to remote host)

```sh
dotfiles-bootstrap user@host
```

Script (`dotfiles-bootstrap`):

```sh
#!/bin/sh
set -e
HOST=$1
[ -z "$HOST" ] && echo "Usage: dotfiles-bootstrap [user@]host" && exit 1

echo "→ Copy SSH key..."
ssh -o BatchMode=yes -o ConnectTimeout=5 "$HOST" true 2>/dev/null || ssh-copy-id "$HOST"

echo "→ Get GitHub token..."
TOKEN=$(gh auth token) || { echo "Run 'gh auth login' first"; exit 1; }

echo "→ Detect platform..."
PLATFORM=$(ssh "$HOST" 'echo $(uname -s | tr A-Z a-z)-$(uname -m | sed "s/x86_64/amd64/;s/aarch64/arm64/")')

echo "→ Install dotfiles ($PLATFORM)..."
ssh "$HOST" "
  set -e
  cd ~ && mkdir -p .dotfiles-install && cd .dotfiles-install
  curl -fsSL -H 'Authorization: token $TOKEN' \
    'https://api.github.com/repos/robwilliams/dotfiles/releases/latest' |
    grep -o '\"browser_download_url\": \"[^\"]*dotfiles-$PLATFORM.tar.gz\"' |
    cut -d'\"' -f4 |
    xargs curl -fsSL -H 'Authorization: token $TOKEN' | tar xz
  ./install.sh
  cd ~ && rm -rf .dotfiles-install
"

echo "✓ Done! Run: ssh $HOST"
```

### Devcontainer Integration

```json
{
  "postCreateCommand": "gh release download -R robwilliams/dotfiles -p 'dotfiles-*.tar.gz' && tar xzf dotfiles-*.tar.gz && ./install.sh"
}
```

Codespaces has `gh` pre-authenticated.

### SSH Config (optional)

Auto-attach to tmux for reliable env:

```
Host myserver
  RequestTTY yes
  RemoteCommand tmux new-session -A -s main
```

**Note:** This can interfere with `scp`/`rsync`. Use a separate host alias or TMUX-aware check in shell config if needed.

## Security

- **Private repo** - no public exposure
- **gitleaks in CI** - catches accidental secret commits
- **No secrets in dotfiles** - use macOS Keychain or 1Password CLI

### Secrets Management (reference)

```sh
# macOS Keychain
security add-generic-password -a "$USER" -s "api-key-name" -w "secret"
export API_KEY=$(security find-generic-password -s "api-key-name" -w)

# 1Password CLI (secrets never in shell env)
op run -- command
```

## What's NOT Included

Removed from base (noted for reference):

- Full LazyVim/IDE neovim setup
- lazygit
- diff-so-fancy (replaced by delta)
- alt-tab (macOS app)
- vim-tmux-navigator
- git worktree helper functions

These can be added as a separate "ide" addon package if ever needed.

## Custom Go Tools (to be developed)

Currently fish functions, to be converted to Go binaries:

| Tool | Current | Does |
|------|---------|------|
| `g-` | fish function | `git checkout -` |
| `grim` | fish function + alias | `git rebase -i main` |
| `grbm` | fish function | fetch origin/main, stash, rebase, pop |
| `cb` | new | cross-platform clipboard |

## Migration Path

1. Archive current dotfiles (branch or tag)
2. Create new repo structure with `tools/cmd/` for Go binaries
3. Set up GitHub Actions CI with goreleaser
4. Build first release for all platforms
5. Test on macOS, Linux, WSL, devcontainer
6. Document and deprecate old setup

## Testing Checklist

- [ ] Fresh macOS install
- [ ] Fresh Ubuntu install
- [ ] WSL2 on Windows
- [ ] GitHub Codespace
- [ ] Generic devcontainer
- [ ] SSH to remote Linux server
- [ ] Behind corporate firewall (no external downloads)
