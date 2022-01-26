# nvim-ale-diagnostic

> This is a v2 rewrite of the forked repo: [nathanmsmith/nvim-ale-diagnostic](https://github.com/nathanmsmith/nvim-ale-diagnostic)

Routes all Neovim LSP diagnostics to ALE for display. Useful if you like to manage all your errors in the same way.

## Requirements

- Neovim >= 0.6
- [ALE](https://github.com/dense-analysis/ale)

## Installation

### vim-plug

```vim
Plug 'creativenull/nvim-ale-diagnostic', { 'branch': 'v2' }
```

### vim-packager

```vim
call packager#add('creativenull/nvim-ale-diagnostic', { 'branch': 'v2' })
```

### packer.nvim

```lua
use { 'creativenull/nvim-ale-diagnostic', branch = 'v2' }
```

## Setup

No setup required, besides adjusting the global `vim.diagnostic` config:

```lua
vim.diagnostic.config({
  underline = false,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
})
```

## Notes

- `underline` and `virtual_text` are configurable, but you should probably disable them and configure those features through ALE.
- The default Neovim diagnostic signs are overridden by this plugin.
