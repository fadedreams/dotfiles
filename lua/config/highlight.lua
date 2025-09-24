--" Define highlight groups for different operations
vim.api.nvim_set_hl(0, "CustomYank", { bg = "#7398e8" })  -- Paste highlight
vim.api.nvim_set_hl(0, "CustomDelete", { bg = "#d94a4a" })  -- Delete highlight
vim.api.nvim_set_hl(0, "CustomSearch", { bg = "#e0af68" })  -- Search highlight
vim.api.nvim_set_hl(0, "CustomUndo", { bg = "#ff5555" })   -- Undo highlight
vim.api.nvim_set_hl(0, "CustomRedo", { bg = "#55ff55" })   -- Redo highlight

-- " Highlight on yank (paste)
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "CustomYank",
      timeout = 150,
    })
  end,
})

-- " Highlight on search
vim.api.nvim_create_autocmd("CmdlineEnter", {
  pattern = { "/,\\?" },
  callback = function()
    vim.highlight.on_yank({
      higroup = "CustomSearch",
      timeout = 150,
    })
  end,
})

-- " Highlight on undo
vim.api.nvim_create_user_command("UndoHighlight", function()
  vim.highlight.on_yank({
    higroup = "CustomUndo",
    timeout = 150,
  })
end, {})
vim.api.nvim_set_keymap("n", "u", ":UndoHighlight<CR>u", { noremap = true, silent = true })

-- " Highlight on redo
vim.api.nvim_create_user_command("RedoHighlight", function()
  vim.highlight.on_yank({
    higroup = "CustomRedo",
    timeout = 150,
  })
end, {})
vim.api.nvim_set_keymap("n", "<C-r>", ":RedoHighlight<CR><C-r>", { noremap = true, silent = true })

-- " Note: Delete highlight can be implemented for specific delete commands
vim.api.nvim_create_user_command("DeleteHighlight", function()
  vim.highlight.on_yank({
    higroup = "CustomDelete",
    timeout = 150,
  })
end, {})
vim.api.nvim_set_keymap("n", "d", ":DeleteHighlight<CR>d", { noremap = true, silent = true })
