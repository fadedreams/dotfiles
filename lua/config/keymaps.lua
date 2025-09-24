require("config.highlight")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.clipboard = "unnamedplus"
vim.g.autoformat = false

vim.opt.guicursor = "" -- Make Insert mode cursor a block (like Normal mode)

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.o.cmdheight = 0 --sitck lualine to the bottom
-- vim.o.laststatus = 3

vim.opt.swapfile = false
vim.opt.backup = false
-- Define the undo directory path
local undo_dir = os.getenv("HOME") .. "/.vim/undodir"
-- Check if directory exists; if not, create it
if vim.fn.isdirectory(undo_dir) == 0 then  -- Returns 0 if dir doesn't exist
  vim.fn.mkdir(undo_dir, "p")  -- "p" flag creates parent dirs if needed
end
-- Set undodir and enable persistent undo
vim.opt.undodir = undo_dir
vim.opt.undofile = true
vim.opt.undolevels = 1000

vim.opt.hlsearch = true
vim.opt.incsearch = true


vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- avante views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

--vim.opt.colorcolumn = "80"
-- vim.cmd("colorscheme tokyonight") -- should be placed in the init.lua

--diff this :vsplit
-- vim.keymap.set("n", "<Leader>df", ":windo diffthis<CR>", { noremap = true, silent = true })

-- vim.cmd([[set grepprg=fd\ --type=file\ --color=never]])
vim.keymap.set('n', 'x', '"_x', { noremap = true }) -- delete without yanking

-- opens a new line below the current line, deletes the leading whitespace
-- vim.keymap.set("n", "<Leader>o", "o<Esc>^Da", { noremap = true, silent = true })
-- vim.keymap.set("n", "<Leader>O", "O<Esc>^Da", { noremap = true, silent = true })

-- The automatic insertion of comment leaders is disabled for all file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove("o")
  end,
})

-- windows
vim.keymap.set("n", "<Leader>go", ":silent !xdg-open %:p:h<CR>", { noremap = true, silent = true, desc = "Open file explorer" })
vim.keymap.set("n", "<F11>", ":only<CR>", { noremap = true, silent = true, desc = "Maximize window" })
vim.keymap.set("n", "<C-w><left>", "<C-w><")
vim.keymap.set("n", "<C-w><right>", "<C-w>>")
vim.keymap.set("n", "<C-w><up>", "<C-w>+")
vim.keymap.set("n", "<C-w><down>", "<C-w>-")

--default browser
-- vim.keymap.set("n", "<F3>", ":Ex<CR>")
--refresh
-- vim.keymap.set("n", "<F5>", ":checktime<CR>", { noremap = true })

--save
vim.keymap.set("n", "<a-w>", ":w<CR>", { noremap = true })
vim.keymap.set("i", "<a-w>", "<Esc>:w<CR>", { noremap = true })
-- save all
vim.keymap.set("n", "<a-s>", ":wa<CR>", { noremap = true })
vim.keymap.set("i", "<a-s>", "<Esc>:wa<CR>", { noremap = true })

--quit
vim.keymap.set("n", "<a-q>", ":q<CR>", { noremap = true })
vim.keymap.set("i", "<a-q>", "<Esc>:q<CR>", { noremap = true })

vim.keymap.set("n", "<leader>sm", ":wshada!", { noremap = true , desc = "Toggle last buffer" }) --saves global marks [A-Z]
--quit all
-- vim.keymap.set("n", "<a-q>", ":qa<CR>", { noremap = true })
-- vim.keymap.set("i", "<a-q>", "<Esc>:qa<CR>", { noremap = true })

