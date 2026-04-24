# Claude Code

Anthropic's CLI coding assistant. Sessions, auth, and history live in
`~/.claude/` (machine state, not tracked). Only specific files are
symlinked from this repo into that directory.

## What this repo tracks

[`claude/`](../claude):

- `settings.json` — user-level Claude Code settings (tracked)
- `.gitignore` — blocks everything else in `~/.claude/` from ever being
  committed (credentials, session logs, plugin caches, etc.)

The Makefile's `link_claude_to_home` target **file-symlinks only the
tracked files**, never the directory — `~/.claude/` stays a real app
directory, and `settings.json` inside it points back to this repo.

## Current `settings.json`

```json
{
  "voice": { "enabled": true, "mode": "hold" },
  "voiceEnabled": true,
  "skipAutoPermissionPrompt": true
}
```

- **`voice.mode: hold`** — push-to-talk; hold a key to dictate.
- **`skipAutoPermissionPrompt`** — don't auto-prompt for permissions at
  session start (useful for familiar trusted projects; remove if you
  want the prompt).

Full schema: <https://docs.claude.com/en/docs/claude-code/settings>.

## Directory layout inside `~/.claude/`

Not tracked, but useful to know what lives there:

| Path | Purpose | Tracked? |
|---|---|---|
| `settings.json` | User settings (model, permissions, hooks) | ✅ via symlink |
| `CLAUDE.md` | Personal memory file, loaded into every session | ❌ (per-machine) |
| `commands/` | User-defined slash commands (`/my-command`) — one `.md` per command | optional (consider tracking) |
| `agents/` | User-defined subagents — one `.md` per agent | optional |
| `skills/` | User-defined skills (richer than commands, can bundle scripts) | optional |
| `plugins/` | Installed plugins | ❌ |
| `memory/` | Auto-memory (built up per-project by the assistant) | ❌ |
| `sessions/`, `projects/`, `shell-snapshots/`, `tasks/`, `backups/`, `cache/`, `file-history/`, `downloads/`, `session-env/` | Runtime state | ❌ (gitignored) |
| `.credentials.json` | OAuth tokens | ❌ (gitignored) |
| `history.jsonl` | Prompt history | ❌ (gitignored) |

## Adding user-level commands/agents/skills

If you author personal commands/agents/skills and want them replicated
across machines:

1. Put the content in this repo under `claude/commands/`,
   `claude/agents/`, or `claude/skills/`.
2. Extend the Makefile's `link_claude_to_home` target (or add a new
   one) to symlink those subdirs into `~/.claude/`.
3. Be careful not to symlink the whole `~/.claude/` dir — only
   individual files/subdirs, so app state isn't touched.

Per-project commands/agents/skills (under `.claude/` in a given repo)
are unaffected by this — they're part of that repo, not this dotfiles
config.

## Keybindings

Personal keybindings file at `~/.claude/keybindings.json` (not tracked
by default; consider adding to `claude/` if you want them replicated).
Defaults are fine for most uses — tweak only what you need.

## Hooks

Hooks are shell commands the harness runs in response to events (tool
calls, prompt submit, session stop). They're configured in
`settings.json`. None are set up in the tracked file yet. Add them when
you want automated behaviours that *must* happen regardless of what the
model remembers — for example, auto-lint on file write, or notify when
a long task completes.

Schema:

```json
{
  "hooks": {
    "PostToolUse": [
      { "matcher": "Edit|Write", "hooks": [
        { "type": "command", "command": "echo done" }
      ]}
    ]
  }
}
```

See <https://docs.claude.com/en/docs/claude-code/hooks>.

## Slash commands (built-in)

A few that come up often:

| Command | What |
|---|---|
| `/help` | Command list + docs pointer |
| `/config` | Interactive settings editor |
| `/clear` | Clear current session context |
| `/compact` | Summarise the session and start fresh (preserves a digest) |
| `/exit` | End session |
| `/loop <interval> <command>` | Run a command on a recurring interval |
| `/schedule` | Create a scheduled cloud agent (routine) |
| `/review` | Review a pull request |
| `/security-review` | Security review of pending changes |
| `/init` | Create a `CLAUDE.md` for the current project |
| `/ultrareview [PR#]` | Multi-agent cloud review of the current branch or a PR (paid) |

## Per-project setup

Drop a `CLAUDE.md` at the repo root (or anywhere in the repo tree) to
give the assistant project-specific context — architectural notes,
conventions, gotchas. It's loaded into every session started inside
that repo. `/init` generates a starter one.

Per-project tool and permission settings live in
`<repo>/.claude/settings.json` (or `settings.local.json` for untracked
per-user overrides).

## Memory

Auto-memory is a per-user, file-based system the assistant maintains
itself under `~/.claude/projects/<project-hash>/memory/`. Not tracked.
Ask the assistant to "remember X" and it writes a memory file; ask it
to "forget X" to remove it.

## Related pages

- [[Shell]] — `~/.claude/` is referenced by `$EDITOR` and interacts
  with shell env
