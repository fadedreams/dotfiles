-- https://github.com/abhilash26/zenedit/blob/main/lua/zenedit/plugins/ui.lua
return {
  {
    "folke/noice.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "MunifTanjim/nui.nvim" },
    init = function()
      vim.opt.lazyredraw = false
    end,
    opts = {

    views = {
      cmdline_popup = {
        position = {
          row = 0, -- Places the cmdline at the top (row 0)
          col = "50%", -- Centers horizontally
        },
      },
    },

      messages = { view = "mini", view_warn = "mini" },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
      routes = {
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
    },
  },
}