--delete buffer
vim.keymap.set("n", "<Leader>bb", "<C-^>", { noremap = true, silent = true, desc = "Toggle last buffer" })
vim.keymap.set("n", "<leader>bo", ":%bd|e#|bd#<CR>", { noremap = true, silent = true, desc = "delete other buffers"  })
vim.keymap.set("n", "<leader>ba", ":%bd<CR>", { noremap = true, silent = true, desc = "delete all buffers"  })
vim.keymap.set("n", "<c-h>", ":bdelete<CR>")
vim.keymap.set("n", "<c-k>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<c-j>", ":bprevious<CR>", { noremap = true, silent = true })

-- Disable Ctrl+K in insert mode
-- vim.api.nvim_set_keymap("i", "<C-k>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("i", "<c-k>", "<Esc>:bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<c-j>", "<Esc>:bprevious<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })

-- Map Ctrl-L to g;
-- vim.api.nvim_set_keymap("n", "<C-l>", "g;", { noremap = true })

-- vim.keymap.set("n", "<c-l>", ":bprevious<CR>", { noremap = true, silent = true })

-- Save current session to ./session.vim
vim.keymap.set("n", "<leader>ss", ":mksession! ./session.vim<CR>", {
  noremap = true,
  silent = true,
  desc = "Save session to file"  -- Shows in which-key
})
-- Load session from the current working directory
vim.keymap.set("n", "<leader>ls", ":source ./session.vim<CR>", { noremap = true, silent = true })
-- delete swap files
local function delete_swap_files()
  local cmd = "rm -rf ~/.local/state/nvim/swap/*"
  vim.fn.system(cmd)
  print("Swap files deleted.")
end
-- Map leader + ds to delete swap files function
-- Uses normal mode (n), is non-recursive (noremap), and silent
vim.keymap.set("n", "<leader>ds", delete_swap_files, {
  noremap = true,
  silent = true,
  desc = "Delete all swap files"  -- Description for which-key
})

-- function search_under_cursor()
--   local word = vim.fn.expand("<cword>")
--
--   vim.api.nvim_command('let @/ = "\\V' .. word .. '\\V"')
--   vim.api.nvim_command("/\\V\\<" .. vim.fn.escape(word, "\\") .. "\\>")
-- end
-- vim.api.nvim_set_keymap("n", "<leader>/", ":lua search_under_cursor()<CR>", { noremap = true, silent = true })

--leader search
function search_under_cursor()
  -- local word = vim.fn.expand("<cword>")
  -- local pattern = "([%w%.%-%:\\,\\\\_:?;%!@#%$%^&*+]+)"
  local pattern = "([%w_-]+)"
  local line = vim.fn.getline(".")
  local cursor_col = vim.fn.col(".")

  local match = line:match(pattern, cursor_col)

  if match then
    vim.api.nvim_command('let @/ = "\\V' .. match .. '\\V"')
    vim.api.nvim_command("/\\V\\<" .. vim.fn.escape(match, "\\") .. "\\>")
  end
end

function search_under_cursor_simple()
  -- local word = vim.fn.expand("<cword>")
  -- local pattern = "([%w%.%-%:\\,\\\\_:?;%!@#%$%^&*+]+)"

  local word = vim.fn.expand("<cword>")
  local line = vim.fn.getline(".")
  local cursor_col = vim.fn.col(".")
  local match = line:match(word, cursor_col)

  if match then
    vim.api.nvim_command('let @/ = "\\V' .. match .. '\\V"')
    vim.api.nvim_command("/\\V\\<" .. vim.fn.escape(match, "\\") .. "\\>")
  end
end

local function get_visual_selection()
  return table.concat(vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos(".")), "\n")
end

