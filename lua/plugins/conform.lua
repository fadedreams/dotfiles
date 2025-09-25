-- lua/plugins/conform.lua
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" }, -- Lua formatting
      python = { "black", "isort" }, -- Python: formatting and import sorting
      rust = { "rustfmt" }, -- Rust formatting
      ruby = { "rubocop" }, -- Ruby formatting/linting
      javascript = { "prettier" }, -- JavaScript formatting
      typescript = { "prettier" }, -- TypeScript formatting
      go = { "gofmt" }, -- Go formatting
      java = { "google-java-format" }, -- Java formatting
      php = { "phpcbf" }, -- PHP formatting with PHP_CodeSniffer
      c = { "clang-format" }, -- C formatting
      cpp = { "clang-format" }, -- C++ formatting
      cs = { "csharpier" }, -- C# formatting
      html = { "prettier" }, -- HTML formatting
      css = { "prettier" }, -- CSS formatting
      json = { "prettier" }, -- JSON formatting
      markdown = { "prettier" }, -- Markdown formatting
    },
    format_on_save = {
      timeout_ms = 1000, -- Increase timeout for larger files
      lsp_fallback = true, -- Fallback to LSP if formatter unavailable
    },
    formatters = {
      prettier = {
        prepend_args = { "--single-quote", "--jsx-single-quote" }, -- Example for JS/TS, HTML, CSS, JSON, Markdown
      },
    },
  },
  init = function()
    -- Set keymap for manual formatting
    vim.keymap.set({ "n", "v" }, "<leader>ft", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, { desc = "Format file or range" })
  end,
}
