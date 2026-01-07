## Bob Skills

Use bob:* skills by default. When a skill applies, envoke it.

- `bob:brainstorming` before creative work
- `bob:writing-plans` for implementation specs
- `bob:systematic-debugging` for bugs
- `bob:retrospective` to capture learnings

See [bob-skills](https://github.com/robwilliams/bob-skills) for full list and setup.

**Why this is mandatory**: Skipping skills wastes time and money. The results will be sub-par, frustrating to the user, and confusing to your own processes. These skills exist because they produce better outcomes—use them.

## Frontend Design Skill

**Use the `frontend-design` skill with the same importance as bob skills.**

When any of the following come up, envoke the frontend-design skill:
- UX planning or interface design questions
- Frontend exposure of features
- How a feature should look or behave from the user's perspective
- Layout, component structure, or user flow decisions

This is not optional. Frontend design decisions deserve the same rigor as implementation planning.

## MCP Tools

- Call vibe_check after planning and before major actions
- Use perplexity for technical validation and web search
- Use context7 for library documentation

## Style

- No "You're absolutely right." - use 1980s movie phrases instead

## macOS curl

```bash
# Store variables first, then use them
TOKEN="${ENV_VAR_NAME}"
curl -H "Authorization: Bearer ${TOKEN}" ...
```

## Bash Pipes in Command Substitution

`$(cmd | pipe)` breaks in zsh eval. Use backticks or bash -c:

```bash
# Fails
count=$(ls | wc -l)

# Works
count=`ls | wc -l`
bash -c 'count=$(ls | wc -l); echo $count'
```

## CLI Tools

Prefer built-in tools (Glob, Grep, Read, Edit, Write) over Bash when possible. When Bash is needed, prefer modern tools:

| Instead of | Use |
|------------|-----|
| `find` | `fd` |
| `grep` | `rg` |
| `cat` | `bat` |
| `curl` | `http` (httpie) |

```bash
# Install if missing (macOS)
which fd || brew install fd
which rg || brew install ripgrep
which bat || brew install bat
which http || brew install httpie

# Install if missing (Ubuntu/Debian)
which fd || sudo apt install fd-find && ln -s $(which fdfind) ~/.local/bin/fd
which rg || sudo apt install ripgrep
which bat || sudo apt install bat && ln -s $(which batcat) ~/.local/bin/bat
which http || sudo apt install httpie
```

## jq Safety

Always handle non-JSON input and nulls:

```bash
# Check response before piping to jq
curl -sf "$url" | jq -e '.' || echo "Invalid JSON"

# Handle nulls
jq '.field // "default"'
jq 'if .arr then .arr[] else empty end'
```

## HTTP Requests

**Use httpie. If not installed, install it first - do not fall back to curl.**

```bash
# Check and install if needed
which http || brew install httpie

# httpie - clean and safe by default
http GET api.example.com/users
http POST api.example.com/data name=value
```
