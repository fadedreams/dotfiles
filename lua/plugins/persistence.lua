return {
  {
    "folke/persistence.nvim",
    event = "BufReadPost",
    keys = {
      {
        "<leader>sl",
        function()
          require("persistence").load({ last = true })
        end,
        "[S]ession [L]oad",
      },
      {
        "<leader>sf",
        function()
          require("persistence").select()
        end,
        "[S]ession [F]ind",
      },
    },
    opts = {
      dir = vim.fn.stdpath("cache") .. "/sessions/",
      options = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds",
    },
  },
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
          Snacks.toggle.inlay_hints():map("<leader>th")
          Snacks.toggle.indent():map("<leader>ti")
          Snacks.toggle.zen():map("<leader>tz")
        end,
      })
    end,
    --stylua: ignore
    keys = {
      { "<leader>z", function() Snacks.zen.zoom() end, desc = "Toggle zoom" },
      { "<leader>\\", function() Snacks.terminal() end, desc = "Toggle terminal" },
      { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification history" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss all notifications" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>bq", function() Snacks.bufdelete() end, desc = "Buffer quit" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Buffer delete" },
      { "<leader>be", function() Snacks.bufdelete.other() end, desc = "Quit other buffers" },
      { "<c-q>", function() Snacks.bufdelete() end, desc = "Buffer quit" },
    },
    opts = {
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true, timeout = 3000 },
      scope = { enabled = true },
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      lazygit = { enabled = true, configure = true },
      dashboard = {
        preset = {
          header = [[
▀█▀ ██▀ █▄ █ ██▀ █▀▄ █ ▀█▀
█▄▄ █▄▄ █ ▀█ █▄▄ █▄▀ █  █
          ]],
          --stylua: ignore
          keys = {
            {
              icon = " ", key = "f", desc = "Find File",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            {
              icon = " ", key = "n", desc = "New File",
              action = ":ene | startinsert",
            },
            {
              icon = " ", key = "g", desc = "Find Text",
              action = ":lua Snacks.dashboard.pick('live_grep')",
            },
            {
              icon = " ", key = "r", desc = "Recent Files",
              action = ":lua Snacks.dashboard.pick('oldfiles')",
            },
            {
              icon = " ", key = "c", desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            {
              icon = " ", key = "s", desc = "Restore Session",
              action = ":lua require('persistence').select()",
            },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}
