return {
	-- Mason: Package manager for LSP servers, formatters, and linters
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"selene",
				-- "luacheck",
				"shellcheck",
				"shfmt",
				"typescript-language-server",
				"css-lsp",
				-- "html-lsp",
				"emmet-ls",
				"pyright",
				"rust-analyzer",
				"gopls",
				"vue-language-server",
				-- "json-lsp",
				-- "lua-language-server",
				-- "yaml-language-server",
			},
			-- ui = {
			--   border = "rounded", -- Customize Mason UI
			--   icons = {
			--     package_installed = "✓",
			--     package_pending = "➜",
			--     package_uninstalled = "✗",
			--   },
			-- },
		},
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},
	-- Mason-LSPConfig: Bridge between mason.nvim and nvim-lspconfig
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({})
		end,
	},
	-- nvim-lspconfig: LSP configurations
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp", -- For LSP completion capabilities
		},
		event = { "BufReadPre", "BufNewFile" }, -- Lazy-load on buffer read or new file
		config = function()
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- Define LSP server capabilities for nvim-cmp
			local capabilities = cmp_nvim_lsp.default_capabilities()

			-- Function to set LSP keymaps
			local function set_lsp_keymaps(client, bufnr)
				-- Helper function to create keymaps
				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
				end

				-- Keymaps for LSP actions
				map("n", "gd", vim.lsp.buf.definition, "Go to definition")
				map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
				map("n", "gr", vim.lsp.buf.references, "Find references")
				map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
				map("n", "K", vim.lsp.buf.hover, "Show hover documentation")
				map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
				map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
				map("n", "<leader>ds", vim.lsp.buf.document_symbol, "Document symbols")
				map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
				map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
				map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
				map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostic in float")
				map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostics to location list")

				-- Optional: Format on save (uncomment if desired)
				-- if client.server_capabilities.documentFormattingProvider then
				--   vim.api.nvim_create_autocmd("BufWritePre", {
				--     buffer = bufnr,
				--     callback = function() vim.lsp.buf.format({ async = false }) end,
				--     desc = "Format on save",
				--   })
				-- end
			end

			-- List of servers to configure
			local servers = {
				html = {},
				tailwindcss = {},
				tsserver = {}, -- TypeScript/JavaScript
				cssls = {},
				jsonls = {},
				lua_ls = {},
				pyright = {},
				gopls = {},
				rust_analyzer = {},
			}

			-- Configure each LSP server using vim.lsp.config
			for server, config in pairs(servers) do
				vim.lsp.config(server, {
					capabilities = capabilities,
					settings = server == "lua_ls"
							and {
								Lua = {
									diagnostics = {
										globals = { "vim" }, -- Recognize 'vim' global for Neovim
									},
									workspace = {
										library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime files
									},
								},
							}
						or {},
					on_attach = set_lsp_keymaps, -- Attach keymaps when LSP client connects
				})
			end
		end,
	},
	-- nvim-cmp: Autocompletion plugin
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP completion source
			"hrsh7th/cmp-buffer", -- Buffer completion source
			"hrsh7th/cmp-path", -- Path completion source
			"hrsh7th/cmp-cmdline", -- Cmdline completion source
			"hrsh7th/cmp-vsnip", -- Snippet completion source
			"hrsh7th/vim-vsnip", -- Snippet engine
		},
		event = { "InsertEnter", "CmdlineEnter" }, -- Lazy-load on entering insert or cmdline mode
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body) -- Use vim-vsnip for snippet expansion
					end,
				},
				window = {
					completion = cmp.config.window.bordered(), -- Bordered completion menu
					documentation = cmp.config.window.bordered(), -- Bordered documentation window
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll documentation up
					["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll documentation down
					["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion
					["<C-e>"] = cmp.mapping.abort(), -- Abort completion
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 }, -- LSP completions
					{ name = "vsnip", priority = 750 }, -- Snippet completions
					{ name = "buffer", priority = 500 }, -- Buffer completions
					{ name = "path", priority = 250 }, -- Path completions
				}),
			})

			-- Configure completion for specific filetypes (e.g., gitcommit)
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "buffer" },
				}),
			})

			-- Configure completion for cmdline ("/" and "?")
			-- cmp.setup.cmdline({ "/", "?" }, {
			--   mapping = cmp.mapping.preset.cmdline(),
			--   sources = {
			--     { name = "buffer" },
			--   },
			-- })

			-- Configure completion for cmdline (":")
			-- cmp.setup.cmdline(":", {
			--   mapping = cmp.mapping.preset.cmdline(),
			--   sources = cmp.config.sources({
			--     { name = "path" },
			--     { name = "cmdline" },
			--   }),
			--   matching = { disallow_symbol_nonprefix_matching = false },
			-- })
		end,
	},
}
