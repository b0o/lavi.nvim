# Lavi.nvim

A soft and sweet colorscheme for Neovim. (Work in progress)

![2024-02-16_11-28-54_region](https://github.com/b0o/nvim-conf/assets/21299126/14439047-bfde-4d83-b84f-732bbf235707)

## Installation

Note: Lavi.nvim depends on [Lush.nvim](https://github.com/rktjmp/lush.nvim/).

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'b0o/lavi.nvim',
  dependencies = { 'rktjmp/lush.nvim' },
  config = function()
    vim.cmd [[colorscheme lavi]]
  end,
},
```

## License

MIT License
