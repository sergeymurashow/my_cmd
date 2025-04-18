local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    -- Автоустановка парсеров
    ensure_installed = {
      "bash", "c", "cpp", "css", "html", "javascript",
      "json", "lua", "python", "typescript", "tsx", "vim", "markdown"
    },

    -- Основные модули
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },

    -- Интеграция с ts_context_commentstring
    context_commentstring = {
      enable = true,
      enable_autocmd = false, -- Важно! Отключаем автоинициализацию
    }
  })
end

return M
