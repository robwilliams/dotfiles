# Dotfiles v2 Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use bob:executing-plans to implement this plan task-by-task.

**Goal:** Implement the dotfiles v2 architecture for cross-platform reliability.

**Architecture:** Self-contained release packages with bundled binaries, chezmoi for config management, fish primary with zsh/bash parity fallbacks.

**Tech Stack:** Go (custom tools), goreleaser (CI builds), chezmoi (dotfile management), GitHub Actions (CI/CD)

---

## Phase 1: Repository Restructure

### Task 1.1: Create Go workspace

**Files:**
- Create: `tools/go.mod`
- Create: `tools/cmd/g-/main.go`
- Create: `tools/cmd/grim/main.go`
- Create: `tools/cmd/grbm/main.go`
- Create: `tools/cmd/cb/main.go`

**Step 1: Create directory structure**

```bash
mkdir -p tools/cmd/{g-,grim,grbm,cb}
```

**Step 2: Initialize Go module**

```bash
cd tools && go mod init github.com/robwilliams/dotfiles/tools && cd ..
```

**Step 3: Create placeholder main.go files**

```go
// tools/cmd/g-/main.go
package main

func main() {
	// TODO: implement
}
```

(Repeat for grim, grbm, cb)

**Step 4: Commit**

```bash
git add tools/
git commit -m "chore: scaffold Go tools directory"
```

---

### Task 1.2: Create Makefile

**Files:**
- Create: `Makefile`

**Step 1: Write Makefile**

```makefile
.PHONY: build test clean

TOOLS := g- grim grbm cb
PLATFORMS := darwin-arm64 darwin-amd64 linux-amd64 linux-arm64

build:
	@for tool in $(TOOLS); do \
		echo "Building $$tool..."; \
		cd tools && CGO_ENABLED=0 go build -o ../bin/$$tool ./cmd/$$tool && cd ..; \
	done

build-all:
	@for platform in $(PLATFORMS); do \
		OS=$${platform%-*}; \
		ARCH=$${platform#*-}; \
		mkdir -p bin/$$platform; \
		for tool in $(TOOLS); do \
			echo "Building $$tool for $$OS/$$ARCH..."; \
			cd tools && CGO_ENABLED=0 GOOS=$$OS GOARCH=$$ARCH go build -o ../bin/$$platform/$$tool ./cmd/$$tool && cd ..; \
		done \
	done

test:
	cd tools && go test ./...

clean:
	rm -rf bin/
```

**Step 2: Commit**

```bash
git add Makefile
git commit -m "chore: add Makefile for Go tools"
```

---

### Task 1.3: Archive current fish functions

**Files:**
- Create: `archive/fish-functions/`

**Step 1: Copy current functions**

```bash
mkdir -p archive/fish-functions
cp dot_config/private_fish/functions/*.fish archive/fish-functions/
```

**Step 2: Commit**

```bash
git add archive/
git commit -m "chore: archive fish functions before migration"
```

---

### Task 1.4: Create scripts directory

**Files:**
- Create: `scripts/install.sh`
- Create: `scripts/dotfiles-bootstrap`
- Create: `scripts/fetch-binaries.sh`

**Step 1: Create directory and placeholder scripts**

```bash
mkdir -p scripts
touch scripts/install.sh scripts/dotfiles-bootstrap scripts/fetch-binaries.sh
chmod +x scripts/*
```

**Step 2: Commit**

```bash
git add scripts/
git commit -m "chore: scaffold scripts directory"
```

---

## Phase 2: Implement Go Tools

### Task 2.1: Implement g- (git checkout -)

**Files:**
- Modify: `tools/cmd/g-/main.go`
- Create: `tools/cmd/g-/main_test.go`

**Step 1: Write test**

