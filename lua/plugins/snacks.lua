return
  {
    "folke/snacks.nvim",
    cmd = "Snacks",
    priority = 1000,
    lazy = false,
    init = function()
      local api = vim.api
      api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        group = api.nvim_create_augroup("zenedit_snacks", { clear = true }),
        callback = function()
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd

          -- Toggle Mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
          Snacks.toggle
            .option("relativenumber", { name = "Relative number" })
            :map("<leader>tr")
          Snacks.toggle.diagnostics():map("<leader>td")
          Snacks.toggle.line_number():map("<leader>tl")
          Snacks.toggle.treesitter():map("<leader>tt")
          -- Snacks.toggle.inlay_hints():map("<leader>th")
          Snacks.toggle.indent():map("<leader>ti")
          Snacks.toggle.zen():map("<leader>tz")
          -- Snacks.toggle.option("list", { name = "Show Whitespace" }):map("<leader>tws")
          -- Snacks.toggle.fold():map("<leader>tf")
          -- Snacks.toggle.quickfix():map("<leader>tq")

        end,
      })
    end,
    --stylua: ignore
    keys = {
      -- { "<leader>z", function() Snacks.zen.zoom() end, desc = "Toggle zoom" },
      -- { "<leader>\\", function() Snacks.terminal() end, desc = "Toggle terminal" },
      { "<leader>bf", function() Snacks.format() end, desc = "Format buffer" },
      { "<leader>uh", function() Snacks.notifier.show_history() end, desc = "Notification history" },
      { "<leader>ud", function() Snacks.notifier.hide() end, desc = "Dismiss all notifications" },
      -- { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      -- { "<leader>bq", function() Snacks.bufdelete() end, desc = "Buffer quit" },
      -- { "<leader>bd", function() Snacks.bufdelete() end, desc = "Buffer delete" },
      -- { "<leader>be", function() Snacks.bufdelete.other() end, desc = "Quit other buffers" },
      -- { "<c-q>", function() Snacks.bufdelete() end, desc = "Buffer quit" },
    },
    opts = {
      -- indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true, timeout = 3000 },
      scope = { enabled = true },
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      -- statuscolumn = { enabled = true },
      -- lazygit = { enabled = true, configure = true },
    },
  }
