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
			{ "<leader>gcc", "<cmd>Octo comment add<cr>", desc = "Add Comment to Issue" },
			{ "<leader>gr", "<cmd>Octo pr create<cr>", desc = "Create GitHub PR" },
			{ "<leader>gic", "<cmd>Octo issue close<cr>", desc = "Close GitHub Issue" },
			{ "<leader>gir", "<cmd>Octo issue reopen<cr>", desc = "Reopen GitHub Issue" },
			{ "<leader>ge", "<cmd>Octo issue edit<cr>", desc = "Edit GitHub Issue" },
			{ "<leader>gpr", "<cmd>Octo review start<cr>", desc = "Start PR Review" },
			{ "<leader>gps", "<cmd>Octo review submit<cr>", desc = "Submit PR Review" },
			{ "<leader>gb", "<cmd>Octo issue browser<cr>", desc = "Open Issue/PR in Browser" },
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