```go
// tools/cmd/g-/main_test.go
package main

import "testing"

func TestBuildArgs(t *testing.T) {
	args := buildArgs([]string{"g-"})
	expected := []string{"git", "checkout", "-"}
	if len(args) != len(expected) {
		t.Fatalf("expected %v, got %v", expected, args)
	}
	for i, v := range expected {
		if args[i] != v {
			t.Errorf("args[%d] = %s, want %s", i, args[i], v)
		}
	}
}
```

**Step 2: Run test to verify it fails**

```bash
cd tools && go test ./cmd/g-/...
```

Expected: FAIL

**Step 3: Implement**

```go
// tools/cmd/g-/main.go
package main

import (
	"os"
	"os/exec"
	"syscall"
)

func buildArgs(osArgs []string) []string {
	return append([]string{"git", "checkout", "-"}, osArgs[1:]...)
}

func main() {
	git, err := exec.LookPath("git")
	if err != nil {
		os.Stderr.WriteString("git not found\n")
		os.Exit(1)
	}
	syscall.Exec(git, buildArgs(os.Args), os.Environ())
}
```

**Step 4: Run test to verify it passes**

```bash
cd tools && go test ./cmd/g-/...
```

Expected: PASS

**Step 5: Build and manual test**

```bash
make build
./bin/g- # should run git checkout -
```

**Step 6: Commit**

```bash
git add tools/cmd/g-/
git commit -m "feat(tools): implement g- (git checkout -)"
```

---

### Task 2.2: Implement grim (git rebase -i main)

**Files:**
- Modify: `tools/cmd/grim/main.go`
- Create: `tools/cmd/grim/main_test.go`

**Step 1: Write test**

```go
// tools/cmd/grim/main_test.go
package main

import "testing"

func TestBuildArgs(t *testing.T) {
	args := buildArgs([]string{"grim"})
	expected := []string{"git", "rebase", "-i", "main"}
	if len(args) != len(expected) {
		t.Fatalf("expected %v, got %v", expected, args)
	}
}
```

**Step 2: Implement**

```go
// tools/cmd/grim/main.go
package main

import (
	"os"
	"os/exec"
	"syscall"
)

func buildArgs(osArgs []string) []string {
	return append([]string{"git", "rebase", "-i", "main"}, osArgs[1:]...)
}

func main() {
	git, err := exec.LookPath("git")
	if err != nil {
		os.Stderr.WriteString("git not found\n")
		os.Exit(1)
	}
	syscall.Exec(git, buildArgs(os.Args), os.Environ())
}
```

**Step 3: Test, build, commit**

```bash
cd tools && go test ./cmd/grim/...
make build
git add tools/cmd/grim/
git commit -m "feat(tools): implement grim (git rebase -i main)"
```

---

### Task 2.3: Implement grbm (fetch/stash/rebase/pop)

**Files:**
- Modify: `tools/cmd/grbm/main.go`
- Create: `tools/cmd/grbm/main_test.go`

**Step 1: Write test for stash detection**

```go
// tools/cmd/grbm/main_test.go
package main

import "testing"

func TestStashNameGeneration(t *testing.T) {
	name := generateStashName()
	if len(name) < 10 {
		t.Errorf("stash name too short: %s", name)
	}
}
```

**Step 2: Implement**

```go
// tools/cmd/grbm/main.go
package main

import (
	"crypto/md5"
	"fmt"
	"os"
	"os/exec"
	"strings"
	"time"
)

func generateStashName() string {
	hash := md5.Sum([]byte(fmt.Sprintf("%d", time.Now().UnixNano())))
	return fmt.Sprintf("grbm-%x", hash[:8])
}

func run(name string, args ...string) error {
	cmd := exec.Command(name, args...)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Stdin = os.Stdin
	return cmd.Run()
}

func hasStash(name string) bool {
	out, err := exec.Command("git", "stash", "list").Output()
	if err != nil {
		return false
	}
	return strings.Contains(string(out), name)
}

func main() {
	stashName := generateStashName()

	// Fetch
	if err := run("git", "fetch", "origin", "main"); err != nil {
		os.Exit(1)
	}

	// Stash
	run("git", "stash", "push", "-u", "-m", stashName)

	// Rebase
	if err := run("git", "rebase", "origin/main"); err != nil {
		// If rebase fails, still try to pop stash
		if hasStash(stashName) {
			run("git", "stash", "pop")
		}
		os.Exit(1)
	}

	// Pop stash if we created one
	if hasStash(stashName) {
		run("git", "stash", "pop")
	}
}
```

