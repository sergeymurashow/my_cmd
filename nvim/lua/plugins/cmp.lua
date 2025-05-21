return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      local lspkind = require "lspkind"

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<C-Space>"] = cmp.mapping.complete(),
        },
        sources = cmp.config.sources {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
          { name = "nvim_lua" },
        },
        formatting = {
          format = lspkind.cmp_format {
            mode = "symbol_text",
            maxwidth = 50,
          },
        },
      }

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "path" },
          { name = "cmdline" },
        },
      })
    end,
  },
}
-- return {
--   "hrsh7th/nvim-cmp",
--   dependencies = {
--     "hrsh7th/cmp-nvim-lsp",     -- LSP source
--     "hrsh7th/cmp-buffer",       -- buffer words
--     "hrsh7th/cmp-path",         -- filesystem paths
--     "saadparwaiz1/cmp_luasnip", -- luasnip completion
--     "L3MON4D3/LuaSnip",         -- snippets engine
--   },
--
--   opts = function(_, opts)
--     local cmp = require("cmp")
--     local luasnip = require("luasnip")
--
--     opts.snippet = {
--       expand = function(args)
--         luasnip.lsp_expand(args.body)
--       end,
--     }
--
--     opts.mapping = cmp.mapping.preset.insert({
--       ["<C-Space>"] = cmp.mapping.complete(),
--       ["<CR>"] = cmp.mapping.confirm({ select = true }),
--       ["<Tab>"] = cmp.mapping(function(fallback)
--         if cmp.visible() then
--           cmp.select_next_item()
--         elseif luasnip.expand_or_jumpable() then
--           luasnip.expand_or_jump()
--         else
--           fallback()
--         end
--       end, { "i", "s" }),
--
--       ["<S-Tab>"] = cmp.mapping(function(fallback)
--         if cmp.visible() then
--           cmp.select_prev_item()
--         elseif luasnip.jumpable(-1) then
--           luasnip.jump(-1)
--         else
--           fallback()
--         end
--       end, { "i", "s" }),
--     })
--
--     opts.sources = cmp.config.sources({
--       { name = "nvim_lsp" },
--       { name = "luasnip" },
--       { name = "buffer" },
--       { name = "path" },
--     })
--   end,
-- }
