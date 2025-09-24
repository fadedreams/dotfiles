return {
  {
    "echasnovski/mini.indentscope",
    event = { "VeryLazy", "BufReadPre", "BufNewFile" }, -- Load on buffer read or new file
    opts = {
      symbol = "│", -- Customize the indent line symbol
      options = {
        try_as_border = true, -- Treat indent as a border
      },
    },
    config = function(_, opts)
      require("mini.indentscope").setup(opts) -- Set up the plugin with options
    end,
  },
}
