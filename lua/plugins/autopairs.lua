return {
  "https://github.com/windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    npairs.setup({
      disable_filetype = { "TelescopePrompt", "vim" },
    })
    -- Remove single and double quote rules
    npairs.remove_rule("'")
    npairs.remove_rule('"')
  end,
}