**Step 3: Test, build, commit**

```bash
cd tools && go test ./cmd/grbm/...
make build
git add tools/cmd/grbm/
git commit -m "feat(tools): implement grbm (fetch/stash/rebase/pop)"
```

---

### Task 2.4: Implement cb (clipboard wrapper)

**Files:**
- Modify: `tools/cmd/cb/main.go`
- Create: `tools/cmd/cb/main_test.go`

**Step 1: Write test for platform detection**

```go
// tools/cmd/cb/main_test.go
package main

import (
	"runtime"
	"testing"
)

func TestDetectPlatform(t *testing.T) {
	p := detectPlatform()
	if runtime.GOOS == "darwin" && p != "darwin" {
		t.Errorf("expected darwin, got %s", p)
	}
}
```

**Step 2: Implement**

```go
// tools/cmd/cb/main.go
package main

import (
	"io"
	"os"
	"os/exec"
	"runtime"
	"strings"
)

func detectPlatform() string {
	if runtime.GOOS == "darwin" {
		return "darwin"
	}
	// Check for WSL
	data, err := os.ReadFile("/proc/sys/kernel/osrelease")
	if err == nil && strings.Contains(strings.ToLower(string(data)), "microsoft") {
		return "wsl"
	}
	return "linux"
}

func copy(data []byte) error {
	var cmd *exec.Cmd
	switch detectPlatform() {
	case "darwin":
		cmd = exec.Command("pbcopy")
	case "wsl":
		cmd = exec.Command("clip.exe")
	default:
		// Try xclip, fall back to wl-copy
		if _, err := exec.LookPath("xclip"); err == nil {
			cmd = exec.Command("xclip", "-selection", "clipboard")
		} else {
			cmd = exec.Command("wl-copy")
		}
	}
	cmd.Stdin = strings.NewReader(string(data))
	return cmd.Run()
}

func paste() ([]byte, error) {
	var cmd *exec.Cmd
	switch detectPlatform() {
	case "darwin":
		cmd = exec.Command("pbpaste")
	case "wsl":
		cmd = exec.Command("powershell.exe", "-command", "Get-Clipboard")
	default:
		if _, err := exec.LookPath("xclip"); err == nil {
			cmd = exec.Command("xclip", "-selection", "clipboard", "-o")
		} else {
			cmd = exec.Command("wl-paste")
		}
	}
	return cmd.Output()
}

func main() {
	stat, _ := os.Stdin.Stat()
	if (stat.Mode() & os.ModeCharDevice) == 0 {
		// Stdin has data - copy mode
		data, err := io.ReadAll(os.Stdin)
		if err != nil {
			os.Stderr.WriteString("failed to read stdin\n")
			os.Exit(1)
		}
		if err := copy(data); err != nil {
			os.Stderr.WriteString("failed to copy\n")
			os.Exit(1)
		}
	} else {
		// No stdin - paste mode
		data, err := paste()
		if err != nil {
			os.Stderr.WriteString("failed to paste\n")
			os.Exit(1)
		}
		os.Stdout.Write(data)
	}
}
```

**Step 3: Test, build, commit**

```bash
cd tools && go test ./cmd/cb/...
make build
echo "test" | ./bin/cb  # copy
./bin/cb               # paste
git add tools/cmd/cb/
git commit -m "feat(tools): implement cb (cross-platform clipboard)"
```

