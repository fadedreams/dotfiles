return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          -- Default Telescope settings (if needed)
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              height = 0.9,
              width = 0.9,
              preview_cutoff = 120,
              prompt_position = "top",
              preview_width = 0.6
            },
            vertical = {
              height = 0.9,
              width = 0.9,
              preview_cutoff = 40,
              prompt_position = "top"
            }
          }
        }
      })
    end,
    keys = {
      {
        "<leader>fs",
        function()
          require("telescope.builtin").lsp_document_symbols({
            layout_strategy = "horizontal",
            layout_config = {
              horizontal = {
                height = 0.95, -- Near-fullscreen
                width = 0.95, -- Near-fullscreen
                preview_cutoff = 120,
                prompt_position = "top",
                preview_width = 0.6
              }
            }
          })
        end,
        noremap = true,
        silent = true,
        desc = "Find Functions (LSP)",
      },
      {
        "<leader>td",
        "<cmd>TodoTelescope layout_config={height=0.9,width=0.9}<cr>",
        noremap = true,
        silent = true,
        desc = "TODO",
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}, -- Minimal setup for todo-comments
  },
}
