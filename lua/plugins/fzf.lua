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
			{ "<c-p>", "<cmd>FzfLua files cwd=%:p:h<cr>", desc = "Find files (cwd)" },
			{ "<leader>ff", "<cmd>FzfLua files cwd=%:p:h<cr>", desc = "Find files (cwd)" },
			{ "<leader>fc", "<cmd>FzfLua files cwd=~/.config/nvim<cr>", desc = "Find nvim config" },
			{ "<leader>fg", "<cmd>FzfLua grep cwd=%:p:h<cr>", desc = "Find in files (cwd)" },
			{ "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help pages" },
			{ "<leader>fm", "<cmd>FzfLua man_pages<cr>", desc = "Man pages" },
			{ "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
			{ "<leader>ft", "<cmd>FzfLua colorschemes<cr>", desc = "Find colorschemes" },
			{ "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Find keymaps" },
			{ "<leader>fq", "<cmd>FzfLua quickfix<cr>", desc = "Find quickfix" },
			{ "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Find git status" },
			{ "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Find git commits" },
			{ "<leader>gb", "<cmd>FzfLua git_branches<cr>", desc = "Find git branches" },
			{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find recent buffers" },
			{ "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Find command history" },
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
