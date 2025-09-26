-- https://github.com/abhilash26/zenedit/blob/main/lua/zenedit/plugins/linting.lua
return {
  {
    "mfussenegger/nvim-lint",
    keys = {
      {
        "<F5>",
        function()
          require("lint").try_lint()
        end,
        desc = "Try lint",
      },
    },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        bash = { "shellcheck" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        php = { "phpcs" },
        python = { "pylint" },
        svelte = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "eslint_d" },
      }
    end,
  },
}