---

## Phase 3: Shell Config Templates

### Task 3.1: Add aliases to chezmoi data

**Files:**
- Modify: `.chezmoi.yaml.tmpl`

**Step 1: Add aliases section**

Add to `.chezmoi.yaml.tmpl`:

```yaml
data:
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
```

**Step 2: Commit**

```bash
git add .chezmoi.yaml.tmpl
git commit -m "feat: add aliases to chezmoi data"
```

---

### Task 3.2: Create ~/.profile

**Files:**
- Create: `dot_profile.tmpl`

**Step 1: Write profile**

```sh
# ~/.profile - POSIX shell environment (sourced by login shells)

# PATH deduplication
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

# Locale (prevents crashes on minimal containers)
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
```

**Step 2: Commit**

```bash
git add dot_profile.tmpl
git commit -m "feat: add ~/.profile for shared env vars"
```

---

### Task 3.3: Create ~/.zshenv

**Files:**
- Create: `dot_zshenv`

**Step 1: Write zshenv**

```sh
# ~/.zshenv - sourced for ALL zsh invocations
[ -f "$HOME/.profile" ] && . "$HOME/.profile"
```

**Step 2: Commit**

```bash
git add dot_zshenv
git commit -m "feat: add ~/.zshenv to source profile"
```

---

### Task 3.4: Create ~/.bash_profile

**Files:**
- Create: `dot_bash_profile`

**Step 1: Write bash_profile**

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

### Task 3.5: Create ~/.bashrc with templated aliases

**Files:**
- Create: `dot_bashrc.tmpl`

**Step 1: Write bashrc**

```sh
# ~/.bashrc - interactive bash

# Exit if not interactive
[[ $- != *i* ]] && return

# Aliases (generated from chezmoi data)
{{ range $name, $cmd := .aliases -}}
alias {{ $name }}='{{ $cmd }}'
{{ end }}

# Functions (need arguments)
wip() { git commit -m "WIP: $*"; }
wap() { git add -p && git commit -m "WIP: $*"; }

# Tool initialization (with guards)
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

### Task 3.6: Update ~/.zshrc with templated aliases

**Files:**
- Modify: `dot_zshrc.tmpl`

**Step 1: Rewrite zshrc**

```sh
# ~/.zshrc - interactive zsh

# Aliases (generated from chezmoi data)
{{ range $name, $cmd := .aliases -}}
alias {{ $name }}='{{ $cmd }}'
{{ end }}

# Functions (need arguments)
wip() { git commit -m "WIP: $*"; }
wap() { git add -p && git commit -m "WIP: $*"; }

# Tool initialization (with guards)
command -v starship >/dev/null && eval "$(starship init zsh)"
command -v mise >/dev/null && eval "$(mise activate zsh)"
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
command -v fzf >/dev/null && eval "$(fzf --zsh)"
```

**Step 2: Commit**

```bash
git add dot_zshrc.tmpl
git commit -m "feat: update ~/.zshrc with templated aliases"
```

---

### Task 3.7: Update fish aliases template

**Files:**
- Rename: `dot_config/private_fish/conf.d/aliases.fish` → `aliases.fish.tmpl`

**Step 1: Rewrite as template**

```fish
# Aliases (generated from chezmoi data)
{{ range $name, $cmd := .aliases -}}
alias {{ $name }} '{{ $cmd }}'
{{ end }}

# Functions (need arguments)
function wip; git commit -m "WIP: $argv"; end
function wap; git add -p && git commit -m "WIP: $argv"; end
```

**Step 2: Commit**

```bash
git mv dot_config/private_fish/conf.d/aliases.fish dot_config/private_fish/conf.d/aliases.fish.tmpl
git add dot_config/private_fish/conf.d/aliases.fish.tmpl
git commit -m "feat: convert fish aliases to chezmoi template"
```

---

### Task 3.8: Update fish conf.d with guards

**Files:**
- Modify: `dot_config/private_fish/conf.d/mise.fish`
- Modify: `dot_config/private_fish/conf.d/starship.fish`
- Modify: `dot_config/private_fish/conf.d/zoxide.fish`
- Modify: `dot_config/private_fish/conf.d/vscode.fish`

**Step 1: Add guards to each file**

```fish
# mise.fish
command -q mise && ~/.local/bin/mise activate fish | source

