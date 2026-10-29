# Neovim config

A Neovim setup for dbt and SQL work, using [lazy.nvim](https://github.com/folke/lazy.nvim) for plugins.

## Before you install

| Needed for | What to install |
|---|---|
| Everything | Neovim 0.12 or newer |
| Treesitter (uses the `main` branch) | `brew install tree-sitter-cli` |
| Telescope's fast search plugin | `make` and a C compiler (`xcode-select --install`) |
| Icons in the completion menu and file tree | A [Nerd Font](https://www.nerdfonts.com/), set as your terminal font |
| SQL formatting (`<leader>f`) | `sqlfmt` |
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

| Keymap | What it does |
|---|---|
| `<leader>drun` | `dbt run` the current model |
| `<leader>dtest` | `dbt test` the current model |
| `<leader>dbuild` | `dbt build` the current model |
| `<leader>dv` | `dbt run` the current model with extra vars (asks for JSON) |
| `<leader>dl` | Show lineage for the current model |
| `<leader>dm` | Pick models |
| `<leader>dw` | Walk the dbt graph |
| `<leader>dd` | Run any dbt command |

Runs use `--defer` against the production state in `prd_target/target/`.

## Other keymaps

The leader key is `Space`.

| Keymap | What it does |
|---|---|
| `<C-t>` or `<leader>t` | Toggle a terminal at the bottom (it keeps running when hidden) |
| `<C-h/j/k/l>` | Move between windows |
| `<leader>f` | Format the buffer |
| `<leader>cn` | Copy the file name |
| `<leader>cp` | Copy the full file path |

## Getting updates

```bash
cd ~/.config/nvim && git pull
```

Then run `:Lazy restore` inside Neovim so your plugins match the versions in `lazy-lock.json`.
