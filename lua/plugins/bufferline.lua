return {
  {
    "akinsho/bufferline.nvim",
    version = "*", -- Use the latest version
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Ensure icon support
    config = function()
      local bufferline = require("bufferline")
      bufferline.setup({
        options = {
          style_preset = bufferline.style_preset.no_italic, -- Disable italics globally
          show_buffer_close_icons = false, -- Disable close icons for individual buffers
          show_close_icon = false, -- Disable the close icon for the tabline
          close_command = false, -- Disable close action
          right_mouse_command = false, -- Disable right-click close action
          middle_mouse_command = false, -- Disable middle-click close action
          diagnostics = false, -- Disable LSP diagnostics (no error/warning indicators)
          diagnostics_indicator = nil, -- Explicitly disable diagnostics indicator
          hover = {
            enabled = false, -- Disable hover events to prevent close icon reveal
            reveal = {},
          },
        },
        highlights = {
          buffer_selected = {
            italic = false, -- Ensure no italic
            bold = true, -- Apply bold
          },
          close_button = {
            fg = "none", -- Hide close button foreground
            bg = "none", -- Hide close button background
          },
          close_button_visible = {
            fg = "none",
            bg = "none",
          },
          close_button_selected = {
            fg = "none",
            bg = "none",
          },
          diagnostic = {
            fg = "none", -- Hide diagnostic indicators
            bg = "none",
          },
          diagnostic_visible = {
            fg = "none",
            bg = "none",
          },
          diagnostic_selected = {
            fg = "none",
            bg = "none",
          },
          error = {
            fg = "none", -- Hide error indicators
            bg = "none",
          },
          error_visible = {
            fg = "none",
            bg = "none",
          },
          error_selected = {
            fg = "none",
            bg = "none",
          },
          warning = {
            fg = "none", -- Hide warning indicators
            bg = "none",
          },
          warning_visible = {
            fg = "none",
            bg = "none",
          },
          warning_selected = {
            fg = "none",
            bg = "none",
          },
        },
      })

    end,
  },
}
