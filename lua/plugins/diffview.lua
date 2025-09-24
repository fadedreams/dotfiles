return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",  -- Optional: Lazy-load on events to improve startup time
  config = function()
    local actions = require("diffview.actions")
    -- Optional: Configure diffview.nvim settings
    require("diffview").setup({
      keymaps = {
        view = {
          ["q"] = "<Cmd>DiffviewClose<CR>", -- Map 'q' to close Diffview
          ["co"] = actions.conflict_choose_all("ours"), -- Choose conflict --ours
          ["ct"] = actions.conflict_choose_all("theirs"), -- Choose conflict --theirs
          ["cb"] = actions.conflict_choose_all("base"), -- Choose conflict --base
        },
        file_panel = {
          ["q"] = "<Cmd>DiffviewClose<CR>", -- Map 'q' to close Diffview in file panel
          ["co"] = actions.conflict_choose_all("ours"), -- Choose conflict --ours
          ["ct"] = actions.conflict_choose_all("theirs"), -- Choose conflict --theirs
          ["cb"] = actions.conflict_choose_all("base"), -- Choose conflict --base
        },
        file_history_panel = {
          ["q"] = "<Cmd>DiffviewClose<CR>", -- Map 'q' to close Diffview in file history panel
          ["co"] = actions.conflict_choose_all("ours"), -- Choose conflict --ours
          ["ct"] = actions.conflict_choose_all("theirs"), -- Choose conflict --theirs
          ["cb"] = actions.conflict_choose_all("base"), -- Choose conflict --base
        },
      },
    })

    -- Map <leader>dv to open Diffview
    vim.keymap.set("n", "<leader>dd", "<Cmd>DiffviewFileHistory<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>dv", "<Cmd>DiffviewOpen<CR>", { noremap = true, silent = true })
  end,
}
