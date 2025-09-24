return {
  {
    'echasnovski/mini.ai',
    version = false, -- Use the main branch for the latest features
    event = 'VeryLazy', -- Load plugin after startup to improve performance
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- Optional for Treesitter support
    config = function()
      -- Optional: Configure mini.ai after loading
      require('mini.ai').setup({
        -- Customize mini.ai settings (optional)
        n_lines = 50, -- Number of lines to scan for text objects
        custom_textobjects = {
          -- Add custom text objects (example)
          o = require('mini.ai').gen_spec.treesitter({
            a = '@function.outer',
            i = '@function.inner',
          }),
        },
      })
    end,
  },
}