# starship.fish
command -q starship && starship init fish | source

# zoxide.fish
command -q zoxide && zoxide init fish | source

# vscode.fish
if string match -q "$TERM_PROGRAM" "vscode"
    and command -q code
    . (code --locate-shell-integration-path fish)
    set -gx EDITOR "code --wait"
else
    set -gx EDITOR "nvim"
end
```

**Step 2: Commit**

```bash
git add dot_config/private_fish/conf.d/
git commit -m "feat: add guards to fish conf.d modules"
```

---

### Task 3.9: Update fish config for fish_user_paths

**Files:**
- Modify: `dot_config/private_fish/config.fish` (or create)

**Step 1: Set up fish_user_paths**

```fish
# ~/.config/fish/config.fish

# PATH (fish_user_paths auto-dedupes)
fish_add_path -g $HOME/.local/bin
fish_add_path -g /opt/homebrew/bin

# FZF
command -q fzf && fzf --fish | source
```

**Step 2: Commit**

```bash
git add dot_config/private_fish/config.fish
git commit -m "feat: update fish config with fish_add_path"
```

---

### Task 3.10: Template git config paths

**Files:**
- Rename: `dot_config/git/private_config` → `private_config.tmpl`

**Step 1: Template the commit template path**

Change:
```
template = /Users/rob/.config/git/template
```

To:
```
template = {{ .chezmoi.homeDir }}/.config/git/template
```

**Step 2: Update pager to delta**

Change:
```
pager = diff-so-fancy | less --tabs=4 -RFX
```

To:
```
pager = delta
```

**Step 3: Add delta config**

```ini
[delta]
    navigate = true
    light = false
    side-by-side = true
```

**Step 4: Commit**

```bash
git mv dot_config/git/private_config dot_config/git/private_config.tmpl
git add dot_config/git/private_config.tmpl
git commit -m "feat: template git config, switch to delta"
```

---

### Task 3.11: Simplify nvim config

**Files:**
- Modify: `dot_config/nvim/init.lua`
- Delete: `dot_config/nvim/lua/` (all plugin configs)

**Step 1: Replace init.lua with minimal config**

```lua
-- Minimal nvim config (no plugins)

-- Leader
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

-- Options
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.wrap = true
vim.o.clipboard = ""
vim.opt.iskeyword:append("-")