-- Map the function to the leader + / key
-- vim.api.nvim_set_keymap("n", "<leader>jj", ":lua search_under_cursor()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>kk", ":lua search_under_cursor_simple()<CR>", { noremap = true, silent = true })
function search_under_visual()
  -- Get the visual selection as a search term
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])
  local word = table.concat(lines, "\n"):sub(start_pos[3], end_pos[3] - 1 + (#lines > 1 and 1 or 0))

  -- Escape special characters for Vim's search pattern
  local escaped_word = vim.fn.escape(word, "\\/.*$^~[]")

  -- Start the search in the current file with the escaped word
  vim.api.nvim_command('let @/ = "\\V' .. escaped_word .. '"')
  vim.api.nvim_command("/\\V" .. escaped_word)
end

vim.api.nvim_set_keymap("v", "<C-f>", ":lua search_under_visual()<CR>", { noremap = true, silent = true })

-- Function to search word under cursor in the current file using a custom pattern
function search_text_under_cursor()
  -- Get the current line and cursor position
  local line = vim.fn.getline(".")
  local col = vim.fn.col(".")
  
  -- Define the pattern to match words (including spaces and specified characters)
  local pattern = "([%w%.%-%:\\,\\\\_-:?;%%!@#%$%^&*+%s]+)"
  
  -- Find the start and end positions of the word under the cursor
  local start_col, end_col, word = line:find(pattern, col - 1)
  
  -- Check if a word was found and the cursor is within its bounds
  if not word or col < start_col or col > end_col then
    vim.notify("No valid word under cursor", vim.log.levels.WARN)
    return
  end
  
  -- Escape special characters for Vim's search pattern
  local escaped_word = vim.fn.escape(word, "\\/.*$^~[]")
  
  -- Set the search register and start the search
  vim.api.nvim_command('let @/ = "\\V' .. escaped_word .. '"')
  vim.api.nvim_command("/\\V" .. escaped_word)
end

-- Keymap to trigger the search
vim.keymap.set(
  "n",
  "<C-f>",
  ":lua search_text_under_cursor()<CR>",
  { noremap = true, silent = true, desc = "Search text under cursor in current file" }
)

--- Searches for text under the cursor in a simple manner.
-- @return nil
function search_yanked_text()
  -- Get the yanked text from the default register
  local yanked_text = vim.fn.getreg('"')

  -- Escape the yanked text for exact match and case insensitivity
  local escaped_text = vim.fn.escape(yanked_text, "\\")

  -- Construct a pattern that matches the exact yanked text
  local pattern = "\\V" .. escaped_text

  -- Set the search register and perform the search
  vim.api.nvim_command('let @/ = "' .. pattern .. '"')
  vim.api.nvim_command("/" .. pattern)
end

-- Map the function to the leader + y key
vim.api.nvim_set_keymap("n", "<leader>sy", ":lua search_yanked_text()<CR>", { noremap = true, silent = true,  desc = "search yanked text" })
--paste in insert mode
-- vim.api.nvim_set_keymap("i", "<a-o>", "<C-r>*", { noremap = true })
-- vim.api.nvim_set_keymap("i", "<a-p>", "<C-r>+", { noremap = true }) --system clipboard
-- vim.api.nvim_set_keymap("i", "<C-A-p>", "<C-r>+<CR>", { noremap = true })

-- vim.api.nvim_set_keymap("n", "gp", "_:put<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "gp", "v_p", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<s-p>", ":put!<CR>", { noremap = true, silent = true }) --paste above
vim.api.nvim_set_keymap("n", "<leader>p", ":put<CR>", { noremap = true, silent = true }) --paste below
-- vim.keymap.set('n', '<Leader>p', 'P', { noremap = true, silent = true })
vim.keymap.set('n', '-p', 'P', { noremap = true, silent = true })

-- vim.api.nvim_set_keymap("i", "<a-s-p>", "<C-o>:put<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("i", "<a-c-P>", "<C-o>:put!<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "$", "g_", { noremap = true, silent = true })

--new file
-- vim.keymap.set("n", "<leader>nf", ":enew<CR>", { noremap = true, silent = true })

-- relative number
vim.keymap.set("n", "<leader>rn", ":set relativenumber!<CR>", { noremap = true, silent = true })

--quickfix
-- vim.keymap.set("n", "<leader>qf", ":copen<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>]n", ":cnext<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>[p", ":cprev<CR>", { noremap = true, silent = true })


-- greatest remap ever
vim.keymap.set("x", "p", "pgvy")
-- vim.keymap.set("x", "p", [["_dP]])
-- vim.keymap.set("x", "<leader>p", [["_dP]])

--This mapping is particularly useful for replacing text with yanked content without affecting the yanked content in the register,
--allowing for repeated pasting of the same yanked content without losing it.
-- vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])
--vim.keymap.set('n', '9', '^', { noremap = true })

--end of line buy laggy
-- vim.keymap.set("n", "-", "g_", { noremap = true })

-- mapping ctrl + i to ctrl + "+"
--vim.keymap.set('n', '<C-p>', '<C-+>', { noremap = true })
-- vim.keymap.set("n", "<C-l>", "<C-i>", { noremap = true })

-- del backward
-- vim.keymap.set("n", "dw", 'vb"_d')

-- Splitkeymap <leader>wv ws
-- vim.keymap.set("n", "<a-h>", ":split<Return><C-w>w")
-- vim.keymap.set("n", "<a-5>", ":vsplit<Return><C-w>w")

--delete buffer
--vim.keymap.set('n', 'fv', ':bdelete')
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- vim.keymap.set("n", "J", "mzJ`z")

-- The two below keeps the cursor in the middle when scrolling with ctrl + d & u
-- Makes searching the file less disorienting.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Make search terms stay in the middle when searching the file for characters, text, etc..
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

--function paste_after_equal()
--local word = vim.fn.expand("<cword>")
--local line = vim.fn.getline(".")
--local start = vim.fn.col(".")
--local pattern = vim.pesc(word)
--local _, end_idx = string.find(line, pattern, start)
--local text = string.sub(line, start, end_idx)
--local replaced_text = string.gsub(text, pattern, "postgres")
--local new_text = string.gsub(line, text, replaced_text, 1) -- Replace only the first occurrence
--vim.fn.setline(".", new_text)
--vim.cmd("normal! `[v`]")
--vim.cmd("normal! \"_dP")
--end

--vim.api.nvim_set_keymap("n", "<leader>p", ":lua paste_after_equal()<CR>", { noremap = true, silent = true })

-- vim.keymap.set({ "n", "v" }, "<leader>dd", [["_d]])
--
-- This is going to get me cancelled
-- vim.keymap.set("i", "<C-c>", "<Esc>")

-- vim.keymap.set("n", "te", ":tabedit")
-- vim.api.nsudo apt install tigervnc-viewervim_set_keymap("n", "<a-t>", ":tabnew<CR>", { noremap = true, silent = true })
--vim.api.nvim_set_keymap("n", "<A-q>", ":tabclose<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<A-m>", ":tabnext<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<A-n>", ":tabprevious<CR>", { noremap = true, silent = true })

--vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- vim.keymap.set("n", "<s-]>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<s-[>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<c-]>", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<c-[>", "<cmd>lprev<CR>zz")

-- Search and replace the word under cursor in whole buffer
vim.keymap.set("n", "<leader>rs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
  desc = "Replace word under cursor",  -- Description for which-key
  noremap = true,
  silent = true
})

-- visual_search_replace
function visual_search_replace()
  -- Save the start and end positions of the visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- Get the lines and columns of the selection
  local start_line = start_pos[2]
  local end_line = end_pos[2]
  local start_col = start_pos[3]
  local end_col = end_pos[3]

  -- Get the text from the selected lines
  local lines = vim.fn.getline(start_line, end_line)

  -- Adjust the end column if the selection spans multiple lines
  if #lines > 1 then
    end_col = #lines[#lines]
  end

  -- Extract the selected text
  local selected_text
  if #lines == 1 then
    selected_text = lines[1]:sub(start_col, end_col)
  else
    selected_text = lines[1]:sub(start_col)
    for i = 2, #lines - 1 do
      selected_text = selected_text .. "\n" .. lines[i]
    end
    selected_text = selected_text .. "\n" .. lines[#lines]:sub(1, end_col)
  end

  -- Escape special characters for Vim's search pattern
  local escaped_text = vim.fn.escape(selected_text, "\\/.*$^~[]")

  -- Prompt for the replacement text
  local replace_text = vim.fn.input("Replace with: ")

  -- Perform the replacement
  vim.cmd("%s/\\V" .. escaped_text .. "/" .. replace_text .. "/gc")
end

-- Map the function to a keybinding in visual mode
vim.api.nvim_set_keymap("v", "<leader>rr", ":lua visual_search_replace()<CR>", { noremap = true, silent = true })

-- visual_search
function visual_search()
  -- Save the start and end positions of the visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- Get the lines and columns of the selection
  local start_line = start_pos[2]
  local end_line = end_pos[2]
  local start_col = start_pos[3]
  local end_col = end_pos[3]

  -- Get the text from the selected lines
  local lines = vim.fn.getline(start_line, end_line)

  -- Adjust the end column if the selection spans multiple lines
  if #lines > 1 then
    end_col = #lines[#lines]
  end

  -- Extract the selected text
  local selected_text
  if #lines == 1 then
    selected_text = lines[1]:sub(start_col, end_col)
  else
    selected_text = lines[1]:sub(start_col)
    for i = 2, #lines - 1 do
      selected_text = selected_text .. "\n" .. lines[i]
    end
    selected_text = selected_text .. "\n" .. lines[#lines]:sub(1, end_col)
  end

  -- Escape special characters for Vim's search pattern
  local escaped_text = vim.fn.escape(selected_text, "\\/.*$^~[]")

  -- Search for the text (using very nomagic mode \V)
  vim.cmd("let @/ = '\\V" .. escaped_text .. "'")
  vim.cmd("set hlsearch")
end

-- Map the function to <leader>/ in visual mode
vim.api.nvim_set_keymap("v", "<leader>/", ":lua visual_search()<CR>", { noremap = true, silent = true })

--vim.keymap.set("n", "<leader>s", "g]")
-- vim.keymap.set("n", "<leader>r", [[:%r/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
--vim.keymap.set("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "chmod +x" })
-- vim.keymap.set("n", "<C-f>", [[:let @/ = '\<<C-r><C-w>\>'<CR>:set hlsearch<CR>]])
-- vim.keymap.set("n", "<C-c>", ":nohlsearch<CR>", { desc = "clear search highlights" })
-- ------------------------------------------------------------------------- }}}
--  V - Linewise reselertion of what you just pasted.
-- vim.keymap.set("n", "<leader>VV", "V`]")

-- Select (charwise) the contents of the current line, excluding indentation.
-- vim.keymap.set("n", "vv", "^vg_", { desc = "select current line - indentation  " })

-- Map <leader>dd to delete a line without yanking it and suppress the command-line window
-- Map in visual mode to delete selected text into the black hole register "_d

--delete forever
vim.keymap.set("x", "D", '"_d', { desc = "delete forever" })
-- Delete the current line.
--vim.keymap.set("n", "-", "dd")

-- Yank the current file path to the system clipboard
function yank_file_path()
  local file_path = vim.fn.expand("%:p")
  vim.fn.setreg("+", file_path)
  vim.fn.setreg("*", file_path)
  print("File path copied to clipboard: " .. file_path)
end

-- Map the function to a key combination (e.g., <Leader>y in normal mode)
vim.keymap.set("n", "<Leader>yf", ":lua yank_file_path()<CR>", { noremap = true, silent = true, desc= "yank path" })

-- Yank the directory path of the current file to the system clipboard
function yank_directory_path()
  local file_path = vim.fn.expand("%:p:h")
  vim.fn.setreg("+", file_path)
  vim.fn.setreg("*", file_path)
  print("Directory path copied to clipboard: " .. file_path)
end

-- Map the function to a key combination (e.g., <Leader>yd in normal mode)
vim.api.nvim_set_keymap("n", "<Leader>yd", ":lua yank_directory_path()<CR>", { noremap = true, silent = true, desc="yank dir" })

--- Yanks the relative file path of the current buffer to the clipboard.
-- Retrieves the relative path of the current file and copies it to both the '+' (system)
-- and '*' (primary) clipboard registers. Prints a confirmation message with the path.
-- @return nil
function yank_relative_file_path()
  local relative_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
  vim.fn.setreg("+", relative_path)
  vim.fn.setreg("*", relative_path)
  print("Relative file path copied to clipboard: " .. relative_path)
end

vim.keymap.set("n", "<Leader>yy", ":lua yank_relative_file_path()<CR>", { noremap = true, silent = true, desc="yank this" })

--- Yanks the relative file path and entire content of the current buffer to the clipboard.
-- Retrieves the relative path of the current file and its full content, combines them with
-- a separator, and copies the result to both the '+' (system) and '*' (primary) clipboard
-- registers. Prints a confirmation message with the file path.
-- @return nil
local function yank_relative_file_path_and_all()
  local relative_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
  if relative_path == "" then
    print("Error: No file associated with the current buffer")
    return
  end
  local file_content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
  local combined = relative_path .. ":    " .. file_content
  vim.fn.setreg("+", combined)
  vim.fn.setreg("*", combined)
  print("Copied to clipboard: " .. relative_path)
end

-- Use a Lua function call directly in the key mapping
vim.keymap.set("n", "<Leader>yu", function()
  yank_relative_file_path_and_all()
end, { noremap = true, silent = false, desc = "Yank relative path and file content" })

-- yank all
vim.keymap.set("n", "<Leader>ya", ":cd $PWD<CR>:!/home/m/.config/nvim/file_dir_to_txt_exclude.sh && xclip -selection clipboard all.txt<CR>", { noremap = true, silent = false, desc = "yank all" })
-- vim.keymap.set("n", "<Leader>ya", ":cd %:p:h<CR>:!/home/m/.config/nvim/file_dir_to_txt_exclude.sh && xclip -selection clipboard all.txt<CR>", { noremap = true, silent = false, desc = "yank all" })
-- yank all input exclusions
function YankWithCustomExclusions()
  -- Default directories to exclude (always included)
  local default_exclude_dirs = {
    "node_modules", "target", ".git", "resources", ".idea", ".vscode",
    "__pycache__", "venv", ".venv", ".mypy_cache", ".pytest_cache",
    "build", "dist", "out", "docs", "env"
  }
  -- Default files to exclude (always included)
  local default_exclude_files = {
    "file_dir_to_txt_exclude.sh", "file_dir_to_txt_exclude2.sh", ".gitignore",
    "serverall.js", ".env", "all.txt", "tree.txt", "go.sum", "package-lock.json", "yarn.lock",
    ".next", ".env.local", ".env.development.local", ".env.production.local",
    ".env.test.local", ".env.development", ".env.production", ".env.test",
    ".DS_Store", "Thumbs.db", "desktop.ini", "*.swp", "*.swo", "*.swn",
    "*.swm", "*.swl", "*.swk", "*.swj", "*.swh", "*.swc", "*.swb"
  }

  -- Prompt for additional directories and files to exclude in one input
  local user_exclusions = vim.fn.input("Enter additional directories and files to exclude (space-separated, press Enter to skip): ")
  local exclude_dirs = default_exclude_dirs
  local exclude_files = default_exclude_files

  if user_exclusions ~= "" then
    for item in user_exclusions:gmatch("%S+") do
      -- Assume items with a dot (.) are files, otherwise directories
      if item:match("%.") then
        table.insert(exclude_files, item)
      else
        table.insert(exclude_dirs, item)
      end
    end
  end

  -- Convert tables to space-separated strings for the shell command
  local exclude_dirs_str = table.concat(exclude_dirs, " ")
  local exclude_files_str = table.concat(exclude_files, " ")

  -- Change to the current working directory
  vim.cmd("cd " .. vim.fn.getcwd())
  -- Construct and execute the shell command
  local shell_cmd = string.format("!/home/m/.config/nvim/file_dir_to_txt_exclude2.sh %s %s && xclip -selection clipboard all.txt", exclude_dirs_str, exclude_files_str)
  vim.cmd(shell_cmd)
end

vim.keymap.set("n", "<Leader>ye", ":lua YankWithCustomExclusions()<CR>", { noremap = true, silent = false, desc = "yank all with custom exclusions" })

--- Yanks the relative file path of the current buffer without its extension to the clipboard.
-- Retrieves the relative path of the current file, removes its extension, and copies it to
-- both the '+' (system) and '*' (primary) clipboard registers. Prints a confirmation message.
-- @return nil
function yank_relative_file_path_without_ex()
  -- Get the relative file path
  local relative_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
  -- Remove the file extension
  local path_without_extension = vim.fn.fnamemodify(relative_path, ":r")
  -- Copy to clipboard registers
  vim.fn.setreg("+", path_without_extension)
  vim.fn.setreg("*", path_without_extension)
  -- Print confirmation message
  print("Relative file path (without extension) copied to clipboard: " .. path_without_extension)
end

-- vim.keymap.set("n", "<Leader>yt", ":cd %:p:h<CR>:!tree -I 'node_modules|venv|.git|.idea|vendor|__pycache__|.pytest_cache|target|dist|bin|obj|.next' -L 4 > tree.txt<CR>", { noremap = true, silent = false })
-- vim.keymap.set("n", "<Leader>yt", ":cd %:p:h<CR>:!tree -I 'node_modules|venv|.git|.ide' -L 4 | tee tree.txt | xclip -selection clipboard<CR>", { noremap = true, silent = false, desc = "yank tree" })
vim.keymap.set("n", "<Leader>yt", ":cd $PWD<CR>:!tree -I 'node_modules|venv|.git|.ide|all.txt|tree.txt' -L 4 | tee tree.txt | xclip -selection clipboard<CR>", { noremap = true, silent = false, desc = "yank tree" })

-- Combine yank tree and yank all, with tree output at the end in all.txt
vim.keymap.set("n", "<Leader>yh", ":cd $PWD<CR>:!tree -I 'node_modules|venv|.git|.ide|all.txt|tree.txt' -L 4 > tree.txt && /home/m/.config/nvim/file_dir_to_txt_exclude.sh > all.txt && cat tree.txt >> all.txt && xclip -selection clipboard all.txt<CR>", { noremap = true, silent = false, desc = "yank tree and all" })
-- Key mapping
-- vim.keymap.set("n", "<Leader>yr", ":lua yank_relative_file_path_without_ex()<CR>", { noremap = true, silent = true })
-- function yank_file_name()
--   local file_name = vim.fn.expand("%:t")
--   vim.fn.setreg("+", file_name)
--   vim.fn.setreg("*", file_name)
--   print("File name copied to clipboard: " .. file_name)
-- end
--
-- vim.keymap.set("n", "<Leader>yn", ":lua yank_file_name()<CR>", { noremap = true, silent = true })

-- Select entire buffer
--vim.keymap.set("n", "vaa", "ggvGg_")
--vim.keymap.set("n", "Vaa", "ggVG")
--vim.keymap.set("n", "<leader>V", "V`]")

-- Save all files.
--vim.keymap.set("n", "<F2>", "<cmd>wall<cr>")

-- Toggle [in]visible characters.
-- vim.keymap.set("n", "F3", "<cmd>set list!<cr>")
-- vim.keymap.set("n", "<F3>", "<cmd>set listchars=tab:»·,trail:·,nbsp:_,eol:¬<cr>", { desc = "Set custom listchars" })
vim.keymap.set("n", "<F3>", function()
    if vim.opt.list:get() then
        vim.opt.list = false
    else
        vim.opt.listchars = { tab = "»·", trail = "·", nbsp = "_", eol = "¬" }
        vim.opt.list = true
    end
end, { desc = "Toggle custom listchars" })


-- Stay in indent mode.
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Visual yank
--vim.keymap.set("v", "<leader>cc", '"+y')

-- Obfuscate
-- vim.keymap.set("n", "<f4>", "mmggg?G`m")

-- <leader>x conflicts with LazyVim
--vim.keymap.set("n", "<leader>X", "<Plug>(bullets-toggle-checkbox)")

-- {{{ Folding commands.key

-- Author: Karl Yngve Lervåg
--    See: https://github.com/lervag/dotnvim
-- za
vim.keymap.set("n", "zz", "zM")
vim.keymap.set("n", "zx", "zR")
vim.keymap.set("n", "zs", "zMzvzz")

-- Close current fold when open. Always open next fold.
-- vim.keymap.set("n", "zj", "zcjzOzz")

-- Close current fold when open. Always open previous fold.
-- vim.keymap.set("n", "zk", "zckzOzz")

-- {{{ Keep the cursor in place while joining lines.

-- vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "<leader>j", "myvipJ`ygq<cr>")

-- {{{ Shell commands.

-- Execute the current line of text as a shell command.
--vim.keymap.set("n", "<localleader>E", [[0mMvg_"ky :exec "r!" getreg("k")<cr>]])
--vim.keymap.set("v", "<localleader>E", [["ky :exec "r!" getreg("k")<cr>]])

-- Quit all
--vim.keymap.set("n", "<c-q>", "<cmd>qall!<cr>")

-- vim.keymap.set("n", "<leader>qq", "<cmd>qall!<cr>")

-- {{{ leader + space

--vim.keymap.set("n", "<leader><space>", "<cmd>nohlsearch<cr>")

-- ------------------------------------------------------------------------- }}}

--vim.keymap.set("n", "<leader>HH", "<cmd>silent vert bo help<cr>")

-- ------------------------------------------------------------------------- }}}
--  b - Buffer adjustments.
--vim.keymap.set("n", "<leader>bh", "<cmd>vertical resize -1<cr>")
--vim.keymap.set("n", "<leader>bj", "<cmd>resize +1<cr>")
--vim.keymap.set("n", "<leader>bk", "<cmd>resize -1<cr>")
--vim.keymap.set("n", "<leader>bl", "<cmd>vertical resize +1<cr>")
--vim.keymap.set("n", "<leader>bx", [[<cmd>w<cr><cmd>luafile %<cr><cmd>echo "Sourced " . @%<cr>]])
-- ------------------------------------------------------------------------- }}}
-- c - Copy & Paste

-- vim.keymap.set("n", "<leader>yy", 'ggVGg_"+y')

--vim.keymap.set("n", "gk", [[^mmvg_"ky<cmd>exec 'r!kjv -b -d -w 65' getreg('k')<cr>'mddi- ??v}gq]])
--vim.keymap.set("v", "gk", [["ky<cmd>exec 'r!kjv -b -d -w 65' getreg('k')<cr>]])
--vim.keymap.set("n", "gK", [[^vg_"ky<cmd>exec 'r!kjv -b -d -w 65' getreg('k')<cr>]])

-- o - Options
--vim.keymap.set("n", "<leader>oh", "<cmd>checkhealth<cr>")
--vim.keymap.set("n", "<leader>oo", "<cmd>only<cr>")

-- w - Whitespace

--vim.keymap.set("n", "<leader>wr", "<cmd>%s/\r//g<cr>")
--vim.keymap.set("n", "<leader>wt", "mz<cmd>%s/\t/  /g<cr><cmd>let @/=''<cr>`z")
--vim.keymap.set("n", "<leader>ww", [[mz<cmd>%s//\\s\\+$////<cr><cmd>let @/=''<cr>`z]])


