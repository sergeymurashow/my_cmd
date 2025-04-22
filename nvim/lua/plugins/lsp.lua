return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "linrongbin16/lsp-progress.nvim",
    },
    config = function()
      -- Настройка Mason
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "pyright" },
        automatic_installation = true,
      })

      -- Настройка LSP серверов
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        print("LSP attached to buffer " .. bufnr)
        if client.server_capabilities.documentHighlightProvider then
          vim.cmd([[
            augroup lsp_document_highlight
              autocmd! * <buffer>
              autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
              autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
          ]])
        end
      end

      -- Настройка lua_ls
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
          },
        },
      })

      -- Настройка ts_ls
      lspconfig.ts_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
      })

      -- Настройка null-ls
      local null_ls = require("null-ls")
      local utils = require("null-ls.utils").make_conditional_utils()
      
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier.with({
            prefer_local = "node_modules/.bin",
            condition = function()
              return utils.root_has_file({ ".prettierrc", ".prettierrc.json" })
            end,
          }),
          null_ls.builtins.diagnostics.eslint_d.with({
            condition = function()
              return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json" })
            end,
          }),
        },
        on_attach = on_attach,
      })

      -- Индикатор прогресса LSP
      require("lsp-progress").setup()
    end,
  },
}