-- Disable Ex mode
vim.keymap.set("n", "Q", "<nop>")

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
  cnoreabbrev wQ wq
  cnoreabbrev W w
  cnoreabbrev Q q
  cnoreabbrev Qa qa
  cnoreabbrev Qall qall
]])
```

**Step 2: Remove lua/ directory (archive first)**

```bash
cp -r dot_config/nvim/lua archive/nvim-lua
rm -rf dot_config/nvim/lua
```

**Step 3: Commit**

```bash
git add dot_config/nvim/
git add archive/nvim-lua/
git commit -m "feat: simplify nvim to minimal config (no plugins)"
```

---

### Task 3.12: Simplify tmux config

**Files:**
- Modify: `dot_tmux.conf`

**Step 1: Remove vim-tmux-navigator integration**

Remove these lines:
```tmux
is_vim='echo "#{pane_current_command}" | grep -iqE "(^|\/)g?(view|n?vim?x?)(diff)?$"'
bind -n C-h if-shell "$is_vim" "send-keys C-h" "select-pane -L"
# ... etc
```

Keep plain vim-style navigation:
```tmux
bind k select-pane -U
bind j select-pane -D
bind h select-pane -L
bind l select-pane -R
```

**Step 2: Commit**

```bash
git add dot_tmux.conf
git commit -m "feat: simplify tmux config (remove vim-tmux-navigator)"
```

---

### Task 3.13: Remove unused fish functions

**Files:**
- Delete: `dot_config/private_fish/functions/gad.fish`
- Delete: `dot_config/private_fish/functions/gp.fish`
- Delete: `dot_config/private_fish/functions/gpf.fish`
- Delete: `dot_config/private_fish/functions/worktree-*.fish`
- Delete: `dot_config/private_fish/functions/wta.fish`
- Delete: `dot_config/private_fish/functions/wtrm.fish`
- Delete: `dot_config/private_fish/functions/ytb*.fish`
- Delete: `dot_config/private_fish/functions/zoxide.fish`
- Keep: `dot_config/private_fish/functions/g-.fish` (until Go tool ready)
- Keep: `dot_config/private_fish/functions/grim.fish` (until Go tool ready)
- Keep: `dot_config/private_fish/functions/grbm.fish` (until Go tool ready)

**Step 1: Remove unused functions**

```bash
rm dot_config/private_fish/functions/{gad,gp,gpf,worktree-*,wta,wtrm,ytb*,zoxide}.fish
```

**Step 2: Commit**

```bash
git add dot_config/private_fish/functions/
git commit -m "chore: remove unused fish functions"
```

---

## Phase 4: CI & Release Pipeline

### Task 4.1: Create fetch-binaries.sh

**Files:**
- Modify: `scripts/fetch-binaries.sh`

**Step 1: Write script**

```bash
#!/bin/bash
set -e

# Versions (pin for reproducibility)
CHEZMOI_VERSION="2.47.1"
STARSHIP_VERSION="1.17.1"
RIPGREP_VERSION="14.1.0"
FD_VERSION="10.1.0"
ZOXIDE_VERSION="0.9.4"
MISE_VERSION="2024.1.0"
DELTA_VERSION="0.17.0"
FZF_VERSION="0.46.1"

PLATFORMS=("darwin-arm64" "darwin-amd64" "linux-amd64" "linux-arm64")

fetch_tool() {
    local name=$1
    local url=$2
    local dest=$3
    echo "Fetching $name..."
    curl -fsSL "$url" | tar xz -C "$dest" --strip-components=1 2>/dev/null || \
    curl -fsSL "$url" -o "$dest/$name"
    chmod +x "$dest/$name" 2>/dev/null || true
}

for platform in "${PLATFORMS[@]}"; do
    OS="${platform%-*}"
    ARCH="${platform#*-}"
    DEST="bin/$platform"
    mkdir -p "$DEST"

    echo "=== Fetching binaries for $platform ==="

    # Map arch names for different tools
    case "$ARCH" in
        amd64) RG_ARCH="x86_64"; FD_ARCH="x86_64" ;;
        arm64) RG_ARCH="aarch64"; FD_ARCH="aarch64" ;;
    esac

    case "$OS" in
        darwin) RG_OS="apple-darwin"; FD_OS="apple-darwin" ;;
        linux) RG_OS="unknown-linux-musl"; FD_OS="unknown-linux-musl" ;;
    esac

    # Chezmoi
    curl -fsSL "https://github.com/twpayne/chezmoi/releases/download/v${CHEZMOI_VERSION}/chezmoi_${CHEZMOI_VERSION}_${OS}_${ARCH}.tar.gz" | tar xz -C "$DEST" chezmoi

    # Starship
    curl -fsSL "https://github.com/starship/starship/releases/download/v${STARSHIP_VERSION}/starship-${RG_ARCH}-${RG_OS}.tar.gz" | tar xz -C "$DEST"

    # Add more tools following same pattern...

    echo "Done with $platform"
