return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    win = {
      no_overlap = true, -- Avoid overlapping cursor
      col = -1, -- Anchor to the right edge (negative value to align with the rightmost column)
      row =-4, -- Anchor to top edge
      padding = { 0, 0 }, -- Top/bottom, right/left padding
      title = true, -- Show title
      title_pos = "center", -- Center the title
      zindex = 1000, -- Ensure popup is on top
      width = { min = 20, max = 50 }, -- Match layout width
    },
    layout = {
      align = "right", -- Align text to the right within the popup
      width = { min = 20, max = 50 }, -- Set reasonable width
      spacing = 3, -- Spacing between columns
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
