return {
  {
    "RRethy/vim-illuminate",
    opts = {
      -- Your custom config here (see full options in the plugin README)
      delay = 100,
      providers = { "lsp", "treesitter", "regex" },
      under_cursor = true,
      filetypes_denylist = { "dirbuf", "dirvish", "fugitive" },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },
}
