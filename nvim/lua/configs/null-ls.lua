local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- Форматтеры
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        "javascript", "typescript", "typescriptreact", 
        "javascriptreact", "css", "html", "json", "yaml", "markdown"
      },
      extra_args = { "--single-quote", "--jsx-single-quote" },
    }),
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
    
    -- Линтеры
    null_ls.builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc", ".eslintrc.js" })
      end,
    }),
    null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.diagnostics.flake8,
    
    -- Code actions
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.code_actions.gitsigns,
  },
  on_attach = function(client, bufnr)
    -- Убедитесь, что форматирование работает только для поддерживаемых клиентов
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_buf_set_keymap(bufnr, "n", "F", "<cmd>lua vim.lsp.buf.format()<CR>", { noremap = true, silent = true })
    end
  end,
  debug = false,
})
