-- read https://github.com/abhilash26/zenedit/blob/main/lua/zenedit/plugins/navigation.lua
return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({

      winopts = {
        height = 1.0, -- Set the height to 1.0 to use the entire screen
        width = 1.0, -- Set the width to 1.0 to use the entire screen
      },
      files = {
        cmd = "fd --type f --hidden --exclude .git --exclude all.txt --exclude tree.txt", -- Include hidden files using fd
        -- Or, you could use the default fzf command like this:
        -- cmd = "fzf --hidden --preview 'cat {}' --border --layout=horizontal"
      },
      -- winopts = {
      --   split = "belowright 10new",
      --   border = "single",
      --   preview = {
      --     hidden = "hidden",
      --     border = "border",
      --     title = false,
      --     layout = "horizontal",
      --     horizontal = "right:50%",
      --   },
      -- },
    })
  end,
  keys = {
    -- Disable the keymap to grep files
    { "<leader>ss", false },
    -- {
    --   "<leader>fs",
    --   function()
    --     require("fzf-lua").lsp_document_symbols({
    --       -- regex_filter = true , 
    --       query = "!Constant !Property !Variable !EnumMember",
    --       symbol_style = 1,
    --       winopts = {
    --         height = 0.8,
    --         width = 0.8,
    --         preview = {
    --           vertical = "up:60%",
    --           layout = "horizontal",
    --
    --         },
    --       },
    --     })
    --   end,
    --   desc = "Document Symbols (Functions and Classes)",
    -- },
    
  },
}
