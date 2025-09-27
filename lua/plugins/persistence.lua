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
        desc="Load session" 
      },
      {
        "<leader>sf",
        function()
          require("persistence").select()
        end,
        "[S]ession [F]ind",
        desc="Find session" 
      },
    },
    opts = {
      dir = vim.fn.stdpath("cache") .. "/sessions/",
      options = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds",
    },
  },
}
