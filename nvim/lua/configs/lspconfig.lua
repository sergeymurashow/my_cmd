local default_config = require("nvchad.configs.lspconfig")
local on_attach = default_config.on_attach
local capabilities = default_config.capabilities

local lspconfig = require("lspconfig")

-- Подключаемые сервера LSP
local servers = { "html", "cssls", "ts_ls", "eslint", "lua_ls" }

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)

      -- автоформатирование при сохранении
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ async = false })
          end,
        })
      end
    end,
    capabilities = capabilities,
  })
end
