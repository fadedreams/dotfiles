return {
	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		cmd = { "Octo" },
		event = { "BufReadPost */issues/*", "BufReadPost */pull/*" },
		keys = {
			{ "<leader>gi", "<cmd>Octo issue list<cr>", desc = "List GitHub Issues" },
			{ "<leader>gp", "<cmd>Octo pr list<cr>", desc = "List GitHub PRs" },
			{ "<leader>gc", "<cmd>Octo issue create<cr>", desc = "Create GitHub Issue" },
		},
		opts = function()
			return {
				default_repo = "yourusername/your-repo", -- Set your default repo here
				-- Optional: Add SSH aliases if using SSH remotes
				ssh_aliases = { ["git@github.com"] = "github.com" },
			}
		end,
		config = function(_, opts)
			require("octo").setup(opts)
		end,
	},
}
