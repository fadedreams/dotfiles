return {
	{
		"echasnovski/mini.pairs",
		version = false, -- Use the main branch for latest features
		event = "VeryLazy", -- Load plugin after startup to improve performance
		config = function()
			-- Set up mini.pairs with mappings for desired pairs, explicitly disabling ' and "
			require("mini.pairs").setup({
				modes = { insert = true, command = false, terminal = false },
				mappings = {
					["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
					["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
					["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
					[")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
					["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
					["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
					['"'] = false, -- Explicitly disable autopairing for double quotes
					["'"] = false, -- Explicitly disable autopairing for single quotes
					["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
				},
			})

			-- Explicitly unmap ' and " in insert mode to ensure no residual mappings
			vim.keymap.set("i", '"', '"', { buffer = false, noremap = true })
			vim.keymap.set("i", "'", "'", { buffer = false, noremap = true })
		end,
	},
	{
		"echasnovski/mini.ai",
		version = false, -- Use the main branch for the latest features
		event = "VeryLazy", -- Load plugin after startup to improve performance
		dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Optional for Treesitter support
		config = function()
			-- Optional: Configure mini.ai after loading
			require("mini.ai").setup({
				-- Customize mini.ai settings (optional)
				n_lines = 50, -- Number of lines to scan for text objects
				custom_textobjects = {
					-- Add custom text objects (example)
					o = require("mini.ai").gen_spec.treesitter({
						a = "@function.outer",
						i = "@function.inner",
					}),
				},
			})
		end,
	},
	{
		"nvim-mini/mini.align",
		version = false, -- Use main branch (latest development version)
		config = function()
			require("mini.align").setup()
		end,
	},
	{
		"tpope/vim-surround",
		event = "VeryLazy", -- Optional: Lazy-load on events to improve startup time
	},
	{
		"echasnovski/mini.indentscope",
		event = { "VeryLazy", "BufReadPre", "BufNewFile" }, -- Load on buffer read or new file
		opts = {
			symbol = "│", -- Customize the indent line symbol
			options = {
				try_as_border = true, -- Treat indent as a border
			},
			draw = {
				delay = 0, -- No delay (in ms) for instant drawing
				animation = function()
					return 0
				end, -- Animation function returning 0ms for no animation
				predicate = function(scope)
					return not scope.body.is_incomplete
				end, -- Draw only complete scopes
				priority = 2, -- Symbol priority
			},
		},
		config = function(_, opts)
			require("mini.indentscope").setup(opts) -- Set up the plugin with options
		end,
	},
	{
		"nvim-mini/mini.icons",
		version = false, -- Use the main branch (development version)
		-- version = "*", -- Uncomment to use the stable branch
		config = function()
			require("mini.icons").setup({
				-- Optional: Customize configuration (defaults shown in the document)
				style = "glyph", -- Use 'ascii' if your terminal/font doesn't support glyph icons
				-- Add custom configurations if needed, e.g.:
				-- filetype = { python = { icon = "🐍", color = "#3572A5" } },
			})
		end,
	},
	-- {
	--   "echasnovski/mini.notify",
	--   event = "VeryLazy", -- Load lazily on most events
	--   config = function()
	--     require("mini.notify").setup({
	--       -- Customize notification options
	--       lsp_progress = {
	--         enable = true, -- Show LSP progress notifications
	--         duration_last = 5000, -- Duration of last message in ms
	--       },
	--       window = {
	--         max_width_share = 0.6, -- Max width as a share of Nvim window
	--       },
	--     })
	--     -- Optional: Set mini.notify as the default notification handler
	--     vim.notify = require("mini.notify").make_notify()
	--   end,
	-- },
}
