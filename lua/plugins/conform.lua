return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black", "isort" },
			rust = { "rustfmt" },
			ruby = { "rubocop" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			go = { "gofmt" },
			java = { "google-java-format" },
			php = { "phpcbf" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			cs = { "csharpier" },
			html = { "prettier" },
			css = { "prettier" },
			json = { "prettier" },
			markdown = { "prettier" },
			yaml = { "yamlfmt" }, -- Added example
		},
		-- format_on_save = function(bufnr)
		-- 	if vim.b[bufnr].disable_format_on_save then
		-- 		return
		-- 	end
		-- 	return { timeout_ms = 1000, lsp_fallback = true }
		-- end,
		formatters = {
			prettier = {
				prepend_args = {
					"--single-quote",
					"--jsx-single-quote",
					"--trailing-comma",
					"es5",
					"--tab-width",
					"2",
				},
			},
		},
		log_level = vim.log.levels.DEBUG, -- Enable debug logging
	},
	init = function()
		vim.keymap.set({ "n", "v" }, "<leader>ff", function()
			require("conform").format({
				async = true,
				lsp_fallback = true,
				on_error = function(err)
					vim.notify("Formatting failed: " .. err, vim.log.levels.ERROR)
				end,
			})
		end, { desc = "Format file or range" })
	end,
}