done
```

**Step 2: Make executable and commit**

```bash
chmod +x scripts/fetch-binaries.sh
git add scripts/fetch-binaries.sh
git commit -m "feat: add binary fetch script for CI"
```

---

### Task 4.2: Create .goreleaser.yaml

**Files:**
- Create: `.goreleaser.yaml`

**Step 1: Write config**

```yaml
version: 2
project_name: dotfiles

before:
  hooks:
    - ./scripts/fetch-binaries.sh

builds:
  - id: g-
    dir: tools
    main: ./cmd/g-
    binary: g-
    env: [CGO_ENABLED=0]
    goos: [darwin, linux]
    goarch: [amd64, arm64]

  - id: grim
    dir: tools
    main: ./cmd/grim
    binary: grim
    env: [CGO_ENABLED=0]
    goos: [darwin, linux]
    goarch: [amd64, arm64]

  - id: grbm
    dir: tools
    main: ./cmd/grbm
    binary: grbm
    env: [CGO_ENABLED=0]
    goos: [darwin, linux]
    goarch: [amd64, arm64]

  - id: cb
    dir: tools
    main: ./cmd/cb
    binary: cb
    env: [CGO_ENABLED=0]
    goos: [darwin, linux]
    goarch: [amd64, arm64]

archives:
  - id: dotfiles
    format: tar.gz
    name_template: "dotfiles-{{ .Os }}-{{ .Arch }}"
    files:
      - src: 'dot_*'
        dst: dotfiles/
      - src: '.chezmoi*'
        dst: dotfiles/
      - src: 'run_*'
        dst: dotfiles/
      - src: 'scripts/install.sh'
        dst: install.sh
      - src: 'bin/{{ .Os }}-{{ .Arch }}/*'
        dst: bin/

checksum:
  name_template: 'checksums.txt'

release:
  github:
    owner: robwilliams
    name: dotfiles
```

**Step 2: Commit**

```bash
git add .goreleaser.yaml
git commit -m "feat: add goreleaser config"
```

---

### Task 4.3: Create GitHub Actions workflow

**Files:**
- Create: `.github/workflows/release.yml`

**Step 1: Create directory and workflow**

```bash
mkdir -p .github/workflows
```

```yaml
# .github/workflows/release.yml
name: Release

on:
  push:
    tags: ['v*']

permissions:
  contents: write

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - uses: actions/setup-go@v5
        with:
          go-version: '1.22'

      - name: Run GoReleaser
        uses: goreleaser/goreleaser-action@v6
        with:
          version: latest
          args: release --clean
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

**Step 2: Add gitleaks workflow**

```yaml
# .github/workflows/security.yml
name: Security

on: [push, pull_request]

jobs:
  gitleaks:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - uses: gitleaks/gitleaks-action@v2
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

**Step 3: Commit**

```bash
git add .github/
git commit -m "feat: add GitHub Actions for release and security"
```

---

### Task 4.4: Create install.sh

**Files:**
- Modify: `scripts/install.sh`

**Step 1: Write install script**

```bash
#!/bin/sh
set -e

echo "=== Dotfiles Installer ==="

