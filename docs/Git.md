# Git

Config lives in three files plus a per-env include:

- [`gitconfig`](../gitconfig) → `~/.gitconfig` (tracked defaults)
- [`gitignore_global`](../gitignore_global) → `~/.gitignore_global` (patterns excluded from every repo)
- [`git_commit_template.txt`](../git_commit_template.txt) → `~/.git_commit_template.txt` (commit-message scaffold)
- [`gitattributes`](../gitattributes) → `~/.gitattributes` (Gemfile.lock merge driver)
- [`local/<env>/gitconfig.local`](../local/generic_ubuntu/gitconfig.local) → `~/.gitconfig.local` (per-env: email, `gh` path)

Plus the per-repo gitignore style at [`config/git/ignore`](../config/git/ignore)
(macOS finder cruft; symlinked to `~/.config/git/ignore`).

## Include layering

The tracked [`gitconfig`](../gitconfig) ends with:

```ini
[include]
    path = ~/.gitconfig.local
```

Included **last** so the local file wins — per-machine email, credential
helpers, signing keys can override the tracked defaults without editing
a tracked file.

## User identity

Tracked:

```ini
[user]
    name = Mark Coleman
    email = git@protected.mehcoleman.com
    signingkey = 5016C1BB1F1FBA4D
```

The Linux-specific `gh` credential helper lives in
[`local/generic_ubuntu/gitconfig.local`](../local/generic_ubuntu/gitconfig.local):

```ini
[credential "https://github.com"]
    helper =
    helper = !/usr/bin/gh auth git-credential
```

The empty first `helper =` clears any inherited system helper (see the
gh docs reasoning). macOS gets a different `gh` path so it lives in the
macOS local override.

## Aliases

From [`gitconfig:30-52`](../gitconfig):

| Alias | Expands to | Why |
|---|---|---|
| `co` | `checkout` | |
| `ci` | `commit` | |
| `ciam` | `commit -am` | stage-all + commit |
| `cis` | `commit -s` | signed-off-by |
| `br` | `branch` | |
| `st` | `status` | |
| `rb` | `rebase` | |
| `df` | `diff` | |
| `d` | `difftool` | opens vimdiff |
| `fix` | `commit --amend -C HEAD-` | amend, reusing previous message |
| `lg` | graph log, one-liner w/ relative dates | everyday scan |
| `shlg` | multi-line graph log with author names | detailed scan |
| `lg2` | graph log with full timestamps | forensic |
| `pl` | graph log, custom format | |
| `lgp` | `log -p` | log with patches |
| `type` | `cat-file -t` | |
| `dump` | `cat-file -p` | |
| `unstage` | `reset HEAD --` | |
| `panic` | tar the working dir to `../git_panic.tar` | oh-no button |
| `fix-conflicts` | open all conflicted files in `$EDITOR` | |
| `it` | `!git init && git commit -m "root" --allow-empty` | new repo with a root commit |
| `alias` | list all aliases | `git alias` |

Combined with the shell aliases from [[Shell#Aliases-worth-knowing]]:
`got` / `get` / `gcm 'msg'` / `gitst` / `gsmb` / `gdmb`.

## Commit template

`[commit] template = ~/.git_commit_template.txt` pulls in
[`git_commit_template.txt`](../git_commit_template.txt) on every
`git commit` without `-m`. Gives the Conventional-Commits-ish prompt:

```
[feat|fix][(scope)][!]: Description
```

The in-file comments remind to explain WHY, HOW, and WHAT — and list
the keywords GitHub/Bitbucket recognise in commit messages (`closes`,
`fixes`, `resolves`).

## Pager — diff-highlight

`[pager]` routes `log`, `show`, `diff`, `grep` through `diff-highlight`
(a perl script in [`bin/diff-highlight`](../bin/diff-highlight)) piped
into `less -RX`. This highlights the *intra-line* changes inside a diff
rather than just marking the whole line red/green — much easier to read
word-level edits.

`[interactive] diffFilter = diff-highlight` applies the same to
`git add -p`.

Make sure `~/bin/` (symlinked from [`bin/`](../bin)) is on `$PATH` — it
is by default via [`shell_profile:7`](../shell_profile).

`less -RX` from [`lesskey`](../lesskey) keeps results on-screen after
exit and renders ANSI colours.

## Diff and merge

| Setting | Value | Effect |
|---|---|---|
| `diff.algorithm` | `histogram` | Better diffs for refactors |
| `diff.compactionHeuristic` | `true` | Fewer weird context shifts |
| `diff.indentHeuristic` | `on` | Aligns indentation-only changes |
| `merge.conflictStyle` | `zdiff3` | Shows base + both sides (better than default diff3) |
| `merge.tool` / `diff.tool` | `vimdiff` | `git d` → vimdiff, `git mergetool` → vimdiff |
| `mergetool.prompt` / `difftool.prompt` | `false` | Doesn't ask "launch vimdiff? [y/n]" every time |
| `rerere.enabled` | `true` | Reuse Recorded Resolution — remembers past conflict resolutions |
| `pull.ff` | `only` | Never auto-merge on pull; fail and force you to rebase or merge explicitly |
| `push.default` | `current` | `git push` pushes current branch to its remote counterpart |
| `branch.autosetupmerge` | `true` | `git checkout -b` auto-tracks the parent branch |
| `submodule.fetchJobs` | `4` | Parallel submodule fetch |
| `init.defaultBranch` | `master` | (personal preference; repos default to `master`) |
| `core.whitespace` | `fix,-indent-with-non-tab,trailing-space,cr-at-eol` | Warn on common whitespace sins |

## Gemfile.lock merge driver

[`gitattributes`](../gitattributes):

```
Gemfile.lock merge=gemfilelock
```

Driver definition in `gitconfig`:

```ini
[merge "gemfilelock"]
    name = relocks the Gemfile.lock
    driver = bundle install
```

So when `Gemfile.lock` conflicts on merge, `bundle install` runs and
re-resolves rather than producing a three-way merge you'd have to edit
by hand.

## Fix-conflicts helper

```
git fix-conflicts
```

Runs your editor on exactly the files with unresolved conflicts — saves
hunting through `git status`.

## LFS

`[filter "lfs"]` + `[lfs] pruneverifyremotealways = true` enables Git
LFS when installed. No repos use LFS here by default.

## Related pages

- [[Shell#Aliases-worth-knowing]] — `got`/`gitst`/`gsmb`/`gdmb` shell wrappers
- [[Neovim#Git]] — fugitive, gitgutter, gitv plugins
- [[Bin Scripts#diff-highlight]] — the pager perl script
