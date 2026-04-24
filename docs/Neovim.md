# Neovim

Neovim is the editor (`vi` aliased to `nvim` in [`aliases`](../aliases)).
Plugins are managed by **[vim-plug](https://github.com/junegunn/vim-plug)**
(despite the file being named `vimrc.plugins` for historical Vundle
reasons). The config is structured:

```
vimrc                 ← entry point; options, autocmds, spec runners
├── vimrc.plugins      ← vim-plug plugin list
├── vimrc.add-ons      ← plugin-specific settings
└── vimrc.key_mappings ← custom keybinds (including Colemak remaps)

vimrc.local           ← per-env override (symlinked from local/<env>/)
config/nvim/init.vim  ← tells nvim to use ~/.vimrc, then loads lua/init.lua
config/nvim/lua/init.lua ← lua-land config (termguicolors, codegpt)
```

Key options: `relativenumber`, `set expandtab` (2-space tabs),
`set winwidth=84 winheight=999` (auto-maximise active split),
`set nohidden`, `listchars` shows trailing whitespace as dots,
`set spelllang=en_gb`, strip trailing whitespace on save, 80-col highlight
band past col 80.

## Leader keys

- `,` — normal leader
- `<space>` — aliased to `,` (so either works)

## Colemak remaps

I type on Colemak, so the homerow movement keys are swapped
([`vimrc.key_mappings:1`](../vimrc.key_mappings)):

| Key | Moves |
|---|---|
| `h` | up |
| `j` | left |
| `k` | down |
| `l` | right (unchanged) |

Also: `;` is remapped to `:` in normal mode (no shift to enter command
mode).

## Colour scheme

[`jesson/vim-daylight`](https://github.com/jesson/vim-daylight) auto-swaps
themes by time of day:

- 06–18: `github`
- 18–22: `railscasts`
- 22–06: `railscasts`

Both themes are installed by the plugin list.

## Plugins

### Navigation & search

| Plugin | Purpose | How I use it |
|---|---|---|
| [`ctrlp.vim`](https://github.com/ctrlpvim/ctrlp.vim) | Fuzzy file finder | `C-p` opens the finder; `<leader>.` → `:CtrlPTag` for tag search |
| [`nerdtree`](https://github.com/preservim/nerdtree) | Sidebar file explorer | `<leader>n` toggles |
| [`nerdtree-git-plugin`](https://github.com/Xuyuanp/nerdtree-git-plugin) | Git status markers in NERDTree | automatic |
| [`tagbar`](https://github.com/majutsushi/tagbar) | Sidebar list of file's functions/classes (ctags-powered) | `<leader>b` toggles |
| [`vim-autotag`](https://github.com/craigemery/vim-autotag) | Regenerate ctags on save | automatic; uses `uctags` (universal-ctags) |
| [`taglist.vim`](https://github.com/vim-scripts/taglist.vim) | Older ctags browser (legacy — prefer tagbar) | — |
| [`vim-easymotion`](https://github.com/Lokaltog/vim-easymotion) | Jump to any visible character | `<leader><leader>w` / `f<char>` prompts with labels |
| [`vim-expand-region`](https://github.com/terryma/vim-expand-region) | Expand visual selection by syntactic unit | `+` expands, `-` contracts |
| [`vim-tmux-navigator`](https://github.com/christoomey/vim-tmux-navigator) | `C-←/↓/↑/→` moves between vim splits *and* tmux panes | See [[Tmux]] for the tmux side |

### Search / grep

| Plugin | Purpose |
|---|---|
| [`ack.vim`](https://github.com/mileszs/ack.vim) | Run `ack` from vim, jump to matches (`:Ack foo`) |
| [`vim-easygrep`](https://github.com/dkprice/vim-easygrep) | Grep-across-files quick bindings |

### Editing

| Plugin | Purpose | Key mappings |
|---|---|---|
| [`nerdcommenter`](https://github.com/scrooloose/nerdcommenter) | Comment/uncomment lines | `<leader>cc`, `<leader>cu`, `<leader>c<space>` toggle |
| [`vim-surround`](https://github.com/tpope/vim-surround) | Add/change/delete surrounding quotes/brackets | `cs"'` (change `"` to `'`), `ds(` (delete surrounding parens), `ysiw)` (surround word with `)`) |
| [`vim-endwise`](https://github.com/tpope/vim-endwise) | Auto-insert `end` in Ruby, etc. | automatic |
| [`vim-unimpaired`](https://github.com/tpope/vim-unimpaired) | Paired navigation: `[q`/`]q` (quickfix), `[b`/`]b` (buffers), etc. | `[<space>` / `]<space>` to add blank lines |
| [`vim-abolish`](https://github.com/tpope/vim-abolish) | `:S/foo/bar/` case-preserving substitute, `crs`/`crc`/`crm` coercion between snake/camel/mixed case | |
| [`vim-eunuch`](https://github.com/tpope/vim-eunuch) | `:Rename newfile`, `:Delete`, `:Mkdir`, `:SudoWrite` | |
| [`vim-expand-region`](https://github.com/terryma/vim-expand-region) | (see above) | `+` / `-` |
| [`ale`](https://github.com/dense-analysis/ale) | Async linting (runs rubocop, eslint, etc. on save) | `:ALEFix`, jump with `[a` / `]a` |
| [`YouCompleteMe`](https://github.com/ycm-core/YouCompleteMe) | Completion engine (needs `./install.py` post-install) | Tab / arrow-keys through popup |
| [`vim-prettier`](https://github.com/prettier/vim-prettier) | Prettier formatter for JS/TS/CSS | `:Prettier` |
| `Recover.vim` | Nicer swap-file recovery prompt | automatic |
| [`vim-sensible`](https://github.com/tpope/vim-sensible) | Universally-agreed defaults | automatic |

### Git

| Plugin | Purpose |
|---|---|
| [`vim-gitgutter`](https://github.com/airblade/vim-gitgutter) | `+`/`~`/`-` signs in the gutter for uncommitted changes |
| [`vim-fugitive`](https://github.com/tpope/vim-fugitive) | Deep git integration. `:G` or `:Git status` gives the summary view; then `-` to stage hunks, `=` to inline-diff, `cc` to commit. Also `:Gblame`, `:Gdiffsplit`, `:Glog` |
| [`gitv`](https://github.com/gregsexton/gitv) | `:Gitv` opens a gitk-style graph viewer |
| [`vim-git`](https://github.com/tpope/vim-git) | Syntax + hooks for commit-message editing |

In fugitive blob/tree buffers, custom mapping: `jj` walks up to the parent
(see [`vimrc.add-ons`](../vimrc.add-ons)). `c` jumps to the originating
commit (built-in).

### Ruby & testing

| Plugin | Purpose | Bindings |
|---|---|---|
| [`vim-rails`](https://github.com/tpope/vim-rails) | Rails-aware navigation | `:Rserver`, `gf` to jump through `params[:x]` → views, models, etc. |
| [`vim-rbenv`](https://github.com/tpope/vim-rbenv) | Use rbenv's ruby in vim | automatic |
| [`vim-bundler`](https://github.com/tpope/vim-bundler) | Bundler integration for `:Rails`/`:Rake` | automatic |
| [`vim-ruby`](https://github.com/vim-ruby/vim-ruby) | Ruby syntax/indent | automatic |
| [`vim-ruby-minitest`](https://github.com/sunaku/vim-ruby-minitest) | Minitest syntax/completion | automatic |
| [`vim-rspec`](https://github.com/thoughtbot/vim-rspec) | Run RSpec from inside vim | `<leader>t` file, `<leader>s` nearest, `<leader>l` last, `<leader>a` all (also bound to `r`/`s`/`l`/`a` in [`vimrc`](../vimrc)) |
| [`vim-vroom`](https://github.com/skalnik/vim-vroom) | Alternative test-runner (RSpec/Rails) | `<leader>r` |
| [`vim-seeing-is-believing`](https://github.com/hwartig/vim-seeing-is-believing) | Inline eval of Ruby expressions (requires `seeing_is_believing` gem) | `F5` mark, `F6` run |

### Language support

Filetype plugins for: Go (`vim-golang`), Elixir (`vim-elixir`), JS
(`vim-javascript`), HAML/Slim (`vim-haml`, `vim-slim`), SCSS
(`scss-syntax.vim`), Markdown (`vim-markdown`), Cucumber (`vim-cucumber`),
CSV (`csv.vim`), Textile (`textile.vim`).

### REPL integration

- [`vim-slime`](https://github.com/jpalardy/vim-slime) — `C-c C-c` sends
  the current paragraph/selection to a tmux pane (configured with
  `g:slime_target = 'tmux'`). Great for REPLs, IRB, iex. First use
  prompts for `session:window.pane`.

### Snippets

- [`vim-snipmate`](https://github.com/garbas/vim-snipmate) +
  [`vim-snippets`](https://github.com/honza/vim-snippets) — tab-expand
  boilerplate. Uses `snipMate.snippet_version = 1` (new parser). Snippets
  loaded from `vim-snippets`.

### Status line

- [`vim-airline`](https://github.com/bling/vim-airline) — the bottom
  status bar. Uses powerline glyphs (`g:airline_powerline_fonts=1`). Same
  Nerd Font requirement as [[Shell#powerlevel10k]].

## Custom key mappings

From [`vimrc.key_mappings`](../vimrc.key_mappings) and [`vimrc`](../vimrc):

| Keys | Mode | What |
|---|---|---|
| `,` or `<space>` | any | Leader |
| `h j k l` | n/v | Remapped for Colemak (see above) |
| `;` | n | `:` (no shift) |
| `<leader>e` | n | `:edit <cwd-of-current-file>/` |
| `<leader>v` | n | `:view <cwd-of-current-file>/` |
| `<leader>gr` | n | `:split config/routes.rb` (Rails jump) |
| `<leader>gg` | n | `:split Gemfile` |
| `<leader>n` | n | Toggle NERDTree |
| `<leader>b` | n | Toggle Tagbar |
| `<leader>.` | n | `:CtrlPTag` |
| `<leader>t` / `s` / `l` / `a` | n | Run spec: current file / nearest / last / all |
| `<leader>r` | n | Also run current spec file (vim-vroom) |
| `F2` | — | Toggle `paste` mode |
| `F3` | — | Toggle soft-wrap (`TextWrap` function) |
| `F4` | — | Set `textwidth=79` (hard-wrap at 79) |
| `F5` / `F6` | any | seeing-is-believing mark / run |
| `C-←/↓/↑/→` | any | vim-tmux-navigator split/pane move (see [[Tmux]]) |

## First-run bootstrap

[`vimrc.plugins`](../vimrc.plugins) auto-installs vim-plug on first
launch:

```vim
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo … plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
```

So a fresh machine: `nvim` → plugins install → restart. For YouCompleteMe
you may need to `cd ~/.vim/bundle/YouCompleteMe && ./install.py`
afterwards (see comments in `vimrc.plugins`).

## Workflow tips

- **Split ergonomics**: `set winheight=999 winminheight=15` gives you a
  "focus the active split" experience — the window you're in grows huge,
  others shrink. Jump with `C-w w` or a `vim-tmux-navigator` arrow.
- **Save-time hooks**: trailing whitespace is stripped on save
  (`StripTrailingWhitespaces` autocmd), ctags are regenerated
  (`vim-autotag`), ALE runs linters.
- **Spell check** is on automatically for `*.md`, `*.txt`, and git commit
  messages. `]s`/`[s` next/prev misspelling; `z=` suggestions; `zg` add
  to dictionary.

## Related pages

- [[Tmux]] — vim-tmux-navigator pairs with tmux-side bindings
- [[Git]] — fugitive/gitgutter complement the git aliases
- [[Shell]] — `alias vi=nvim`
