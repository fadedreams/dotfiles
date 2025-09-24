return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",  -- Optional: Lazy-load on events to improve startup time
  config = function()
    local gitsigns = require('gitsigns')
    local blame_enabled = true -- Track blame state manually
    gitsigns.setup {
      -- signs = {
      --   add = { text = '┃' },
      --   change = { text = '┃' },
      --   delete = { text = '_' },
      --   topdelete = { text = '‾' },
      --   changedelete = { text = '~' },
      --   untracked = { text = '┆' },
      -- },
      signcolumn = true, -- Ensure sign column is always shown
      numhl = true, -- Highlight line numbers for changes
      linehl = false, -- Optionally highlight changed lines (can toggle later)
      -- show_untracked = true, -- Explicitly show untracked files
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <committer_time:%Y-%m-%d> - <summary>', -- Enhanced blame format
      preview_config = { -- Configure hunk preview window
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
      },
    }

    -- Keybindings
    vim.keymap.set('n', '<leader>gb', function()
      blame_enabled = not blame_enabled
      gitsigns.toggle_current_line_blame()
      vim.notify("Git blame " .. (blame_enabled and "disabled" or "enabled"))
    end, { desc = "Toggle git blame (show/hide author)" })

    -- Navigate hunks
    -- vim.keymap.set('n', ']h', gitsigns.next_hunk, { desc = "Next git hunk" })
    -- vim.keymap.set('n', '[h', gitsigns.prev_hunk, { desc = "Previous git hunk" })
    vim.keymap.set('n', ']h', function() gitsigns.nav_hunk('next') end, { desc = "Next git hunk" }) -- luacheck: ignore
    vim.keymap.set('n', '[h', function() gitsigns.nav_hunk('prev') end, { desc = "Previous git hunk" }) -- luacheck: ignore

    -- Stage and reset hunks
    vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Stage git hunk" })
    vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { desc = "Reset git hunk" })

    -- Preview hunk
    vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { desc = "Preview git hunk" })
    vim.keymap.set('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = "Preview git hunk inline" })

    -- Toggle word diff
    vim.keymap.set('n', '<leader>hw', gitsigns.toggle_word_diff, { desc = "Toggle word diff" })
    vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, { desc = "gitsigns.diffthis" })

    -- Stage entire buffer
    vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { desc = "Stage entire buffer" })
  end,
}
