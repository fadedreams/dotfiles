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
			{ "<leader>gil", "<cmd>Octo issue list<cr>", desc = "List GitHub Issues" },
			{ "<leader>gpl", "<cmd>Octo pr list<cr>", desc = "List GitHub PRs" },
			{ "<leader>gic", "<cmd>Octo issue create<cr>", desc = "Create GitHub Issue" },
			{ "<leader>gcc", "<cmd>Octo comment add<cr>", desc = "Add Comment to Issue" },
			{ "<leader>gpc", "<cmd>Octo pr create<cr>", desc = "Create GitHub PR" },
			{ "<leader>gic", "<cmd>Octo issue close<cr>", desc = "Close GitHub Issue" },
			{ "<leader>gir", "<cmd>Octo issue reopen<cr>", desc = "Reopen GitHub Issue" },
			{ "<leader>gie", "<cmd>Octo issue edit<cr>", desc = "Edit GitHub Issue" },
			{ "<leader>grs", "<cmd>Octo review start<cr>", desc = "Start PR Review" },
			{ "<leader>gre", "<cmd>Octo review submit<cr>", desc = "Submit PR Review" },
			{ "<leader>gib", "<cmd>Octo issue browser<cr>", desc = "Open Issue/PR in Browser" },
		},
		opts = function()
			return {}
		end,
		config = function(_, opts)
			require("octo").setup(opts)
		end,
	},
}
