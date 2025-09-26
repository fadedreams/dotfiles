-- https://github.com/abhilash26/zenedit/blob/main/lua/zenedit/plugins/completion.lua
return {
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      {
        "garymjr/nvim-snippets",
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = { friendly_snippets = true },
      },
    },
    opts = function()
      return {
        completeopt = "menu,menuone,noinsert,preview,noselect",
        kind_icons = {
          Class = "󰠱", Color = "󰏘", Constant = "󰏿", Constructor = "",
          Enum = "", EnumMember = "", Event = "", Field = "󰜢",
          File = "󰈙", Folder = "󰉋", Function = "󰊕", Interface = "",
          Keyword = "󰌋", Method = "󰆧", Module = "", Operator = "󰆕",
          Property = "󰜢", Reference = "󰈇", Snippet = "", Struct = "󰙅",
          Text = "󰉿", TypeParameter = "", Unit = "󰑭", Value = "󰎠",
          Variable = "󰀫",
        },
        source_name = { nvim_lsp = "LSP", nvim_lua = "nvim" },
        sources = {
          { name = "path", keyword_length = 3 },
          { name = "nvim_lsp", keyword_length = 1 },
          { name = "snippets", keyword_length = 2 },
          { name = "buffer", keyword_length = 2 },
        },
      }
    end,
    config = function(_, opts)
      local has_cmp, cmp = pcall(require, "cmp")

      if not has_cmp then
        print("cmp is not available")
        return
      end

      local icons = opts.kind_icons
      local sname = opts.source_name
      local cmap = cmp.mapping
      local snip = vim.snippet

      local snip_jump = function(dir)
        -- stylua: ignore
				if snip.active({ direction = dir }) then snip.jump(dir) end
      end

      cmp.setup({
        snippet = {
        -- stylua: ignore
					expand = function(args) snip.expand(args.body) end,
        },
        formatting = {
          format = function(entry, item)
            local kind = item.kind
            local icon = icons[kind]
            local ename = entry.source.name
            item.kind = string.format("%s %s", icon, kind)
            item.menu = string.format("[%s]", sname[ename] or ename)
            return item
          end,
        },
        completion = {
          completeopt = opts.completeopt,
        },
        mapping = cmap.preset.insert({
          ["<c-b>"] = cmap.scroll_docs(-4),
          ["<c-f>"] = cmap.scroll_docs(4),
          ["<c-n>"] = cmap.select_next_item(),
          ["<c-p>"] = cmap.select_prev_item(),
          ["<cr>"] = cmap.confirm({ select = true }),
          ["<c-y>"] = cmap.confirm({ select = true }),
          ["<c-space>"] = cmap.complete(),
          ["<c-l>"] = cmap(snip_jump(1), { "i", "s" }),
          ["<c-h>"] = cmap(snip_jump(-1), { "i", "s" }),
          ["<c-e>"] = cmap.abort(),
        }),
        sources = cmp.config.sources(opts.sources),
      })
    end,
  },
}
