-- ~/.config/nvim/lua/custom/plugins/lsp.lua

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "pmizio/typescript-tools.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = { "html", "cssls", "ts_ls", "eslint", "lua_ls" },
      }

      local lspconfig = require "lspconfig"

      -- typescript via typescript-tools.nvim
      require("typescript-tools").setup {}

      lspconfig.cssls.setup {}
      lspconfig.html.setup {}
      lspconfig.eslint.setup {}

      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      }
    end,
  },
}
