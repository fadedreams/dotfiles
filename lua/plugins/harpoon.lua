return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",  -- Optional: Lazy-load on events to improve startup time
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    -- REQUIRED
    harpoon:setup()
    -- REQUIRED
    vim.keymap.set("n", "<c-\\>", function()
      harpoon:list():add()
    end)
    vim.keymap.set("n", "\\\\", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    vim.keymap.set("n", "\\p", function()
      harpoon:list():select(1)
    end)
    vim.keymap.set("n", "\\o", function()
      harpoon:list():select(2)
    end)
    vim.keymap.set("n", "<c-m>", function()
      harpoon:list():select(3)
    end)
    vim.keymap.set("n", "<c-n>", function()
      harpoon:list():select(4)
    end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "\\]", function()
      harpoon:list():prev()
    end)
    vim.keymap.set("n", "\\[", function()
      harpoon:list():next()
    end)
  end,
}
