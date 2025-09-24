
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Define a custom theme with pure black background
      local custom_theme = {
        normal = {
          a = { bg = "#000000", fg = "#7aa2f7" },
          b = { bg = "#000000", fg = "#7aa2f7" },
          c = { bg = "#000000", fg = "#7aa2f7" },
        },
        insert = {
          a = { bg = "#000000", fg = "#0db9d7" },
          b = { bg = "#000000", fg = "#0db9d7" },
          c = { bg = "#000000", fg = "#0db9d7" },
        },
        visual = {
          a = { bg = "#000000", fg = "#a487d8" },
          b = { bg = "#000000", fg = "#a487d8" },
          c = { bg = "#000000", fg = "#a487d8" },
        },
        replace = {
          a = { bg = "#000000", fg = "#d94a4a" },
          b = { bg = "#000000", fg = "#d94a4a" },
          c = { bg = "#000000", fg = "#d94a4a" },
        },
        command = {
          a = { bg = "#000000", fg = "#e0af68" },
          b = { bg = "#000000", fg = "#e0af68" },
          c = { bg = "#000000", fg = "#e0af68" },
        },
        inactive = {
          a = { bg = "#000000", fg = "#565f89" },
          b = { bg = "#000000", fg = "#565f89" },
          c = { bg = "#000000", fg = "#565f89" },
        },
      }

      -- Apply the custom theme
      opts.options = {
        theme = custom_theme,
      }

      -- Your existing section configuration
      opts.sections = {
        lualine_a = {},
        -- lualine_x = {},
        lualine_z = {
          {
            function()
              local char_count = vim.api.nvim_buf_get_offset(0, vim.api.nvim_buf_line_count(0))
              return string.format("%d", char_count)
            end,
            cond = function() return vim.bo.buftype == "" end, -- Only show for normal buffers
          },
        },
      }
    end,
  },
}
-- return {
--   {
--     "nvim-lualine/lualine.nvim",
--
--
--     opts = function(_, opts)
--
--       -- opts.sections = {
--       --   -- lualine_a = {}, -- Hide mode
--       --   -- lualine_b = {}, -- Hide left-side components
--       --   -- lualine_c = {}, -- Hide custom sections
--       --   lualine_x = {}, -- Hide right-side components
--       --   -- lualine_y = {}, -- Hide e.g., "Y 12"
--       --   -- lualine_z = {}, -- Hide encoding, fileformat, etc.
--       -- }
--       opts.sections.lualine_a = {}
--       opts.sections.lualine_x = {}
--       opts.sections.lualine_z = {
--         {
--           function()
--             local char_count = vim.api.nvim_buf_get_offset(0, vim.api.nvim_buf_line_count(0))
--             return string.format("%d", char_count)
--           end,
--           cond = function() return vim.bo.buftype == "" end, -- Only show for normal buffers
--         },
--         { "encoding", fmt = function(enc) return string.format(" %s", enc) end }, -- Built-in encoding component
--         { "fileformat", fmt = function(fmt) return string.format(" %s", fmt:upper()) end }, -- Built-in fileformat component
--       }
--     end,
--   },
-- }



