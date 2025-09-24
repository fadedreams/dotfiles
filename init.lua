vim.api.nvim_set_keymap("i", "<A-p>", "<C-r>+", { noremap = true }) --system clipboard
require("config.keymaps")
require("config.lazy")
require("config.keymaps_fzf")

vim.cmd("colorscheme tokyonight") -- Apply TokyoNight globally


