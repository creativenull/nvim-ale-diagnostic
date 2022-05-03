# nvim-ale-diagnostic

> This is a v2 rewrite of the repo: [nathanmsmith/nvim-ale-diagnostic](https://github.com/nathanmsmith/nvim-ale-diagnostic)

> NOTE: This is only temporary until this PR is merged in ALE: [https://github.com/dense-analysis/ale/pull/4135](https://github.com/dense-analysis/ale/pull/4135)

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

No setup is required, but if you're using `vim.diagnostic` then turn them off to let ALE handle the diagnostics:

```lua
vim.diagnostic.config({
  underline = false,
  virtual_text = false,
  signs = false,
  update_in_insert = false,
})
```
