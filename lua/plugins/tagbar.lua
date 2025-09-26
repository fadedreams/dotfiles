-- sudo apt install universal-ctags -y
return {
  "preservim/tagbar",
  event = "VeryLazy",  -- Load on demand to keep startup fast
  config = function()
    vim.keymap.set("n", "<leader>fo", ":TagbarToggle<CR>", { desc = "Toggle Tagbar" })
  end,
}
