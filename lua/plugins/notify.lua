return {
  "rcarriga/nvim-notify",
  lazy = false,
  config = function()
    vim.notify = require("notify")
    require("notify").setup({
      -- Render style (e.g., "default", "compact", "minimal")
      render = "default",
      -- Animation style (e.g., "fade", "slide", "static")
      stages = "fade_in_slide_out",
      -- Timeout in ms (default: 3000)
      timeout = 5000,
      -- Max width/height
      max_width = 60,
      max_height = 25,
      -- Custom highlights (optional)
      on_do_not_disturb = function() end,  -- Callback for Do Not Disturb mode
    })
  end,
}
