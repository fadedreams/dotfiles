return{
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  event = "VeryLazy",
  opts = {
    views = {
      cmdline_popup = {
        position = {
          row = 0, -- Places the cmdline at the top (row 0)
          col = "50%", -- Centers horizontally
        },
      },
    },
  },
}
