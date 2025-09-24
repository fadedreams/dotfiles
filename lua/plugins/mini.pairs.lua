return {
  {
    'echasnovski/mini.pairs',
    version = false, -- Use the main branch for latest features
    event = 'VeryLazy', -- Load plugin after startup to improve performance
    config = function()
      -- Set up mini.pairs with mappings for desired pairs, explicitly disabling ' and "
      require('mini.pairs').setup({
        modes = { insert = true, command = false, terminal = false },
        mappings = {
          ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
          ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
          ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },
          [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
          [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
          ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
          ['"'] = false, -- Explicitly disable autopairing for double quotes
          ["'"] = false, -- Explicitly disable autopairing for single quotes
          ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
        },
      })

      -- Explicitly unmap ' and " in insert mode to ensure no residual mappings
      vim.keymap.set('i', '"', '"', { buffer = false, noremap = true })
      vim.keymap.set('i', "'", "'", { buffer = false, noremap = true })
    end,
  },
}
