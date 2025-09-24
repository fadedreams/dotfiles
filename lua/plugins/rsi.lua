return {
  {
    "tpope/vim-rsi",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      -- Unmap default vim-rsi key bindings
      local function unmap(modes, lhs)
        for _, mode in ipairs(modes) do
          pcall(vim.keymap.del, mode, lhs, { buffer = 0 })
        end
      end
      local rsi_mappings = {
        "<C-a>", "<C-b>", "<C-d>", "<C-e>", "<C-f>", "<C-k>", "<C-u>", "<C-w>", "<C-t>", "<C-y>",
        "<M-f>", "<M-b>", "<M-d>",
      }
      for _, key in ipairs(rsi_mappings) do
        unmap({ "i", "c" }, key)
      end
      -- Additional unmapping for <M-p> to remove the default vim-rsi mapping
      unmap({ "i" }, "<M-p>")
      unmap({ "i" }, "<M-o>")
      unmap({ "i" }, "<M-]>")
      unmap({ "i" }, "<M-[>")

      -- Define new mappings
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }
      -- Insert mode mappings
      keymap("i", "<a-u>", "<C-o>d0", opts) -- Delete to start of line
      keymap("i", "<a-k>", "<C-o>d$", opts) -- Delete to end of line
      -- keymap("i", "<M-a>", "<Home>", opts) -- Move to start of line
      -- keymap("i", "<M-h>", "<Left>", opts) -- Move back one character
      -- keymap("i", "<M-d>", "<Del>", opts) -- Delete character under cursor
      -- keymap("i", "<M-e>", "<End>", opts) -- Move to end of line
      -- keymap("i", "<M-l>", "<Right>", opts) -- Move forward one character
      -- keymap("i", "<M-w>", "<C-o>db", opts) -- Delete previous word
      -- keymap("i", "<M-t>", "<C-o>x<C-o>p", opts) -- Transpose characters
      -- keymap("i", "<M-y>", "<C-o>p", opts) -- Paste killed text (simplified)
      -- keymap("i", "<M-n>", "<C-o>w", opts) -- Move forward one word
      -- keymap("i", "<M-p>", "<C-o>b", opts) -- Move backward one word (unmapped above)
      -- keymap("i", "<M-x>", "<C-o>dw", opts) -- Delete next word
      -- Command-line mode mappings
      -- keymap("c", "<M-a>", "<Home>", opts) -- Move to start of line
      -- keymap("c", "<M-h>", "<Left>", opts) -- Move back one character
      -- keymap("c", "<M-d>", "<Del>", opts) -- Delete character under cursor
      -- keymap("c", "<M-e>", "<End>", opts) -- Move to end of line
      -- keymap("c", "<M-l>", "<Right>", opts) -- Move forward one character
      -- keymap("c", "<M-k>", "<C-f>D", opts) -- Delete to end of line
      -- keymap("c", "<M-u>", "<C-u>", opts) -- Delete to start of line
      -- keymap("c", "<M-w>", "<C-Left><C-w>", opts) -- Delete previous word
      -- keymap("c", "<M-t>", "<C-f>xp", opts) -- Transpose characters
      -- keymap("c", "<M-y>", "<C-y>", opts) -- Paste killed text
      -- keymap("c", "<M-n>", "<C-Right>", opts) -- Move forward one word
      -- keymap("c", "<M-p>", "<C-Left>", opts) -- Move backward one word
      -- keymap("c", "<M-x>", "<C-Right><C-w>", opts) -- Delete next word

      -- Custom mapping for Alt-p to paste from system clipboard
      keymap("i", "<A-p>", "<C-r>+", opts)
    end,
  },
}
