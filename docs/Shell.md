# Shell

zsh is the primary shell (via oh-my-zsh, theme [powerlevel10k](https://github.com/romkatv/powerlevel10k)).
bash is supported for rescue/compat. A shared `shell_profile` is sourced
by both, so interactive behavior stays consistent.

## Init chain

```
Terminal launches
├── zsh (login/interactive)
│     zshrc                      ← loads oh-my-zsh + p10k, then…
│       └── shell_profile        ← PATH, env, aliases, kube, rbenv, nvm…
│             ├── shell_profile.local    (per-env, symlinked from local/<env>/)
│             ├── shell_profile.private  (secrets; gitignored)
│             └── aliases
│                   └── aliases.local    (per-env)
│
└── bash
    ├── login shell  → bash_profile → shell_profile (…as above)
    └── non-login    → bashrc  → bash_profile  → shell_profile
                                    └── bash_aliases, prompt (bash only)
```

**Rule of thumb**: if you want something in *both* shells, put it in
`shell_profile`. If it's bash-only (prompt code, Debian default niceties),
put it in `bash_profile`. If it's zsh-only (oh-my-zsh plugin config,
zle options), put it in `zshrc`.

See also the "Shell-init reference" section in the top-level
[`README`](../README.md).

## oh-my-zsh

Custom dir is `$ZSH_CUSTOM = $HOME/.oh-my-zsh_custom`, symlinked from
[`oh-my-zsh_custom/`](../oh-my-zsh_custom) in this repo. Contains:

- **`themes/powerlevel10k/`** — submodule, the p10k prompt engine.
- **`themes/mark.zsh-theme`** — legacy custom theme (agnoster-derived, no
  powerline deps). Kept for reference; not the active theme.
- **`plugins/zsh-syntax-highlighting/`** — submodule.
- **`plugins/zsh-z/`** — submodule; `z <frecent-dir>` jumper.
- **`plugins/mark/`** — personal plugin with workflow helpers.

### Enabled plugins

From [`zshrc:39`](../zshrc):

```
mark gitfast git-extras tmux dirhistory rbenv brew docker gem z
zsh-syntax-highlighting kubectl ansible zsh-autosuggestions web-search
```

| Plugin | What it gives you |
|---|---|
| `mark` | Custom helpers (see [`oh-my-zsh_custom/plugins/mark/mark.plugin.zsh`](../oh-my-zsh_custom/plugins/mark/mark.plugin.zsh)) |
| `gitfast` | Faster version of the built-in git plugin (completion, aliases) |
| `git-extras` | Extra git subcommands (`git-summary`, `git-ignore`, etc.) |
| `tmux` | `tmux` auto-start hooks + completion |
| `dirhistory` | `Alt+←/→` to navigate dir history, `Alt+↑/↓` up/into dirs |
| `rbenv` | Ruby version manager integration |
| `brew`, `docker`, `gem`, `kubectl`, `ansible` | Command completion for those tools |
| `z` | `z foo` — frecency-based `cd` to anywhere you've been |
| `zsh-syntax-highlighting` | Fish-style live syntax highlighting on the command line |
| `zsh-autosuggestions` | Ghost-text from history; `→` or `End` to accept |
| `web-search` | `google foo`, `ddg foo`, etc. — opens a browser query |

### powerlevel10k

Prompt config is `p10k.zsh` (auto-generated; committed so the prompt is
identical across machines). To reconfigure interactively:

```sh
p10k configure
```

Then commit the new `p10k.zsh` — the file is verbose (~1600 lines) but
stable; treat it as generated.

Requires [[Other Tools#Fonts|MesloLGS Nerd Font]] (in `fonts/`) to render
glyphs correctly.

## Aliases worth knowing

From [`aliases`](../aliases):

| Alias | Expands to |
|---|---|
| `s`, `sl` | `ls` (typo-safe) |
| `la`, `al` | `ls -la` |
| `lr` | `ls -lart` |
| `please`, `ffs` | `sudo` |
| `vi` | `nvim` |
| `got`, `get` | `git ` |
| `gcm 'msg'` | `git commit -m 'msg'` |
| `gitst` | fetch origin + show commits ahead on `origin/master` |
| `gsmb` | list merged branches (excluding main/dev/stage) |
| `gdmb` | delete the above |
| `bi` / `bii` / `be` | bundle install (+ binstubs) / force / exec |
| `kl` / `klx` / `kln` | `kubectl` / `kubectx` / `kubens` |
| `tmux` | `tmux -2` (force 256-color) |
| `mphoenix`, `mpay`, etc. | `tmuxifier load-window <layout>` — see [[Tmux]] |

## Local and private overrides

Two layers below the tracked defaults:

- **`*.local`** — tracked per environment under
  [`local/generic_ubuntu/`](../local/generic_ubuntu) or
  [`local/home_macos/`](../local/home_macos). Picked by
  `make target_env=<env> set_local_dotfiles`. Use for per-host paths
  (Rancher Desktop, OS-specific gh path, machine-local aliases).
- **`*.private`** — never tracked. Gitignored at root (`/*.private`).
  Use for secrets (API keys, tokens). Touch an empty file to silence
  the sourcing check:

  ```sh
  touch ~/.shell_profile.private
  ```

## Environment extras sourced from shell_profile

- **`rbenv`** — Ruby shims prepended to `PATH`, `rbenv init -` evaluated.
- **`pipx`** — `~/.local/bin` on `PATH`.
- **Rust** — `~/.cargo/env` sourced if present.
- **NVM** — `~/.nvm/nvm.sh` sourced if present.
- **Kubeconfig merging** — every `.yml` under `~/.kube/custom-contexts/`
  is appended to `$KUBECONFIG`. Drop a context file in there and it's
  auto-available.
- **GPG TTY** — `export GPG_TTY=$(tty)` so commit signing works in a
  terminal without a graphical pinentry.
- **tmuxifier** — `eval "$(tmuxifier init -)"` so `tmuxifier load-window`
  works. Layouts live in [`tmux-layouts/`](../tmux-layouts) — see [[Tmux]].

## Related pages

- [[Tmux]] — tmux prefix, keybinds, tmuxifier
- [[Git]] — git aliases from the oh-my-zsh `gitfast`/`git-extras` plugins compose with these
- [[Other Tools#fonts]] — Nerd Font required by powerlevel10k
