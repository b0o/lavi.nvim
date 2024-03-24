# Lavi.nvim

A soft and sweet colorscheme for Neovim. (Work in progress)

![Screenshot](https://github.com/b0o/lavi.nvim/assets/21299126/81b54b40-2213-4385-aed5-2f13f2cadb43)

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
