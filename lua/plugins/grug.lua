return {
  {
    "MagicDuck/grug-far.nvim",
    config = function()
      require("grug-far").setup({
        keymaps = {
          replace = { n = "A" },
          close = { n = "q" },
        },
        engine = "ripgrep",
        debounceMs = 300,
      })

      -- Set keybinding to open grug-far with <leader>sr
      vim.keymap.set("n", "<leader>sr", function()
        require("grug-far").open()
      end, { noremap = true, silent = true })
    end,
  },
}
