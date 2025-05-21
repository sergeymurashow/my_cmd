local options = {
formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
    },
    format_on_save = {
      timeout_ms = 1000,
      lsp_fallback = true,
    },
}

return options
