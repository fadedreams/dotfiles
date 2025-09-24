return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>v",
      function()
        require("telescope").extensions.file_browser.file_browser({
          path = vim.fn.expand("%:p:h"), -- Use the current file's directory as path
          select_buffer = true, -- Set select_buffer to true
          hidden = true, -- Show hidden files and folders
          respect_gitignore = false, -- Do not respect .gitignore (show ignored files)
          layout_config = {
            width = 0.99, -- Almost full-screen width
            height = 0.99, -- Almost full-screen height
          },
        })
      end,
      desc = "Browse Files",
    },
    -- {
    --   "<leader>x",
    --   function()
    --     require("telescope").extensions.file_browser.file_browser({
    --       path = vim.fn.expand("%:p:h"), -- Use the current file's directory as path
    --       select_buffer = true, -- Set select_buffer to true
    --       hidden = true, -- Show hidden files and folders
    --       respect_gitignore = true, -- Do not respect .gitignore (show ignored files)
    --       layout_config = {
    --         width = 0.99, -- Almost full-screen width
    --         height = 0.99, -- Almost full-screen height
    --       },
    --     })
    --   end,
    --   desc = "Browse Files",
    -- },
  },
}
