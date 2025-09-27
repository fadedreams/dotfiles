--  https://github.com/abhilash26/zenedit/blob/main/lua/zenedit/plugins/lsp.lua
-- pipx install black
-- pipx install isort
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", cmd = "Mason" },
      { "williamboman/mason-lspconfig.nvim" },
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        cmd = {
          "MasonToolsInstall",
          "MasonToolsInstallSync",
          "MasonToolsUpdate",
          "MasonToolsUpdateSync",
        },
      },
      { 'hrsh7th/nvim-cmp' },
      { "hrsh7th/cmp-nvim-lsp" },
    },
    opts = function()
      return {
        servers = {
          emmet_ls = { filetypes = { "html", "php", "svelte", "vue", "templ" } },
          intelephense = { single_file_support = true },
          lua_ls = {
            settings = {
              Lua = {
                codelens = { enable = true },
                completion = { callSnippet = "Replace" },
                diagnostics = { globals = { "vim", "Snacks" } },
                runtime = { version = "LuaJIT" },
                telemetry = { enable = false },
                workspace = { checkThirdParty = false },
              },
            },
          },
          tailwindcss = {
            filetypes = { "react", "svelte", "vue", "html", "templ" },
          },
          tsserver = {
            initializationOptions = {
              preferences = { includeCompletionsForModuleExports = false },
            },
          },
        },
        diagnostics = {
          severity_sort = true,
          underline = false,
          update_in_insert = false,
          virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
        },
        diagnostic_icons = {
          Error = " ",
          Warn = " ",
          Hint = " ",
          Info = " ",
        },
        ensure_installed = {
          -- LSP Servers
          "bashls",
          "clangd",
          "cssls",
          "css_variables",
          "emmet_ls",
          "gopls",
          "html",
          "htmx",
          "intelephense",
          "jsonls",
          "lua_ls",
          "marksman",
          "pyright",
          "svelte",
          "tailwindcss",
          "templ",
          "ts_ls",
          "vuels",
          -- Linters
          "eslint_d",
          "phpcs",
          "pylint",
          "shellcheck",
          -- Formatters
          "black",
          "gofumpt",
          "isort",
          "php-cs-fixer",
          "prettierd",
          "shfmt",
          "sqlfmt",
          "stylua",
          "sql-formatter",
        },
      }
    end,
    config = function(_, opts)
      local diag = vim.diagnostic
      local kmap = vim.keymap.set
      local fn = vim.fn
      local api = vim.api

      -- Set diagnostic icons once
      for key, icon in pairs(opts.diagnostic_icons) do
        fn.sign_define(key, { text = icon, texthl = "DiagnosticSign" .. key })
      end

      -- Pre-cache diagnostics configuration
      diag.config(opts.diagnostics)

      -- Diagnostic key mappings
      kmap("n", "[d", diag.goto_prev, { desc = "Go to previous diagnostic" })
      kmap("n", "]d", diag.goto_next, { desc = "Go to next diagnostic" })
      kmap(
        "n",
        "<leader>de",
        diag.open_float,
        { desc = "Show diagnostic error" }
      )
      kmap(
        "n",
        "<leader>dq",
        diag.setloclist,
        { desc = "Show diagnostic quickfix" }
      )

      -- LSP attach event
      api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        group = api.nvim_create_augroup("zenedit_lsp_attach", { clear = true }),
        callback = function(event)
          local lsp = vim.lsp
          local client = lsp.get_client_by_id(event.data.client_id)
          if not client then
            return
          end

          local buf = event.buf
          local map = vim.keymap.set

          local bmap = function(lhs, rhs, desc)
            map("n", lhs, rhs, { desc = desc, buffer = buf })
          end

          -- Core LSP mappings
          bmap("K", lsp.buf.hover, "Hover documentation")
          bmap("<F2>", lsp.buf.rename, "Rename")

          -- Optional: Fzf-Lua integration
          local has_fzf, fzf = pcall(require, "fzf-lua")
          if has_fzf then
            bmap("gd", fzf.lsp_definitions, "Go to definition")
            bmap("gD", fzf.lsp_declarations, "Go to declaration")
            bmap("gi", fzf.lsp_implementations, "Go to implementation")
            bmap("gt", fzf.lsp_typedefs, "Go to type definition")
            bmap("gr", fzf.lsp_references, "Go to references")
            bmap("<leader>ds", fzf.lsp_document_symbols, "Document symbols")
            bmap("<leader>ws", fzf.lsp_workspace_symbols, "Workspace symbols")
            bmap("<leader>ca", fzf.lsp_code_actions, "Code actions")
          end
        end,
      })

      -- Mason setup
      local has_mason, mason = pcall(require, "mason")
      if has_mason then
        mason.setup({ install_root_dir = fn.stdpath("cache") .. "/mason" })
      end

      -- Mason tool installer
      local has_installer, installer = pcall(require, "mason-tool-installer")
      if has_installer then
        installer.setup({ ensure_installed = opts.ensure_installed })
      end

      -- LSP capabilities and setup
      local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")

      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp.default_capabilities() or {}
      )

      local has_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")
      local has_lspconfig, lspconfig = pcall(require, "lspconfig")
      if has_mason_lsp and has_lspconfig then
        mason_lspconfig.setup({
          handlers = {
            function(s)
              local server_opts = opts.servers[s] or {}
              server_opts.capabilities = vim.tbl_deep_extend(
                "force",
                {},
                capabilities,
                server_opts.capabilities or {}
              )
              lspconfig[s].setup(server_opts)
            end,
          },
        })
      end
    end,
  },
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