# macOS quarantine removal
if [ "$(uname)" = "Darwin" ]; then
    echo "→ Removing macOS quarantine attributes..."
    xattr -dr com.apple.quarantine ./bin/* 2>/dev/null || true
fi

# Copy binaries
echo "→ Installing binaries to ~/.local/bin..."
mkdir -p "$HOME/.local/bin"
cp ./bin/* "$HOME/.local/bin/"
chmod +x "$HOME/.local/bin"/*

# Apply chezmoi
echo "→ Applying dotfiles via chezmoi..."
"$HOME/.local/bin/chezmoi" init --source ./dotfiles --apply --force

# Check for system dependencies
echo ""
echo "=== System Dependencies ==="
command -v fish >/dev/null && echo "✓ fish" || echo "✗ fish (install for primary shell)"
command -v tmux >/dev/null && echo "✓ tmux" || echo "✗ tmux (optional)"
command -v nvim >/dev/null && echo "✓ nvim" || command -v vim >/dev/null && echo "✓ vim" || echo "✗ nvim/vim (install an editor)"

echo ""
echo "✓ Done! Restart your shell or run: exec \$SHELL"
```

**Step 2: Commit**

```bash
git add scripts/install.sh
git commit -m "feat: add install.sh"
```

---

### Task 4.5: Create dotfiles-bootstrap

**Files:**
- Modify: `scripts/dotfiles-bootstrap`

**Step 1: Write bootstrap script**

```bash
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

**Step 2: Commit**

```bash
git add scripts/dotfiles-bootstrap
git commit -m "feat: add dotfiles-bootstrap for remote installation"
```

---

## Phase 5: Cleanup & Testing

### Task 5.1: Remove old install scripts

**Files:**
- Delete: `run_onchange_install-packages.sh.tmpl`
- Delete: `run_onchange_lazygit.sh.tmpl`
- Delete: `run_onchange_neovim.sh.tmpl`
- Delete: `run_onchange_starship.sh.tmpl`

**Step 1: Archive and remove**

```bash
mkdir -p archive/old-install-scripts
mv run_onchange_*.tmpl archive/old-install-scripts/
git add archive/old-install-scripts/
git rm run_onchange_*.tmpl
git commit -m "chore: archive old install scripts"
```

---

### Task 5.2: Remove duplicate alias from aliases.fish

**Files:**
- Modify: `dot_config/private_fish/conf.d/aliases.fish.tmpl`

**Step 1: Remove grim alias (now a Go binary)**

The templated aliases will handle this, but ensure no duplicate grim definition.

**Step 2: Commit if changes made**

```bash
git add dot_config/private_fish/conf.d/aliases.fish.tmpl
git commit -m "chore: remove duplicate aliases"
```

---

### Task 5.3: Test locally

**Step 1: Build Go tools**

```bash
make build
```

**Step 2: Test chezmoi apply**

```bash
chezmoi diff
chezmoi apply --dry-run
```

**Step 3: Manual testing checklist**

- [ ] `g-` switches to previous branch
- [ ] `grim` opens interactive rebase
- [ ] `grbm` fetches, stashes, rebases, pops
- [ ] `cb` copies and pastes (test on macOS)
- [ ] Aliases work in fish/zsh/bash
- [ ] starship prompt loads
- [ ] mise activates
- [ ] zoxide works

---

### Task 5.4: Create first release

**Step 1: Tag and push**

```bash
git tag v2.0.0
git push origin v2.0.0
```

**Step 2: Verify release**

- Check GitHub Actions ran successfully
- Download and test release artifact
- Verify checksums

---

### Task 5.5: Update README

**Files:**
- Create/Modify: `README.md`

**Step 1: Write new README**

Document:
- Quick install command
- What's included
- Bootstrap for remote hosts
- Architecture overview

**Step 2: Commit**

```bash
git add README.md
git commit -m "docs: update README for v2"
```

---

## Execution Options

Plan saved to `docs/plans/2026-01-03-dotfiles-v2-implementation.md`

┌─────────────────────────────────────────────────────────────────────┐
│ COPY-PASTE COMMANDS                                                 │
├─────────────────────────────────────────────────────────────────────┤
│ Parallel Session:                                                   │
│ claude "Use bob:executing-plans on                                  │
│   docs/plans/2026-01-03-dotfiles-v2-implementation.md"              │
│                                                                     │
│ Claude Code Web (after push):                                       │
│ Execute the implementation plan at                                  │
│ `docs/plans/2026-01-03-dotfiles-v2-implementation.md`.              │
│ Start from first pending task, work through sequentially.           │
│ For each task: implement, test, commit. Self-review before moving.  │
└─────────────────────────────────────────────────────────────────────┘
