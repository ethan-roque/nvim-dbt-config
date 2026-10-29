# Neovim config

A Neovim setup for dbt and SQL work, using [lazy.nvim](https://github.com/folke/lazy.nvim) for plugins.

## Before you install

| Needed for | What to install |
|---|---|
| Everything | Neovim 0.12 or newer |
| Treesitter (uses the `main` branch) | `brew install tree-sitter-cli` |
| Telescope's fast search plugin | `make` and a C compiler (`xcode-select --install`) |
| Text search (`<leader>fg`) | `brew install ripgrep` |
| Icons in the completion menu and file tree | A [Nerd Font](https://www.nerdfonts.com/), set as your terminal font |
| SQL formatting (`<leader>f`) | `sqlfmt` |
| dbt language server (optional) | `dbt-language-server` on your `PATH` |
| dbt commands (`<leader>drun` and friends) | A `data-dbx-dbt` checkout with its `.venv` and `.env` set up (see below) |

## Install

### Try it without touching your own config

```bash
git clone https://github.com/ethan-roque/nvim-config.git ~/.config/nvim-team
NVIM_APPNAME=nvim-team nvim
```

`NVIM_APPNAME` makes Neovim use `~/.config/nvim-team` and its own plugin folder, so your existing setup stays as it is.

### Switch over fully

```bash
mv ~/.config/nvim ~/.config/nvim.bak    # only if you already have a config
git clone https://github.com/ethan-roque/nvim-config.git ~/.config/nvim
nvim
```

Plugins install on first start. Language servers (`lua_ls`, `yamlls`) install through Mason.

## dbt setup

The dbt keymaps run dbt from your `data-dbx-dbt` checkout. They expect it at `~/Documents/GitHub/data-dbx-dbt`. If yours is somewhere else, set this in your shell profile:

```bash
export DBT_REPO_ROOT=~/path/to/data-dbx-dbt
```

Runs use `--defer` against the production state in `prd_target/target/`.

## All keymaps

The leader key is `Space`, so `<leader>fg` means press `Space`, then `f`, then `g`. Press `Space` and wait to see every leader keymap in a popup.

These work from any normal buffer. Keys that only work inside a plugin's own window (the file tree, a Telescope picker, the diff view) are listed under that plugin in [Plugins](#plugins).

### Files and search

| Keys | What it does | From |
|---|---|---|
| `<C-p>` | Find a file by name | Telescope |
| `<leader>fg` | Search text across the project | Telescope |
| `<leader>fb` | Pick from open buffers | Telescope |
| `<leader>fh` | Search Neovim help | Telescope |
| `<leader>b` | Show or hide the file tree | Neo-tree |
| `<leader>e` | Jump between the file tree and your file | Neo-tree |

### Buffers, windows and terminal

| Keys | What it does | From |
|---|---|---|
| `<S-h>` / `<S-l>` | Previous / next buffer | Bufferline |
| `<leader>x` | Close the current buffer (keeps the window open) | Bufferline |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | Move to the window left / below / above / right | `init.lua` |
| `<C-t>` or `<leader>t` | Show or hide a terminal at the bottom (it keeps running when hidden) | `init.lua` |
| `<Esc>` (in the terminal) | Leave terminal typing mode | `init.lua` |
| `<leader>cn` | Copy the file name | `init.lua` |
| `<leader>cp` | Copy the full file path | `init.lua` |

### Code

| Keys | What it does | From |
|---|---|---|
| `K` | Show docs for the thing under the cursor | LSP |
| `gd` | Go to definition. In SQL files this is dbt-forge's version, which jumps to the dbt model, source or macro | LSP / dbt-forge |
| `<leader>ca` | Code actions (normal and visual mode) | LSP |
| `<leader>f` | Format the buffer or selection | conform |
| `<leader>?` | Show keymaps for the current buffer | which-key |

### Git

| Keys | What it does | From |
|---|---|---|
| `<leader>gd` | Open or close the git diff view | Diffview |
| `<leader>gh` | Show git history for the current file | Diffview |
| `<leader>gq` | Close the diff view | Diffview |

### dbt

| Keys | What it does | From |
|---|---|---|
| `<leader>drun` | `dbt run` the current model | dbtpal |
| `<leader>dtest` | `dbt test` the current model | dbtpal |
| `<leader>dbuild` | `dbt build` the current model | dbtpal |
| `<leader>dv` | `dbt run` the current model with extra vars (asks for JSON) | dbtpal |
| `<leader>dd` | Run any dbt command | dbtpal |
| `<leader>dm` | Pick models | dbtpal |
| `<leader>dw` | Walk the dbt graph | dbtpal |
| `<leader>dl` | Show lineage for the current model | dbt-forge |

`<leader>dl` works once you have opened a `.sql` file.

### Completion menu (insert mode)

| Keys | What it does | From |
|---|---|---|
| `<CR>` | Accept the selected item | blink.cmp |
| `<C-Space>` | Open the menu, or show / hide docs for the selected item | blink.cmp |
| `<C-e>` | Close the menu | blink.cmp |
| `<Up>` / `<Down>` or `<C-p>` / `<C-n>` | Move through the menu | blink.cmp |
| `<Tab>` / `<S-Tab>` | Jump to the next / previous spot in a snippet | blink.cmp |
| `<C-b>` / `<C-f>` | Scroll the docs window | blink.cmp |
| `<C-k>` | Show function signature help | blink.cmp |

### Start screen

| Keys | What it does |
|---|---|
| `f` | Find a file |
| `n` | New file |
| `r` | Recent files |
| `g` | Search text |
| `c` | Open this config |
| `l` | Open Lazy (plugin manager) |
| `q` | Quit |

## Plugins

### Look and layout

**[catppuccin](https://github.com/catppuccin/nvim)**: the colour theme (Mocha). Also sets custom colours for the start screen and the CSV header row. No keymaps.

**[dashboard-nvim](https://github.com/nvimdev/dashboard-nvim)**: the start screen when you open Neovim with no file. Keys are in [Start screen](#start-screen).

**[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)**: the status line at the bottom, and a bar at the top of each window showing its file name. No keymaps.

**[bufferline.nvim](https://github.com/akinsho/bufferline.nvim)**: shows open buffers as tabs along the top, with error and warning counts.

| Keys | What it does |
|---|---|
| `<S-h>` / `<S-l>` | Previous / next buffer |
| `<leader>x` | Close the current buffer (keeps the window open) |

**[which-key.nvim](https://github.com/folke/which-key.nvim)**: shows a popup of the keys you can press next. Press `Space` and wait to see all leader keymaps.

| Keys | What it does |
|---|---|
| `<leader>?` | Show keymaps for the current buffer |

### Files and search

**[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)**: the file tree on the left. Hidden and gitignored files are shown dimmed, and the tree follows the file you have open.

| Keys | What it does |
|---|---|
| `<leader>b` | Show or hide the file tree |
| `<leader>e` | Jump between the file tree and your file |

Inside the tree:

| Keys | What it does |
|---|---|
| `<CR>` | Open the file, or open / close the folder |
| `s` / `S` / `t` | Open in a side split / a split below / a new tab |
| `P` | Preview the file without opening it |
| `a` | Add a file (end the name with `/` to make a folder) |
| `A` | Add a folder |
| `r` | Rename |
| `d` | Delete |
| `c` / `m` | Copy / move (asks for the new path) |
| `y` / `x` / `p` | Copy / cut / paste |
| `H` | Show or hide hidden files |
| `/` | Fuzzy-find in the tree |
| `.` | Make the selected folder the root |
| `<BS>` | Go up one folder |
| `[g` / `]g` | Previous / next file with git changes |
| `C` / `z` | Close this folder / close all folders |
| `R` | Refresh |
| `q` | Close the tree |
| `?` | Show every key |

**[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)**: fuzzy finder for files, text, buffers and help. With `telescope-fzf-native` for faster matching and `telescope-ui-select`, so menus like code actions open in a Telescope picker.

| Keys | What it does |
|---|---|
| `<C-p>` | Find a file by name |
| `<leader>fg` | Search text across the project |
| `<leader>fb` | Pick from open buffers |
| `<leader>fh` | Search Neovim help |

Inside a picker:

| Keys | What it does |
|---|---|
| `<CR>` | Open the selected item |
| `<C-x>` / `<C-v>` / `<C-t>` | Open in a split below / a side split / a new tab |
| `<C-n>` / `<C-p>` or `<Down>` / `<Up>` | Move through the results |
| `<C-u>` / `<C-d>` | Scroll the preview |
| `<Tab>` | Mark several items |
| `<C-q>` | Send the results to the quickfix list |
| `<C-c>` | Close (or `<Esc>` twice) |
| `<C-/>` | Show every key |

### Editing and completion

**[blink.cmp](https://github.com/saghen/blink.cmp)**: the completion menu. Suggestions come from the language server, file paths, snippets (from `friendly-snippets`) and words in the buffer. Keys are in [Completion menu](#completion-menu-insert-mode).

**[nvim-autopairs](https://github.com/windwp/nvim-autopairs)**: closes brackets and quotes for you as you type. No keymaps.

**[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)**: better syntax highlighting and indenting. SQL files keep Vim's normal highlighting as well, because the SQL parser cannot read dbt's Jinja. No keymaps.

**[conform.nvim](https://github.com/stevearc/conform.nvim)**: formatting. Uses `sqlfmt` for SQL, and the language server for everything else.

| Keys | What it does |
|---|---|
| `<leader>f` | Format the buffer or selection |

### Language servers

**[mason.nvim](https://github.com/mason-org/mason.nvim)** and **[mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim)**: install language servers for you. `lua_ls` and `yamlls` install automatically. Run `:Mason` to see or add more.

**[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)**: connects Neovim to the language servers: `lua_ls` for Lua, `yamlls` for YAML, and `dbt-language-server` for dbt projects. With `schemastore.nvim`, `yamlls` checks dbt YAML files (`dbt_project.yml`, `models/*.yml` and so on) against the dbt Core schemas.

| Keys | What it does |
|---|---|
| `K` | Show docs for the thing under the cursor |
| `gd` | Go to definition (in SQL files, dbt-forge's version replaces this) |
| `<leader>ca` | Code actions (normal and visual mode) |

### Git

**[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)**: marks added, changed and deleted lines in the left margin. No keymaps. Useful commands: `:Gitsigns blame_line`, `:Gitsigns preview_hunk`, `:Gitsigns toggle_current_line_blame`.

**[diffview.nvim](https://github.com/sindrets/diffview.nvim)**: a side-by-side view of your git changes, and the git history of a file.

| Keys | What it does |
|---|---|
| `<leader>gd` | Open or close the diff view |
| `<leader>gh` | Show git history for the current file |
| `<leader>gq` | Close the diff view |

Inside the diff view (in here, `<leader>e` and `<leader>b` control Diffview's file list, not Neo-tree):

| Keys | What it does |
|---|---|
| `<Tab>` / `<S-Tab>` | Next / previous changed file |
| `gf` | Open the file for editing |
| `<leader>e` | Jump to the file list |
| `<leader>b` | Show or hide the file list |
| `g<C-x>` | Switch layout |
| `[x` / `]x` | Previous / next merge conflict |
| `<leader>co` / `<leader>ct` / `<leader>cb` / `<leader>ca` | Keep ours / theirs / base / all for this conflict |
| `dx` | Delete this conflict section |
| `g?` | Show every key |

In the file list:

| Keys | What it does |
|---|---|
| `<CR>` or `o` | Open the diff for that file |
| `-` or `s` | Stage / unstage the file |
| `S` / `U` | Stage all / unstage all |
| `X` | Throw away changes to the file (cannot be undone) |
| `i` | Switch between list and tree view |
| `R` | Refresh |

In the file history list:

| Keys | What it does |
|---|---|
| `<CR>` | Open the diff for that commit |
| `y` | Copy the commit hash |
| `L` | Show the commit details |

### dbt

**[dbtpal.nvim](https://github.com/samyilin/dbtpal.nvim)**: runs dbt commands from Neovim using the `data-dbx-dbt` repo's `.venv` and `.env`. Output opens in a window at the bottom; press `q` to close it.

| Keys | What it does |
|---|---|
| `<leader>drun` | `dbt run` the current model |
| `<leader>dtest` | `dbt test` the current model |
| `<leader>dbuild` | `dbt build` the current model |
| `<leader>dv` | `dbt run` the current model with extra vars (asks for JSON) |
| `<leader>dd` | Run any dbt command |
| `<leader>dm` | Pick models |
| `<leader>dw` | Walk the dbt graph |

**[dbt-forge.nvim](https://github.com/gbakes/dbt-forge.nvim)**: the model lineage graph, and go-to-definition in SQL files. Its run and test keys are turned off, because dbtpal does that. Loads when you open a `.sql` file.

| Keys | What it does |
|---|---|
| `<leader>dl` | Show lineage for the current model |
| `gd` (SQL files) | Go to the dbt model, source or macro under the cursor |

Inside the lineage window:

| Keys | What it does |
|---|---|
| `<CR>` | Open the model |
| `o` | Open the model but stay in the lineage window |
| `r` | Re-draw the lineage from this model |
| `+` / `-` | Show more / fewer levels |
| `R` | Run `dbt parse` and reload |
| `q` or `<Esc>` | Close |

### CSV and Markdown

**[csvview.nvim](https://github.com/hat0uma/csvview.nvim)**: shows CSV and TSV files as a table with `│` between columns. Everything is left-aligned, the header row is highlighted, and it stays at the top as you scroll. No keymaps. Run `:CsvViewToggle` to turn the table view on or off.

**[rainbow_csv.nvim](https://github.com/cameron-wags/rainbow_csv.nvim)**: gives each CSV column its own colour. No keymaps. Useful commands: `:RainbowAlign` / `:RainbowShrink` to pad or unpad the columns in the file itself, `:CSVLint` to check the file, `:Select ...` to query the file with SQL-like syntax.

**[markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)**: live preview of Markdown files in your browser. No keymaps. Run `:MarkdownPreviewToggle`.

### Plugin manager and helpers

**[lazy.nvim](https://github.com/folke/lazy.nvim)**: installs and updates the plugins. Run `:Lazy` to open it. No keymaps.

These are used by other plugins and have no keymaps: `plenary.nvim`, `nui.nvim`, `nvim-web-devicons` (file icons), `friendly-snippets`, `schemastore.nvim`, `telescope-fzf-native.nvim`, `telescope-ui-select.nvim`.

## Getting updates

```bash
cd ~/.config/nvim && git pull
```

Then run `:Lazy restore` inside Neovim so your plugins match the versions in `lazy-lock.json`.
