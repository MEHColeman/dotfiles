# Bin Scripts

Scripts in [`bin/`](../bin), symlinked into `~/bin/` by the Makefile.
`~/bin` is on `$PATH` via [`shell_profile:7`](../shell_profile).

| Script | What it does |
|---|---|
| [`diff-highlight`](../bin/diff-highlight) | Perl script that highlights intra-line diff changes. Wired up as git's pager — see [[Git#Pager-diff-highlight]] |
| [`ssh-manager`](../bin/ssh-manager) | Interactive SSH key + `~/.ssh/config` host manager (from [`mihaliak/dotfiles`](https://github.com/mihaliak/dotfiles)) |
| [`start_ssh_agent.sh`](../bin/start_ssh_agent.sh) | `eval "$(ssh-agent -s)"` — one-shot ssh-agent start |
| [`tmux.number.sh`](../bin/tmux.number.sh) | Swap or move tmux window to a target index; used by `prefix + <` — see [[Tmux]] |
| [`tree`](../bin/tree) | Tiny `ls`-based directory tree (no `tree(1)` required) — public-domain shim |

## ssh-manager

Usage:

```
ssh-manager <command>
```

| Command | Action |
|---|---|
| `list` | List keys + hosts |
| `list-keys` | List `~/.ssh/*.pub` |
| `list-host` | List hosts defined in `~/.ssh/config` |
| `copy <name>` | Copy `~/.ssh/id_ed25519_<name>.pub` to clipboard (`pbcopy` — macOS) |
| `new` | Generate a new `ed25519` key interactively |
| `host [--key]` | Add a host to `~/.ssh/config`; `--key` generates a key at the same time |
| `remove <name>` | Remove a host from `~/.ssh/config` |

Assumptions: your keys follow `id_ed25519_<name>` naming; `pbcopy` is
available (macOS — swap for `xclip -selection clipboard` or
`wl-copy` on Linux if you want `copy` to work there).

## start_ssh_agent.sh

Just `eval "$(ssh-agent -s)"`. Run once per shell when ssh-add'ing keys
manually. Most setups use the system's ssh-agent (or a keychain-based
one) so this is rarely needed interactively — kept for scripting.

## tmux.number.sh

Given a numeric arg N, either **swaps** the current tmux window to
position N (if that slot is taken) or **moves** it there (if not).
Invoked from [`tmux.conf:66`](../tmux.conf):

```
bind < command-prompt -p index "run-shell '$HOME/bin/tmux.number.sh %%'"
```

So `prefix + <` prompts for a new index and renumbers.

## tree

Not the `tree(1)` binary — a small `ls | grep | sed` pipeline that draws
a tree view. Kept for systems where `tree` isn't installed. If you have
the real `tree` installed via apt/brew, that'll be found first on
`$PATH` (and prints much richer output).

## Related pages

- [[Git]] — `diff-highlight` wired as the pager
- [[Tmux]] — `tmux.number.sh` behind `prefix + <`
