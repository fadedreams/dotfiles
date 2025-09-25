return {
	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			-- Optionally: "ibhagwan/fzf-lua" or "folke/snacks.nvim" (uncomment one if preferred)
			-- "ibhagwan/fzf-lua",
			-- "folke/snacks.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		cmd = { "Octo" }, -- Lazy-load on :Octo command
		event = { "BufReadPost */issues/*", "BufReadPost */pull/*" }, -- Lazy-load on GitHub-related buffers
		opts = function()
			return {
				-- Basic setup; add custom options here if needed
				-- Example: ssh_aliases = { ["git@github.com"] = "github.com" }
			}
		end,
		config = function(_, opts)
			require("octo").setup(opts)
		end,
	},
}
